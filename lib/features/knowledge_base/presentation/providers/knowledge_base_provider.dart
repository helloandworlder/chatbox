import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

import '../../../../core/di/providers.dart';
import '../../../../core/storage/database/app_database.dart';
import '../../../../core/storage/vector_store/objectbox_store.dart';
import '../../../ai_models/domain/provider_config.dart';
import '../../../ai_models/presentation/providers/ai_provider.dart';
import '../../data/embedding_service.dart';
import '../../data/rag_service.dart';
import '../../domain/knowledge_base.dart';

// ========== ObjectBox Store Provider ==========
final objectBoxStoreProvider = FutureProvider<ObjectBoxStore>((ref) async {
  return ObjectBoxStore.create();
});

// ========== Embedding Service Provider ==========
final embeddingServiceProvider = Provider<EmbeddingService>((ref) {
  return EmbeddingService();
});

// ========== RAG Service Provider ==========
final ragServiceProvider = FutureProvider<RAGService>((ref) async {
  final objectBox = await ref.watch(objectBoxStoreProvider.future);
  final embeddingService = ref.watch(embeddingServiceProvider);
  return RAGService(objectBox, embeddingService);
});

// ========== Knowledge Bases Provider ==========
final knowledgeBasesProvider = StreamProvider<List<KnowledgeBase>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllKnowledgeBases();
});

// ========== Knowledge Base Files Provider ==========
final knowledgeBaseFilesProvider =
    StreamProvider.family<List<KnowledgeBaseFile>, String>((ref, kbId) {
  final db = ref.watch(databaseProvider);
  return db.watchKnowledgeBaseFiles(kbId);
});

// ========== Current Knowledge Base Provider ==========
final currentKnowledgeBaseIdProvider = StateProvider<String?>((ref) => null);

// ========== Selected Knowledge Bases for Chat ==========
final selectedKnowledgeBaseIdsProvider = StateProvider<List<String>>((ref) => []);

// ========== Embedding Config Provider ==========
final embeddingConfigProvider =
    StateNotifierProvider<EmbeddingConfigNotifier, EmbeddingModelConfig?>((ref) {
  return EmbeddingConfigNotifier(ref);
});

class EmbeddingConfigNotifier extends StateNotifier<EmbeddingModelConfig?> {
  final Ref _ref;

  EmbeddingConfigNotifier(this._ref) : super(null) {
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final db = _ref.read(databaseProvider);
    final json = await db.getSetting('embedding_config');
    if (json != null) {
      try {
        final map = jsonDecode(json) as Map<String, dynamic>;
        state = EmbeddingModelConfig(
          providerId: map['providerId'] as String? ?? 'openai',
          model: map['model'] as String? ?? 'text-embedding-3-small',
          baseUrl: map['baseUrl'] as String? ?? 'https://api.openai.com/v1',
          apiKey: map['apiKey'] as String? ?? '',
          dimensions: map['dimensions'] as int? ?? 1536,
        );
        _ref.read(embeddingServiceProvider).configure(state!);
      } catch (e) {
        // Ignore parse errors
      }
    }
  }

  Future<void> setConfig(EmbeddingModelConfig config) async {
    state = config;
    _ref.read(embeddingServiceProvider).configure(config);

    final db = _ref.read(databaseProvider);
    await db.setSetting(
        'embedding_config',
        jsonEncode({
          'providerId': config.providerId,
          'model': config.model,
          'baseUrl': config.baseUrl,
          'apiKey': config.apiKey,
          'dimensions': config.dimensions,
        }));
  }

  /// 从 AI Provider 配置中设置 embedding
  Future<void> setFromAIProvider(String providerId) async {
    final providers = _ref.read(aiProvidersProvider);
    final provider = providers.where((p) => p.id == providerId).firstOrNull;
    if (provider == null) return;

    final baseUrl = provider.baseUrl ?? providerDefaultBaseUrls[provider.type];
    if (baseUrl == null || provider.apiKey == null) return;

    final config = EmbeddingModelConfig(
      providerId: providerId,
      model: _getDefaultEmbeddingModel(provider.type),
      baseUrl: baseUrl,
      apiKey: provider.apiKey!,
      dimensions: _getDefaultDimensions(provider.type),
    );

    await setConfig(config);
  }

  String _getDefaultEmbeddingModel(AIProviderType type) {
    return switch (type) {
      AIProviderType.openai => 'text-embedding-3-small',
      AIProviderType.azure => 'text-embedding-3-small',
      AIProviderType.ollama => 'nomic-embed-text',
      _ => 'text-embedding-3-small',
    };
  }

  int _getDefaultDimensions(AIProviderType type) {
    return switch (type) {
      AIProviderType.ollama => 768,
      _ => 1536,
    };
  }
}

