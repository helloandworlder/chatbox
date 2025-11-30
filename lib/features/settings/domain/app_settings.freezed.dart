// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
// ===== 默认模型 =====
  String? get defaultChatModel => throw _privateConstructorUsedError;
  String? get defaultNamingModel => throw _privateConstructorUsedError;
  String? get defaultSearchQueryModel => throw _privateConstructorUsedError;
  String? get ocrModel =>
      throw _privateConstructorUsedError; // ===== 联网搜索 =====
  String get searchProvider => throw _privateConstructorUsedError;
  String? get tavilyApiKey => throw _privateConstructorUsedError;
  String? get bingApiKey => throw _privateConstructorUsedError;
  String get tavilySearchDepth => throw _privateConstructorUsedError;
  int get searchMaxResults =>
      throw _privateConstructorUsedError; // ===== MCP 服务器配置 =====
  String? get mcpServersJson => throw _privateConstructorUsedError;
  bool get mcpAutoConnect =>
      throw _privateConstructorUsedError; // ===== 外观设置 =====
  String get locale => throw _privateConstructorUsedError;
  String get themeMode => throw _privateConstructorUsedError; // ===== 头像 =====
  String? get userAvatarPath => throw _privateConstructorUsedError;
  String? get assistantAvatarPath =>
      throw _privateConstructorUsedError; // ===== 新对话默认设置 =====
  String get defaultSystemPrompt => throw _privateConstructorUsedError;
  int get maxContextMessages => throw _privateConstructorUsedError;
  double? get defaultTemperature => throw _privateConstructorUsedError;
  double? get defaultTopP => throw _privateConstructorUsedError;
  bool get streamingOutput =>
      throw _privateConstructorUsedError; // ===== 显示设置 =====
  bool get showWordCount => throw _privateConstructorUsedError;
  bool get showTokenUsage => throw _privateConstructorUsedError;
  bool get showModelName => throw _privateConstructorUsedError;
  bool get showTimestamp => throw _privateConstructorUsedError;
  bool get showFirstTokenLatency =>
      throw _privateConstructorUsedError; // ===== 功能设置 =====
  bool get autoCollapseCodeBlocks => throw _privateConstructorUsedError;
  bool get autoGenerateChatTitle => throw _privateConstructorUsedError;
  bool get spellCheck => throw _privateConstructorUsedError;
  bool get markdownRendering => throw _privateConstructorUsedError;
  bool get latexRendering => throw _privateConstructorUsedError;
  bool get mermaidRendering => throw _privateConstructorUsedError;
  bool get injectDefaultMetadata => throw _privateConstructorUsedError;
  bool get autoPreviewArtifacts => throw _privateConstructorUsedError;
  bool get pasteLongTextAsFile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {String? defaultChatModel,
      String? defaultNamingModel,
      String? defaultSearchQueryModel,
      String? ocrModel,
      String searchProvider,
      String? tavilyApiKey,
      String? bingApiKey,
      String tavilySearchDepth,
      int searchMaxResults,
      String? mcpServersJson,
      bool mcpAutoConnect,
      String locale,
      String themeMode,
      String? userAvatarPath,
      String? assistantAvatarPath,
      String defaultSystemPrompt,
      int maxContextMessages,
      double? defaultTemperature,
      double? defaultTopP,
      bool streamingOutput,
      bool showWordCount,
      bool showTokenUsage,
      bool showModelName,
      bool showTimestamp,
      bool showFirstTokenLatency,
      bool autoCollapseCodeBlocks,
      bool autoGenerateChatTitle,
      bool spellCheck,
      bool markdownRendering,
      bool latexRendering,
      bool mermaidRendering,
      bool injectDefaultMetadata,
      bool autoPreviewArtifacts,
      bool pasteLongTextAsFile});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultChatModel = freezed,
    Object? defaultNamingModel = freezed,
    Object? defaultSearchQueryModel = freezed,
    Object? ocrModel = freezed,
    Object? searchProvider = null,
    Object? tavilyApiKey = freezed,
    Object? bingApiKey = freezed,
    Object? tavilySearchDepth = null,
    Object? searchMaxResults = null,
    Object? mcpServersJson = freezed,
    Object? mcpAutoConnect = null,
    Object? locale = null,
    Object? themeMode = null,
    Object? userAvatarPath = freezed,
    Object? assistantAvatarPath = freezed,
    Object? defaultSystemPrompt = null,
    Object? maxContextMessages = null,
    Object? defaultTemperature = freezed,
    Object? defaultTopP = freezed,
    Object? streamingOutput = null,
    Object? showWordCount = null,
    Object? showTokenUsage = null,
    Object? showModelName = null,
    Object? showTimestamp = null,
    Object? showFirstTokenLatency = null,
    Object? autoCollapseCodeBlocks = null,
    Object? autoGenerateChatTitle = null,
    Object? spellCheck = null,
    Object? markdownRendering = null,
    Object? latexRendering = null,
    Object? mermaidRendering = null,
    Object? injectDefaultMetadata = null,
    Object? autoPreviewArtifacts = null,
    Object? pasteLongTextAsFile = null,
  }) {
    return _then(_value.copyWith(
      defaultChatModel: freezed == defaultChatModel
          ? _value.defaultChatModel
          : defaultChatModel // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultNamingModel: freezed == defaultNamingModel
          ? _value.defaultNamingModel
          : defaultNamingModel // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultSearchQueryModel: freezed == defaultSearchQueryModel
          ? _value.defaultSearchQueryModel
          : defaultSearchQueryModel // ignore: cast_nullable_to_non_nullable
              as String?,
      ocrModel: freezed == ocrModel
          ? _value.ocrModel
          : ocrModel // ignore: cast_nullable_to_non_nullable
              as String?,
      searchProvider: null == searchProvider
          ? _value.searchProvider
          : searchProvider // ignore: cast_nullable_to_non_nullable
              as String,
      tavilyApiKey: freezed == tavilyApiKey
          ? _value.tavilyApiKey
          : tavilyApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      bingApiKey: freezed == bingApiKey
          ? _value.bingApiKey
          : bingApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      tavilySearchDepth: null == tavilySearchDepth
          ? _value.tavilySearchDepth
          : tavilySearchDepth // ignore: cast_nullable_to_non_nullable
              as String,
      searchMaxResults: null == searchMaxResults
          ? _value.searchMaxResults
          : searchMaxResults // ignore: cast_nullable_to_non_nullable
              as int,
      mcpServersJson: freezed == mcpServersJson
          ? _value.mcpServersJson
          : mcpServersJson // ignore: cast_nullable_to_non_nullable
              as String?,
      mcpAutoConnect: null == mcpAutoConnect
          ? _value.mcpAutoConnect
          : mcpAutoConnect // ignore: cast_nullable_to_non_nullable
              as bool,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatarPath: freezed == userAvatarPath
          ? _value.userAvatarPath
          : userAvatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      assistantAvatarPath: freezed == assistantAvatarPath
          ? _value.assistantAvatarPath
          : assistantAvatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultSystemPrompt: null == defaultSystemPrompt
          ? _value.defaultSystemPrompt
          : defaultSystemPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      maxContextMessages: null == maxContextMessages
          ? _value.maxContextMessages
          : maxContextMessages // ignore: cast_nullable_to_non_nullable
              as int,
      defaultTemperature: freezed == defaultTemperature
          ? _value.defaultTemperature
          : defaultTemperature // ignore: cast_nullable_to_non_nullable
              as double?,
      defaultTopP: freezed == defaultTopP
          ? _value.defaultTopP
          : defaultTopP // ignore: cast_nullable_to_non_nullable
              as double?,
      streamingOutput: null == streamingOutput
          ? _value.streamingOutput
          : streamingOutput // ignore: cast_nullable_to_non_nullable
              as bool,
      showWordCount: null == showWordCount
          ? _value.showWordCount
          : showWordCount // ignore: cast_nullable_to_non_nullable
              as bool,
      showTokenUsage: null == showTokenUsage
          ? _value.showTokenUsage
          : showTokenUsage // ignore: cast_nullable_to_non_nullable
              as bool,
      showModelName: null == showModelName
          ? _value.showModelName
          : showModelName // ignore: cast_nullable_to_non_nullable
              as bool,
      showTimestamp: null == showTimestamp
          ? _value.showTimestamp
          : showTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
      showFirstTokenLatency: null == showFirstTokenLatency
          ? _value.showFirstTokenLatency
          : showFirstTokenLatency // ignore: cast_nullable_to_non_nullable
              as bool,
      autoCollapseCodeBlocks: null == autoCollapseCodeBlocks
          ? _value.autoCollapseCodeBlocks
          : autoCollapseCodeBlocks // ignore: cast_nullable_to_non_nullable
              as bool,
      autoGenerateChatTitle: null == autoGenerateChatTitle
          ? _value.autoGenerateChatTitle
          : autoGenerateChatTitle // ignore: cast_nullable_to_non_nullable
              as bool,
      spellCheck: null == spellCheck
          ? _value.spellCheck
          : spellCheck // ignore: cast_nullable_to_non_nullable
              as bool,
      markdownRendering: null == markdownRendering
          ? _value.markdownRendering
          : markdownRendering // ignore: cast_nullable_to_non_nullable
              as bool,
      latexRendering: null == latexRendering
          ? _value.latexRendering
          : latexRendering // ignore: cast_nullable_to_non_nullable
              as bool,
      mermaidRendering: null == mermaidRendering
          ? _value.mermaidRendering
          : mermaidRendering // ignore: cast_nullable_to_non_nullable
              as bool,
      injectDefaultMetadata: null == injectDefaultMetadata
          ? _value.injectDefaultMetadata
          : injectDefaultMetadata // ignore: cast_nullable_to_non_nullable
              as bool,
      autoPreviewArtifacts: null == autoPreviewArtifacts
          ? _value.autoPreviewArtifacts
          : autoPreviewArtifacts // ignore: cast_nullable_to_non_nullable
              as bool,
      pasteLongTextAsFile: null == pasteLongTextAsFile
          ? _value.pasteLongTextAsFile
          : pasteLongTextAsFile // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? defaultChatModel,
      String? defaultNamingModel,
      String? defaultSearchQueryModel,
      String? ocrModel,
      String searchProvider,
      String? tavilyApiKey,
      String? bingApiKey,
      String tavilySearchDepth,
      int searchMaxResults,
      String? mcpServersJson,
      bool mcpAutoConnect,
      String locale,
      String themeMode,
      String? userAvatarPath,
      String? assistantAvatarPath,
      String defaultSystemPrompt,
      int maxContextMessages,
      double? defaultTemperature,
      double? defaultTopP,
      bool streamingOutput,
      bool showWordCount,
      bool showTokenUsage,
      bool showModelName,
      bool showTimestamp,
      bool showFirstTokenLatency,
      bool autoCollapseCodeBlocks,
      bool autoGenerateChatTitle,
      bool spellCheck,
      bool markdownRendering,
      bool latexRendering,
      bool mermaidRendering,
      bool injectDefaultMetadata,
      bool autoPreviewArtifacts,
      bool pasteLongTextAsFile});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultChatModel = freezed,
    Object? defaultNamingModel = freezed,
    Object? defaultSearchQueryModel = freezed,
    Object? ocrModel = freezed,
    Object? searchProvider = null,
    Object? tavilyApiKey = freezed,
    Object? bingApiKey = freezed,
    Object? tavilySearchDepth = null,
    Object? searchMaxResults = null,
    Object? mcpServersJson = freezed,
    Object? mcpAutoConnect = null,
    Object? locale = null,
    Object? themeMode = null,
    Object? userAvatarPath = freezed,
    Object? assistantAvatarPath = freezed,
    Object? defaultSystemPrompt = null,
    Object? maxContextMessages = null,
    Object? defaultTemperature = freezed,
    Object? defaultTopP = freezed,
    Object? streamingOutput = null,
    Object? showWordCount = null,
    Object? showTokenUsage = null,
    Object? showModelName = null,
    Object? showTimestamp = null,
    Object? showFirstTokenLatency = null,
    Object? autoCollapseCodeBlocks = null,
    Object? autoGenerateChatTitle = null,
    Object? spellCheck = null,
    Object? markdownRendering = null,
    Object? latexRendering = null,
    Object? mermaidRendering = null,
    Object? injectDefaultMetadata = null,
    Object? autoPreviewArtifacts = null,
    Object? pasteLongTextAsFile = null,
  }) {
    return _then(_$AppSettingsImpl(
      defaultChatModel: freezed == defaultChatModel
          ? _value.defaultChatModel
          : defaultChatModel // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultNamingModel: freezed == defaultNamingModel
          ? _value.defaultNamingModel
          : defaultNamingModel // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultSearchQueryModel: freezed == defaultSearchQueryModel
          ? _value.defaultSearchQueryModel
          : defaultSearchQueryModel // ignore: cast_nullable_to_non_nullable
              as String?,
      ocrModel: freezed == ocrModel
          ? _value.ocrModel
          : ocrModel // ignore: cast_nullable_to_non_nullable
              as String?,
      searchProvider: null == searchProvider
          ? _value.searchProvider
          : searchProvider // ignore: cast_nullable_to_non_nullable
              as String,
      tavilyApiKey: freezed == tavilyApiKey
          ? _value.tavilyApiKey
          : tavilyApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      bingApiKey: freezed == bingApiKey
          ? _value.bingApiKey
          : bingApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      tavilySearchDepth: null == tavilySearchDepth
          ? _value.tavilySearchDepth
          : tavilySearchDepth // ignore: cast_nullable_to_non_nullable
              as String,
      searchMaxResults: null == searchMaxResults
          ? _value.searchMaxResults
          : searchMaxResults // ignore: cast_nullable_to_non_nullable
              as int,
      mcpServersJson: freezed == mcpServersJson
          ? _value.mcpServersJson
          : mcpServersJson // ignore: cast_nullable_to_non_nullable
              as String?,
      mcpAutoConnect: null == mcpAutoConnect
          ? _value.mcpAutoConnect
          : mcpAutoConnect // ignore: cast_nullable_to_non_nullable
              as bool,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatarPath: freezed == userAvatarPath
          ? _value.userAvatarPath
          : userAvatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      assistantAvatarPath: freezed == assistantAvatarPath
          ? _value.assistantAvatarPath
          : assistantAvatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultSystemPrompt: null == defaultSystemPrompt
          ? _value.defaultSystemPrompt
          : defaultSystemPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      maxContextMessages: null == maxContextMessages
          ? _value.maxContextMessages
          : maxContextMessages // ignore: cast_nullable_to_non_nullable
              as int,
      defaultTemperature: freezed == defaultTemperature
          ? _value.defaultTemperature
          : defaultTemperature // ignore: cast_nullable_to_non_nullable
              as double?,
      defaultTopP: freezed == defaultTopP
          ? _value.defaultTopP
          : defaultTopP // ignore: cast_nullable_to_non_nullable
              as double?,
      streamingOutput: null == streamingOutput
          ? _value.streamingOutput
          : streamingOutput // ignore: cast_nullable_to_non_nullable
              as bool,
      showWordCount: null == showWordCount
          ? _value.showWordCount
          : showWordCount // ignore: cast_nullable_to_non_nullable
              as bool,
      showTokenUsage: null == showTokenUsage
          ? _value.showTokenUsage
          : showTokenUsage // ignore: cast_nullable_to_non_nullable
              as bool,
      showModelName: null == showModelName
          ? _value.showModelName
          : showModelName // ignore: cast_nullable_to_non_nullable
              as bool,
      showTimestamp: null == showTimestamp
          ? _value.showTimestamp
          : showTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
      showFirstTokenLatency: null == showFirstTokenLatency
          ? _value.showFirstTokenLatency
          : showFirstTokenLatency // ignore: cast_nullable_to_non_nullable
              as bool,
      autoCollapseCodeBlocks: null == autoCollapseCodeBlocks
          ? _value.autoCollapseCodeBlocks
          : autoCollapseCodeBlocks // ignore: cast_nullable_to_non_nullable
              as bool,
      autoGenerateChatTitle: null == autoGenerateChatTitle
          ? _value.autoGenerateChatTitle
          : autoGenerateChatTitle // ignore: cast_nullable_to_non_nullable
              as bool,
      spellCheck: null == spellCheck
          ? _value.spellCheck
          : spellCheck // ignore: cast_nullable_to_non_nullable
              as bool,
      markdownRendering: null == markdownRendering
          ? _value.markdownRendering
          : markdownRendering // ignore: cast_nullable_to_non_nullable
              as bool,
      latexRendering: null == latexRendering
          ? _value.latexRendering
          : latexRendering // ignore: cast_nullable_to_non_nullable
              as bool,
      mermaidRendering: null == mermaidRendering
          ? _value.mermaidRendering
          : mermaidRendering // ignore: cast_nullable_to_non_nullable
              as bool,
      injectDefaultMetadata: null == injectDefaultMetadata
          ? _value.injectDefaultMetadata
          : injectDefaultMetadata // ignore: cast_nullable_to_non_nullable
              as bool,
      autoPreviewArtifacts: null == autoPreviewArtifacts
          ? _value.autoPreviewArtifacts
          : autoPreviewArtifacts // ignore: cast_nullable_to_non_nullable
              as bool,
      pasteLongTextAsFile: null == pasteLongTextAsFile
          ? _value.pasteLongTextAsFile
          : pasteLongTextAsFile // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {this.defaultChatModel,
      this.defaultNamingModel,
      this.defaultSearchQueryModel,
      this.ocrModel,
      this.searchProvider = 'tavily',
      this.tavilyApiKey,
      this.bingApiKey,
      this.tavilySearchDepth = 'basic',
      this.searchMaxResults = 5,
      this.mcpServersJson,
      this.mcpAutoConnect = true,
      this.locale = 'system',
      this.themeMode = 'system',
      this.userAvatarPath,
      this.assistantAvatarPath,
      this.defaultSystemPrompt = 'You are a helpful assistant.',
      this.maxContextMessages = 10,
      this.defaultTemperature,
      this.defaultTopP,
      this.streamingOutput = true,
      this.showWordCount = true,
      this.showTokenUsage = true,
      this.showModelName = true,
      this.showTimestamp = true,
      this.showFirstTokenLatency = true,
      this.autoCollapseCodeBlocks = true,
      this.autoGenerateChatTitle = true,
      this.spellCheck = true,
      this.markdownRendering = true,
      this.latexRendering = true,
      this.mermaidRendering = true,
      this.injectDefaultMetadata = true,
      this.autoPreviewArtifacts = true,
      this.pasteLongTextAsFile = true});

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

// ===== 默认模型 =====
  @override
  final String? defaultChatModel;
  @override
  final String? defaultNamingModel;
  @override
  final String? defaultSearchQueryModel;
  @override
  final String? ocrModel;
// ===== 联网搜索 =====
  @override
  @JsonKey()
  final String searchProvider;
  @override
  final String? tavilyApiKey;
  @override
  final String? bingApiKey;
  @override
  @JsonKey()
  final String tavilySearchDepth;
  @override
  @JsonKey()
  final int searchMaxResults;
// ===== MCP 服务器配置 =====
  @override
  final String? mcpServersJson;
  @override
  @JsonKey()
  final bool mcpAutoConnect;
// ===== 外观设置 =====
  @override
  @JsonKey()
  final String locale;
  @override
  @JsonKey()
  final String themeMode;
// ===== 头像 =====
  @override
  final String? userAvatarPath;
  @override
  final String? assistantAvatarPath;
// ===== 新对话默认设置 =====
  @override
  @JsonKey()
  final String defaultSystemPrompt;
  @override
  @JsonKey()
  final int maxContextMessages;
  @override
  final double? defaultTemperature;
  @override
  final double? defaultTopP;
  @override
  @JsonKey()
  final bool streamingOutput;
// ===== 显示设置 =====
  @override
  @JsonKey()
  final bool showWordCount;
  @override
  @JsonKey()
  final bool showTokenUsage;
  @override
  @JsonKey()
  final bool showModelName;
  @override
  @JsonKey()
  final bool showTimestamp;
  @override
  @JsonKey()
  final bool showFirstTokenLatency;
// ===== 功能设置 =====
  @override
  @JsonKey()
  final bool autoCollapseCodeBlocks;
  @override
  @JsonKey()
  final bool autoGenerateChatTitle;
  @override
  @JsonKey()
  final bool spellCheck;
  @override
  @JsonKey()
  final bool markdownRendering;
  @override
  @JsonKey()
  final bool latexRendering;
  @override
  @JsonKey()
  final bool mermaidRendering;
  @override
  @JsonKey()
  final bool injectDefaultMetadata;
  @override
  @JsonKey()
  final bool autoPreviewArtifacts;
  @override
  @JsonKey()
  final bool pasteLongTextAsFile;

  @override
  String toString() {
    return 'AppSettings(defaultChatModel: $defaultChatModel, defaultNamingModel: $defaultNamingModel, defaultSearchQueryModel: $defaultSearchQueryModel, ocrModel: $ocrModel, searchProvider: $searchProvider, tavilyApiKey: $tavilyApiKey, bingApiKey: $bingApiKey, tavilySearchDepth: $tavilySearchDepth, searchMaxResults: $searchMaxResults, mcpServersJson: $mcpServersJson, mcpAutoConnect: $mcpAutoConnect, locale: $locale, themeMode: $themeMode, userAvatarPath: $userAvatarPath, assistantAvatarPath: $assistantAvatarPath, defaultSystemPrompt: $defaultSystemPrompt, maxContextMessages: $maxContextMessages, defaultTemperature: $defaultTemperature, defaultTopP: $defaultTopP, streamingOutput: $streamingOutput, showWordCount: $showWordCount, showTokenUsage: $showTokenUsage, showModelName: $showModelName, showTimestamp: $showTimestamp, showFirstTokenLatency: $showFirstTokenLatency, autoCollapseCodeBlocks: $autoCollapseCodeBlocks, autoGenerateChatTitle: $autoGenerateChatTitle, spellCheck: $spellCheck, markdownRendering: $markdownRendering, latexRendering: $latexRendering, mermaidRendering: $mermaidRendering, injectDefaultMetadata: $injectDefaultMetadata, autoPreviewArtifacts: $autoPreviewArtifacts, pasteLongTextAsFile: $pasteLongTextAsFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.defaultChatModel, defaultChatModel) ||
                other.defaultChatModel == defaultChatModel) &&
            (identical(other.defaultNamingModel, defaultNamingModel) ||
                other.defaultNamingModel == defaultNamingModel) &&
            (identical(other.defaultSearchQueryModel, defaultSearchQueryModel) ||
                other.defaultSearchQueryModel == defaultSearchQueryModel) &&
            (identical(other.ocrModel, ocrModel) ||
                other.ocrModel == ocrModel) &&
            (identical(other.searchProvider, searchProvider) ||
                other.searchProvider == searchProvider) &&
            (identical(other.tavilyApiKey, tavilyApiKey) ||
                other.tavilyApiKey == tavilyApiKey) &&
            (identical(other.bingApiKey, bingApiKey) ||
                other.bingApiKey == bingApiKey) &&
            (identical(other.tavilySearchDepth, tavilySearchDepth) ||
                other.tavilySearchDepth == tavilySearchDepth) &&
            (identical(other.searchMaxResults, searchMaxResults) ||
                other.searchMaxResults == searchMaxResults) &&
            (identical(other.mcpServersJson, mcpServersJson) ||
                other.mcpServersJson == mcpServersJson) &&
            (identical(other.mcpAutoConnect, mcpAutoConnect) ||
                other.mcpAutoConnect == mcpAutoConnect) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.userAvatarPath, userAvatarPath) ||
                other.userAvatarPath == userAvatarPath) &&
            (identical(other.assistantAvatarPath, assistantAvatarPath) ||
                other.assistantAvatarPath == assistantAvatarPath) &&
            (identical(other.defaultSystemPrompt, defaultSystemPrompt) ||
                other.defaultSystemPrompt == defaultSystemPrompt) &&
            (identical(other.maxContextMessages, maxContextMessages) ||
                other.maxContextMessages == maxContextMessages) &&
            (identical(other.defaultTemperature, defaultTemperature) ||
                other.defaultTemperature == defaultTemperature) &&
            (identical(other.defaultTopP, defaultTopP) ||
                other.defaultTopP == defaultTopP) &&
            (identical(other.streamingOutput, streamingOutput) ||
                other.streamingOutput == streamingOutput) &&
            (identical(other.showWordCount, showWordCount) ||
                other.showWordCount == showWordCount) &&
            (identical(other.showTokenUsage, showTokenUsage) ||
                other.showTokenUsage == showTokenUsage) &&
            (identical(other.showModelName, showModelName) ||
                other.showModelName == showModelName) &&
            (identical(other.showTimestamp, showTimestamp) ||
                other.showTimestamp == showTimestamp) &&
            (identical(other.showFirstTokenLatency, showFirstTokenLatency) ||
                other.showFirstTokenLatency == showFirstTokenLatency) &&
            (identical(other.autoCollapseCodeBlocks, autoCollapseCodeBlocks) ||
                other.autoCollapseCodeBlocks == autoCollapseCodeBlocks) &&
            (identical(other.autoGenerateChatTitle, autoGenerateChatTitle) ||
                other.autoGenerateChatTitle == autoGenerateChatTitle) &&
            (identical(other.spellCheck, spellCheck) ||
                other.spellCheck == spellCheck) &&
            (identical(other.markdownRendering, markdownRendering) ||
                other.markdownRendering == markdownRendering) &&
            (identical(other.latexRendering, latexRendering) ||
                other.latexRendering == latexRendering) &&
            (identical(other.mermaidRendering, mermaidRendering) ||
                other.mermaidRendering == mermaidRendering) &&
            (identical(other.injectDefaultMetadata, injectDefaultMetadata) ||
                other.injectDefaultMetadata == injectDefaultMetadata) &&
            (identical(other.autoPreviewArtifacts, autoPreviewArtifacts) ||
                other.autoPreviewArtifacts == autoPreviewArtifacts) &&
            (identical(other.pasteLongTextAsFile, pasteLongTextAsFile) || other.pasteLongTextAsFile == pasteLongTextAsFile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        defaultChatModel,
        defaultNamingModel,
        defaultSearchQueryModel,
        ocrModel,
        searchProvider,
        tavilyApiKey,
        bingApiKey,
        tavilySearchDepth,
        searchMaxResults,
        mcpServersJson,
        mcpAutoConnect,
        locale,
        themeMode,
        userAvatarPath,
        assistantAvatarPath,
        defaultSystemPrompt,
        maxContextMessages,
        defaultTemperature,
        defaultTopP,
        streamingOutput,
        showWordCount,
        showTokenUsage,
        showModelName,
        showTimestamp,
        showFirstTokenLatency,
        autoCollapseCodeBlocks,
        autoGenerateChatTitle,
        spellCheck,
        markdownRendering,
        latexRendering,
        mermaidRendering,
        injectDefaultMetadata,
        autoPreviewArtifacts,
        pasteLongTextAsFile
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {final String? defaultChatModel,
      final String? defaultNamingModel,
      final String? defaultSearchQueryModel,
      final String? ocrModel,
      final String searchProvider,
      final String? tavilyApiKey,
      final String? bingApiKey,
      final String tavilySearchDepth,
      final int searchMaxResults,
      final String? mcpServersJson,
      final bool mcpAutoConnect,
      final String locale,
      final String themeMode,
      final String? userAvatarPath,
      final String? assistantAvatarPath,
      final String defaultSystemPrompt,
      final int maxContextMessages,
      final double? defaultTemperature,
      final double? defaultTopP,
      final bool streamingOutput,
      final bool showWordCount,
      final bool showTokenUsage,
      final bool showModelName,
      final bool showTimestamp,
      final bool showFirstTokenLatency,
      final bool autoCollapseCodeBlocks,
      final bool autoGenerateChatTitle,
      final bool spellCheck,
      final bool markdownRendering,
      final bool latexRendering,
      final bool mermaidRendering,
      final bool injectDefaultMetadata,
      final bool autoPreviewArtifacts,
      final bool pasteLongTextAsFile}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  @override // ===== 默认模型 =====
  String? get defaultChatModel;
  @override
  String? get defaultNamingModel;
  @override
  String? get defaultSearchQueryModel;
  @override
  String? get ocrModel;
  @override // ===== 联网搜索 =====
  String get searchProvider;
  @override
  String? get tavilyApiKey;
  @override
  String? get bingApiKey;
  @override
  String get tavilySearchDepth;
  @override
  int get searchMaxResults;
  @override // ===== MCP 服务器配置 =====
  String? get mcpServersJson;
  @override
  bool get mcpAutoConnect;
  @override // ===== 外观设置 =====
  String get locale;
  @override
  String get themeMode;
  @override // ===== 头像 =====
  String? get userAvatarPath;
  @override
  String? get assistantAvatarPath;
  @override // ===== 新对话默认设置 =====
  String get defaultSystemPrompt;
  @override
  int get maxContextMessages;
  @override
  double? get defaultTemperature;
  @override
  double? get defaultTopP;
  @override
  bool get streamingOutput;
  @override // ===== 显示设置 =====
  bool get showWordCount;
  @override
  bool get showTokenUsage;
  @override
  bool get showModelName;
  @override
  bool get showTimestamp;
  @override
  bool get showFirstTokenLatency;
  @override // ===== 功能设置 =====
  bool get autoCollapseCodeBlocks;
  @override
  bool get autoGenerateChatTitle;
  @override
  bool get spellCheck;
  @override
  bool get markdownRendering;
  @override
  bool get latexRendering;
  @override
  bool get mermaidRendering;
  @override
  bool get injectDefaultMetadata;
  @override
  bool get autoPreviewArtifacts;
  @override
  bool get pasteLongTextAsFile;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
