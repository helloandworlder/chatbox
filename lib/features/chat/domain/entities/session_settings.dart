import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_settings.freezed.dart';
part 'session_settings.g.dart';

@freezed
class SessionSettings with _$SessionSettings {
  const factory SessionSettings({
    String? systemPrompt,
    int? maxContextMessages,
    double? temperature,
    double? topP,
    int? maxOutputTokens,
    @Default(true) bool streamingOutput,
  }) = _SessionSettings;

  factory SessionSettings.fromJson(Map<String, dynamic> json) =>
      _$SessionSettingsFromJson(json);
}
