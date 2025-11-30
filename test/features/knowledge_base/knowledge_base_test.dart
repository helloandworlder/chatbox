import 'package:flutter_test/flutter_test.dart';

import 'package:chatbox_flutter/features/knowledge_base/domain/knowledge_base.dart';

void main() {
  group('KnowledgeBaseIndexStatus', () {
    test('should have all expected statuses', () {
      expect(KnowledgeBaseIndexStatus.values.length, equals(4));
      expect(KnowledgeBaseIndexStatus.values.contains(KnowledgeBaseIndexStatus.idle), isTrue);
      expect(KnowledgeBaseIndexStatus.values.contains(KnowledgeBaseIndexStatus.indexing), isTrue);
      expect(KnowledgeBaseIndexStatus.values.contains(KnowledgeBaseIndexStatus.completed), isTrue);
      expect(KnowledgeBaseIndexStatus.values.contains(KnowledgeBaseIndexStatus.error), isTrue);
    });
  });

  group('KnowledgeBaseEntity', () {
    test('should create with required fields', () {
      final now = DateTime.now();
      final kb = KnowledgeBaseEntity(
        id: 'kb-001',
        name: 'Test Knowledge Base',
        createdAt: now,
        updatedAt: now,
      );

      expect(kb.id, equals('kb-001'));
      expect(kb.name, equals('Test Knowledge Base'));
      expect(kb.description, isNull);
      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.idle));
      expect(kb.fileCount, equals(0));
      expect(kb.chunkCount, equals(0));
      expect(kb.embeddingDimensions, equals(1536));
    });

    test('should create with all fields', () {
      final now = DateTime.now();
      final kb = KnowledgeBaseEntity(
        id: 'kb-002',
        name: 'Full Knowledge Base',
        description: 'A detailed description',
        indexStatus: KnowledgeBaseIndexStatus.completed,
        fileCount: 10,
        chunkCount: 500,
        embeddingDimensions: 3072,
        embeddingProviderId: 'openai',
        embeddingModel: 'text-embedding-3-large',
        createdAt: now,
        updatedAt: now,
      );

      expect(kb.description, equals('A detailed description'));
      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.completed));
      expect(kb.fileCount, equals(10));
      expect(kb.chunkCount, equals(500));
      expect(kb.embeddingDimensions, equals(3072));
      expect(kb.embeddingProviderId, equals('openai'));
      expect(kb.embeddingModel, equals('text-embedding-3-large'));
    });

    test('should support copyWith', () {
      final now = DateTime.now();
      final kb = KnowledgeBaseEntity(
        id: 'kb-001',
        name: 'Original Name',
        createdAt: now,
        updatedAt: now,
      );

      final updated = kb.copyWith(
        name: 'Updated Name',
        indexStatus: KnowledgeBaseIndexStatus.indexing,
        fileCount: 5,
      );

      expect(updated.id, equals(kb.id)); // unchanged
      expect(updated.name, equals('Updated Name'));
      expect(updated.indexStatus, equals(KnowledgeBaseIndexStatus.indexing));
      expect(updated.fileCount, equals(5));
    });

    test('should serialize and deserialize to JSON', () {
      final now = DateTime.now();
      final kb = KnowledgeBaseEntity(
        id: 'kb-001',
        name: 'Test KB',
        description: 'Test description',
        indexStatus: KnowledgeBaseIndexStatus.completed,
        fileCount: 3,
        chunkCount: 100,
        embeddingDimensions: 1536,
        createdAt: now,
        updatedAt: now,
      );

      final json = kb.toJson();
      final restored = KnowledgeBaseEntity.fromJson(json);

      expect(restored.id, equals(kb.id));
      expect(restored.name, equals(kb.name));
      expect(restored.description, equals(kb.description));
      expect(restored.indexStatus, equals(kb.indexStatus));
      expect(restored.fileCount, equals(kb.fileCount));
      expect(restored.chunkCount, equals(kb.chunkCount));
    });

    test('should handle error status with error message', () {
      final now = DateTime.now();
      final kb = KnowledgeBaseEntity(
        id: 'kb-error',
        name: 'Failed KB',
        indexStatus: KnowledgeBaseIndexStatus.error,
        indexError: 'Embedding service not configured',
        createdAt: now,
        updatedAt: now,
      );

      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.error));
      expect(kb.indexError, equals('Embedding service not configured'));
    });
  });

  group('KnowledgeBaseFileEntity', () {
    test('should create with required fields', () {
      final now = DateTime.now();
      final file = KnowledgeBaseFileEntity(
        id: 'file-001',
        knowledgeBaseId: 'kb-001',
        fileName: 'document.txt',
        filePath: '/path/to/document.txt',
        createdAt: now,
        updatedAt: now,
      );

      expect(file.id, equals('file-001'));
      expect(file.knowledgeBaseId, equals('kb-001'));
      expect(file.fileName, equals('document.txt'));
      expect(file.filePath, equals('/path/to/document.txt'));
      expect(file.mimeType, equals(''));
      expect(file.fileSize, equals(0));
      expect(file.indexStatus, equals(KnowledgeBaseIndexStatus.idle));
      expect(file.chunkCount, equals(0));
    });

    test('should create with all fields', () {
      final now = DateTime.now();
      final file = KnowledgeBaseFileEntity(
        id: 'file-002',
        knowledgeBaseId: 'kb-001',
        fileName: 'report.pdf',
        filePath: '/path/to/report.pdf',
        mimeType: 'application/pdf',
        fileSize: 1024000,
        indexStatus: KnowledgeBaseIndexStatus.completed,
        chunkCount: 50,
        createdAt: now,
        updatedAt: now,
      );

      expect(file.mimeType, equals('application/pdf'));
      expect(file.fileSize, equals(1024000));
      expect(file.indexStatus, equals(KnowledgeBaseIndexStatus.completed));
      expect(file.chunkCount, equals(50));
    });

    test('should support copyWith', () {
      final now = DateTime.now();
      final file = KnowledgeBaseFileEntity(
        id: 'file-001',
        knowledgeBaseId: 'kb-001',
        fileName: 'doc.txt',
        filePath: '/path/doc.txt',
        createdAt: now,
        updatedAt: now,
      );

      final updated = file.copyWith(
        indexStatus: KnowledgeBaseIndexStatus.completed,
        chunkCount: 25,
      );

      expect(updated.fileName, equals(file.fileName));
      expect(updated.indexStatus, equals(KnowledgeBaseIndexStatus.completed));
      expect(updated.chunkCount, equals(25));
    });

    test('should serialize and deserialize to JSON', () {
      final now = DateTime.now();
      final file = KnowledgeBaseFileEntity(
        id: 'file-001',
        knowledgeBaseId: 'kb-001',
        fileName: 'test.md',
        filePath: '/test.md',
        mimeType: 'text/markdown',
        fileSize: 2048,
        indexStatus: KnowledgeBaseIndexStatus.completed,
        chunkCount: 10,
        createdAt: now,
        updatedAt: now,
      );

      final json = file.toJson();
      final restored = KnowledgeBaseFileEntity.fromJson(json);

      expect(restored.id, equals(file.id));
      expect(restored.fileName, equals(file.fileName));
      expect(restored.mimeType, equals(file.mimeType));
      expect(restored.chunkCount, equals(file.chunkCount));
    });

    test('should handle error status with error message', () {
      final now = DateTime.now();
      final file = KnowledgeBaseFileEntity(
        id: 'file-error',
        knowledgeBaseId: 'kb-001',
        fileName: 'corrupted.txt',
        filePath: '/corrupted.txt',
        indexStatus: KnowledgeBaseIndexStatus.error,
        indexError: 'File could not be read',
        createdAt: now,
        updatedAt: now,
      );

      expect(file.indexStatus, equals(KnowledgeBaseIndexStatus.error));
      expect(file.indexError, equals('File could not be read'));
    });
  });

  group('SearchResult', () {
    test('should create with all required fields', () {
      final result = SearchResult(
        chunkId: 'chunk-001',
        knowledgeBaseId: 'kb-001',
        fileId: 'file-001',
        fileName: 'document.txt',
        content: 'This is the matching content from the document.',
        chunkIndex: 5,
        score: 0.95,
      );

      expect(result.chunkId, equals('chunk-001'));
      expect(result.knowledgeBaseId, equals('kb-001'));
      expect(result.fileId, equals('file-001'));
      expect(result.fileName, equals('document.txt'));
      expect(result.content, equals('This is the matching content from the document.'));
      expect(result.chunkIndex, equals(5));
      expect(result.score, equals(0.95));
    });

    test('should serialize and deserialize to JSON', () {
      final result = SearchResult(
        chunkId: 'chunk-001',
        knowledgeBaseId: 'kb-001',
        fileId: 'file-001',
        fileName: 'doc.txt',
        content: 'Content',
        chunkIndex: 0,
        score: 0.88,
      );

      final json = result.toJson();
      final restored = SearchResult.fromJson(json);

      expect(restored.chunkId, equals(result.chunkId));
      expect(restored.score, equals(result.score));
      expect(restored.content, equals(result.content));
    });

    test('should support score comparison', () {
      final results = [
        SearchResult(
          chunkId: 'c1',
          knowledgeBaseId: 'kb',
          fileId: 'f1',
          fileName: 'doc1.txt',
          content: 'Content 1',
          chunkIndex: 0,
          score: 0.75,
        ),
        SearchResult(
          chunkId: 'c2',
          knowledgeBaseId: 'kb',
          fileId: 'f2',
          fileName: 'doc2.txt',
          content: 'Content 2',
          chunkIndex: 0,
          score: 0.95,
        ),
        SearchResult(
          chunkId: 'c3',
          knowledgeBaseId: 'kb',
          fileId: 'f3',
          fileName: 'doc3.txt',
          content: 'Content 3',
          chunkIndex: 0,
          score: 0.85,
        ),
      ];

      // Sort by score descending
      results.sort((a, b) => b.score.compareTo(a.score));

      expect(results[0].score, equals(0.95));
      expect(results[1].score, equals(0.85));
      expect(results[2].score, equals(0.75));
    });

    test('should filter by score threshold', () {
      final results = [
        SearchResult(
          chunkId: 'c1',
          knowledgeBaseId: 'kb',
          fileId: 'f1',
          fileName: 'd1.txt',
          content: 'C1',
          chunkIndex: 0,
          score: 0.95,
        ),
        SearchResult(
          chunkId: 'c2',
          knowledgeBaseId: 'kb',
          fileId: 'f2',
          fileName: 'd2.txt',
          content: 'C2',
          chunkIndex: 0,
          score: 0.65,
        ),
        SearchResult(
          chunkId: 'c3',
          knowledgeBaseId: 'kb',
          fileId: 'f3',
          fileName: 'd3.txt',
          content: 'C3',
          chunkIndex: 0,
          score: 0.50,
        ),
      ];

      const threshold = 0.7;
      final filtered = results.where((r) => r.score >= threshold).toList();

      expect(filtered.length, equals(1));
      expect(filtered[0].score, equals(0.95));
    });
  });

  group('Knowledge Base Workflow', () {
    test('should track index progress correctly', () {
      final now = DateTime.now();
      var kb = KnowledgeBaseEntity(
        id: 'kb-001',
        name: 'Test KB',
        createdAt: now,
        updatedAt: now,
      );

      // Initial state
      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.idle));
      expect(kb.fileCount, equals(0));
      expect(kb.chunkCount, equals(0));

      // Add files
      kb = kb.copyWith(fileCount: 3);
      expect(kb.fileCount, equals(3));

      // Start indexing
      kb = kb.copyWith(indexStatus: KnowledgeBaseIndexStatus.indexing);
      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.indexing));

      // Complete indexing
      kb = kb.copyWith(
        indexStatus: KnowledgeBaseIndexStatus.completed,
        chunkCount: 150,
      );
      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.completed));
      expect(kb.chunkCount, equals(150));
    });

    test('should handle index error correctly', () {
      final now = DateTime.now();
      var kb = KnowledgeBaseEntity(
        id: 'kb-001',
        name: 'Test KB',
        indexStatus: KnowledgeBaseIndexStatus.indexing,
        createdAt: now,
        updatedAt: now,
      );

      // Error during indexing
      kb = kb.copyWith(
        indexStatus: KnowledgeBaseIndexStatus.error,
        indexError: 'API rate limit exceeded',
      );

      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.error));
      expect(kb.indexError, equals('API rate limit exceeded'));

      // Clear error and retry
      kb = kb.copyWith(
        indexStatus: KnowledgeBaseIndexStatus.indexing,
        indexError: null,
      );

      expect(kb.indexStatus, equals(KnowledgeBaseIndexStatus.indexing));
      expect(kb.indexError, isNull);
    });

    test('should track file index progress independently', () {
      final now = DateTime.now();
      final files = [
        KnowledgeBaseFileEntity(
          id: 'f1',
          knowledgeBaseId: 'kb-001',
          fileName: 'doc1.txt',
          filePath: '/doc1.txt',
          indexStatus: KnowledgeBaseIndexStatus.completed,
          chunkCount: 10,
          createdAt: now,
          updatedAt: now,
        ),
        KnowledgeBaseFileEntity(
          id: 'f2',
          knowledgeBaseId: 'kb-001',
          fileName: 'doc2.txt',
          filePath: '/doc2.txt',
          indexStatus: KnowledgeBaseIndexStatus.indexing,
          chunkCount: 0,
          createdAt: now,
          updatedAt: now,
        ),
        KnowledgeBaseFileEntity(
          id: 'f3',
          knowledgeBaseId: 'kb-001',
          fileName: 'doc3.txt',
          filePath: '/doc3.txt',
          indexStatus: KnowledgeBaseIndexStatus.idle,
          chunkCount: 0,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      // Count completed files
      final completedCount = files
          .where((f) => f.indexStatus == KnowledgeBaseIndexStatus.completed)
          .length;
      expect(completedCount, equals(1));

      // Count total chunks
      final totalChunks = files.fold(0, (sum, f) => sum + f.chunkCount);
      expect(totalChunks, equals(10));
    });
  });
}
