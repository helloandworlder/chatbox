// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      defaultChatModel: json['defaultChatModel'] as String?,
      defaultNamingModel: json['defaultNamingModel'] as String?,
      defaultSearchQueryModel: json['defaultSearchQueryModel'] as String?,
      ocrModel: json['ocrModel'] as String?,
      searchProvider: json['searchProvider'] as String? ?? 'tavily',
      tavilyApiKey: json['tavilyApiKey'] as String?,
      bingApiKey: json['bingApiKey'] as String?,
      tavilySearchDepth: json['tavilySearchDepth'] as String? ?? 'basic',
      searchMaxResults: (json['searchMaxResults'] as num?)?.toInt() ?? 5,
      mcpServersJson: json['mcpServersJson'] as String?,
      mcpAutoConnect: json['mcpAutoConnect'] as bool? ?? true,
      locale: json['locale'] as String? ?? 'system',
      themeMode: json['themeMode'] as String? ?? 'system',
      userAvatarPath: json['userAvatarPath'] as String?,
      assistantAvatarPath: json['assistantAvatarPath'] as String?,
      defaultSystemPrompt: json['defaultSystemPrompt'] as String? ??
          'You are a helpful assistant.',
      maxContextMessages: (json['maxContextMessages'] as num?)?.toInt() ?? 10,
      defaultTemperature: (json['defaultTemperature'] as num?)?.toDouble(),
      defaultTopP: (json['defaultTopP'] as num?)?.toDouble(),
      streamingOutput: json['streamingOutput'] as bool? ?? true,
      showWordCount: json['showWordCount'] as bool? ?? true,
      showTokenUsage: json['showTokenUsage'] as bool? ?? true,
      showModelName: json['showModelName'] as bool? ?? true,
      showTimestamp: json['showTimestamp'] as bool? ?? true,
      showFirstTokenLatency: json['showFirstTokenLatency'] as bool? ?? true,
      autoCollapseCodeBlocks: json['autoCollapseCodeBlocks'] as bool? ?? true,
      autoGenerateChatTitle: json['autoGenerateChatTitle'] as bool? ?? true,
      spellCheck: json['spellCheck'] as bool? ?? true,
      markdownRendering: json['markdownRendering'] as bool? ?? true,
      latexRendering: json['latexRendering'] as bool? ?? true,
      mermaidRendering: json['mermaidRendering'] as bool? ?? true,
      injectDefaultMetadata: json['injectDefaultMetadata'] as bool? ?? true,
      autoPreviewArtifacts: json['autoPreviewArtifacts'] as bool? ?? true,
      pasteLongTextAsFile: json['pasteLongTextAsFile'] as bool? ?? true,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'defaultChatModel': instance.defaultChatModel,
      'defaultNamingModel': instance.defaultNamingModel,
      'defaultSearchQueryModel': instance.defaultSearchQueryModel,
      'ocrModel': instance.ocrModel,
      'searchProvider': instance.searchProvider,
      'tavilyApiKey': instance.tavilyApiKey,
      'bingApiKey': instance.bingApiKey,
      'tavilySearchDepth': instance.tavilySearchDepth,
      'searchMaxResults': instance.searchMaxResults,
      'mcpServersJson': instance.mcpServersJson,
      'mcpAutoConnect': instance.mcpAutoConnect,
      'locale': instance.locale,
      'themeMode': instance.themeMode,
      'userAvatarPath': instance.userAvatarPath,
      'assistantAvatarPath': instance.assistantAvatarPath,
      'defaultSystemPrompt': instance.defaultSystemPrompt,
      'maxContextMessages': instance.maxContextMessages,
      'defaultTemperature': instance.defaultTemperature,
      'defaultTopP': instance.defaultTopP,
      'streamingOutput': instance.streamingOutput,
      'showWordCount': instance.showWordCount,
      'showTokenUsage': instance.showTokenUsage,
      'showModelName': instance.showModelName,
      'showTimestamp': instance.showTimestamp,
      'showFirstTokenLatency': instance.showFirstTokenLatency,
      'autoCollapseCodeBlocks': instance.autoCollapseCodeBlocks,
      'autoGenerateChatTitle': instance.autoGenerateChatTitle,
      'spellCheck': instance.spellCheck,
      'markdownRendering': instance.markdownRendering,
      'latexRendering': instance.latexRendering,
      'mermaidRendering': instance.mermaidRendering,
      'injectDefaultMetadata': instance.injectDefaultMetadata,
      'autoPreviewArtifacts': instance.autoPreviewArtifacts,
      'pasteLongTextAsFile': instance.pasteLongTextAsFile,
    };
