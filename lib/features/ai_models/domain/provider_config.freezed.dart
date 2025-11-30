// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIProviderConfig _$AIProviderConfigFromJson(Map<String, dynamic> json) {
  return _AIProviderConfig.fromJson(json);
}

/// @nodoc
mixin _$AIProviderConfig {
  String get id => throw _privateConstructorUsedError;
  AIProviderType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get apiKey => throw _privateConstructorUsedError;
  String? get baseUrl => throw _privateConstructorUsedError;
  String? get apiVersion => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  List<ModelConfig> get models => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AIProviderConfigCopyWith<AIProviderConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIProviderConfigCopyWith<$Res> {
  factory $AIProviderConfigCopyWith(
          AIProviderConfig value, $Res Function(AIProviderConfig) then) =
      _$AIProviderConfigCopyWithImpl<$Res, AIProviderConfig>;
  @useResult
  $Res call(
      {String id,
      AIProviderType type,
      String name,
      String? apiKey,
      String? baseUrl,
      String? apiVersion,
      bool enabled,
      List<ModelConfig> models});
}

/// @nodoc
class _$AIProviderConfigCopyWithImpl<$Res, $Val extends AIProviderConfig>
    implements $AIProviderConfigCopyWith<$Res> {
  _$AIProviderConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? apiKey = freezed,
    Object? baseUrl = freezed,
    Object? apiVersion = freezed,
    Object? enabled = null,
    Object? models = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AIProviderType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      baseUrl: freezed == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      apiVersion: freezed == apiVersion
          ? _value.apiVersion
          : apiVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      models: null == models
          ? _value.models
          : models // ignore: cast_nullable_to_non_nullable
              as List<ModelConfig>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIProviderConfigImplCopyWith<$Res>
    implements $AIProviderConfigCopyWith<$Res> {
  factory _$$AIProviderConfigImplCopyWith(_$AIProviderConfigImpl value,
          $Res Function(_$AIProviderConfigImpl) then) =
      __$$AIProviderConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      AIProviderType type,
      String name,
      String? apiKey,
      String? baseUrl,
      String? apiVersion,
      bool enabled,
      List<ModelConfig> models});
}

/// @nodoc
class __$$AIProviderConfigImplCopyWithImpl<$Res>
    extends _$AIProviderConfigCopyWithImpl<$Res, _$AIProviderConfigImpl>
    implements _$$AIProviderConfigImplCopyWith<$Res> {
  __$$AIProviderConfigImplCopyWithImpl(_$AIProviderConfigImpl _value,
      $Res Function(_$AIProviderConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? apiKey = freezed,
    Object? baseUrl = freezed,
    Object? apiVersion = freezed,
    Object? enabled = null,
    Object? models = null,
  }) {
    return _then(_$AIProviderConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AIProviderType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      baseUrl: freezed == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      apiVersion: freezed == apiVersion
          ? _value.apiVersion
          : apiVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      models: null == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<ModelConfig>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIProviderConfigImpl implements _AIProviderConfig {
  const _$AIProviderConfigImpl(
      {required this.id,
      required this.type,
      required this.name,
      this.apiKey,
      this.baseUrl,
      this.apiVersion,
      this.enabled = true,
      final List<ModelConfig> models = const []})
      : _models = models;

  factory _$AIProviderConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIProviderConfigImplFromJson(json);

  @override
  final String id;
  @override
  final AIProviderType type;
  @override
  final String name;
  @override
  final String? apiKey;
  @override
  final String? baseUrl;
  @override
  final String? apiVersion;
  @override
  @JsonKey()
  final bool enabled;
  final List<ModelConfig> _models;
  @override
  @JsonKey()
  List<ModelConfig> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  @override
  String toString() {
    return 'AIProviderConfig(id: $id, type: $type, name: $name, apiKey: $apiKey, baseUrl: $baseUrl, apiVersion: $apiVersion, enabled: $enabled, models: $models)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIProviderConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.apiVersion, apiVersion) ||
                other.apiVersion == apiVersion) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality().equals(other._models, _models));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, name, apiKey, baseUrl,
      apiVersion, enabled, const DeepCollectionEquality().hash(_models));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AIProviderConfigImplCopyWith<_$AIProviderConfigImpl> get copyWith =>
      __$$AIProviderConfigImplCopyWithImpl<_$AIProviderConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIProviderConfigImplToJson(
      this,
    );
  }
}

abstract class _AIProviderConfig implements AIProviderConfig {
  const factory _AIProviderConfig(
      {required final String id,
      required final AIProviderType type,
      required final String name,
      final String? apiKey,
      final String? baseUrl,
      final String? apiVersion,
      final bool enabled,
      final List<ModelConfig> models}) = _$AIProviderConfigImpl;

  factory _AIProviderConfig.fromJson(Map<String, dynamic> json) =
      _$AIProviderConfigImpl.fromJson;

