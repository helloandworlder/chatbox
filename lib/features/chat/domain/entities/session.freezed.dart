// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionEntity _$SessionEntityFromJson(Map<String, dynamic> json) {
  return _SessionEntity.fromJson(json);
}

/// @nodoc
mixin _$SessionEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get starred => throw _privateConstructorUsedError;
  String? get copilotId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get settings => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionEntityCopyWith<SessionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionEntityCopyWith<$Res> {
  factory $SessionEntityCopyWith(
          SessionEntity value, $Res Function(SessionEntity) then) =
      _$SessionEntityCopyWithImpl<$Res, SessionEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      bool starred,
      String? copilotId,
      Map<String, dynamic>? settings,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$SessionEntityCopyWithImpl<$Res, $Val extends SessionEntity>
    implements $SessionEntityCopyWith<$Res> {
  _$SessionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? starred = null,
    Object? copilotId = freezed,
    Object? settings = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value.starred
          : starred // ignore: cast_nullable_to_non_nullable
              as bool,
      copilotId: freezed == copilotId
          ? _value.copilotId
          : copilotId // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionEntityImplCopyWith<$Res>
    implements $SessionEntityCopyWith<$Res> {
  factory _$$SessionEntityImplCopyWith(
          _$SessionEntityImpl value, $Res Function(_$SessionEntityImpl) then) =
      __$$SessionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      bool starred,
      String? copilotId,
      Map<String, dynamic>? settings,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$SessionEntityImplCopyWithImpl<$Res>
    extends _$SessionEntityCopyWithImpl<$Res, _$SessionEntityImpl>
    implements _$$SessionEntityImplCopyWith<$Res> {
  __$$SessionEntityImplCopyWithImpl(
      _$SessionEntityImpl _value, $Res Function(_$SessionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? starred = null,
    Object? copilotId = freezed,
    Object? settings = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SessionEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value.starred
          : starred // ignore: cast_nullable_to_non_nullable
              as bool,
      copilotId: freezed == copilotId
          ? _value.copilotId
          : copilotId // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: freezed == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionEntityImpl implements _SessionEntity {
  const _$SessionEntityImpl(
      {required this.id,
      required this.name,
      this.type = 'chat',
      this.starred = false,
      this.copilotId,
      final Map<String, dynamic>? settings,
      required this.createdAt,
      required this.updatedAt})
      : _settings = settings;

  factory _$SessionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final bool starred;
  @override
  final String? copilotId;
  final Map<String, dynamic>? _settings;
  @override
  Map<String, dynamic>? get settings {
    final value = _settings;
    if (value == null) return null;
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SessionEntity(id: $id, name: $name, type: $type, starred: $starred, copilotId: $copilotId, settings: $settings, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.starred, starred) || other.starred == starred) &&
            (identical(other.copilotId, copilotId) ||
                other.copilotId == copilotId) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      starred,
      copilotId,
      const DeepCollectionEquality().hash(_settings),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionEntityImplCopyWith<_$SessionEntityImpl> get copyWith =>
      __$$SessionEntityImplCopyWithImpl<_$SessionEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionEntityImplToJson(
      this,
    );
  }
}

abstract class _SessionEntity implements SessionEntity {
  const factory _SessionEntity(
      {required final String id,
      required final String name,
      final String type,
      final bool starred,
      final String? copilotId,
      final Map<String, dynamic>? settings,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$SessionEntityImpl;

  factory _SessionEntity.fromJson(Map<String, dynamic> json) =
      _$SessionEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  bool get starred;
  @override
  String? get copilotId;
  @override
  Map<String, dynamic>? get settings;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SessionEntityImplCopyWith<_$SessionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
