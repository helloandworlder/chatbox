// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mcp_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MCPServerConfig _$MCPServerConfigFromJson(Map<String, dynamic> json) {
  return _MCPServerConfig.fromJson(json);
}

/// @nodoc
mixin _$MCPServerConfig {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  MCPTransportConfig get transport => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MCPServerConfigCopyWith<MCPServerConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServerConfigCopyWith<$Res> {
  factory $MCPServerConfigCopyWith(
          MCPServerConfig value, $Res Function(MCPServerConfig) then) =
      _$MCPServerConfigCopyWithImpl<$Res, MCPServerConfig>;
  @useResult
  $Res call(
      {String id, String name, bool enabled, MCPTransportConfig transport});

  $MCPTransportConfigCopyWith<$Res> get transport;
}

/// @nodoc
class _$MCPServerConfigCopyWithImpl<$Res, $Val extends MCPServerConfig>
    implements $MCPServerConfigCopyWith<$Res> {
  _$MCPServerConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? enabled = null,
    Object? transport = null,
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
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      transport: null == transport
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as MCPTransportConfig,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MCPTransportConfigCopyWith<$Res> get transport {
    return $MCPTransportConfigCopyWith<$Res>(_value.transport, (value) {
      return _then(_value.copyWith(transport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MCPServerConfigImplCopyWith<$Res>
    implements $MCPServerConfigCopyWith<$Res> {
  factory _$$MCPServerConfigImplCopyWith(_$MCPServerConfigImpl value,
          $Res Function(_$MCPServerConfigImpl) then) =
      __$$MCPServerConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, bool enabled, MCPTransportConfig transport});

  @override
  $MCPTransportConfigCopyWith<$Res> get transport;
}

/// @nodoc
class __$$MCPServerConfigImplCopyWithImpl<$Res>
    extends _$MCPServerConfigCopyWithImpl<$Res, _$MCPServerConfigImpl>
    implements _$$MCPServerConfigImplCopyWith<$Res> {
  __$$MCPServerConfigImplCopyWithImpl(
      _$MCPServerConfigImpl _value, $Res Function(_$MCPServerConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? enabled = null,
    Object? transport = null,
  }) {
    return _then(_$MCPServerConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      transport: null == transport
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as MCPTransportConfig,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPServerConfigImpl implements _MCPServerConfig {
  const _$MCPServerConfigImpl(
      {required this.id,
      required this.name,
      this.enabled = false,
      required this.transport});

  factory _$MCPServerConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPServerConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final MCPTransportConfig transport;

  @override
  String toString() {
    return 'MCPServerConfig(id: $id, name: $name, enabled: $enabled, transport: $transport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServerConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.transport, transport) ||
                other.transport == transport));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, enabled, transport);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServerConfigImplCopyWith<_$MCPServerConfigImpl> get copyWith =>
      __$$MCPServerConfigImplCopyWithImpl<_$MCPServerConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPServerConfigImplToJson(
      this,
    );
  }
}

abstract class _MCPServerConfig implements MCPServerConfig {
  const factory _MCPServerConfig(
      {required final String id,
      required final String name,
      final bool enabled,
      required final MCPTransportConfig transport}) = _$MCPServerConfigImpl;

  factory _MCPServerConfig.fromJson(Map<String, dynamic> json) =
      _$MCPServerConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get enabled;
  @override
  MCPTransportConfig get transport;
  @override
  @JsonKey(ignore: true)
  _$$MCPServerConfigImplCopyWith<_$MCPServerConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPTransportConfig _$MCPTransportConfigFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'stdio':
      return MCPStdioTransportConfig.fromJson(json);
    case 'http':
      return MCPHttpTransportConfig.fromJson(json);
    case 'sse':
      return MCPSseTransportConfig.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'MCPTransportConfig',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$MCPTransportConfig {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command, List<String> args, Map<String, String> env)
        stdio,
    required TResult Function(String url, Map<String, String> headers) http,
    required TResult Function(String url, Map<String, String> headers) sse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult? Function(String url, Map<String, String> headers)? http,
    TResult? Function(String url, Map<String, String> headers)? sse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult Function(String url, Map<String, String> headers)? http,
    TResult Function(String url, Map<String, String> headers)? sse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MCPStdioTransportConfig value) stdio,
    required TResult Function(MCPHttpTransportConfig value) http,
    required TResult Function(MCPSseTransportConfig value) sse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MCPStdioTransportConfig value)? stdio,
    TResult? Function(MCPHttpTransportConfig value)? http,
    TResult? Function(MCPSseTransportConfig value)? sse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MCPStdioTransportConfig value)? stdio,
    TResult Function(MCPHttpTransportConfig value)? http,
    TResult Function(MCPSseTransportConfig value)? sse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPTransportConfigCopyWith<$Res> {
  factory $MCPTransportConfigCopyWith(
          MCPTransportConfig value, $Res Function(MCPTransportConfig) then) =
      _$MCPTransportConfigCopyWithImpl<$Res, MCPTransportConfig>;
}

/// @nodoc
class _$MCPTransportConfigCopyWithImpl<$Res, $Val extends MCPTransportConfig>
    implements $MCPTransportConfigCopyWith<$Res> {
  _$MCPTransportConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MCPStdioTransportConfigImplCopyWith<$Res> {
  factory _$$MCPStdioTransportConfigImplCopyWith(
          _$MCPStdioTransportConfigImpl value,
          $Res Function(_$MCPStdioTransportConfigImpl) then) =
      __$$MCPStdioTransportConfigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String command, List<String> args, Map<String, String> env});
}

/// @nodoc
class __$$MCPStdioTransportConfigImplCopyWithImpl<$Res>
    extends _$MCPTransportConfigCopyWithImpl<$Res,
        _$MCPStdioTransportConfigImpl>
    implements _$$MCPStdioTransportConfigImplCopyWith<$Res> {
  __$$MCPStdioTransportConfigImplCopyWithImpl(
      _$MCPStdioTransportConfigImpl _value,
      $Res Function(_$MCPStdioTransportConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? args = null,
    Object? env = null,
  }) {
    return _then(_$MCPStdioTransportConfigImpl(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      args: null == args
          ? _value._args
          : args // ignore: cast_nullable_to_non_nullable
              as List<String>,
      env: null == env
          ? _value._env
          : env // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPStdioTransportConfigImpl implements MCPStdioTransportConfig {
  const _$MCPStdioTransportConfigImpl(
      {required this.command,
      final List<String> args = const [],
      final Map<String, String> env = const {},
      final String? $type})
      : _args = args,
        _env = env,
        $type = $type ?? 'stdio';

  factory _$MCPStdioTransportConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPStdioTransportConfigImplFromJson(json);

  @override
  final String command;
  final List<String> _args;
  @override
  @JsonKey()
  List<String> get args {
    if (_args is EqualUnmodifiableListView) return _args;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_args);
  }

  final Map<String, String> _env;
  @override
  @JsonKey()
  Map<String, String> get env {
    if (_env is EqualUnmodifiableMapView) return _env;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_env);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'MCPTransportConfig.stdio(command: $command, args: $args, env: $env)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPStdioTransportConfigImpl &&
            (identical(other.command, command) || other.command == command) &&
            const DeepCollectionEquality().equals(other._args, _args) &&
            const DeepCollectionEquality().equals(other._env, _env));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      command,
      const DeepCollectionEquality().hash(_args),
      const DeepCollectionEquality().hash(_env));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPStdioTransportConfigImplCopyWith<_$MCPStdioTransportConfigImpl>
      get copyWith => __$$MCPStdioTransportConfigImplCopyWithImpl<
          _$MCPStdioTransportConfigImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command, List<String> args, Map<String, String> env)
        stdio,
    required TResult Function(String url, Map<String, String> headers) http,
    required TResult Function(String url, Map<String, String> headers) sse,
  }) {
    return stdio(command, args, env);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult? Function(String url, Map<String, String> headers)? http,
    TResult? Function(String url, Map<String, String> headers)? sse,
  }) {
    return stdio?.call(command, args, env);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult Function(String url, Map<String, String> headers)? http,
    TResult Function(String url, Map<String, String> headers)? sse,
    required TResult orElse(),
  }) {
    if (stdio != null) {
      return stdio(command, args, env);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MCPStdioTransportConfig value) stdio,
    required TResult Function(MCPHttpTransportConfig value) http,
    required TResult Function(MCPSseTransportConfig value) sse,
  }) {
    return stdio(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MCPStdioTransportConfig value)? stdio,
    TResult? Function(MCPHttpTransportConfig value)? http,
    TResult? Function(MCPSseTransportConfig value)? sse,
  }) {
    return stdio?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MCPStdioTransportConfig value)? stdio,
    TResult Function(MCPHttpTransportConfig value)? http,
    TResult Function(MCPSseTransportConfig value)? sse,
    required TResult orElse(),
  }) {
    if (stdio != null) {
      return stdio(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPStdioTransportConfigImplToJson(
      this,
    );
  }
}

abstract class MCPStdioTransportConfig implements MCPTransportConfig {
  const factory MCPStdioTransportConfig(
      {required final String command,
      final List<String> args,
      final Map<String, String> env}) = _$MCPStdioTransportConfigImpl;

  factory MCPStdioTransportConfig.fromJson(Map<String, dynamic> json) =
      _$MCPStdioTransportConfigImpl.fromJson;

  String get command;
  List<String> get args;
  Map<String, String> get env;
  @JsonKey(ignore: true)
  _$$MCPStdioTransportConfigImplCopyWith<_$MCPStdioTransportConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MCPHttpTransportConfigImplCopyWith<$Res> {
  factory _$$MCPHttpTransportConfigImplCopyWith(
          _$MCPHttpTransportConfigImpl value,
          $Res Function(_$MCPHttpTransportConfigImpl) then) =
      __$$MCPHttpTransportConfigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String url, Map<String, String> headers});
}

