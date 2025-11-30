// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KnowledgeBaseEntityImpl _$$KnowledgeBaseEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$KnowledgeBaseEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      indexStatus: $enumDecodeNullable(
              _$KnowledgeBaseIndexStatusEnumMap, json['indexStatus']) ??
          KnowledgeBaseIndexStatus.idle,
      indexError: json['indexError'] as String?,
      fileCount: (json['fileCount'] as num?)?.toInt() ?? 0,
      chunkCount: (json['chunkCount'] as num?)?.toInt() ?? 0,
      embeddingDimensions:
          (json['embeddingDimensions'] as num?)?.toInt() ?? 1536,
      embeddingProviderId: json['embeddingProviderId'] as String?,
      embeddingModel: json['embeddingModel'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$KnowledgeBaseEntityImplToJson(
        _$KnowledgeBaseEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'indexStatus': _$KnowledgeBaseIndexStatusEnumMap[instance.indexStatus]!,
      'indexError': instance.indexError,
      'fileCount': instance.fileCount,
      'chunkCount': instance.chunkCount,
      'embeddingDimensions': instance.embeddingDimensions,
      'embeddingProviderId': instance.embeddingProviderId,
      'embeddingModel': instance.embeddingModel,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$KnowledgeBaseIndexStatusEnumMap = {
  KnowledgeBaseIndexStatus.idle: 'idle',
  KnowledgeBaseIndexStatus.indexing: 'indexing',
  KnowledgeBaseIndexStatus.completed: 'completed',
  KnowledgeBaseIndexStatus.error: 'error',
};

_$KnowledgeBaseFileEntityImpl _$$KnowledgeBaseFileEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$KnowledgeBaseFileEntityImpl(
      id: json['id'] as String,
      knowledgeBaseId: json['knowledgeBaseId'] as String,
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      mimeType: json['mimeType'] as String? ?? '',
      fileSize: (json['fileSize'] as num?)?.toInt() ?? 0,
      indexStatus: $enumDecodeNullable(
              _$KnowledgeBaseIndexStatusEnumMap, json['indexStatus']) ??
          KnowledgeBaseIndexStatus.idle,
      indexError: json['indexError'] as String?,
      chunkCount: (json['chunkCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$KnowledgeBaseFileEntityImplToJson(
        _$KnowledgeBaseFileEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'knowledgeBaseId': instance.knowledgeBaseId,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'mimeType': instance.mimeType,
      'fileSize': instance.fileSize,
      'indexStatus': _$KnowledgeBaseIndexStatusEnumMap[instance.indexStatus]!,
      'indexError': instance.indexError,
      'chunkCount': instance.chunkCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      chunkId: json['chunkId'] as String,
      knowledgeBaseId: json['knowledgeBaseId'] as String,
      fileId: json['fileId'] as String,
      fileName: json['fileName'] as String,
      content: json['content'] as String,
      chunkIndex: (json['chunkIndex'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'chunkId': instance.chunkId,
      'knowledgeBaseId': instance.knowledgeBaseId,
      'fileId': instance.fileId,
      'fileName': instance.fileName,
      'content': instance.content,
      'chunkIndex': instance.chunkIndex,
      'score': instance.score,
    };
