import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class SessionEntity with _$SessionEntity {
  const factory SessionEntity({
    required String id,
    required String name,
    @Default('chat') String type,
    @Default(false) bool starred,
    String? copilotId,
    Map<String, dynamic>? settings,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SessionEntity;

  factory SessionEntity.fromJson(Map<String, dynamic> json) =>
      _$SessionEntityFromJson(json);
}