/// @nodoc
class __$$MCPHttpTransportConfigImplCopyWithImpl<$Res>
    extends _$MCPTransportConfigCopyWithImpl<$Res, _$MCPHttpTransportConfigImpl>
    implements _$$MCPHttpTransportConfigImplCopyWith<$Res> {
  __$$MCPHttpTransportConfigImplCopyWithImpl(
      _$MCPHttpTransportConfigImpl _value,
      $Res Function(_$MCPHttpTransportConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? headers = null,
  }) {
    return _then(_$MCPHttpTransportConfigImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPHttpTransportConfigImpl implements MCPHttpTransportConfig {
  const _$MCPHttpTransportConfigImpl(
      {required this.url,
      final Map<String, String> headers = const {},
      final String? $type})
      : _headers = headers,
        $type = $type ?? 'http';

  factory _$MCPHttpTransportConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPHttpTransportConfigImplFromJson(json);

  @override
  final String url;
  final Map<String, String> _headers;
  @override
  @JsonKey()
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'MCPTransportConfig.http(url: $url, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPHttpTransportConfigImpl &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, const DeepCollectionEquality().hash(_headers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPHttpTransportConfigImplCopyWith<_$MCPHttpTransportConfigImpl>
      get copyWith => __$$MCPHttpTransportConfigImplCopyWithImpl<
          _$MCPHttpTransportConfigImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command, List<String> args, Map<String, String> env)
        stdio,
    required TResult Function(String url, Map<String, String> headers) http,
    required TResult Function(String url, Map<String, String> headers) sse,
  }) {
    return http(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult? Function(String url, Map<String, String> headers)? http,
    TResult? Function(String url, Map<String, String> headers)? sse,
  }) {
    return http?.call(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult Function(String url, Map<String, String> headers)? http,
    TResult Function(String url, Map<String, String> headers)? sse,
    required TResult orElse(),
  }) {
    if (http != null) {
      return http(url, headers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MCPStdioTransportConfig value) stdio,
    required TResult Function(MCPHttpTransportConfig value) http,
    required TResult Function(MCPSseTransportConfig value) sse,
  }) {
    return http(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MCPStdioTransportConfig value)? stdio,
    TResult? Function(MCPHttpTransportConfig value)? http,
    TResult? Function(MCPSseTransportConfig value)? sse,
  }) {
    return http?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MCPStdioTransportConfig value)? stdio,
    TResult Function(MCPHttpTransportConfig value)? http,
    TResult Function(MCPSseTransportConfig value)? sse,
    required TResult orElse(),
  }) {
    if (http != null) {
      return http(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPHttpTransportConfigImplToJson(
      this,
    );
  }
}

abstract class MCPHttpTransportConfig implements MCPTransportConfig {
  const factory MCPHttpTransportConfig(
      {required final String url,
      final Map<String, String> headers}) = _$MCPHttpTransportConfigImpl;

  factory MCPHttpTransportConfig.fromJson(Map<String, dynamic> json) =
      _$MCPHttpTransportConfigImpl.fromJson;

  String get url;
  Map<String, String> get headers;
  @JsonKey(ignore: true)
  _$$MCPHttpTransportConfigImplCopyWith<_$MCPHttpTransportConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MCPSseTransportConfigImplCopyWith<$Res> {
  factory _$$MCPSseTransportConfigImplCopyWith(
          _$MCPSseTransportConfigImpl value,
          $Res Function(_$MCPSseTransportConfigImpl) then) =
      __$$MCPSseTransportConfigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String url, Map<String, String> headers});
}

