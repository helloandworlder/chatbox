// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'knowledge_base.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KnowledgeBaseEntity _$KnowledgeBaseEntityFromJson(Map<String, dynamic> json) {
  return _KnowledgeBaseEntity.fromJson(json);
}

/// @nodoc
mixin _$KnowledgeBaseEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  KnowledgeBaseIndexStatus get indexStatus =>
      throw _privateConstructorUsedError;
  String? get indexError => throw _privateConstructorUsedError;
  int get fileCount => throw _privateConstructorUsedError;
  int get chunkCount => throw _privateConstructorUsedError;
  int get embeddingDimensions => throw _privateConstructorUsedError;
  String? get embeddingProviderId => throw _privateConstructorUsedError;
  String? get embeddingModel => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KnowledgeBaseEntityCopyWith<KnowledgeBaseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KnowledgeBaseEntityCopyWith<$Res> {
  factory $KnowledgeBaseEntityCopyWith(
          KnowledgeBaseEntity value, $Res Function(KnowledgeBaseEntity) then) =
      _$KnowledgeBaseEntityCopyWithImpl<$Res, KnowledgeBaseEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      KnowledgeBaseIndexStatus indexStatus,
      String? indexError,
      int fileCount,
      int chunkCount,
      int embeddingDimensions,
      String? embeddingProviderId,
      String? embeddingModel,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$KnowledgeBaseEntityCopyWithImpl<$Res, $Val extends KnowledgeBaseEntity>
    implements $KnowledgeBaseEntityCopyWith<$Res> {
  _$KnowledgeBaseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? indexStatus = null,
    Object? indexError = freezed,
    Object? fileCount = null,
    Object? chunkCount = null,
    Object? embeddingDimensions = null,
    Object? embeddingProviderId = freezed,
    Object? embeddingModel = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      indexStatus: null == indexStatus
          ? _value.indexStatus
          : indexStatus // ignore: cast_nullable_to_non_nullable
              as KnowledgeBaseIndexStatus,
      indexError: freezed == indexError
          ? _value.indexError
          : indexError // ignore: cast_nullable_to_non_nullable
              as String?,
      fileCount: null == fileCount
          ? _value.fileCount
          : fileCount // ignore: cast_nullable_to_non_nullable
              as int,
      chunkCount: null == chunkCount
          ? _value.chunkCount
          : chunkCount // ignore: cast_nullable_to_non_nullable
              as int,
      embeddingDimensions: null == embeddingDimensions
          ? _value.embeddingDimensions
          : embeddingDimensions // ignore: cast_nullable_to_non_nullable
              as int,
      embeddingProviderId: freezed == embeddingProviderId
          ? _value.embeddingProviderId
          : embeddingProviderId // ignore: cast_nullable_to_non_nullable
              as String?,
      embeddingModel: freezed == embeddingModel
          ? _value.embeddingModel
          : embeddingModel // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$KnowledgeBaseEntityImplCopyWith<$Res>
    implements $KnowledgeBaseEntityCopyWith<$Res> {
  factory _$$KnowledgeBaseEntityImplCopyWith(_$KnowledgeBaseEntityImpl value,
          $Res Function(_$KnowledgeBaseEntityImpl) then) =
      __$$KnowledgeBaseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      KnowledgeBaseIndexStatus indexStatus,
      String? indexError,
      int fileCount,
      int chunkCount,
      int embeddingDimensions,
      String? embeddingProviderId,
      String? embeddingModel,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$KnowledgeBaseEntityImplCopyWithImpl<$Res>
    extends _$KnowledgeBaseEntityCopyWithImpl<$Res, _$KnowledgeBaseEntityImpl>
    implements _$$KnowledgeBaseEntityImplCopyWith<$Res> {
  __$$KnowledgeBaseEntityImplCopyWithImpl(_$KnowledgeBaseEntityImpl _value,
      $Res Function(_$KnowledgeBaseEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? indexStatus = null,
    Object? indexError = freezed,
    Object? fileCount = null,
    Object? chunkCount = null,
    Object? embeddingDimensions = null,
    Object? embeddingProviderId = freezed,
    Object? embeddingModel = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$KnowledgeBaseEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      indexStatus: null == indexStatus
          ? _value.indexStatus
          : indexStatus // ignore: cast_nullable_to_non_nullable
              as KnowledgeBaseIndexStatus,
      indexError: freezed == indexError
          ? _value.indexError
          : indexError // ignore: cast_nullable_to_non_nullable
              as String?,
      fileCount: null == fileCount
          ? _value.fileCount
          : fileCount // ignore: cast_nullable_to_non_nullable
              as int,
      chunkCount: null == chunkCount
          ? _value.chunkCount
          : chunkCount // ignore: cast_nullable_to_non_nullable
              as int,
      embeddingDimensions: null == embeddingDimensions
          ? _value.embeddingDimensions
          : embeddingDimensions // ignore: cast_nullable_to_non_nullable
              as int,
      embeddingProviderId: freezed == embeddingProviderId
          ? _value.embeddingProviderId
          : embeddingProviderId // ignore: cast_nullable_to_non_nullable
              as String?,
      embeddingModel: freezed == embeddingModel
          ? _value.embeddingModel
          : embeddingModel // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$KnowledgeBaseEntityImpl implements _KnowledgeBaseEntity {
  const _$KnowledgeBaseEntityImpl(
      {required this.id,
      required this.name,
      this.description,
      this.indexStatus = KnowledgeBaseIndexStatus.idle,
      this.indexError,
      this.fileCount = 0,
      this.chunkCount = 0,
      this.embeddingDimensions = 1536,
      this.embeddingProviderId,
      this.embeddingModel,
      required this.createdAt,
      required this.updatedAt});

  factory _$KnowledgeBaseEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$KnowledgeBaseEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final KnowledgeBaseIndexStatus indexStatus;
  @override
  final String? indexError;
  @override
  @JsonKey()
  final int fileCount;
  @override
  @JsonKey()
  final int chunkCount;
  @override
  @JsonKey()
  final int embeddingDimensions;
  @override
  final String? embeddingProviderId;
  @override
  final String? embeddingModel;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'KnowledgeBaseEntity(id: $id, name: $name, description: $description, indexStatus: $indexStatus, indexError: $indexError, fileCount: $fileCount, chunkCount: $chunkCount, embeddingDimensions: $embeddingDimensions, embeddingProviderId: $embeddingProviderId, embeddingModel: $embeddingModel, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KnowledgeBaseEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.indexStatus, indexStatus) ||
                other.indexStatus == indexStatus) &&
            (identical(other.indexError, indexError) ||
                other.indexError == indexError) &&
            (identical(other.fileCount, fileCount) ||
                other.fileCount == fileCount) &&
            (identical(other.chunkCount, chunkCount) ||
                other.chunkCount == chunkCount) &&
            (identical(other.embeddingDimensions, embeddingDimensions) ||
                other.embeddingDimensions == embeddingDimensions) &&
            (identical(other.embeddingProviderId, embeddingProviderId) ||
                other.embeddingProviderId == embeddingProviderId) &&
            (identical(other.embeddingModel, embeddingModel) ||
                other.embeddingModel == embeddingModel) &&
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
      description,
      indexStatus,
      indexError,
      fileCount,
      chunkCount,
      embeddingDimensions,
      embeddingProviderId,
      embeddingModel,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KnowledgeBaseEntityImplCopyWith<_$KnowledgeBaseEntityImpl> get copyWith =>
      __$$KnowledgeBaseEntityImplCopyWithImpl<_$KnowledgeBaseEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KnowledgeBaseEntityImplToJson(
      this,
    );
  }
}

abstract class _KnowledgeBaseEntity implements KnowledgeBaseEntity {
  const factory _KnowledgeBaseEntity(
      {required final String id,
      required final String name,
      final String? description,
      final KnowledgeBaseIndexStatus indexStatus,
      final String? indexError,
      final int fileCount,
      final int chunkCount,
      final int embeddingDimensions,
      final String? embeddingProviderId,
      final String? embeddingModel,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$KnowledgeBaseEntityImpl;

  factory _KnowledgeBaseEntity.fromJson(Map<String, dynamic> json) =
      _$KnowledgeBaseEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  KnowledgeBaseIndexStatus get indexStatus;
  @override
  String? get indexError;
  @override
  int get fileCount;
  @override
  int get chunkCount;
  @override
  int get embeddingDimensions;
  @override
  String? get embeddingProviderId;
  @override
  String? get embeddingModel;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$KnowledgeBaseEntityImplCopyWith<_$KnowledgeBaseEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KnowledgeBaseFileEntity _$KnowledgeBaseFileEntityFromJson(
    Map<String, dynamic> json) {
  return _KnowledgeBaseFileEntity.fromJson(json);
}

/// @nodoc
mixin _$KnowledgeBaseFileEntity {
  String get id => throw _privateConstructorUsedError;
  String get knowledgeBaseId => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  KnowledgeBaseIndexStatus get indexStatus =>
      throw _privateConstructorUsedError;
  String? get indexError => throw _privateConstructorUsedError;
  int get chunkCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KnowledgeBaseFileEntityCopyWith<KnowledgeBaseFileEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KnowledgeBaseFileEntityCopyWith<$Res> {
  factory $KnowledgeBaseFileEntityCopyWith(KnowledgeBaseFileEntity value,
          $Res Function(KnowledgeBaseFileEntity) then) =
      _$KnowledgeBaseFileEntityCopyWithImpl<$Res, KnowledgeBaseFileEntity>;
  @useResult
  $Res call(
      {String id,
      String knowledgeBaseId,
      String fileName,
      String filePath,
      String mimeType,
      int fileSize,
      KnowledgeBaseIndexStatus indexStatus,
      String? indexError,
      int chunkCount,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$KnowledgeBaseFileEntityCopyWithImpl<$Res,
        $Val extends KnowledgeBaseFileEntity>
    implements $KnowledgeBaseFileEntityCopyWith<$Res> {
  _$KnowledgeBaseFileEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? knowledgeBaseId = null,
    Object? fileName = null,
    Object? filePath = null,
    Object? mimeType = null,
    Object? fileSize = null,
    Object? indexStatus = null,
    Object? indexError = freezed,
    Object? chunkCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      knowledgeBaseId: null == knowledgeBaseId
          ? _value.knowledgeBaseId
          : knowledgeBaseId // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      indexStatus: null == indexStatus
          ? _value.indexStatus
          : indexStatus // ignore: cast_nullable_to_non_nullable
              as KnowledgeBaseIndexStatus,
      indexError: freezed == indexError
          ? _value.indexError
          : indexError // ignore: cast_nullable_to_non_nullable
              as String?,
      chunkCount: null == chunkCount
          ? _value.chunkCount
          : chunkCount // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$KnowledgeBaseFileEntityImplCopyWith<$Res>
    implements $KnowledgeBaseFileEntityCopyWith<$Res> {
  factory _$$KnowledgeBaseFileEntityImplCopyWith(
          _$KnowledgeBaseFileEntityImpl value,
          $Res Function(_$KnowledgeBaseFileEntityImpl) then) =
      __$$KnowledgeBaseFileEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String knowledgeBaseId,
      String fileName,
      String filePath,
      String mimeType,
      int fileSize,
      KnowledgeBaseIndexStatus indexStatus,
      String? indexError,
      int chunkCount,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$KnowledgeBaseFileEntityImplCopyWithImpl<$Res>
    extends _$KnowledgeBaseFileEntityCopyWithImpl<$Res,
        _$KnowledgeBaseFileEntityImpl>
    implements _$$KnowledgeBaseFileEntityImplCopyWith<$Res> {
  __$$KnowledgeBaseFileEntityImplCopyWithImpl(
      _$KnowledgeBaseFileEntityImpl _value,
      $Res Function(_$KnowledgeBaseFileEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? knowledgeBaseId = null,
    Object? fileName = null,
    Object? filePath = null,
    Object? mimeType = null,
    Object? fileSize = null,
    Object? indexStatus = null,
    Object? indexError = freezed,
    Object? chunkCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$KnowledgeBaseFileEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      knowledgeBaseId: null == knowledgeBaseId
          ? _value.knowledgeBaseId
          : knowledgeBaseId // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      indexStatus: null == indexStatus
          ? _value.indexStatus
          : indexStatus // ignore: cast_nullable_to_non_nullable
              as KnowledgeBaseIndexStatus,
      indexError: freezed == indexError
          ? _value.indexError
          : indexError // ignore: cast_nullable_to_non_nullable
              as String?,
      chunkCount: null == chunkCount
          ? _value.chunkCount
          : chunkCount // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$KnowledgeBaseFileEntityImpl implements _KnowledgeBaseFileEntity {
  const _$KnowledgeBaseFileEntityImpl(
      {required this.id,
      required this.knowledgeBaseId,
      required this.fileName,
      required this.filePath,
      this.mimeType = '',
      this.fileSize = 0,
      this.indexStatus = KnowledgeBaseIndexStatus.idle,
      this.indexError,
      this.chunkCount = 0,
      required this.createdAt,
      required this.updatedAt});

  factory _$KnowledgeBaseFileEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$KnowledgeBaseFileEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String knowledgeBaseId;
  @override
  final String fileName;
  @override
  final String filePath;
  @override
  @JsonKey()
  final String mimeType;
  @override
  @JsonKey()
  final int fileSize;
  @override
  @JsonKey()
  final KnowledgeBaseIndexStatus indexStatus;
  @override
  final String? indexError;
  @override
  @JsonKey()
  final int chunkCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'KnowledgeBaseFileEntity(id: $id, knowledgeBaseId: $knowledgeBaseId, fileName: $fileName, filePath: $filePath, mimeType: $mimeType, fileSize: $fileSize, indexStatus: $indexStatus, indexError: $indexError, chunkCount: $chunkCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KnowledgeBaseFileEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.knowledgeBaseId, knowledgeBaseId) ||
                other.knowledgeBaseId == knowledgeBaseId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.indexStatus, indexStatus) ||
                other.indexStatus == indexStatus) &&
            (identical(other.indexError, indexError) ||
                other.indexError == indexError) &&
            (identical(other.chunkCount, chunkCount) ||
                other.chunkCount == chunkCount) &&
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
      knowledgeBaseId,
      fileName,
      filePath,
      mimeType,
      fileSize,
      indexStatus,
      indexError,
      chunkCount,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KnowledgeBaseFileEntityImplCopyWith<_$KnowledgeBaseFileEntityImpl>
      get copyWith => __$$KnowledgeBaseFileEntityImplCopyWithImpl<
          _$KnowledgeBaseFileEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KnowledgeBaseFileEntityImplToJson(
      this,
    );
  }
}

abstract class _KnowledgeBaseFileEntity implements KnowledgeBaseFileEntity {
  const factory _KnowledgeBaseFileEntity(
      {required final String id,
      required final String knowledgeBaseId,
      required final String fileName,
      required final String filePath,
      final String mimeType,
      final int fileSize,
      final KnowledgeBaseIndexStatus indexStatus,
      final String? indexError,
      final int chunkCount,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$KnowledgeBaseFileEntityImpl;

  factory _KnowledgeBaseFileEntity.fromJson(Map<String, dynamic> json) =
      _$KnowledgeBaseFileEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get knowledgeBaseId;
  @override
  String get fileName;
  @override
  String get filePath;
  @override
  String get mimeType;
  @override
  int get fileSize;
  @override
  KnowledgeBaseIndexStatus get indexStatus;
  @override
  String? get indexError;
  @override
  int get chunkCount;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$KnowledgeBaseFileEntityImplCopyWith<_$KnowledgeBaseFileEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

/// @nodoc
mixin _$SearchResult {
  String get chunkId => throw _privateConstructorUsedError;
  String get knowledgeBaseId => throw _privateConstructorUsedError;
  String get fileId => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get chunkIndex => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
          SearchResult value, $Res Function(SearchResult) then) =
      _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call(
      {String chunkId,
      String knowledgeBaseId,
      String fileId,
      String fileName,
      String content,
      int chunkIndex,
      double score});
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chunkId = null,
    Object? knowledgeBaseId = null,
    Object? fileId = null,
    Object? fileName = null,
    Object? content = null,
    Object? chunkIndex = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      chunkId: null == chunkId
          ? _value.chunkId
          : chunkId // ignore: cast_nullable_to_non_nullable
              as String,
      knowledgeBaseId: null == knowledgeBaseId
          ? _value.knowledgeBaseId
          : knowledgeBaseId // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      chunkIndex: null == chunkIndex
          ? _value.chunkIndex
          : chunkIndex // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchResultImplCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$SearchResultImplCopyWith(
          _$SearchResultImpl value, $Res Function(_$SearchResultImpl) then) =
      __$$SearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chunkId,
      String knowledgeBaseId,
      String fileId,
      String fileName,
      String content,
      int chunkIndex,
      double score});
}

/// @nodoc
class __$$SearchResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$SearchResultImpl>
    implements _$$SearchResultImplCopyWith<$Res> {
  __$$SearchResultImplCopyWithImpl(
      _$SearchResultImpl _value, $Res Function(_$SearchResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chunkId = null,
    Object? knowledgeBaseId = null,
    Object? fileId = null,
    Object? fileName = null,
    Object? content = null,
    Object? chunkIndex = null,
    Object? score = null,
  }) {
    return _then(_$SearchResultImpl(
      chunkId: null == chunkId
          ? _value.chunkId
          : chunkId // ignore: cast_nullable_to_non_nullable
              as String,
      knowledgeBaseId: null == knowledgeBaseId
          ? _value.knowledgeBaseId
          : knowledgeBaseId // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      chunkIndex: null == chunkIndex
          ? _value.chunkIndex
          : chunkIndex // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResultImpl implements _SearchResult {
  const _$SearchResultImpl(
      {required this.chunkId,
      required this.knowledgeBaseId,
      required this.fileId,
      required this.fileName,
      required this.content,
      required this.chunkIndex,
      required this.score});

  factory _$SearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResultImplFromJson(json);

  @override
  final String chunkId;
  @override
  final String knowledgeBaseId;
  @override
  final String fileId;
  @override
  final String fileName;
  @override
  final String content;
  @override
  final int chunkIndex;
  @override
  final double score;

  @override
  String toString() {
    return 'SearchResult(chunkId: $chunkId, knowledgeBaseId: $knowledgeBaseId, fileId: $fileId, fileName: $fileName, content: $content, chunkIndex: $chunkIndex, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultImpl &&
            (identical(other.chunkId, chunkId) || other.chunkId == chunkId) &&
            (identical(other.knowledgeBaseId, knowledgeBaseId) ||
                other.knowledgeBaseId == knowledgeBaseId) &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.chunkIndex, chunkIndex) ||
                other.chunkIndex == chunkIndex) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chunkId, knowledgeBaseId, fileId,
      fileName, content, chunkIndex, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      __$$SearchResultImplCopyWithImpl<_$SearchResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResultImplToJson(
      this,
    );
  }
}

abstract class _SearchResult implements SearchResult {
  const factory _SearchResult(
      {required final String chunkId,
      required final String knowledgeBaseId,
      required final String fileId,
      required final String fileName,
      required final String content,
      required final int chunkIndex,
      required final double score}) = _$SearchResultImpl;

  factory _SearchResult.fromJson(Map<String, dynamic> json) =
      _$SearchResultImpl.fromJson;

  @override
  String get chunkId;
  @override
  String get knowledgeBaseId;
  @override
  String get fileId;
  @override
  String get fileName;
  @override
  String get content;
  @override
  int get chunkIndex;
  @override
  double get score;
  @override
  @JsonKey(ignore: true)
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
