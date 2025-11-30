import 'package:objectbox/objectbox.dart';

/// 文档块 - 用于向量存储
/// 使用 ObjectBox HNSW 向量索引实现相似度搜索
@Entity()
class DocumentChunk {
  @Id()
  int id = 0;

  /// 知识库 ID
  @Index()
  late String knowledgeBaseId;

  /// 文件 ID
  @Index()
  late String fileId;

  /// 文件名 (用于搜索结果展示)
  late String fileName;

  /// 块内容
  late String content;

  /// 块在文件中的索引
  late int chunkIndex;

  /// 块的起始字符位置
  int? startOffset;

  /// 块的结束字符位置
  int? endOffset;

  /// 向量嵌入 (1536维 = OpenAI text-embedding-3-small)
  /// HNSW 索引用于高效相似度搜索
  @HnswIndex(dimensions: 1536)
  @Property(type: PropertyType.floatVector)
  List<double>? embedding;

  /// 创建时间
  @Property(type: PropertyType.date)
  late DateTime createdAt;

  DocumentChunk();

  DocumentChunk.create({
    required this.knowledgeBaseId,
    required this.fileId,
    required this.fileName,
    required this.content,
    required this.chunkIndex,
    this.startOffset,
    this.endOffset,
    this.embedding,
  }) : createdAt = DateTime.now();
}

/// 用于不同维度的 embedding 模型
/// 3072维 = OpenAI text-embedding-3-large
@Entity()
class DocumentChunkLarge {
  @Id()
  int id = 0;

  @Index()
  late String knowledgeBaseId;

  @Index()
  late String fileId;

  late String fileName;
  late String content;
  late int chunkIndex;
  int? startOffset;
  int? endOffset;

  @HnswIndex(dimensions: 3072)
  @Property(type: PropertyType.floatVector)
  List<double>? embedding;

  @Property(type: PropertyType.date)
  late DateTime createdAt;

  DocumentChunkLarge();

  DocumentChunkLarge.create({
    required this.knowledgeBaseId,
    required this.fileId,
    required this.fileName,
    required this.content,
    required this.chunkIndex,
    this.startOffset,
    this.endOffset,
    this.embedding,
  }) : createdAt = DateTime.now();
}
