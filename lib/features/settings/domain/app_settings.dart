import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    // ===== 默认模型 =====
    String? defaultChatModel,
    String? defaultNamingModel,
    String? defaultSearchQueryModel,
    String? ocrModel,

    // ===== 联网搜索 =====
    @Default('tavily') String searchProvider,
    String? tavilyApiKey,
    String? bingApiKey,
    @Default('basic') String tavilySearchDepth,
    @Default(5) int searchMaxResults,

    // ===== MCP 服务器配置 =====
    String? mcpServersJson,
    @Default(true) bool mcpAutoConnect,

    // ===== 外观设置 =====
    @Default('system') String locale,
    @Default('system') String themeMode,

    // ===== 头像 =====
    String? userAvatarPath,
    String? assistantAvatarPath,

    // ===== 新对话默认设置 =====
    @Default('You are a helpful assistant.') String defaultSystemPrompt,
    @Default(10) int maxContextMessages,
    double? defaultTemperature,
    double? defaultTopP,
    @Default(true) bool streamingOutput,

    // ===== 显示设置 =====
    @Default(true) bool showWordCount,
    @Default(true) bool showTokenUsage,
    @Default(true) bool showModelName,
    @Default(true) bool showTimestamp,
    @Default(true) bool showFirstTokenLatency,

    // ===== 功能设置 =====
    @Default(true) bool autoCollapseCodeBlocks,
    @Default(true) bool autoGenerateChatTitle,
    @Default(true) bool spellCheck,
    @Default(true) bool markdownRendering,
    @Default(true) bool latexRendering,
    @Default(true) bool mermaidRendering,
    @Default(true) bool injectDefaultMetadata,
    @Default(true) bool autoPreviewArtifacts,
    @Default(true) bool pasteLongTextAsFile,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
