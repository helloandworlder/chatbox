import 'package:freezed_annotation/freezed_annotation.dart';

part 'knowledge_base.freezed.dart';
part 'knowledge_base.g.dart';

/// 知识库索引状态
enum KnowledgeBaseIndexStatus {
  idle,
  indexing,
  completed,
  error,
}

/// 知识库实体
@freezed
class KnowledgeBaseEntity with _$KnowledgeBaseEntity {
  const factory KnowledgeBaseEntity({
    required String id,
    required String name,
    String? description,
    @Default(KnowledgeBaseIndexStatus.idle) KnowledgeBaseIndexStatus indexStatus,
    String? indexError,
    @Default(0) int fileCount,
    @Default(0) int chunkCount,
    @Default(1536) int embeddingDimensions,
    String? embeddingProviderId,
    String? embeddingModel,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _KnowledgeBaseEntity;

  factory KnowledgeBaseEntity.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeBaseEntityFromJson(json);
}

/// 知识库文件实体
@freezed
class KnowledgeBaseFileEntity with _$KnowledgeBaseFileEntity {
  const factory KnowledgeBaseFileEntity({
    required String id,
    required String knowledgeBaseId,
    required String fileName,
    required String filePath,
    @Default('') String mimeType,
    @Default(0) int fileSize,
    @Default(KnowledgeBaseIndexStatus.idle) KnowledgeBaseIndexStatus indexStatus,
    String? indexError,
    @Default(0) int chunkCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _KnowledgeBaseFileEntity;

  factory KnowledgeBaseFileEntity.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeBaseFileEntityFromJson(json);
}

/// 搜索结果
@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String chunkId,
    required String knowledgeBaseId,
    required String fileId,
    required String fileName,
    required String content,
    required int chunkIndex,
    required double score,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}
