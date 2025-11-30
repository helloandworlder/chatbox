import 'package:freezed_annotation/freezed_annotation.dart';

part 'copilot.freezed.dart';
part 'copilot.g.dart';

@freezed
class CopilotEntity with _$CopilotEntity {
  const factory CopilotEntity({
    required String id,
    required String name,
    String? picUrl,
    required String prompt,
    @Default(false) bool starred,
    @Default(0) int usedCount,
    required DateTime createdAt,
  }) = _CopilotEntity;

  factory CopilotEntity.fromJson(Map<String, dynamic> json) =>
      _$CopilotEntityFromJson(json);
}