// ========== Knowledge Base Actions Provider ==========
final knowledgeBaseActionsProvider = Provider((ref) => KnowledgeBaseActions(ref));

class KnowledgeBaseActions {
  final Ref _ref;
  final _uuid = const Uuid();

  KnowledgeBaseActions(this._ref);

  AppDatabase get _db => _ref.read(databaseProvider);

  /// 创建知识库
  Future<String> createKnowledgeBase({
    required String name,
    String? description,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    final config = _ref.read(embeddingConfigProvider);

    await _db.insertKnowledgeBase(KnowledgeBasesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      embeddingDimensions: Value(config?.dimensions ?? 1536),
      embeddingProviderId: Value(config?.providerId),
      embeddingModel: Value(config?.model),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    return id;
  }

  /// 更新知识库
  Future<void> updateKnowledgeBase({
    required String id,
    String? name,
    String? description,
  }) async {
    final kb = await _db.getKnowledgeBase(id);
    if (kb == null) return;

    await _db.updateKnowledgeBase(KnowledgeBasesCompanion(
      id: Value(id),
      name: Value(name ?? kb.name),
      description: Value(description ?? kb.description),
      indexStatus: Value(kb.indexStatus),
      indexError: Value(kb.indexError),
      fileCount: Value(kb.fileCount),
      chunkCount: Value(kb.chunkCount),
      embeddingDimensions: Value(kb.embeddingDimensions),
      embeddingProviderId: Value(kb.embeddingProviderId),
      embeddingModel: Value(kb.embeddingModel),
      createdAt: Value(kb.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  /// 删除知识库
  Future<void> deleteKnowledgeBase(String id) async {
    // 1. 删除向量数据
    final rag = await _ref.read(ragServiceProvider.future);
    await rag.deleteKnowledgeBaseChunks(id);

    // 2. 删除文件记录
    await _db.deleteAllKnowledgeBaseFiles(id);

    // 3. 删除知识库记录
    await _db.deleteKnowledgeBase(id);

    // 4. 清理选中状态
    final currentId = _ref.read(currentKnowledgeBaseIdProvider);
    if (currentId == id) {
      _ref.read(currentKnowledgeBaseIdProvider.notifier).state = null;
    }

    final selectedIds = _ref.read(selectedKnowledgeBaseIdsProvider);
    if (selectedIds.contains(id)) {
      _ref.read(selectedKnowledgeBaseIdsProvider.notifier).state =
          selectedIds.where((i) => i != id).toList();
    }
  }

  /// 添加文件到知识库
  Future<String?> addFileToKnowledgeBase(String knowledgeBaseId) async {
    // 1. 选择文件
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'md', 'json', 'csv', 'xml', 'html', 'log'],
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.first;
    if (file.path == null) return null;

    // 2. 复制文件到应用目录
    final appDir = await getApplicationDocumentsDirectory();
    final kbDir = Directory(p.join(appDir.path, 'knowledge_bases', knowledgeBaseId));
    if (!await kbDir.exists()) {
      await kbDir.create(recursive: true);
    }

    final fileId = _uuid.v4();
    final extension = file.extension ?? 'txt';
    final targetPath = p.join(kbDir.path, '$fileId.$extension');

    await File(file.path!).copy(targetPath);

    // 3. 创建文件记录
    final now = DateTime.now();
    await _db.insertKnowledgeBaseFile(KnowledgeBaseFilesCompanion(
      id: Value(fileId),
      knowledgeBaseId: Value(knowledgeBaseId),
      fileName: Value(file.name),
      filePath: Value(targetPath),
      mimeType: Value(_getMimeType(extension)),
      fileSize: Value(file.size),
      indexStatus: const Value('idle'),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    // 4. 更新知识库文件数量
    await _updateKnowledgeBaseFileCount(knowledgeBaseId);

    return fileId;
  }

  /// 索引文件
  Future<void> indexFile(
    String knowledgeBaseId,
    String fileId, {
    void Function(int current, int total, String? status)? onProgress,
  }) async {
    final file = await _db.getKnowledgeBaseFile(fileId);
    if (file == null) return;

    // 1. 更新状态为 indexing
    await _updateFileStatus(fileId, 'indexing');

    try {
      // 2. 执行索引
      final rag = await _ref.read(ragServiceProvider.future);
      final chunkCount = await rag.indexFile(
        knowledgeBaseId: knowledgeBaseId,
        fileId: fileId,
        fileName: file.fileName,
        filePath: file.filePath,
        onProgress: onProgress,
      );

      // 3. 更新状态为 completed
      await _updateFileStatus(fileId, 'completed', chunkCount: chunkCount);

      // 4. 更新知识库块数量
      await _updateKnowledgeBaseChunkCount(knowledgeBaseId);
    } catch (e) {
      // 更新状态为 error
      await _updateFileStatus(fileId, 'error', error: e.toString());
      rethrow;
    }
  }

  /// 删除文件
  Future<void> deleteFile(String knowledgeBaseId, String fileId) async {
    // 1. 删除向量数据
    final rag = await _ref.read(ragServiceProvider.future);
    await rag.deleteFileChunks(fileId);

    // 2. 删除实际文件
    final file = await _db.getKnowledgeBaseFile(fileId);
    if (file != null) {
      try {
        await File(file.filePath).delete();
      } catch (e) {
        // Ignore file deletion errors
      }
    }

    // 3. 删除数据库记录
    await _db.deleteKnowledgeBaseFile(fileId);

    // 4. 更新知识库统计
    await _updateKnowledgeBaseFileCount(knowledgeBaseId);
    await _updateKnowledgeBaseChunkCount(knowledgeBaseId);
  }

  /// 重新索引文件
  Future<void> reindexFile(
    String knowledgeBaseId,
    String fileId, {
    void Function(int current, int total, String? status)? onProgress,
  }) async {
    // 1. 删除旧的向量数据
    final rag = await _ref.read(ragServiceProvider.future);
    await rag.deleteFileChunks(fileId);

    // 2. 重新索引
    await indexFile(knowledgeBaseId, fileId, onProgress: onProgress);
  }

  /// 搜索知识库
  Future<List<SearchResult>> search(
    String query, {
    int k = 5,
    double? scoreThreshold,
  }) async {
    final selectedIds = _ref.read(selectedKnowledgeBaseIdsProvider);
    if (selectedIds.isEmpty) return [];

    final rag = await _ref.read(ragServiceProvider.future);
    return rag.searchMultiple(selectedIds, query, k: k, scoreThreshold: scoreThreshold);
  }

  Future<void> _updateFileStatus(
    String fileId,
    String status, {
    int? chunkCount,
    String? error,
  }) async {
    final file = await _db.getKnowledgeBaseFile(fileId);
    if (file == null) return;

    await _db.updateKnowledgeBaseFile(KnowledgeBaseFilesCompanion(
      id: Value(fileId),
      knowledgeBaseId: Value(file.knowledgeBaseId),
      fileName: Value(file.fileName),
      filePath: Value(file.filePath),
      mimeType: Value(file.mimeType),
      fileSize: Value(file.fileSize),
      indexStatus: Value(status),
      indexError: Value(error),
      chunkCount: Value(chunkCount ?? file.chunkCount),
      createdAt: Value(file.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> _updateKnowledgeBaseFileCount(String kbId) async {
    final files = await _db.getKnowledgeBaseFiles(kbId);
    final kb = await _db.getKnowledgeBase(kbId);
    if (kb == null) return;

    await _db.updateKnowledgeBase(KnowledgeBasesCompanion(
      id: Value(kbId),
      name: Value(kb.name),
      description: Value(kb.description),
      indexStatus: Value(kb.indexStatus),
      indexError: Value(kb.indexError),
      fileCount: Value(files.length),
      chunkCount: Value(kb.chunkCount),
      embeddingDimensions: Value(kb.embeddingDimensions),
      embeddingProviderId: Value(kb.embeddingProviderId),
      embeddingModel: Value(kb.embeddingModel),
      createdAt: Value(kb.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> _updateKnowledgeBaseChunkCount(String kbId) async {
    final rag = await _ref.read(ragServiceProvider.future);
    final chunkCount = rag.getKnowledgeBaseChunkCount(kbId);

    final kb = await _db.getKnowledgeBase(kbId);
    if (kb == null) return;

    await _db.updateKnowledgeBase(KnowledgeBasesCompanion(
      id: Value(kbId),
      name: Value(kb.name),
      description: Value(kb.description),
      indexStatus: Value(kb.indexStatus),
      indexError: Value(kb.indexError),
      fileCount: Value(kb.fileCount),
      chunkCount: Value(chunkCount),
      embeddingDimensions: Value(kb.embeddingDimensions),
      embeddingProviderId: Value(kb.embeddingProviderId),
      embeddingModel: Value(kb.embeddingModel),
      createdAt: Value(kb.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  String _getMimeType(String extension) {
    return switch (extension.toLowerCase()) {
      'txt' => 'text/plain',
      'md' || 'markdown' => 'text/markdown',
      'json' => 'application/json',
      'xml' => 'application/xml',
      'html' => 'text/html',
      'csv' => 'text/csv',
      'log' => 'text/plain',
      _ => 'application/octet-stream',
    };
  }
}
