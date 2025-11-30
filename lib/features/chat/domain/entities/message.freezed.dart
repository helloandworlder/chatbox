// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) {
  return _MessageEntity.fromJson(json);
}

/// @nodoc
mixin _$MessageEntity {
  String get id => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  MessageRole get role => throw _privateConstructorUsedError;
  List<ContentPart> get content => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  int? get inputTokens => throw _privateConstructorUsedError;
  int? get outputTokens => throw _privateConstructorUsedError;
  bool get generating => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) then) =
      _$MessageEntityCopyWithImpl<$Res, MessageEntity>;
  @useResult
  $Res call(
      {String id,
      String sessionId,
      MessageRole role,
      List<ContentPart> content,
      String? model,
      int? inputTokens,
      int? outputTokens,
      bool generating,
      DateTime createdAt});
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res, $Val extends MessageEntity>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? role = null,
    Object? content = null,
    Object? model = freezed,
    Object? inputTokens = freezed,
    Object? outputTokens = freezed,
    Object? generating = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as MessageRole,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<ContentPart>,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      inputTokens: freezed == inputTokens
          ? _value.inputTokens
          : inputTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      outputTokens: freezed == outputTokens
          ? _value.outputTokens
          : outputTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      generating: null == generating
          ? _value.generating
          : generating // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageEntityImplCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$$MessageEntityImplCopyWith(
          _$MessageEntityImpl value, $Res Function(_$MessageEntityImpl) then) =
      __$$MessageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sessionId,
      MessageRole role,
      List<ContentPart> content,
      String? model,
      int? inputTokens,
      int? outputTokens,
      bool generating,
      DateTime createdAt});
}

/// @nodoc
class __$$MessageEntityImplCopyWithImpl<$Res>
    extends _$MessageEntityCopyWithImpl<$Res, _$MessageEntityImpl>
    implements _$$MessageEntityImplCopyWith<$Res> {
  __$$MessageEntityImplCopyWithImpl(
      _$MessageEntityImpl _value, $Res Function(_$MessageEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? role = null,
    Object? content = null,
    Object? model = freezed,
    Object? inputTokens = freezed,
    Object? outputTokens = freezed,
    Object? generating = null,
    Object? createdAt = null,
  }) {
    return _then(_$MessageEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as MessageRole,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<ContentPart>,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      inputTokens: freezed == inputTokens
          ? _value.inputTokens
          : inputTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      outputTokens: freezed == outputTokens
          ? _value.outputTokens
          : outputTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      generating: null == generating
          ? _value.generating
          : generating // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageEntityImpl implements _MessageEntity {
  const _$MessageEntityImpl(
      {required this.id,
      required this.sessionId,
      required this.role,
      required final List<ContentPart> content,
      this.model,
      this.inputTokens,
      this.outputTokens,
      this.generating = false,
      required this.createdAt})
      : _content = content;

  factory _$MessageEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String sessionId;
  @override
  final MessageRole role;
  final List<ContentPart> _content;
  @override
  List<ContentPart> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  final String? model;
  @override
  final int? inputTokens;
  @override
  final int? outputTokens;
  @override
  @JsonKey()
  final bool generating;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'MessageEntity(id: $id, sessionId: $sessionId, role: $role, content: $content, model: $model, inputTokens: $inputTokens, outputTokens: $outputTokens, generating: $generating, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.inputTokens, inputTokens) ||
                other.inputTokens == inputTokens) &&
            (identical(other.outputTokens, outputTokens) ||
                other.outputTokens == outputTokens) &&
            (identical(other.generating, generating) ||
                other.generating == generating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sessionId,
      role,
      const DeepCollectionEquality().hash(_content),
      model,
      inputTokens,
      outputTokens,
      generating,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      __$$MessageEntityImplCopyWithImpl<_$MessageEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageEntityImplToJson(
      this,
    );
  }
}

abstract class _MessageEntity implements MessageEntity {
  const factory _MessageEntity(
      {required final String id,
      required final String sessionId,
      required final MessageRole role,
      required final List<ContentPart> content,
      final String? model,
      final int? inputTokens,
      final int? outputTokens,
      final bool generating,
      required final DateTime createdAt}) = _$MessageEntityImpl;

  factory _MessageEntity.fromJson(Map<String, dynamic> json) =
      _$MessageEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get sessionId;
  @override
  MessageRole get role;
  @override
  List<ContentPart> get content;
  @override
  String? get model;
  @override
  int? get inputTokens;
  @override
  int? get outputTokens;
  @override
  bool get generating;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentPart _$ContentPartFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'text':
      return TextContent.fromJson(json);
    case 'image':
      return ImageContent.fromJson(json);
    case 'file':
      return FileContent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ContentPart',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ContentPart {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(String url, String? alt) image,
    required TResult Function(String path, String name) file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String url, String? alt)? image,
    TResult? Function(String path, String name)? file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String url, String? alt)? image,
    TResult Function(String path, String name)? file,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextContent value) text,
    required TResult Function(ImageContent value) image,
    required TResult Function(FileContent value) file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextContent value)? text,
    TResult? Function(ImageContent value)? image,
    TResult? Function(FileContent value)? file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextContent value)? text,
    TResult Function(ImageContent value)? image,
    TResult Function(FileContent value)? file,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentPartCopyWith<$Res> {
  factory $ContentPartCopyWith(
          ContentPart value, $Res Function(ContentPart) then) =
      _$ContentPartCopyWithImpl<$Res, ContentPart>;
}

