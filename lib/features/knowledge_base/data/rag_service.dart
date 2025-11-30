import 'dart:async';
import 'dart:io';
import 'dart:math';

import '../../../core/storage/vector_store/objectbox_store.dart';
import '../../../objectbox.g.dart';
import '../domain/knowledge_base.dart';
import 'embedding_service.dart';
import 'models/document_chunk.dart';

/// 文本分块配置
class ChunkConfig {
  final int chunkSize;
  final int overlap;
  final String separator;

  const ChunkConfig({
    this.chunkSize = 500,
    this.overlap = 50,
    this.separator = '\n',
  });
}

/// 索引进度回调
typedef IndexProgressCallback = void Function(
  int current,
  int total,
  String? status,
);

/// RAG 服务
class RAGService {
  final ObjectBoxStore _objectBox;
  final EmbeddingService _embeddingService;

  RAGService(this._objectBox, this._embeddingService);

  Box<DocumentChunk> get _chunkBox => _objectBox.documentChunkBox;

  /// 索引文件到知识库
  Future<int> indexFile({
    required String knowledgeBaseId,
    required String fileId,
    required String fileName,
    required String filePath,
    ChunkConfig config = const ChunkConfig(),
    IndexProgressCallback? onProgress,
  }) async {
    // 1. 读取文件内容
    onProgress?.call(0, 100, 'Reading file...');
    final content = await _readFile(filePath);
    if (content.isEmpty) {
      throw Exception('File is empty or cannot be read');
    }

    // 2. 分块
    onProgress?.call(10, 100, 'Splitting text...');
    final chunks = _splitText(content, config);
    if (chunks.isEmpty) {
      throw Exception('No chunks generated from file');
    }

    // 3. 生成 embeddings
    onProgress?.call(20, 100, 'Generating embeddings...');
    final embeddings = await _embeddingService.embedBatch(chunks);

    // 4. 存储到 ObjectBox
    onProgress?.call(80, 100, 'Storing vectors...');
    final models = <DocumentChunk>[];
    int startOffset = 0;

    for (var i = 0; i < chunks.length; i++) {
      final chunk = chunks[i];
      final endOffset = startOffset + chunk.length;

      models.add(DocumentChunk.create(
        knowledgeBaseId: knowledgeBaseId,
        fileId: fileId,
        fileName: fileName,
        content: chunk,
        chunkIndex: i,
        startOffset: startOffset,
        endOffset: endOffset,
        embedding: embeddings[i],
      ));

      startOffset = endOffset - config.overlap;
      if (startOffset < 0) startOffset = 0;
    }

    _chunkBox.putMany(models);

    onProgress?.call(100, 100, 'Complete');
    return models.length;
  }

  /// 从索引文本内容 (非文件)
  Future<int> indexText({
    required String knowledgeBaseId,
    required String fileId,
    required String fileName,
    required String content,
    ChunkConfig config = const ChunkConfig(),
    IndexProgressCallback? onProgress,
  }) async {
    if (content.isEmpty) {
      throw Exception('Content is empty');
    }

    onProgress?.call(10, 100, 'Splitting text...');
    final chunks = _splitText(content, config);
    if (chunks.isEmpty) {
      throw Exception('No chunks generated');
    }

    onProgress?.call(20, 100, 'Generating embeddings...');
    final embeddings = await _embeddingService.embedBatch(chunks);

    onProgress?.call(80, 100, 'Storing vectors...');
    final models = <DocumentChunk>[];
    int startOffset = 0;

    for (var i = 0; i < chunks.length; i++) {
      final chunk = chunks[i];
      final endOffset = startOffset + chunk.length;

      models.add(DocumentChunk.create(
        knowledgeBaseId: knowledgeBaseId,
        fileId: fileId,
        fileName: fileName,
        content: chunk,
        chunkIndex: i,
        startOffset: startOffset,
        endOffset: endOffset,
        embedding: embeddings[i],
      ));

      startOffset = endOffset - config.overlap;
    }

    _chunkBox.putMany(models);

    onProgress?.call(100, 100, 'Complete');
    return models.length;
  }