  @override
  String get id;
  @override
  AIProviderType get type;
  @override
  String get name;
  @override
  String? get apiKey;
  @override
  String? get baseUrl;
  @override
  String? get apiVersion;
  @override
  bool get enabled;
  @override
  List<ModelConfig> get models;
  @override
  @JsonKey(ignore: true)
  _$$AIProviderConfigImplCopyWith<_$AIProviderConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModelConfig _$ModelConfigFromJson(Map<String, dynamic> json) {
  return _ModelConfig.fromJson(json);
}

/// @nodoc
mixin _$ModelConfig {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get supportsStreaming => throw _privateConstructorUsedError;
  bool get supportsVision => throw _privateConstructorUsedError;
  bool get supportsFunctionCalling => throw _privateConstructorUsedError;
  int? get maxTokens => throw _privateConstructorUsedError;
  int? get contextWindow => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModelConfigCopyWith<ModelConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelConfigCopyWith<$Res> {
  factory $ModelConfigCopyWith(
          ModelConfig value, $Res Function(ModelConfig) then) =
      _$ModelConfigCopyWithImpl<$Res, ModelConfig>;
  @useResult
  $Res call(
      {String id,
      String name,
      bool supportsStreaming,
      bool supportsVision,
      bool supportsFunctionCalling,
      int? maxTokens,
      int? contextWindow});
}

/// @nodoc
class _$ModelConfigCopyWithImpl<$Res, $Val extends ModelConfig>
    implements $ModelConfigCopyWith<$Res> {
  _$ModelConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? supportsStreaming = null,
    Object? supportsVision = null,
    Object? supportsFunctionCalling = null,
    Object? maxTokens = freezed,
    Object? contextWindow = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      supportsStreaming: null == supportsStreaming
          ? _value.supportsStreaming
          : supportsStreaming // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsVision: null == supportsVision
          ? _value.supportsVision
          : supportsVision // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsFunctionCalling: null == supportsFunctionCalling
          ? _value.supportsFunctionCalling
          : supportsFunctionCalling // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      contextWindow: freezed == contextWindow
          ? _value.contextWindow
          : contextWindow // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelConfigImplCopyWith<$Res>
    implements $ModelConfigCopyWith<$Res> {
  factory _$$ModelConfigImplCopyWith(
          _$ModelConfigImpl value, $Res Function(_$ModelConfigImpl) then) =
      __$$ModelConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      bool supportsStreaming,
      bool supportsVision,
      bool supportsFunctionCalling,
      int? maxTokens,
      int? contextWindow});
}

/// @nodoc
class __$$ModelConfigImplCopyWithImpl<$Res>
    extends _$ModelConfigCopyWithImpl<$Res, _$ModelConfigImpl>
    implements _$$ModelConfigImplCopyWith<$Res> {
  __$$ModelConfigImplCopyWithImpl(
      _$ModelConfigImpl _value, $Res Function(_$ModelConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? supportsStreaming = null,
    Object? supportsVision = null,
    Object? supportsFunctionCalling = null,
    Object? maxTokens = freezed,
    Object? contextWindow = freezed,
  }) {
    return _then(_$ModelConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      supportsStreaming: null == supportsStreaming
          ? _value.supportsStreaming
          : supportsStreaming // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsVision: null == supportsVision
          ? _value.supportsVision
          : supportsVision // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsFunctionCalling: null == supportsFunctionCalling
          ? _value.supportsFunctionCalling
          : supportsFunctionCalling // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      contextWindow: freezed == contextWindow
          ? _value.contextWindow
          : contextWindow // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelConfigImpl implements _ModelConfig {
  const _$ModelConfigImpl(
      {required this.id,
      required this.name,
      this.supportsStreaming = true,
      this.supportsVision = false,
      this.supportsFunctionCalling = false,
      this.maxTokens,
      this.contextWindow});

  factory _$ModelConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool supportsStreaming;
  @override
  @JsonKey()
  final bool supportsVision;
  @override
  @JsonKey()
  final bool supportsFunctionCalling;
  @override
  final int? maxTokens;
  @override
  final int? contextWindow;

  @override
  String toString() {
    return 'ModelConfig(id: $id, name: $name, supportsStreaming: $supportsStreaming, supportsVision: $supportsVision, supportsFunctionCalling: $supportsFunctionCalling, maxTokens: $maxTokens, contextWindow: $contextWindow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.supportsStreaming, supportsStreaming) ||
                other.supportsStreaming == supportsStreaming) &&
            (identical(other.supportsVision, supportsVision) ||
                other.supportsVision == supportsVision) &&
            (identical(
                    other.supportsFunctionCalling, supportsFunctionCalling) ||
                other.supportsFunctionCalling == supportsFunctionCalling) &&
            (identical(other.maxTokens, maxTokens) ||
                other.maxTokens == maxTokens) &&
            (identical(other.contextWindow, contextWindow) ||
                other.contextWindow == contextWindow));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, supportsStreaming,
      supportsVision, supportsFunctionCalling, maxTokens, contextWindow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelConfigImplCopyWith<_$ModelConfigImpl> get copyWith =>
      __$$ModelConfigImplCopyWithImpl<_$ModelConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelConfigImplToJson(
      this,
    );
  }
}

abstract class _ModelConfig implements ModelConfig {
  const factory _ModelConfig(
      {required final String id,
      required final String name,
      final bool supportsStreaming,
      final bool supportsVision,
      final bool supportsFunctionCalling,
      final int? maxTokens,
      final int? contextWindow}) = _$ModelConfigImpl;

  factory _ModelConfig.fromJson(Map<String, dynamic> json) =
      _$ModelConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get supportsStreaming;
  @override
  bool get supportsVision;
  @override
  bool get supportsFunctionCalling;
  @override
  int? get maxTokens;
  @override
  int? get contextWindow;
  @override
  @JsonKey(ignore: true)
  _$$ModelConfigImplCopyWith<_$ModelConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
