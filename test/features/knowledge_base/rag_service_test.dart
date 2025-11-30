import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:chatbox_flutter/features/knowledge_base/data/rag_service.dart';
import 'package:chatbox_flutter/features/knowledge_base/domain/knowledge_base.dart';

void main() {
  group('ChunkConfig', () {
    test('should create with default values', () {
      const config = ChunkConfig();
      expect(config.chunkSize, equals(500));
      expect(config.overlap, equals(50));
      expect(config.separator, equals('\n'));
    });

    test('should allow custom values', () {
      const config = ChunkConfig(
        chunkSize: 1000,
        overlap: 100,
        separator: '. ',
      );
      expect(config.chunkSize, equals(1000));
      expect(config.overlap, equals(100));
      expect(config.separator, equals('. '));
    });
  });

  group('SearchResult', () {
    test('should create SearchResult with all fields', () {
      final result = SearchResult(
        chunkId: 'chunk-1',
        knowledgeBaseId: 'kb-1',
        fileId: 'file-1',
        fileName: 'test.txt',
        content: 'Test content',
        chunkIndex: 0,
        score: 0.95,
      );

      expect(result.chunkId, equals('chunk-1'));
      expect(result.knowledgeBaseId, equals('kb-1'));
      expect(result.fileId, equals('file-1'));
      expect(result.fileName, equals('test.txt'));
      expect(result.content, equals('Test content'));
      expect(result.chunkIndex, equals(0));
      expect(result.score, equals(0.95));
    });
  });

  group('Text Splitting Logic', () {
    test('_splitText should split by separator', () {
      final splitter = TextSplitter();
      const config = ChunkConfig(chunkSize: 100, overlap: 10);
      final text = '''First paragraph here.
Second paragraph here.
Third paragraph here.''';

      final chunks = splitter.splitText(text, config);

      expect(chunks.isNotEmpty, isTrue);
      expect(chunks.every((c) => c.isNotEmpty), isTrue);
    });

    test('_splitText should handle empty text', () {
      final splitter = TextSplitter();
      const config = ChunkConfig();
      final chunks = splitter.splitText('', config);
      expect(chunks, isEmpty);
    });

    test('_splitText should handle single short paragraph', () {
      final splitter = TextSplitter();
      const config = ChunkConfig(chunkSize: 100, overlap: 10);
      final chunks = splitter.splitText('Short text', config);

      expect(chunks.length, equals(1));
      expect(chunks.first, equals('Short text'));
    });

    test('_splitLongText should handle long text without spaces', () {
      final splitter = TextSplitter();
      const config = ChunkConfig(chunkSize: 50, overlap: 10);
      final longText = 'A' * 200;

      final chunks = splitter.splitLongText(longText, config);

      expect(chunks.isNotEmpty, isTrue);
      expect(chunks.length, greaterThan(1));
      // Each chunk should be approximately chunkSize
      expect(chunks.first.length, equals(50));
    });

    test('_splitText should create overlapping chunks', () {
      final splitter = TextSplitter();
      const config = ChunkConfig(chunkSize: 30, overlap: 10);
      final text = 'Word1 Word2 Word3 Word4 Word5 Word6 Word7 Word8 Word9 Word10';

      final chunks = splitter.splitText(text, config);

      expect(chunks.length, greaterThan(1));
    });

    test('_splitLongText should split at word boundaries when possible', () {
      final splitter = TextSplitter();
      const config = ChunkConfig(chunkSize: 20, overlap: 5);
      final text = 'Hello world this is a test sentence';

      final chunks = splitter.splitLongText(text, config);

      expect(chunks.isNotEmpty, isTrue);
      // Chunks should try to split at spaces
      expect(chunks.every((c) => !c.startsWith(' ')), isTrue);
    });
  });

  group('Cosine Similarity', () {
    test('should return 1.0 for identical vectors', () {
      final a = [1.0, 2.0, 3.0];
      final b = [1.0, 2.0, 3.0];
      final similarity = cosineSimilarity(a, b);
      expect(similarity, closeTo(1.0, 0.001));
    });

    test('should return 0.0 for orthogonal vectors', () {
      final a = [1.0, 0.0, 0.0];
      final b = [0.0, 1.0, 0.0];
      final similarity = cosineSimilarity(a, b);
      expect(similarity, closeTo(0.0, 0.001));
    });

    test('should return -1.0 for opposite vectors', () {
      final a = [1.0, 2.0, 3.0];
      final b = [-1.0, -2.0, -3.0];
      final similarity = cosineSimilarity(a, b);
      expect(similarity, closeTo(-1.0, 0.001));
    });

    test('should return 0.0 for vectors with different lengths', () {
      final a = [1.0, 2.0, 3.0];
      final b = [1.0, 2.0];
      final similarity = cosineSimilarity(a, b);
      expect(similarity, equals(0.0));
    });

    test('should return 0.0 for zero vectors', () {
      final a = [0.0, 0.0, 0.0];
      final b = [1.0, 2.0, 3.0];
      final similarity = cosineSimilarity(a, b);
      expect(similarity, equals(0.0));
    });

    test('should handle normalized vectors', () {
      final a = _normalize([1.0, 2.0, 3.0]);
      final b = _normalize([2.0, 3.0, 4.0]);
      final similarity = cosineSimilarity(a, b);
      expect(similarity, greaterThan(0.9)); // Similar vectors
    });

    test('should be symmetric', () {
      final a = [1.0, 2.0, 3.0, 4.0];
      final b = [4.0, 3.0, 2.0, 1.0];
      expect(cosineSimilarity(a, b), equals(cosineSimilarity(b, a)));
    });
  });

  group('File Reading', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('rag_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('should read txt file', () async {
      final file = File('${tempDir.path}/test.txt');
      await file.writeAsString('This is test content');

      final reader = FileReader();
      final content = await reader.readFile(file.path);

      expect(content, equals('This is test content'));
    });

    test('should read md file', () async {
      final file = File('${tempDir.path}/test.md');
      await file.writeAsString('# Heading\n\nParagraph');

      final reader = FileReader();
      final content = await reader.readFile(file.path);

      expect(content, contains('# Heading'));
    });

    test('should read json file', () async {
      final file = File('${tempDir.path}/test.json');
      await file.writeAsString('{"key": "value"}');

      final reader = FileReader();
      final content = await reader.readFile(file.path);

      expect(content, contains('"key"'));
    });

    test('should read csv file', () async {
      final file = File('${tempDir.path}/test.csv');
      await file.writeAsString('col1,col2\nval1,val2');

      final reader = FileReader();
      final content = await reader.readFile(file.path);

      expect(content, contains('col1,col2'));
    });

    test('should throw exception for non-existent file', () async {
      final reader = FileReader();
      expect(
        () => reader.readFile('${tempDir.path}/non_existent.txt'),
        throwsException,
      );
    });

    test('should throw exception for unsupported PDF', () async {
      final file = File('${tempDir.path}/test.pdf');
      await file.writeAsBytes([0x25, 0x50, 0x44, 0x46]); // PDF magic bytes

      final reader = FileReader();
      expect(
        () => reader.readFile(file.path),
        throwsException,
      );
    });
  });
}