  /// 向量搜索
  Future<List<SearchResult>> search(
    String knowledgeBaseId,
    String query, {
    int k = 5,
    double? scoreThreshold,
  }) async {
    // 1. 生成查询向量
    final queryVector = await _embeddingService.embed(query);

    // 2. 获取知识库中的所有块
    final queryBuilder = _chunkBox.query(
      DocumentChunk_.knowledgeBaseId.equals(knowledgeBaseId),
    );
    final allChunks = queryBuilder.build().find();

    // 3. 计算余弦相似度并排序
    final scoredChunks = <_ScoredChunk>[];
    for (final chunk in allChunks) {
      if (chunk.embedding == null || chunk.embedding!.isEmpty) continue;
      final score = _cosineSimilarity(queryVector, chunk.embedding!);
      
      if (scoreThreshold != null && score < scoreThreshold) continue;
      
      scoredChunks.add(_ScoredChunk(chunk, score));
    }

    // 4. 按分数排序取 top-k
    scoredChunks.sort((a, b) => b.score.compareTo(a.score));
    final topK = scoredChunks.take(k).toList();

    // 5. 转换为搜索结果
    return topK.map((sc) => SearchResult(
      chunkId: sc.chunk.id.toString(),
      knowledgeBaseId: sc.chunk.knowledgeBaseId,
      fileId: sc.chunk.fileId,
      fileName: sc.chunk.fileName,
      content: sc.chunk.content,
      chunkIndex: sc.chunk.chunkIndex,
      score: sc.score,
    )).toList();
  }

  /// 在多个知识库中搜索
  Future<List<SearchResult>> searchMultiple(
    List<String> knowledgeBaseIds,
    String query, {
    int k = 5,
    double? scoreThreshold,
  }) async {
    if (knowledgeBaseIds.isEmpty) return [];

    // 1. 生成查询向量
    final queryVector = await _embeddingService.embed(query);

    // 2. 获取所有知识库中的块
    final condition = DocumentChunk_.knowledgeBaseId.oneOf(knowledgeBaseIds);
    final allChunks = _chunkBox.query(condition).build().find();

    // 3. 计算余弦相似度
    final scoredChunks = <_ScoredChunk>[];
    for (final chunk in allChunks) {
      if (chunk.embedding == null || chunk.embedding!.isEmpty) continue;
      final score = _cosineSimilarity(queryVector, chunk.embedding!);
      
      if (scoreThreshold != null && score < scoreThreshold) continue;
      
      scoredChunks.add(_ScoredChunk(chunk, score));
    }

    // 4. 按分数排序取 top-k
    scoredChunks.sort((a, b) => b.score.compareTo(a.score));
    final topK = scoredChunks.take(k).toList();

    // 5. 转换为搜索结果
    return topK.map((sc) => SearchResult(
      chunkId: sc.chunk.id.toString(),
      knowledgeBaseId: sc.chunk.knowledgeBaseId,
      fileId: sc.chunk.fileId,
      fileName: sc.chunk.fileName,
      content: sc.chunk.content,
      chunkIndex: sc.chunk.chunkIndex,
      score: sc.score,
    )).toList();
  }