/// @nodoc
class _$ContentPartCopyWithImpl<$Res, $Val extends ContentPart>
    implements $ContentPartCopyWith<$Res> {
  _$ContentPartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TextContentImplCopyWith<$Res> {
  factory _$$TextContentImplCopyWith(
          _$TextContentImpl value, $Res Function(_$TextContentImpl) then) =
      __$$TextContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$TextContentImplCopyWithImpl<$Res>
    extends _$ContentPartCopyWithImpl<$Res, _$TextContentImpl>
    implements _$$TextContentImplCopyWith<$Res> {
  __$$TextContentImplCopyWithImpl(
      _$TextContentImpl _value, $Res Function(_$TextContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$TextContentImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextContentImpl implements TextContent {
  const _$TextContentImpl({required this.text, final String? $type})
      : $type = $type ?? 'text';

  factory _$TextContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextContentImplFromJson(json);

  @override
  final String text;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContentPart.text(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextContentImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextContentImplCopyWith<_$TextContentImpl> get copyWith =>
      __$$TextContentImplCopyWithImpl<_$TextContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(String url, String? alt) image,
    required TResult Function(String path, String name) file,
  }) {
    return text(this.text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String url, String? alt)? image,
    TResult? Function(String path, String name)? file,
  }) {
    return text?.call(this.text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String url, String? alt)? image,
    TResult Function(String path, String name)? file,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this.text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextContent value) text,
    required TResult Function(ImageContent value) image,
    required TResult Function(FileContent value) file,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextContent value)? text,
    TResult? Function(ImageContent value)? image,
    TResult? Function(FileContent value)? file,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextContent value)? text,
    TResult Function(ImageContent value)? image,
    TResult Function(FileContent value)? file,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextContentImplToJson(
      this,
    );
  }
}

abstract class TextContent implements ContentPart {
  const factory TextContent({required final String text}) = _$TextContentImpl;

  factory TextContent.fromJson(Map<String, dynamic> json) =
      _$TextContentImpl.fromJson;

  String get text;
  @JsonKey(ignore: true)
  _$$TextContentImplCopyWith<_$TextContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageContentImplCopyWith<$Res> {
  factory _$$ImageContentImplCopyWith(
          _$ImageContentImpl value, $Res Function(_$ImageContentImpl) then) =
      __$$ImageContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String url, String? alt});
}