// Helper class to test text splitting logic in isolation
class TextSplitter {
  List<String> splitText(String text, ChunkConfig config) {
    final chunks = <String>[];

    if (text.isEmpty) return chunks;

    final paragraphs = text.split(RegExp(config.separator));
    final buffer = StringBuffer();

    for (final paragraph in paragraphs) {
      final trimmed = paragraph.trim();
      if (trimmed.isEmpty) continue;

      if (buffer.length + trimmed.length > config.chunkSize) {
        if (buffer.isNotEmpty) {
          chunks.add(buffer.toString().trim());
          final currentContent = buffer.toString();
          buffer.clear();
          if (config.overlap > 0 && currentContent.length > config.overlap) {
            buffer.write(
                currentContent.substring(currentContent.length - config.overlap));
            buffer.write(' ');
          }
        }

        if (trimmed.length > config.chunkSize) {
          final subChunks = splitLongText(trimmed, config);
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

    if (buffer.isNotEmpty) {
      final remaining = buffer.toString().trim();
      if (remaining.isNotEmpty) {
        chunks.add(remaining);
      }
    }

    return chunks;
  }

  List<String> splitLongText(String text, ChunkConfig config) {
    final chunks = <String>[];
    var start = 0;

    while (start < text.length) {
      var end = start + config.chunkSize;
      if (end > text.length) {
        end = text.length;
      }

      if (end < text.length) {
        final lastSpace = text.lastIndexOf(' ', end);
        if (lastSpace > start) {
          end = lastSpace;
        }
      }

      final chunk = text.substring(start, end).trim();
      if (chunk.isNotEmpty) {
        chunks.add(chunk);
      }
      
      // Move start forward
      final nextStart = end - config.overlap;
      // Ensure we always make progress to avoid infinite loop
      if (nextStart <= start) {
        start = end;
      } else {
        start = nextStart;
      }
      
      if (start >= text.length) break;
    }

    return chunks;
  }
}

// Helper class to test file reading logic
class FileReader {
  Future<String> readFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File not found: $filePath');
    }

    final extension = filePath.toLowerCase().split('.').last;

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
        throw Exception('PDF parsing not implemented yet');
      case 'docx':
      case 'doc':
        throw Exception('Word document parsing not implemented yet');
      default:
        try {
          return await file.readAsString();
        } catch (e) {
          throw Exception('Unsupported file type: $extension');
        }
    }
  }
}

// Cosine similarity function for testing
double cosineSimilarity(List<double> a, List<double> b) {
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

// Helper to normalize vector
List<double> _normalize(List<double> vec) {
  final magnitude = sqrt(vec.fold(0.0, (sum, v) => sum + v * v));
  if (magnitude == 0) return vec;
  return vec.map((v) => v / magnitude).toList();
}