  /// 计算余弦相似度
  double _cosineSimilarity(List<double> a, List<double> b) {
    if (a.length != b.length) return 0.0;
    
    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;
    
    for (var i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    
    final denominator = sqrt(normA) * sqrt(normB);
    if (denominator == 0) return 0.0;
    
    return dotProduct / denominator;
  }

  /// 删除文件的所有块
  Future<int> deleteFileChunks(String fileId) async {
    final query = _chunkBox.query(DocumentChunk_.fileId.equals(fileId)).build();
    final count = query.count();
    query.remove();
    query.close();
    return count;
  }

  /// 删除知识库的所有块
  Future<int> deleteKnowledgeBaseChunks(String knowledgeBaseId) async {
    final query = _chunkBox
        .query(DocumentChunk_.knowledgeBaseId.equals(knowledgeBaseId))
        .build();
    final count = query.count();
    query.remove();
    query.close();
    return count;
  }

  /// 获取文件的块数量
  int getFileChunkCount(String fileId) {
    final query = _chunkBox.query(DocumentChunk_.fileId.equals(fileId)).build();
    final count = query.count();
    query.close();
    return count;
  }

  /// 获取知识库的块数量
  int getKnowledgeBaseChunkCount(String knowledgeBaseId) {
    final query = _chunkBox
        .query(DocumentChunk_.knowledgeBaseId.equals(knowledgeBaseId))
        .build();
    final count = query.count();
    query.close();
    return count;
  }

  /// 读取文件内容
  Future<String> _readFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File not found: $filePath');
    }

    final extension = filePath.toLowerCase().split('.').last;

    // 根据文件类型处理
    switch (extension) {
      case 'txt':
      case 'md':
      case 'markdown':
      case 'json':
      case 'xml':
      case 'html':
      case 'csv':
      case 'log':
        return await file.readAsString();
      case 'pdf':
        // TODO: 实现 PDF 解析
        throw Exception('PDF parsing not implemented yet');
      case 'docx':
      case 'doc':
        // TODO: 实现 Word 文档解析
        throw Exception('Word document parsing not implemented yet');
      default:
        // 尝试作为文本读取
        try {
          return await file.readAsString();
        } catch (e) {
          throw Exception('Unsupported file type: $extension');
        }
    }
  }

  /// 文本分块
  List<String> _splitText(String text, ChunkConfig config) {
    final chunks = <String>[];

    // 按分隔符分段
    final paragraphs = text.split(RegExp(config.separator));
    final buffer = StringBuffer();

    for (final paragraph in paragraphs) {
      final trimmed = paragraph.trim();
      if (trimmed.isEmpty) continue;

      // 如果当前缓冲区加上新段落超过块大小
      if (buffer.length + trimmed.length > config.chunkSize) {
        if (buffer.isNotEmpty) {
          chunks.add(buffer.toString().trim());
          // 保留 overlap 部分
          final currentContent = buffer.toString();
          buffer.clear();
          if (config.overlap > 0 && currentContent.length > config.overlap) {
            buffer.write(
                currentContent.substring(currentContent.length - config.overlap));
            buffer.write(' ');
          }
        }

        // 如果单个段落超过块大小，需要进一步切分
        if (trimmed.length > config.chunkSize) {
          final subChunks = _splitLongText(trimmed, config);
          chunks.addAll(subChunks);
        } else {
          buffer.write(trimmed);
          buffer.write(' ');
        }
      } else {
        buffer.write(trimmed);
        buffer.write(' ');
      }
    }

    // 处理剩余内容
    if (buffer.isNotEmpty) {
      final remaining = buffer.toString().trim();
      if (remaining.isNotEmpty) {
        chunks.add(remaining);
      }
    }

    return chunks;
  }

  /// 切分超长文本
  List<String> _splitLongText(String text, ChunkConfig config) {
    final chunks = <String>[];
    var start = 0;

    while (start < text.length) {
      var end = start + config.chunkSize;
      if (end > text.length) {
        end = text.length;
      }

      // 尝试在单词边界切分
      if (end < text.length) {
        final lastSpace = text.lastIndexOf(' ', end);
        if (lastSpace > start) {
          end = lastSpace;
        }
      }

      chunks.add(text.substring(start, end).trim());
      start = end - config.overlap;
      if (start < 0) start = 0;
    }

    return chunks;
  }
}

/// 带分数的块
class _ScoredChunk {
  final DocumentChunk chunk;
  final double score;

  _ScoredChunk(this.chunk, this.score);
}
