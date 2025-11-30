// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'copilot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CopilotEntity _$CopilotEntityFromJson(Map<String, dynamic> json) {
  return _CopilotEntity.fromJson(json);
}

/// @nodoc
mixin _$CopilotEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get picUrl => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;
  bool get starred => throw _privateConstructorUsedError;
  int get usedCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CopilotEntityCopyWith<CopilotEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CopilotEntityCopyWith<$Res> {
  factory $CopilotEntityCopyWith(
          CopilotEntity value, $Res Function(CopilotEntity) then) =
      _$CopilotEntityCopyWithImpl<$Res, CopilotEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? picUrl,
      String prompt,
      bool starred,
      int usedCount,
      DateTime createdAt});
}

/// @nodoc
class _$CopilotEntityCopyWithImpl<$Res, $Val extends CopilotEntity>
    implements $CopilotEntityCopyWith<$Res> {
  _$CopilotEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? picUrl = freezed,
    Object? prompt = null,
    Object? starred = null,
    Object? usedCount = null,
    Object? createdAt = null,
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
      picUrl: freezed == picUrl
          ? _value.picUrl
          : picUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value.starred
          : starred // ignore: cast_nullable_to_non_nullable
              as bool,
      usedCount: null == usedCount
          ? _value.usedCount
          : usedCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CopilotEntityImplCopyWith<$Res>
    implements $CopilotEntityCopyWith<$Res> {
  factory _$$CopilotEntityImplCopyWith(
          _$CopilotEntityImpl value, $Res Function(_$CopilotEntityImpl) then) =
      __$$CopilotEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? picUrl,
      String prompt,
      bool starred,
      int usedCount,
      DateTime createdAt});
}

/// @nodoc
class __$$CopilotEntityImplCopyWithImpl<$Res>
    extends _$CopilotEntityCopyWithImpl<$Res, _$CopilotEntityImpl>
    implements _$$CopilotEntityImplCopyWith<$Res> {
  __$$CopilotEntityImplCopyWithImpl(
      _$CopilotEntityImpl _value, $Res Function(_$CopilotEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? picUrl = freezed,
    Object? prompt = null,
    Object? starred = null,
    Object? usedCount = null,
    Object? createdAt = null,
  }) {
    return _then(_$CopilotEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      picUrl: freezed == picUrl
          ? _value.picUrl
          : picUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value.starred
          : starred // ignore: cast_nullable_to_non_nullable
              as bool,
      usedCount: null == usedCount
          ? _value.usedCount
          : usedCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CopilotEntityImpl implements _CopilotEntity {
  const _$CopilotEntityImpl(
      {required this.id,
      required this.name,
      this.picUrl,
      required this.prompt,
      this.starred = false,
      this.usedCount = 0,
      required this.createdAt});

  factory _$CopilotEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CopilotEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? picUrl;
  @override
  final String prompt;
  @override
  @JsonKey()
  final bool starred;
  @override
  @JsonKey()
  final int usedCount;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'CopilotEntity(id: $id, name: $name, picUrl: $picUrl, prompt: $prompt, starred: $starred, usedCount: $usedCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CopilotEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.picUrl, picUrl) || other.picUrl == picUrl) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.starred, starred) || other.starred == starred) &&
            (identical(other.usedCount, usedCount) ||
                other.usedCount == usedCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, picUrl, prompt, starred, usedCount, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CopilotEntityImplCopyWith<_$CopilotEntityImpl> get copyWith =>
      __$$CopilotEntityImplCopyWithImpl<_$CopilotEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CopilotEntityImplToJson(
      this,
    );
  }
}

abstract class _CopilotEntity implements CopilotEntity {
  const factory _CopilotEntity(
      {required final String id,
      required final String name,
      final String? picUrl,
      required final String prompt,
      final bool starred,
      final int usedCount,
      required final DateTime createdAt}) = _$CopilotEntityImpl;

  factory _CopilotEntity.fromJson(Map<String, dynamic> json) =
      _$CopilotEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get picUrl;
  @override
  String get prompt;
  @override
  bool get starred;
  @override
  int get usedCount;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CopilotEntityImplCopyWith<_$CopilotEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