/// @nodoc
class __$$MCPSseTransportConfigImplCopyWithImpl<$Res>
    extends _$MCPTransportConfigCopyWithImpl<$Res, _$MCPSseTransportConfigImpl>
    implements _$$MCPSseTransportConfigImplCopyWith<$Res> {
  __$$MCPSseTransportConfigImplCopyWithImpl(_$MCPSseTransportConfigImpl _value,
      $Res Function(_$MCPSseTransportConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? headers = null,
  }) {
    return _then(_$MCPSseTransportConfigImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPSseTransportConfigImpl implements MCPSseTransportConfig {
  const _$MCPSseTransportConfigImpl(
      {required this.url,
      final Map<String, String> headers = const {},
      final String? $type})
      : _headers = headers,
        $type = $type ?? 'sse';

  factory _$MCPSseTransportConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPSseTransportConfigImplFromJson(json);

  @override
  final String url;
  final Map<String, String> _headers;
  @override
  @JsonKey()
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'MCPTransportConfig.sse(url: $url, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPSseTransportConfigImpl &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, const DeepCollectionEquality().hash(_headers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPSseTransportConfigImplCopyWith<_$MCPSseTransportConfigImpl>
      get copyWith => __$$MCPSseTransportConfigImplCopyWithImpl<
          _$MCPSseTransportConfigImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String command, List<String> args, Map<String, String> env)
        stdio,
    required TResult Function(String url, Map<String, String> headers) http,
    required TResult Function(String url, Map<String, String> headers) sse,
  }) {
    return sse(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult? Function(String url, Map<String, String> headers)? http,
    TResult? Function(String url, Map<String, String> headers)? sse,
  }) {
    return sse?.call(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String command, List<String> args, Map<String, String> env)?
        stdio,
    TResult Function(String url, Map<String, String> headers)? http,
    TResult Function(String url, Map<String, String> headers)? sse,
    required TResult orElse(),
  }) {
    if (sse != null) {
      return sse(url, headers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MCPStdioTransportConfig value) stdio,
    required TResult Function(MCPHttpTransportConfig value) http,
    required TResult Function(MCPSseTransportConfig value) sse,
  }) {
    return sse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MCPStdioTransportConfig value)? stdio,
    TResult? Function(MCPHttpTransportConfig value)? http,
    TResult? Function(MCPSseTransportConfig value)? sse,
  }) {
    return sse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MCPStdioTransportConfig value)? stdio,
    TResult Function(MCPHttpTransportConfig value)? http,
    TResult Function(MCPSseTransportConfig value)? sse,
    required TResult orElse(),
  }) {
    if (sse != null) {
      return sse(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPSseTransportConfigImplToJson(
      this,
    );
  }
}

abstract class MCPSseTransportConfig implements MCPTransportConfig {
  const factory MCPSseTransportConfig(
      {required final String url,
      final Map<String, String> headers}) = _$MCPSseTransportConfigImpl;

  factory MCPSseTransportConfig.fromJson(Map<String, dynamic> json) =
      _$MCPSseTransportConfigImpl.fromJson;

  String get url;
  Map<String, String> get headers;
  @JsonKey(ignore: true)
  _$$MCPSseTransportConfigImplCopyWith<_$MCPSseTransportConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MCPServerStatus {
  MCPServerState get state => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  List<MCPToolInfo> get tools => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MCPServerStatusCopyWith<MCPServerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServerStatusCopyWith<$Res> {
  factory $MCPServerStatusCopyWith(
          MCPServerStatus value, $Res Function(MCPServerStatus) then) =
      _$MCPServerStatusCopyWithImpl<$Res, MCPServerStatus>;
  @useResult
  $Res call({MCPServerState state, String? error, List<MCPToolInfo> tools});
}

/// @nodoc
class _$MCPServerStatusCopyWithImpl<$Res, $Val extends MCPServerStatus>
    implements $MCPServerStatusCopyWith<$Res> {
  _$MCPServerStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? error = freezed,
    Object? tools = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MCPServerState,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      tools: null == tools
          ? _value.tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<MCPToolInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPServerStatusImplCopyWith<$Res>
    implements $MCPServerStatusCopyWith<$Res> {
  factory _$$MCPServerStatusImplCopyWith(_$MCPServerStatusImpl value,
          $Res Function(_$MCPServerStatusImpl) then) =
      __$$MCPServerStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MCPServerState state, String? error, List<MCPToolInfo> tools});
}

/// @nodoc
class __$$MCPServerStatusImplCopyWithImpl<$Res>
    extends _$MCPServerStatusCopyWithImpl<$Res, _$MCPServerStatusImpl>
    implements _$$MCPServerStatusImplCopyWith<$Res> {
  __$$MCPServerStatusImplCopyWithImpl(
      _$MCPServerStatusImpl _value, $Res Function(_$MCPServerStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? error = freezed,
    Object? tools = null,
  }) {
    return _then(_$MCPServerStatusImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MCPServerState,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      tools: null == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<MCPToolInfo>,
    ));
  }
}

/// @nodoc

class _$MCPServerStatusImpl implements _MCPServerStatus {
  const _$MCPServerStatusImpl(
      {required this.state,
      this.error,
      final List<MCPToolInfo> tools = const []})
      : _tools = tools;

  @override
  final MCPServerState state;
  @override
  final String? error;
  final List<MCPToolInfo> _tools;
  @override
  @JsonKey()
  List<MCPToolInfo> get tools {
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tools);
  }

  @override
  String toString() {
    return 'MCPServerStatus(state: $state, error: $error, tools: $tools)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServerStatusImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._tools, _tools));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, state, error, const DeepCollectionEquality().hash(_tools));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServerStatusImplCopyWith<_$MCPServerStatusImpl> get copyWith =>
      __$$MCPServerStatusImplCopyWithImpl<_$MCPServerStatusImpl>(
          this, _$identity);
}

abstract class _MCPServerStatus implements MCPServerStatus {
  const factory _MCPServerStatus(
      {required final MCPServerState state,
      final String? error,
      final List<MCPToolInfo> tools}) = _$MCPServerStatusImpl;

  @override
  MCPServerState get state;
  @override
  String? get error;
  @override
  List<MCPToolInfo> get tools;
  @override
  @JsonKey(ignore: true)
  _$$MCPServerStatusImplCopyWith<_$MCPServerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPToolInfo _$MCPToolInfoFromJson(Map<String, dynamic> json) {
  return _MCPToolInfo.fromJson(json);
}

/// @nodoc
mixin _$MCPToolInfo {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get inputSchema => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MCPToolInfoCopyWith<MCPToolInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPToolInfoCopyWith<$Res> {
  factory $MCPToolInfoCopyWith(
          MCPToolInfo value, $Res Function(MCPToolInfo) then) =
      _$MCPToolInfoCopyWithImpl<$Res, MCPToolInfo>;
  @useResult
  $Res call(
      {String name, String? description, Map<String, dynamic>? inputSchema});
}

/// @nodoc
class _$MCPToolInfoCopyWithImpl<$Res, $Val extends MCPToolInfo>
    implements $MCPToolInfoCopyWith<$Res> {
  _$MCPToolInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? inputSchema = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      inputSchema: freezed == inputSchema
          ? _value.inputSchema
          : inputSchema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPToolInfoImplCopyWith<$Res>
    implements $MCPToolInfoCopyWith<$Res> {
  factory _$$MCPToolInfoImplCopyWith(
          _$MCPToolInfoImpl value, $Res Function(_$MCPToolInfoImpl) then) =
      __$$MCPToolInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String? description, Map<String, dynamic>? inputSchema});
}

/// @nodoc
class __$$MCPToolInfoImplCopyWithImpl<$Res>
    extends _$MCPToolInfoCopyWithImpl<$Res, _$MCPToolInfoImpl>
    implements _$$MCPToolInfoImplCopyWith<$Res> {
  __$$MCPToolInfoImplCopyWithImpl(
      _$MCPToolInfoImpl _value, $Res Function(_$MCPToolInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? inputSchema = freezed,
  }) {
    return _then(_$MCPToolInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      inputSchema: freezed == inputSchema
          ? _value._inputSchema
          : inputSchema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPToolInfoImpl implements _MCPToolInfo {
  const _$MCPToolInfoImpl(
      {required this.name,
      this.description,
      final Map<String, dynamic>? inputSchema})
      : _inputSchema = inputSchema;

  factory _$MCPToolInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPToolInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  final Map<String, dynamic>? _inputSchema;
  @override
  Map<String, dynamic>? get inputSchema {
    final value = _inputSchema;
    if (value == null) return null;
    if (_inputSchema is EqualUnmodifiableMapView) return _inputSchema;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MCPToolInfo(name: $name, description: $description, inputSchema: $inputSchema)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPToolInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._inputSchema, _inputSchema));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_inputSchema));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPToolInfoImplCopyWith<_$MCPToolInfoImpl> get copyWith =>
      __$$MCPToolInfoImplCopyWithImpl<_$MCPToolInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPToolInfoImplToJson(
      this,
    );
  }
}

abstract class _MCPToolInfo implements MCPToolInfo {
  const factory _MCPToolInfo(
      {required final String name,
      final String? description,
      final Map<String, dynamic>? inputSchema}) = _$MCPToolInfoImpl;

  factory _MCPToolInfo.fromJson(Map<String, dynamic> json) =
      _$MCPToolInfoImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  Map<String, dynamic>? get inputSchema;
  @override
  @JsonKey(ignore: true)
  _$$MCPToolInfoImplCopyWith<_$MCPToolInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