/// @nodoc
class __$$ImageContentImplCopyWithImpl<$Res>
    extends _$ContentPartCopyWithImpl<$Res, _$ImageContentImpl>
    implements _$$ImageContentImplCopyWith<$Res> {
  __$$ImageContentImplCopyWithImpl(
      _$ImageContentImpl _value, $Res Function(_$ImageContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? alt = freezed,
  }) {
    return _then(_$ImageContentImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      alt: freezed == alt
          ? _value.alt
          : alt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageContentImpl implements ImageContent {
  const _$ImageContentImpl({required this.url, this.alt, final String? $type})
      : $type = $type ?? 'image';

  factory _$ImageContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageContentImplFromJson(json);

  @override
  final String url;
  @override
  final String? alt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContentPart.image(url: $url, alt: $alt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageContentImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.alt, alt) || other.alt == alt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, alt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageContentImplCopyWith<_$ImageContentImpl> get copyWith =>
      __$$ImageContentImplCopyWithImpl<_$ImageContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(String url, String? alt) image,
    required TResult Function(String path, String name) file,
  }) {
    return image(url, alt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String url, String? alt)? image,
    TResult? Function(String path, String name)? file,
  }) {
    return image?.call(url, alt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String url, String? alt)? image,
    TResult Function(String path, String name)? file,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(url, alt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextContent value) text,
    required TResult Function(ImageContent value) image,
    required TResult Function(FileContent value) file,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextContent value)? text,
    TResult? Function(ImageContent value)? image,
    TResult? Function(FileContent value)? file,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextContent value)? text,
    TResult Function(ImageContent value)? image,
    TResult Function(FileContent value)? file,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageContentImplToJson(
      this,
    );
  }
}

abstract class ImageContent implements ContentPart {
  const factory ImageContent({required final String url, final String? alt}) =
      _$ImageContentImpl;

  factory ImageContent.fromJson(Map<String, dynamic> json) =
      _$ImageContentImpl.fromJson;

  String get url;
  String? get alt;
  @JsonKey(ignore: true)
  _$$ImageContentImplCopyWith<_$ImageContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileContentImplCopyWith<$Res> {
  factory _$$FileContentImplCopyWith(
          _$FileContentImpl value, $Res Function(_$FileContentImpl) then) =
      __$$FileContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String path, String name});
}

/// @nodoc
class __$$FileContentImplCopyWithImpl<$Res>
    extends _$ContentPartCopyWithImpl<$Res, _$FileContentImpl>
    implements _$$FileContentImplCopyWith<$Res> {
  __$$FileContentImplCopyWithImpl(
      _$FileContentImpl _value, $Res Function(_$FileContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? name = null,
  }) {
    return _then(_$FileContentImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileContentImpl implements FileContent {
  const _$FileContentImpl(
      {required this.path, required this.name, final String? $type})
      : $type = $type ?? 'file';

  factory _$FileContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileContentImplFromJson(json);

  @override
  final String path;
  @override
  final String name;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ContentPart.file(path: $path, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileContentImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileContentImplCopyWith<_$FileContentImpl> get copyWith =>
      __$$FileContentImplCopyWithImpl<_$FileContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(String url, String? alt) image,
    required TResult Function(String path, String name) file,
  }) {
    return file(path, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String url, String? alt)? image,
    TResult? Function(String path, String name)? file,
  }) {
    return file?.call(path, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String url, String? alt)? image,
    TResult Function(String path, String name)? file,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(path, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextContent value) text,
    required TResult Function(ImageContent value) image,
    required TResult Function(FileContent value) file,
  }) {
    return file(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextContent value)? text,
    TResult? Function(ImageContent value)? image,
    TResult? Function(FileContent value)? file,
  }) {
    return file?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextContent value)? text,
    TResult Function(ImageContent value)? image,
    TResult Function(FileContent value)? file,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FileContentImplToJson(
      this,
    );
  }
}

abstract class FileContent implements ContentPart {
  const factory FileContent(
      {required final String path,
      required final String name}) = _$FileContentImpl;

  factory FileContent.fromJson(Map<String, dynamic> json) =
      _$FileContentImpl.fromJson;

  String get path;
  String get name;
  @JsonKey(ignore: true)
  _$$FileContentImplCopyWith<_$FileContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
