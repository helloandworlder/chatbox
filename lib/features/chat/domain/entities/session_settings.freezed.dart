// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionSettings _$SessionSettingsFromJson(Map<String, dynamic> json) {
  return _SessionSettings.fromJson(json);
}

/// @nodoc
mixin _$SessionSettings {
  String? get systemPrompt => throw _privateConstructorUsedError;
  int? get maxContextMessages => throw _privateConstructorUsedError;
  double? get temperature => throw _privateConstructorUsedError;
  double? get topP => throw _privateConstructorUsedError;
  int? get maxOutputTokens => throw _privateConstructorUsedError;
  bool get streamingOutput => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionSettingsCopyWith<SessionSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionSettingsCopyWith<$Res> {
  factory $SessionSettingsCopyWith(
          SessionSettings value, $Res Function(SessionSettings) then) =
      _$SessionSettingsCopyWithImpl<$Res, SessionSettings>;
  @useResult
  $Res call(
      {String? systemPrompt,
      int? maxContextMessages,
      double? temperature,
      double? topP,
      int? maxOutputTokens,
      bool streamingOutput});
}

/// @nodoc
class _$SessionSettingsCopyWithImpl<$Res, $Val extends SessionSettings>
    implements $SessionSettingsCopyWith<$Res> {
  _$SessionSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemPrompt = freezed,
    Object? maxContextMessages = freezed,
    Object? temperature = freezed,
    Object? topP = freezed,
    Object? maxOutputTokens = freezed,
    Object? streamingOutput = null,
  }) {
    return _then(_value.copyWith(
      systemPrompt: freezed == systemPrompt
          ? _value.systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      maxContextMessages: freezed == maxContextMessages
          ? _value.maxContextMessages
          : maxContextMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
      topP: freezed == topP
          ? _value.topP
          : topP // ignore: cast_nullable_to_non_nullable
              as double?,
      maxOutputTokens: freezed == maxOutputTokens
          ? _value.maxOutputTokens
          : maxOutputTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      streamingOutput: null == streamingOutput
          ? _value.streamingOutput
          : streamingOutput // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionSettingsImplCopyWith<$Res>
    implements $SessionSettingsCopyWith<$Res> {
  factory _$$SessionSettingsImplCopyWith(_$SessionSettingsImpl value,
          $Res Function(_$SessionSettingsImpl) then) =
      __$$SessionSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? systemPrompt,
      int? maxContextMessages,
      double? temperature,
      double? topP,
      int? maxOutputTokens,
      bool streamingOutput});
}

/// @nodoc
class __$$SessionSettingsImplCopyWithImpl<$Res>
    extends _$SessionSettingsCopyWithImpl<$Res, _$SessionSettingsImpl>
    implements _$$SessionSettingsImplCopyWith<$Res> {
  __$$SessionSettingsImplCopyWithImpl(
      _$SessionSettingsImpl _value, $Res Function(_$SessionSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemPrompt = freezed,
    Object? maxContextMessages = freezed,
    Object? temperature = freezed,
    Object? topP = freezed,
    Object? maxOutputTokens = freezed,
    Object? streamingOutput = null,
  }) {
    return _then(_$SessionSettingsImpl(
      systemPrompt: freezed == systemPrompt
          ? _value.systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      maxContextMessages: freezed == maxContextMessages
          ? _value.maxContextMessages
          : maxContextMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
      topP: freezed == topP
          ? _value.topP
          : topP // ignore: cast_nullable_to_non_nullable
              as double?,
      maxOutputTokens: freezed == maxOutputTokens
          ? _value.maxOutputTokens
          : maxOutputTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      streamingOutput: null == streamingOutput
          ? _value.streamingOutput
          : streamingOutput // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionSettingsImpl implements _SessionSettings {
  const _$SessionSettingsImpl(
      {this.systemPrompt,
      this.maxContextMessages,
      this.temperature,
      this.topP,
      this.maxOutputTokens,
      this.streamingOutput = true});

  factory _$SessionSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionSettingsImplFromJson(json);

  @override
  final String? systemPrompt;
  @override
  final int? maxContextMessages;
  @override
  final double? temperature;
  @override
  final double? topP;
  @override
  final int? maxOutputTokens;
  @override
  @JsonKey()
  final bool streamingOutput;

  @override
  String toString() {
    return 'SessionSettings(systemPrompt: $systemPrompt, maxContextMessages: $maxContextMessages, temperature: $temperature, topP: $topP, maxOutputTokens: $maxOutputTokens, streamingOutput: $streamingOutput)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionSettingsImpl &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(other.maxContextMessages, maxContextMessages) ||
                other.maxContextMessages == maxContextMessages) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.topP, topP) || other.topP == topP) &&
            (identical(other.maxOutputTokens, maxOutputTokens) ||
                other.maxOutputTokens == maxOutputTokens) &&
            (identical(other.streamingOutput, streamingOutput) ||
                other.streamingOutput == streamingOutput));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, systemPrompt, maxContextMessages,
      temperature, topP, maxOutputTokens, streamingOutput);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionSettingsImplCopyWith<_$SessionSettingsImpl> get copyWith =>
      __$$SessionSettingsImplCopyWithImpl<_$SessionSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionSettingsImplToJson(
      this,
    );
  }
}

abstract class _SessionSettings implements SessionSettings {
  const factory _SessionSettings(
      {final String? systemPrompt,
      final int? maxContextMessages,
      final double? temperature,
      final double? topP,
      final int? maxOutputTokens,
      final bool streamingOutput}) = _$SessionSettingsImpl;

  factory _SessionSettings.fromJson(Map<String, dynamic> json) =
      _$SessionSettingsImpl.fromJson;

  @override
  String? get systemPrompt;
  @override
  int? get maxContextMessages;
  @override
  double? get temperature;
  @override
  double? get topP;
  @override
  int? get maxOutputTokens;
  @override
  bool get streamingOutput;
  @override
  @JsonKey(ignore: true)
  _$$SessionSettingsImplCopyWith<_$SessionSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
