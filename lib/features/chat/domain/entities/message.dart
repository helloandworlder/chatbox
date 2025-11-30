import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum MessageRole { user, assistant, system }

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String id,
    required String sessionId,
    required MessageRole role,
    required List<ContentPart> content,
    String? model,
    int? inputTokens,
    int? outputTokens,
    @Default(false) bool generating,
    required DateTime createdAt,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);
}

@freezed
class ContentPart with _$ContentPart {
  const factory ContentPart.text({required String text}) = TextContent;
  const factory ContentPart.image({required String url, String? alt}) =
      ImageContent;
  const factory ContentPart.file({required String path, required String name}) =
      FileContent;

  factory ContentPart.fromJson(Map<String, dynamic> json) =>
      _$ContentPartFromJson(json);
}

extension MessageEntityX on MessageEntity {
  String get textContent {
    return content
        .whereType<TextContent>()
        .map((c) => c.text)
        .join('\n');
  }
}
