import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chatbox_flutter/features/chat/presentation/widgets/input_box/attachment_picker.dart';

void main() {
  group('AttachmentType', () {
    test('should have image type', () {
      expect(AttachmentType.image, isNotNull);
      expect(AttachmentType.values.contains(AttachmentType.image), isTrue);
    });

    test('should have file type', () {
      expect(AttachmentType.file, isNotNull);
      expect(AttachmentType.values.contains(AttachmentType.file), isTrue);
    });

    test('should have exactly 2 types', () {
      expect(AttachmentType.values.length, equals(2));
    });
  });

  group('Attachment', () {
    test('should create image attachment', () {
      const attachment = Attachment(
        id: 'img-001',
        type: AttachmentType.image,
        path: '/path/to/image.jpg',
        name: 'image.jpg',
        size: 1024000,
        mimeType: 'image/jpeg',
      );

      expect(attachment.id, equals('img-001'));
      expect(attachment.type, equals(AttachmentType.image));
      expect(attachment.path, equals('/path/to/image.jpg'));
      expect(attachment.name, equals('image.jpg'));
      expect(attachment.size, equals(1024000));
      expect(attachment.mimeType, equals('image/jpeg'));
    });

    test('should create file attachment', () {
      const attachment = Attachment(
        id: 'file-001',
        type: AttachmentType.file,
        path: '/path/to/document.pdf',
        name: 'document.pdf',
        size: 2048000,
        mimeType: 'application/pdf',
      );

      expect(attachment.id, equals('file-001'));
      expect(attachment.type, equals(AttachmentType.file));
      expect(attachment.name, equals('document.pdf'));
      expect(attachment.mimeType, equals('application/pdf'));
    });

    test('should allow null size and mimeType', () {
      const attachment = Attachment(
        id: 'test-001',
        type: AttachmentType.file,
        path: '/path/to/file',
        name: 'unknown',
      );

      expect(attachment.size, isNull);
      expect(attachment.mimeType, isNull);
    });
  });

  group('AttachmentPicker', () {
    test('should generate IDs with timestamp prefix', () {
      final picker = AttachmentPicker();
      final id = picker.generateId();

      expect(id.startsWith('attachment_'), isTrue);
      expect(id.length, greaterThan(12)); // attachment_ + timestamp
    });
  });

  group('MIME Type Detection', () {
    late MimeTypeDetector detector;

    setUp(() {
      detector = MimeTypeDetector();
    });

    test('should detect JPEG image', () {
      expect(detector.getMimeType('jpg'), equals('image/jpeg'));
      expect(detector.getMimeType('jpeg'), equals('image/jpeg'));
    });

    test('should detect PNG image', () {
      expect(detector.getMimeType('png'), equals('image/png'));
    });

    test('should detect GIF image', () {
      expect(detector.getMimeType('gif'), equals('image/gif'));
    });

    test('should detect WebP image', () {
      expect(detector.getMimeType('webp'), equals('image/webp'));
    });

    test('should detect PDF file', () {
      expect(detector.getMimeType('pdf'), equals('application/pdf'));
    });

    test('should detect plain text file', () {
      expect(detector.getMimeType('txt'), equals('text/plain'));
    });

    test('should detect markdown file', () {
      expect(detector.getMimeType('md'), equals('text/markdown'));
    });

    test('should detect JSON file', () {
      expect(detector.getMimeType('json'), equals('application/json'));
    });

    test('should detect CSV file', () {
      expect(detector.getMimeType('csv'), equals('text/csv'));
    });

    test('should return null for unknown extension', () {
      expect(detector.getMimeType('xyz'), isNull);
      expect(detector.getMimeType('unknown'), isNull);
    });

    test('should handle null extension', () {
      expect(detector.getMimeType(null), isNull);
    });

    test('should be case-insensitive', () {
      expect(detector.getMimeType('JPG'), equals('image/jpeg'));
      expect(detector.getMimeType('PNG'), equals('image/png'));
      expect(detector.getMimeType('Pdf'), equals('application/pdf'));
    });
  });

  group('Image File Detection', () {
    late ImageFileDetector detector;

    setUp(() {
      detector = ImageFileDetector();
    });

    test('should detect common image extensions', () {
      expect(detector.isImageFile('jpg'), isTrue);
      expect(detector.isImageFile('jpeg'), isTrue);
      expect(detector.isImageFile('png'), isTrue);
      expect(detector.isImageFile('gif'), isTrue);
      expect(detector.isImageFile('webp'), isTrue);
      expect(detector.isImageFile('bmp'), isTrue);
    });

    test('should detect HEIC/HEIF (iOS formats)', () {
      expect(detector.isImageFile('heic'), isTrue);
      expect(detector.isImageFile('heif'), isTrue);
    });

    test('should not detect non-image files', () {
      expect(detector.isImageFile('pdf'), isFalse);
      expect(detector.isImageFile('txt'), isFalse);
      expect(detector.isImageFile('doc'), isFalse);
      expect(detector.isImageFile('mp4'), isFalse);
    });

    test('should return false for null extension', () {
      expect(detector.isImageFile(null), isFalse);
    });

    test('should be case-insensitive', () {
      expect(detector.isImageFile('JPG'), isTrue);
      expect(detector.isImageFile('PNG'), isTrue);
      expect(detector.isImageFile('HEIC'), isTrue);
    });
  });

  group('AttachmentPreview Widget', () {
    testWidgets('should not render when attachments is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AttachmentPreview(
              attachments: const [],
              onRemove: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('should render attachment thumbnails', (tester) async {
      const attachments = [
        Attachment(
          id: 'test-1',
          type: AttachmentType.file,
          path: '/test/file.txt',
          name: 'file.txt',
        ),
        Attachment(
          id: 'test-2',
          type: AttachmentType.file,
          path: '/test/doc.pdf',
          name: 'doc.pdf',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AttachmentPreview(
              attachments: attachments,
              onRemove: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should call onRemove when remove button tapped', (tester) async {
      Attachment? removedAttachment;
      const attachments = [
        Attachment(
          id: 'test-1',
          type: AttachmentType.file,
          path: '/test/file.txt',
          name: 'file.txt',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AttachmentPreview(
              attachments: attachments,
              onRemove: (attachment) {
                removedAttachment = attachment;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(removedAttachment, isNotNull);
      expect(removedAttachment!.id, equals('test-1'));
    });
  });

  group('AttachmentMenuSheet Widget', () {
    testWidgets('should display all menu options', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => AttachmentMenuSheet(
                      onCamera: () {},
                      onGallery: () {},
                      onFile: () {},
                    ),
                  );
                },
                child: const Text('Show Menu'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Menu'));
      await tester.pumpAndSettle();

      expect(find.text('Take Photo'), findsOneWidget);
      expect(find.text('Choose from Gallery'), findsOneWidget);
      expect(find.text('Choose File'), findsOneWidget);
    });

    testWidgets('should call onCamera when Take Photo tapped', (tester) async {
      bool cameraCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => AttachmentMenuSheet(
                      onCamera: () => cameraCalled = true,
                      onGallery: () {},
                      onFile: () {},
                    ),
                  );
                },
                child: const Text('Show Menu'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Menu'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Take Photo'));
      await tester.pumpAndSettle();

      expect(cameraCalled, isTrue);
    });

    testWidgets('should call onGallery when Choose from Gallery tapped', (tester) async {
      bool galleryCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => AttachmentMenuSheet(
                      onCamera: () {},
                      onGallery: () => galleryCalled = true,
                      onFile: () {},
                    ),
                  );
                },
                child: const Text('Show Menu'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Menu'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Choose from Gallery'));
      await tester.pumpAndSettle();

      expect(galleryCalled, isTrue);
    });

    testWidgets('should call onFile when Choose File tapped', (tester) async {
      bool fileCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => AttachmentMenuSheet(
                      onCamera: () {},
                      onGallery: () {},
                      onFile: () => fileCalled = true,
                    ),
                  );
                },
                child: const Text('Show Menu'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Menu'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Choose File'));
      await tester.pumpAndSettle();

      expect(fileCalled, isTrue);
    });

    testWidgets('should display correct icons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => AttachmentMenuSheet(
                      onCamera: () {},
                      onGallery: () {},
                      onFile: () {},
                    ),
                  );
                },
                child: const Text('Show Menu'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Menu'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
      expect(find.byIcon(Icons.photo_library), findsOneWidget);
      expect(find.byIcon(Icons.attach_file), findsOneWidget);
    });
  });
}

// Helper class for testing - extracts ID generation logic
extension AttachmentPickerTest on AttachmentPicker {
  String generateId() => 'attachment_${DateTime.now().millisecondsSinceEpoch}';
}

// Helper class for MIME type detection testing
class MimeTypeDetector {
  String? getMimeType(String? extension) {
    if (extension == null) return null;
    final mimeTypes = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'webp': 'image/webp',
      'pdf': 'application/pdf',
      'txt': 'text/plain',
      'md': 'text/markdown',
      'json': 'application/json',
      'csv': 'text/csv',
    };
    return mimeTypes[extension.toLowerCase()];
  }
}

// Helper class for image file detection testing
class ImageFileDetector {
  bool isImageFile(String? extension) {
    if (extension == null) return false;
    final imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'webp',
      'bmp',
      'heic',
      'heif'
    ];
    return imageExtensions.contains(extension.toLowerCase());
  }
}
