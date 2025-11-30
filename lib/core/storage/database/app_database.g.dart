// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('chat'));
  static const VerificationMeta _starredMeta =
      const VerificationMeta('starred');
  @override
  late final GeneratedColumn<bool> starred = GeneratedColumn<bool>(
      'starred', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("starred" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _copilotIdMeta =
      const VerificationMeta('copilotId');
  @override
  late final GeneratedColumn<String> copilotId = GeneratedColumn<String>(
      'copilot_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settingsJsonMeta =
      const VerificationMeta('settingsJson');
  @override
  late final GeneratedColumn<String> settingsJson = GeneratedColumn<String>(
      'settings_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, starred, copilotId, settingsJson, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('starred')) {
      context.handle(_starredMeta,
          starred.isAcceptableOrUnknown(data['starred']!, _starredMeta));
    }
    if (data.containsKey('copilot_id')) {
      context.handle(_copilotIdMeta,
          copilotId.isAcceptableOrUnknown(data['copilot_id']!, _copilotIdMeta));
    }
    if (data.containsKey('settings_json')) {
      context.handle(
          _settingsJsonMeta,
          settingsJson.isAcceptableOrUnknown(
              data['settings_json']!, _settingsJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      starred: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}starred'])!,
      copilotId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}copilot_id']),
      settingsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settings_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final String name;
  final String type;
  final bool starred;
  final String? copilotId;
  final String? settingsJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Session(
      {required this.id,
      required this.name,
      required this.type,
      required this.starred,
      this.copilotId,
      this.settingsJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['starred'] = Variable<bool>(starred);
    if (!nullToAbsent || copilotId != null) {
      map['copilot_id'] = Variable<String>(copilotId);
    }
    if (!nullToAbsent || settingsJson != null) {
      map['settings_json'] = Variable<String>(settingsJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      starred: Value(starred),
      copilotId: copilotId == null && nullToAbsent
          ? const Value.absent()
          : Value(copilotId),
      settingsJson: settingsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(settingsJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      starred: serializer.fromJson<bool>(json['starred']),
      copilotId: serializer.fromJson<String?>(json['copilotId']),
      settingsJson: serializer.fromJson<String?>(json['settingsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'starred': serializer.toJson<bool>(starred),
      'copilotId': serializer.toJson<String?>(copilotId),
      'settingsJson': serializer.toJson<String?>(settingsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Session copyWith(
          {String? id,
          String? name,
          String? type,
          bool? starred,
          Value<String?> copilotId = const Value.absent(),
          Value<String?> settingsJson = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Session(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        starred: starred ?? this.starred,
        copilotId: copilotId.present ? copilotId.value : this.copilotId,
        settingsJson:
            settingsJson.present ? settingsJson.value : this.settingsJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      starred: data.starred.present ? data.starred.value : this.starred,
      copilotId: data.copilotId.present ? data.copilotId.value : this.copilotId,
      settingsJson: data.settingsJson.present
          ? data.settingsJson.value
          : this.settingsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('starred: $starred, ')
          ..write('copilotId: $copilotId, ')
          ..write('settingsJson: $settingsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, type, starred, copilotId, settingsJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.starred == this.starred &&
          other.copilotId == this.copilotId &&
          other.settingsJson == this.settingsJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<bool> starred;
  final Value<String?> copilotId;
  final Value<String?> settingsJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.starred = const Value.absent(),
    this.copilotId = const Value.absent(),
    this.settingsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required String name,
    this.type = const Value.absent(),
    this.starred = const Value.absent(),
    this.copilotId = const Value.absent(),
    this.settingsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? starred,
    Expression<String>? copilotId,
    Expression<String>? settingsJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (starred != null) 'starred': starred,
      if (copilotId != null) 'copilot_id': copilotId,
      if (settingsJson != null) 'settings_json': settingsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<bool>? starred,
      Value<String?>? copilotId,
      Value<String?>? settingsJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SessionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      starred: starred ?? this.starred,
      copilotId: copilotId ?? this.copilotId,
      settingsJson: settingsJson ?? this.settingsJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (starred.present) {
      map['starred'] = Variable<bool>(starred.value);
    }
    if (copilotId.present) {
      map['copilot_id'] = Variable<String>(copilotId.value);
    }
    if (settingsJson.present) {
      map['settings_json'] = Variable<String>(settingsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('starred: $starred, ')
          ..write('copilotId: $copilotId, ')
          ..write('settingsJson: $settingsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentJsonMeta =
      const VerificationMeta('contentJson');
  @override
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
      'content_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _inputTokensMeta =
      const VerificationMeta('inputTokens');
  @override
  late final GeneratedColumn<int> inputTokens = GeneratedColumn<int>(
      'input_tokens', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _outputTokensMeta =
      const VerificationMeta('outputTokens');
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
      'output_tokens', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _generatingMeta =
      const VerificationMeta('generating');
  @override
  late final GeneratedColumn<bool> generating = GeneratedColumn<bool>(
      'generating', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("generating" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        role,
        contentJson,
        model,
        inputTokens,
        outputTokens,
        generating,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content_json')) {
      context.handle(
          _contentJsonMeta,
          contentJson.isAcceptableOrUnknown(
              data['content_json']!, _contentJsonMeta));
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    }
    if (data.containsKey('input_tokens')) {
      context.handle(
          _inputTokensMeta,
          inputTokens.isAcceptableOrUnknown(
              data['input_tokens']!, _inputTokensMeta));
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
          _outputTokensMeta,
          outputTokens.isAcceptableOrUnknown(
              data['output_tokens']!, _outputTokensMeta));
    }
    if (data.containsKey('generating')) {
      context.handle(
          _generatingMeta,
          generating.isAcceptableOrUnknown(
              data['generating']!, _generatingMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      contentJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_json'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model']),
      inputTokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}input_tokens']),
      outputTokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}output_tokens']),
      generating: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}generating'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String id;
  final String sessionId;
  final String role;
  final String contentJson;
  final String? model;
  final int? inputTokens;
  final int? outputTokens;
  final bool generating;
  final DateTime createdAt;
  const Message(
      {required this.id,
      required this.sessionId,
      required this.role,
      required this.contentJson,
      this.model,
      this.inputTokens,
      this.outputTokens,
      required this.generating,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['role'] = Variable<String>(role);
    map['content_json'] = Variable<String>(contentJson);
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || inputTokens != null) {
      map['input_tokens'] = Variable<int>(inputTokens);
    }
    if (!nullToAbsent || outputTokens != null) {
      map['output_tokens'] = Variable<int>(outputTokens);
    }
    map['generating'] = Variable<bool>(generating);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      role: Value(role),
      contentJson: Value(contentJson),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      inputTokens: inputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(inputTokens),
      outputTokens: outputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(outputTokens),
      generating: Value(generating),
      createdAt: Value(createdAt),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      role: serializer.fromJson<String>(json['role']),
      contentJson: serializer.fromJson<String>(json['contentJson']),
      model: serializer.fromJson<String?>(json['model']),
      inputTokens: serializer.fromJson<int?>(json['inputTokens']),
      outputTokens: serializer.fromJson<int?>(json['outputTokens']),
      generating: serializer.fromJson<bool>(json['generating']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'role': serializer.toJson<String>(role),
      'contentJson': serializer.toJson<String>(contentJson),
      'model': serializer.toJson<String?>(model),
      'inputTokens': serializer.toJson<int?>(inputTokens),
      'outputTokens': serializer.toJson<int?>(outputTokens),
      'generating': serializer.toJson<bool>(generating),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Message copyWith(
          {String? id,
          String? sessionId,
          String? role,
          String? contentJson,
          Value<String?> model = const Value.absent(),
          Value<int?> inputTokens = const Value.absent(),
          Value<int?> outputTokens = const Value.absent(),
          bool? generating,
          DateTime? createdAt}) =>
      Message(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        role: role ?? this.role,
        contentJson: contentJson ?? this.contentJson,
        model: model.present ? model.value : this.model,
        inputTokens: inputTokens.present ? inputTokens.value : this.inputTokens,
        outputTokens:
            outputTokens.present ? outputTokens.value : this.outputTokens,
        generating: generating ?? this.generating,
        createdAt: createdAt ?? this.createdAt,
      );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      role: data.role.present ? data.role.value : this.role,
      contentJson:
          data.contentJson.present ? data.contentJson.value : this.contentJson,
      model: data.model.present ? data.model.value : this.model,
      inputTokens:
          data.inputTokens.present ? data.inputTokens.value : this.inputTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      generating:
          data.generating.present ? data.generating.value : this.generating,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('contentJson: $contentJson, ')
          ..write('model: $model, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('generating: $generating, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, role, contentJson, model,
      inputTokens, outputTokens, generating, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.role == this.role &&
          other.contentJson == this.contentJson &&
          other.model == this.model &&
          other.inputTokens == this.inputTokens &&
          other.outputTokens == this.outputTokens &&
          other.generating == this.generating &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> role;
  final Value<String> contentJson;
  final Value<String?> model;
  final Value<int?> inputTokens;
  final Value<int?> outputTokens;
  final Value<bool> generating;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.role = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.model = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.generating = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required String sessionId,
    required String role,
    required String contentJson,
    this.model = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.generating = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        role = Value(role),
        contentJson = Value(contentJson);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? role,
    Expression<String>? contentJson,
    Expression<String>? model,
    Expression<int>? inputTokens,
    Expression<int>? outputTokens,
    Expression<bool>? generating,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (role != null) 'role': role,
      if (contentJson != null) 'content_json': contentJson,
      if (model != null) 'model': model,
      if (inputTokens != null) 'input_tokens': inputTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (generating != null) 'generating': generating,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? role,
      Value<String>? contentJson,
      Value<String?>? model,
      Value<int?>? inputTokens,
      Value<int?>? outputTokens,
      Value<bool>? generating,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MessagesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      role: role ?? this.role,
      contentJson: contentJson ?? this.contentJson,
      model: model ?? this.model,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      generating: generating ?? this.generating,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (inputTokens.present) {
      map['input_tokens'] = Variable<int>(inputTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (generating.present) {
      map['generating'] = Variable<bool>(generating.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('contentJson: $contentJson, ')
          ..write('model: $model, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('generating: $generating, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueJsonMeta =
      const VerificationMeta('valueJson');
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
      'value_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [key, valueJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(_valueJsonMeta,
          valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta));
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      valueJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value_json'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String valueJson;
  final DateTime updatedAt;
  const Setting(
      {required this.key, required this.valueJson, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      valueJson: Value(valueJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Setting copyWith({String? key, String? valueJson, DateTime? updatedAt}) =>
      Setting(
        key: key ?? this.key,
        valueJson: valueJson ?? this.valueJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.key == this.key &&
          other.valueJson == this.valueJson &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> valueJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String valueJson,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        valueJson = Value(valueJson);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? key,
      Value<String>? valueJson,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SettingsCompanion(
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $McpServersTable extends McpServers
    with TableInfo<$McpServersTable, McpServer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $McpServersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _transportJsonMeta =
      const VerificationMeta('transportJson');
  @override
  late final GeneratedColumn<String> transportJson = GeneratedColumn<String>(
      'transport_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, enabled, transportJson, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mcp_servers';
  @override
  VerificationContext validateIntegrity(Insertable<McpServer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('transport_json')) {
      context.handle(
          _transportJsonMeta,
          transportJson.isAcceptableOrUnknown(
              data['transport_json']!, _transportJsonMeta));
    } else if (isInserting) {
      context.missing(_transportJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  McpServer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return McpServer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
      transportJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transport_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $McpServersTable createAlias(String alias) {
    return $McpServersTable(attachedDatabase, alias);
  }
}

class McpServer extends DataClass implements Insertable<McpServer> {
  final String id;
  final String name;
  final bool enabled;
  final String transportJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const McpServer(
      {required this.id,
      required this.name,
      required this.enabled,
      required this.transportJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['enabled'] = Variable<bool>(enabled);
    map['transport_json'] = Variable<String>(transportJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  McpServersCompanion toCompanion(bool nullToAbsent) {
    return McpServersCompanion(
      id: Value(id),
      name: Value(name),
      enabled: Value(enabled),
      transportJson: Value(transportJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory McpServer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return McpServer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      transportJson: serializer.fromJson<String>(json['transportJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'enabled': serializer.toJson<bool>(enabled),
      'transportJson': serializer.toJson<String>(transportJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  McpServer copyWith(
          {String? id,
          String? name,
          bool? enabled,
          String? transportJson,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      McpServer(
        id: id ?? this.id,
        name: name ?? this.name,
        enabled: enabled ?? this.enabled,
        transportJson: transportJson ?? this.transportJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  McpServer copyWithCompanion(McpServersCompanion data) {
    return McpServer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      transportJson: data.transportJson.present
          ? data.transportJson.value
          : this.transportJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('McpServer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('enabled: $enabled, ')
          ..write('transportJson: $transportJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, enabled, transportJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is McpServer &&
          other.id == this.id &&
          other.name == this.name &&
          other.enabled == this.enabled &&
          other.transportJson == this.transportJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class McpServersCompanion extends UpdateCompanion<McpServer> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> enabled;
  final Value<String> transportJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const McpServersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.enabled = const Value.absent(),
    this.transportJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  McpServersCompanion.insert({
    required String id,
    required String name,
    this.enabled = const Value.absent(),
    required String transportJson,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        transportJson = Value(transportJson);
  static Insertable<McpServer> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? enabled,
    Expression<String>? transportJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (enabled != null) 'enabled': enabled,
      if (transportJson != null) 'transport_json': transportJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  McpServersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<bool>? enabled,
      Value<String>? transportJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return McpServersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
      transportJson: transportJson ?? this.transportJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (transportJson.present) {
      map['transport_json'] = Variable<String>(transportJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('McpServersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('enabled: $enabled, ')
          ..write('transportJson: $transportJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeBasesTable extends KnowledgeBases
    with TableInfo<$KnowledgeBasesTable, KnowledgeBase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeBasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _indexStatusMeta =
      const VerificationMeta('indexStatus');
  @override
  late final GeneratedColumn<String> indexStatus = GeneratedColumn<String>(
      'index_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('idle'));
  static const VerificationMeta _indexErrorMeta =
      const VerificationMeta('indexError');
  @override
  late final GeneratedColumn<String> indexError = GeneratedColumn<String>(
      'index_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileCountMeta =
      const VerificationMeta('fileCount');
  @override
  late final GeneratedColumn<int> fileCount = GeneratedColumn<int>(
      'file_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _chunkCountMeta =
      const VerificationMeta('chunkCount');
  @override
  late final GeneratedColumn<int> chunkCount = GeneratedColumn<int>(
      'chunk_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _embeddingDimensionsMeta =
      const VerificationMeta('embeddingDimensions');
  @override
  late final GeneratedColumn<int> embeddingDimensions = GeneratedColumn<int>(
      'embedding_dimensions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1536));
  static const VerificationMeta _embeddingProviderIdMeta =
      const VerificationMeta('embeddingProviderId');
  @override
  late final GeneratedColumn<String> embeddingProviderId =
      GeneratedColumn<String>('embedding_provider_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _embeddingModelMeta =
      const VerificationMeta('embeddingModel');
  @override
  late final GeneratedColumn<String> embeddingModel = GeneratedColumn<String>(
      'embedding_model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
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
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_bases';
  @override
  VerificationContext validateIntegrity(Insertable<KnowledgeBase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('index_status')) {
      context.handle(
          _indexStatusMeta,
          indexStatus.isAcceptableOrUnknown(
              data['index_status']!, _indexStatusMeta));
    }
    if (data.containsKey('index_error')) {
      context.handle(
          _indexErrorMeta,
          indexError.isAcceptableOrUnknown(
              data['index_error']!, _indexErrorMeta));
    }
    if (data.containsKey('file_count')) {
      context.handle(_fileCountMeta,
          fileCount.isAcceptableOrUnknown(data['file_count']!, _fileCountMeta));
    }
    if (data.containsKey('chunk_count')) {
      context.handle(
          _chunkCountMeta,
          chunkCount.isAcceptableOrUnknown(
              data['chunk_count']!, _chunkCountMeta));
    }
    if (data.containsKey('embedding_dimensions')) {
      context.handle(
          _embeddingDimensionsMeta,
          embeddingDimensions.isAcceptableOrUnknown(
              data['embedding_dimensions']!, _embeddingDimensionsMeta));
    }
    if (data.containsKey('embedding_provider_id')) {
      context.handle(
          _embeddingProviderIdMeta,
          embeddingProviderId.isAcceptableOrUnknown(
              data['embedding_provider_id']!, _embeddingProviderIdMeta));
    }
    if (data.containsKey('embedding_model')) {
      context.handle(
          _embeddingModelMeta,
          embeddingModel.isAcceptableOrUnknown(
              data['embedding_model']!, _embeddingModelMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeBase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeBase(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      indexStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}index_status'])!,
      indexError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}index_error']),
      fileCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_count'])!,
      chunkCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chunk_count'])!,
      embeddingDimensions: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}embedding_dimensions'])!,
      embeddingProviderId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}embedding_provider_id']),
      embeddingModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}embedding_model']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $KnowledgeBasesTable createAlias(String alias) {
    return $KnowledgeBasesTable(attachedDatabase, alias);
  }
}

class KnowledgeBase extends DataClass implements Insertable<KnowledgeBase> {
  final String id;
  final String name;
  final String? description;
  final String indexStatus;
  final String? indexError;
  final int fileCount;
  final int chunkCount;
  final int embeddingDimensions;
  final String? embeddingProviderId;
  final String? embeddingModel;
  final DateTime createdAt;
  final DateTime updatedAt;
  const KnowledgeBase(
      {required this.id,
      required this.name,
      this.description,
      required this.indexStatus,
      this.indexError,
      required this.fileCount,
      required this.chunkCount,
      required this.embeddingDimensions,
      this.embeddingProviderId,
      this.embeddingModel,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['index_status'] = Variable<String>(indexStatus);
    if (!nullToAbsent || indexError != null) {
      map['index_error'] = Variable<String>(indexError);
    }
    map['file_count'] = Variable<int>(fileCount);
    map['chunk_count'] = Variable<int>(chunkCount);
    map['embedding_dimensions'] = Variable<int>(embeddingDimensions);
    if (!nullToAbsent || embeddingProviderId != null) {
      map['embedding_provider_id'] = Variable<String>(embeddingProviderId);
    }
    if (!nullToAbsent || embeddingModel != null) {
      map['embedding_model'] = Variable<String>(embeddingModel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  KnowledgeBasesCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeBasesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      indexStatus: Value(indexStatus),
      indexError: indexError == null && nullToAbsent
          ? const Value.absent()
          : Value(indexError),
      fileCount: Value(fileCount),
      chunkCount: Value(chunkCount),
      embeddingDimensions: Value(embeddingDimensions),
      embeddingProviderId: embeddingProviderId == null && nullToAbsent
          ? const Value.absent()
          : Value(embeddingProviderId),
      embeddingModel: embeddingModel == null && nullToAbsent
          ? const Value.absent()
          : Value(embeddingModel),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory KnowledgeBase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeBase(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      indexStatus: serializer.fromJson<String>(json['indexStatus']),
      indexError: serializer.fromJson<String?>(json['indexError']),
      fileCount: serializer.fromJson<int>(json['fileCount']),
      chunkCount: serializer.fromJson<int>(json['chunkCount']),
      embeddingDimensions:
          serializer.fromJson<int>(json['embeddingDimensions']),
      embeddingProviderId:
          serializer.fromJson<String?>(json['embeddingProviderId']),
      embeddingModel: serializer.fromJson<String?>(json['embeddingModel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'indexStatus': serializer.toJson<String>(indexStatus),
      'indexError': serializer.toJson<String?>(indexError),
      'fileCount': serializer.toJson<int>(fileCount),
      'chunkCount': serializer.toJson<int>(chunkCount),
      'embeddingDimensions': serializer.toJson<int>(embeddingDimensions),
      'embeddingProviderId': serializer.toJson<String?>(embeddingProviderId),
      'embeddingModel': serializer.toJson<String?>(embeddingModel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  KnowledgeBase copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          String? indexStatus,
          Value<String?> indexError = const Value.absent(),
          int? fileCount,
          int? chunkCount,
          int? embeddingDimensions,
          Value<String?> embeddingProviderId = const Value.absent(),
          Value<String?> embeddingModel = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      KnowledgeBase(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        indexStatus: indexStatus ?? this.indexStatus,
        indexError: indexError.present ? indexError.value : this.indexError,
        fileCount: fileCount ?? this.fileCount,
        chunkCount: chunkCount ?? this.chunkCount,
        embeddingDimensions: embeddingDimensions ?? this.embeddingDimensions,
        embeddingProviderId: embeddingProviderId.present
            ? embeddingProviderId.value
            : this.embeddingProviderId,
        embeddingModel:
            embeddingModel.present ? embeddingModel.value : this.embeddingModel,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  KnowledgeBase copyWithCompanion(KnowledgeBasesCompanion data) {
    return KnowledgeBase(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      indexStatus:
          data.indexStatus.present ? data.indexStatus.value : this.indexStatus,
      indexError:
          data.indexError.present ? data.indexError.value : this.indexError,
      fileCount: data.fileCount.present ? data.fileCount.value : this.fileCount,
      chunkCount:
          data.chunkCount.present ? data.chunkCount.value : this.chunkCount,
      embeddingDimensions: data.embeddingDimensions.present
          ? data.embeddingDimensions.value
          : this.embeddingDimensions,
      embeddingProviderId: data.embeddingProviderId.present
          ? data.embeddingProviderId.value
          : this.embeddingProviderId,
      embeddingModel: data.embeddingModel.present
          ? data.embeddingModel.value
          : this.embeddingModel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeBase(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('indexStatus: $indexStatus, ')
          ..write('indexError: $indexError, ')
          ..write('fileCount: $fileCount, ')
          ..write('chunkCount: $chunkCount, ')
          ..write('embeddingDimensions: $embeddingDimensions, ')
          ..write('embeddingProviderId: $embeddingProviderId, ')
          ..write('embeddingModel: $embeddingModel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeBase &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.indexStatus == this.indexStatus &&
          other.indexError == this.indexError &&
          other.fileCount == this.fileCount &&
          other.chunkCount == this.chunkCount &&
          other.embeddingDimensions == this.embeddingDimensions &&
          other.embeddingProviderId == this.embeddingProviderId &&
          other.embeddingModel == this.embeddingModel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class KnowledgeBasesCompanion extends UpdateCompanion<KnowledgeBase> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> indexStatus;
  final Value<String?> indexError;
  final Value<int> fileCount;
  final Value<int> chunkCount;
  final Value<int> embeddingDimensions;
  final Value<String?> embeddingProviderId;
  final Value<String?> embeddingModel;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const KnowledgeBasesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.indexStatus = const Value.absent(),
    this.indexError = const Value.absent(),
    this.fileCount = const Value.absent(),
    this.chunkCount = const Value.absent(),
    this.embeddingDimensions = const Value.absent(),
    this.embeddingProviderId = const Value.absent(),
    this.embeddingModel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KnowledgeBasesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.indexStatus = const Value.absent(),
    this.indexError = const Value.absent(),
    this.fileCount = const Value.absent(),
    this.chunkCount = const Value.absent(),
    this.embeddingDimensions = const Value.absent(),
    this.embeddingProviderId = const Value.absent(),
    this.embeddingModel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<KnowledgeBase> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? indexStatus,
    Expression<String>? indexError,
    Expression<int>? fileCount,
    Expression<int>? chunkCount,
    Expression<int>? embeddingDimensions,
    Expression<String>? embeddingProviderId,
    Expression<String>? embeddingModel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (indexStatus != null) 'index_status': indexStatus,
      if (indexError != null) 'index_error': indexError,
      if (fileCount != null) 'file_count': fileCount,
      if (chunkCount != null) 'chunk_count': chunkCount,
      if (embeddingDimensions != null)
        'embedding_dimensions': embeddingDimensions,
      if (embeddingProviderId != null)
        'embedding_provider_id': embeddingProviderId,
      if (embeddingModel != null) 'embedding_model': embeddingModel,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KnowledgeBasesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? indexStatus,
      Value<String?>? indexError,
      Value<int>? fileCount,
      Value<int>? chunkCount,
      Value<int>? embeddingDimensions,
      Value<String?>? embeddingProviderId,
      Value<String?>? embeddingModel,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return KnowledgeBasesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      indexStatus: indexStatus ?? this.indexStatus,
      indexError: indexError ?? this.indexError,
      fileCount: fileCount ?? this.fileCount,
      chunkCount: chunkCount ?? this.chunkCount,
      embeddingDimensions: embeddingDimensions ?? this.embeddingDimensions,
      embeddingProviderId: embeddingProviderId ?? this.embeddingProviderId,
      embeddingModel: embeddingModel ?? this.embeddingModel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (indexStatus.present) {
      map['index_status'] = Variable<String>(indexStatus.value);
    }
    if (indexError.present) {
      map['index_error'] = Variable<String>(indexError.value);
    }
    if (fileCount.present) {
      map['file_count'] = Variable<int>(fileCount.value);
    }
    if (chunkCount.present) {
      map['chunk_count'] = Variable<int>(chunkCount.value);
    }
    if (embeddingDimensions.present) {
      map['embedding_dimensions'] = Variable<int>(embeddingDimensions.value);
    }
    if (embeddingProviderId.present) {
      map['embedding_provider_id'] =
          Variable<String>(embeddingProviderId.value);
    }
    if (embeddingModel.present) {
      map['embedding_model'] = Variable<String>(embeddingModel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeBasesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('indexStatus: $indexStatus, ')
          ..write('indexError: $indexError, ')
          ..write('fileCount: $fileCount, ')
          ..write('chunkCount: $chunkCount, ')
          ..write('embeddingDimensions: $embeddingDimensions, ')
          ..write('embeddingProviderId: $embeddingProviderId, ')
          ..write('embeddingModel: $embeddingModel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeBaseFilesTable extends KnowledgeBaseFiles
    with TableInfo<$KnowledgeBaseFilesTable, KnowledgeBaseFile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeBaseFilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _knowledgeBaseIdMeta =
      const VerificationMeta('knowledgeBaseId');
  @override
  late final GeneratedColumn<String> knowledgeBaseId = GeneratedColumn<String>(
      'knowledge_base_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_bases (id)'));
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _fileSizeMeta =
      const VerificationMeta('fileSize');
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
      'file_size', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _indexStatusMeta =
      const VerificationMeta('indexStatus');
  @override
  late final GeneratedColumn<String> indexStatus = GeneratedColumn<String>(
      'index_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('idle'));
  static const VerificationMeta _indexErrorMeta =
      const VerificationMeta('indexError');
  @override
  late final GeneratedColumn<String> indexError = GeneratedColumn<String>(
      'index_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _chunkCountMeta =
      const VerificationMeta('chunkCount');
  @override
  late final GeneratedColumn<int> chunkCount = GeneratedColumn<int>(
      'chunk_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
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
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_base_files';
  @override
  VerificationContext validateIntegrity(Insertable<KnowledgeBaseFile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('knowledge_base_id')) {
      context.handle(
          _knowledgeBaseIdMeta,
          knowledgeBaseId.isAcceptableOrUnknown(
              data['knowledge_base_id']!, _knowledgeBaseIdMeta));
    } else if (isInserting) {
      context.missing(_knowledgeBaseIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    }
    if (data.containsKey('file_size')) {
      context.handle(_fileSizeMeta,
          fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta));
    }
    if (data.containsKey('index_status')) {
      context.handle(
          _indexStatusMeta,
          indexStatus.isAcceptableOrUnknown(
              data['index_status']!, _indexStatusMeta));
    }
    if (data.containsKey('index_error')) {
      context.handle(
          _indexErrorMeta,
          indexError.isAcceptableOrUnknown(
              data['index_error']!, _indexErrorMeta));
    }
    if (data.containsKey('chunk_count')) {
      context.handle(
          _chunkCountMeta,
          chunkCount.isAcceptableOrUnknown(
              data['chunk_count']!, _chunkCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeBaseFile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeBaseFile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      knowledgeBaseId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}knowledge_base_id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type'])!,
      fileSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size'])!,
      indexStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}index_status'])!,
      indexError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}index_error']),
      chunkCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chunk_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $KnowledgeBaseFilesTable createAlias(String alias) {
    return $KnowledgeBaseFilesTable(attachedDatabase, alias);
  }
}

class KnowledgeBaseFile extends DataClass
    implements Insertable<KnowledgeBaseFile> {
  final String id;
  final String knowledgeBaseId;
  final String fileName;
  final String filePath;
  final String mimeType;
  final int fileSize;
  final String indexStatus;
  final String? indexError;
  final int chunkCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const KnowledgeBaseFile(
      {required this.id,
      required this.knowledgeBaseId,
      required this.fileName,
      required this.filePath,
      required this.mimeType,
      required this.fileSize,
      required this.indexStatus,
      this.indexError,
      required this.chunkCount,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['knowledge_base_id'] = Variable<String>(knowledgeBaseId);
    map['file_name'] = Variable<String>(fileName);
    map['file_path'] = Variable<String>(filePath);
    map['mime_type'] = Variable<String>(mimeType);
    map['file_size'] = Variable<int>(fileSize);
    map['index_status'] = Variable<String>(indexStatus);
    if (!nullToAbsent || indexError != null) {
      map['index_error'] = Variable<String>(indexError);
    }
    map['chunk_count'] = Variable<int>(chunkCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  KnowledgeBaseFilesCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeBaseFilesCompanion(
      id: Value(id),
      knowledgeBaseId: Value(knowledgeBaseId),
      fileName: Value(fileName),
      filePath: Value(filePath),
      mimeType: Value(mimeType),
      fileSize: Value(fileSize),
      indexStatus: Value(indexStatus),
      indexError: indexError == null && nullToAbsent
          ? const Value.absent()
          : Value(indexError),
      chunkCount: Value(chunkCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory KnowledgeBaseFile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeBaseFile(
      id: serializer.fromJson<String>(json['id']),
      knowledgeBaseId: serializer.fromJson<String>(json['knowledgeBaseId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      filePath: serializer.fromJson<String>(json['filePath']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      indexStatus: serializer.fromJson<String>(json['indexStatus']),
      indexError: serializer.fromJson<String?>(json['indexError']),
      chunkCount: serializer.fromJson<int>(json['chunkCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'knowledgeBaseId': serializer.toJson<String>(knowledgeBaseId),
      'fileName': serializer.toJson<String>(fileName),
      'filePath': serializer.toJson<String>(filePath),
      'mimeType': serializer.toJson<String>(mimeType),
      'fileSize': serializer.toJson<int>(fileSize),
      'indexStatus': serializer.toJson<String>(indexStatus),
      'indexError': serializer.toJson<String?>(indexError),
      'chunkCount': serializer.toJson<int>(chunkCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  KnowledgeBaseFile copyWith(
          {String? id,
          String? knowledgeBaseId,
          String? fileName,
          String? filePath,
          String? mimeType,
          int? fileSize,
          String? indexStatus,
          Value<String?> indexError = const Value.absent(),
          int? chunkCount,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      KnowledgeBaseFile(
        id: id ?? this.id,
        knowledgeBaseId: knowledgeBaseId ?? this.knowledgeBaseId,
        fileName: fileName ?? this.fileName,
        filePath: filePath ?? this.filePath,
        mimeType: mimeType ?? this.mimeType,
        fileSize: fileSize ?? this.fileSize,
        indexStatus: indexStatus ?? this.indexStatus,
        indexError: indexError.present ? indexError.value : this.indexError,
        chunkCount: chunkCount ?? this.chunkCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  KnowledgeBaseFile copyWithCompanion(KnowledgeBaseFilesCompanion data) {
    return KnowledgeBaseFile(
      id: data.id.present ? data.id.value : this.id,
      knowledgeBaseId: data.knowledgeBaseId.present
          ? data.knowledgeBaseId.value
          : this.knowledgeBaseId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      indexStatus:
          data.indexStatus.present ? data.indexStatus.value : this.indexStatus,
      indexError:
          data.indexError.present ? data.indexError.value : this.indexError,
      chunkCount:
          data.chunkCount.present ? data.chunkCount.value : this.chunkCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeBaseFile(')
          ..write('id: $id, ')
          ..write('knowledgeBaseId: $knowledgeBaseId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSize: $fileSize, ')
          ..write('indexStatus: $indexStatus, ')
          ..write('indexError: $indexError, ')
          ..write('chunkCount: $chunkCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeBaseFile &&
          other.id == this.id &&
          other.knowledgeBaseId == this.knowledgeBaseId &&
          other.fileName == this.fileName &&
          other.filePath == this.filePath &&
          other.mimeType == this.mimeType &&
          other.fileSize == this.fileSize &&
          other.indexStatus == this.indexStatus &&
          other.indexError == this.indexError &&
          other.chunkCount == this.chunkCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class KnowledgeBaseFilesCompanion extends UpdateCompanion<KnowledgeBaseFile> {
  final Value<String> id;
  final Value<String> knowledgeBaseId;
  final Value<String> fileName;
  final Value<String> filePath;
  final Value<String> mimeType;
  final Value<int> fileSize;
  final Value<String> indexStatus;
  final Value<String?> indexError;
  final Value<int> chunkCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const KnowledgeBaseFilesCompanion({
    this.id = const Value.absent(),
    this.knowledgeBaseId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.filePath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.indexStatus = const Value.absent(),
    this.indexError = const Value.absent(),
    this.chunkCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KnowledgeBaseFilesCompanion.insert({
    required String id,
    required String knowledgeBaseId,
    required String fileName,
    required String filePath,
    this.mimeType = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.indexStatus = const Value.absent(),
    this.indexError = const Value.absent(),
    this.chunkCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        knowledgeBaseId = Value(knowledgeBaseId),
        fileName = Value(fileName),
        filePath = Value(filePath);
  static Insertable<KnowledgeBaseFile> custom({
    Expression<String>? id,
    Expression<String>? knowledgeBaseId,
    Expression<String>? fileName,
    Expression<String>? filePath,
    Expression<String>? mimeType,
    Expression<int>? fileSize,
    Expression<String>? indexStatus,
    Expression<String>? indexError,
    Expression<int>? chunkCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (knowledgeBaseId != null) 'knowledge_base_id': knowledgeBaseId,
      if (fileName != null) 'file_name': fileName,
      if (filePath != null) 'file_path': filePath,
      if (mimeType != null) 'mime_type': mimeType,
      if (fileSize != null) 'file_size': fileSize,
      if (indexStatus != null) 'index_status': indexStatus,
      if (indexError != null) 'index_error': indexError,
      if (chunkCount != null) 'chunk_count': chunkCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KnowledgeBaseFilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? knowledgeBaseId,
      Value<String>? fileName,
      Value<String>? filePath,
      Value<String>? mimeType,
      Value<int>? fileSize,
      Value<String>? indexStatus,
      Value<String?>? indexError,
      Value<int>? chunkCount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return KnowledgeBaseFilesCompanion(
      id: id ?? this.id,
      knowledgeBaseId: knowledgeBaseId ?? this.knowledgeBaseId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      mimeType: mimeType ?? this.mimeType,
      fileSize: fileSize ?? this.fileSize,
      indexStatus: indexStatus ?? this.indexStatus,
      indexError: indexError ?? this.indexError,
      chunkCount: chunkCount ?? this.chunkCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (knowledgeBaseId.present) {
      map['knowledge_base_id'] = Variable<String>(knowledgeBaseId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (indexStatus.present) {
      map['index_status'] = Variable<String>(indexStatus.value);
    }
    if (indexError.present) {
      map['index_error'] = Variable<String>(indexError.value);
    }
    if (chunkCount.present) {
      map['chunk_count'] = Variable<int>(chunkCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeBaseFilesCompanion(')
          ..write('id: $id, ')
          ..write('knowledgeBaseId: $knowledgeBaseId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSize: $fileSize, ')
          ..write('indexStatus: $indexStatus, ')
          ..write('indexError: $indexError, ')
          ..write('chunkCount: $chunkCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CopilotsTable extends Copilots with TableInfo<$CopilotsTable, Copilot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CopilotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _picUrlMeta = const VerificationMeta('picUrl');
  @override
  late final GeneratedColumn<String> picUrl = GeneratedColumn<String>(
      'pic_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
      'prompt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _starredMeta =
      const VerificationMeta('starred');
  @override
  late final GeneratedColumn<bool> starred = GeneratedColumn<bool>(
      'starred', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("starred" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _usedCountMeta =
      const VerificationMeta('usedCount');
  @override
  late final GeneratedColumn<int> usedCount = GeneratedColumn<int>(
      'used_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, picUrl, prompt, starred, usedCount, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'copilots';
  @override
  VerificationContext validateIntegrity(Insertable<Copilot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('pic_url')) {
      context.handle(_picUrlMeta,
          picUrl.isAcceptableOrUnknown(data['pic_url']!, _picUrlMeta));
    }
    if (data.containsKey('prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta));
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('starred')) {
      context.handle(_starredMeta,
          starred.isAcceptableOrUnknown(data['starred']!, _starredMeta));
    }
    if (data.containsKey('used_count')) {
      context.handle(_usedCountMeta,
          usedCount.isAcceptableOrUnknown(data['used_count']!, _usedCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Copilot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Copilot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      picUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pic_url']),
      prompt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prompt'])!,
      starred: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}starred'])!,
      usedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}used_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CopilotsTable createAlias(String alias) {
    return $CopilotsTable(attachedDatabase, alias);
  }
}

class Copilot extends DataClass implements Insertable<Copilot> {
  final String id;
  final String name;
  final String? picUrl;
  final String prompt;
  final bool starred;
  final int usedCount;
  final DateTime createdAt;
  const Copilot(
      {required this.id,
      required this.name,
      this.picUrl,
      required this.prompt,
      required this.starred,
      required this.usedCount,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || picUrl != null) {
      map['pic_url'] = Variable<String>(picUrl);
    }
    map['prompt'] = Variable<String>(prompt);
    map['starred'] = Variable<bool>(starred);
    map['used_count'] = Variable<int>(usedCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CopilotsCompanion toCompanion(bool nullToAbsent) {
    return CopilotsCompanion(
      id: Value(id),
      name: Value(name),
      picUrl:
          picUrl == null && nullToAbsent ? const Value.absent() : Value(picUrl),
      prompt: Value(prompt),
      starred: Value(starred),
      usedCount: Value(usedCount),
      createdAt: Value(createdAt),
    );
  }

  factory Copilot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Copilot(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      picUrl: serializer.fromJson<String?>(json['picUrl']),
      prompt: serializer.fromJson<String>(json['prompt']),
      starred: serializer.fromJson<bool>(json['starred']),
      usedCount: serializer.fromJson<int>(json['usedCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'picUrl': serializer.toJson<String?>(picUrl),
      'prompt': serializer.toJson<String>(prompt),
      'starred': serializer.toJson<bool>(starred),
      'usedCount': serializer.toJson<int>(usedCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Copilot copyWith(
          {String? id,
          String? name,
          Value<String?> picUrl = const Value.absent(),
          String? prompt,
          bool? starred,
          int? usedCount,
          DateTime? createdAt}) =>
      Copilot(
        id: id ?? this.id,
        name: name ?? this.name,
        picUrl: picUrl.present ? picUrl.value : this.picUrl,
        prompt: prompt ?? this.prompt,
        starred: starred ?? this.starred,
        usedCount: usedCount ?? this.usedCount,
        createdAt: createdAt ?? this.createdAt,
      );
  Copilot copyWithCompanion(CopilotsCompanion data) {
    return Copilot(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      picUrl: data.picUrl.present ? data.picUrl.value : this.picUrl,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      starred: data.starred.present ? data.starred.value : this.starred,
      usedCount: data.usedCount.present ? data.usedCount.value : this.usedCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Copilot(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('picUrl: $picUrl, ')
          ..write('prompt: $prompt, ')
          ..write('starred: $starred, ')
          ..write('usedCount: $usedCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, picUrl, prompt, starred, usedCount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Copilot &&
          other.id == this.id &&
          other.name == this.name &&
          other.picUrl == this.picUrl &&
          other.prompt == this.prompt &&
          other.starred == this.starred &&
          other.usedCount == this.usedCount &&
          other.createdAt == this.createdAt);
}

class CopilotsCompanion extends UpdateCompanion<Copilot> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> picUrl;
  final Value<String> prompt;
  final Value<bool> starred;
  final Value<int> usedCount;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CopilotsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.picUrl = const Value.absent(),
    this.prompt = const Value.absent(),
    this.starred = const Value.absent(),
    this.usedCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CopilotsCompanion.insert({
    required String id,
    required String name,
    this.picUrl = const Value.absent(),
    required String prompt,
    this.starred = const Value.absent(),
    this.usedCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        prompt = Value(prompt);
  static Insertable<Copilot> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? picUrl,
    Expression<String>? prompt,
    Expression<bool>? starred,
    Expression<int>? usedCount,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (picUrl != null) 'pic_url': picUrl,
      if (prompt != null) 'prompt': prompt,
      if (starred != null) 'starred': starred,
      if (usedCount != null) 'used_count': usedCount,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CopilotsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? picUrl,
      Value<String>? prompt,
      Value<bool>? starred,
      Value<int>? usedCount,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CopilotsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      picUrl: picUrl ?? this.picUrl,
      prompt: prompt ?? this.prompt,
      starred: starred ?? this.starred,
      usedCount: usedCount ?? this.usedCount,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (picUrl.present) {
      map['pic_url'] = Variable<String>(picUrl.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (starred.present) {
      map['starred'] = Variable<bool>(starred.value);
    }
    if (usedCount.present) {
      map['used_count'] = Variable<int>(usedCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CopilotsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('picUrl: $picUrl, ')
          ..write('prompt: $prompt, ')
          ..write('starred: $starred, ')
          ..write('usedCount: $usedCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $McpServersTable mcpServers = $McpServersTable(this);
  late final $KnowledgeBasesTable knowledgeBases = $KnowledgeBasesTable(this);
  late final $KnowledgeBaseFilesTable knowledgeBaseFiles =
      $KnowledgeBaseFilesTable(this);
  late final $CopilotsTable copilots = $CopilotsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        sessions,
        messages,
        settings,
        mcpServers,
        knowledgeBases,
        knowledgeBaseFiles,
        copilots
      ];
}

typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  required String id,
  required String name,
  Value<String> type,
  Value<bool> starred,
  Value<String?> copilotId,
  Value<String?> settingsJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<bool> starred,
  Value<String?> copilotId,
  Value<String?> settingsJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder> {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SessionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SessionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<String?> copilotId = const Value.absent(),
            Value<String?> settingsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion(
            id: id,
            name: name,
            type: type,
            starred: starred,
            copilotId: copilotId,
            settingsJson: settingsJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> type = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<String?> copilotId = const Value.absent(),
            Value<String?> settingsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion.insert(
            id: id,
            name: name,
            type: type,
            starred: starred,
            copilotId: copilotId,
            settingsJson: settingsJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$SessionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get starred => $state.composableBuilder(
      column: $state.table.starred,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get copilotId => $state.composableBuilder(
      column: $state.table.copilotId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get settingsJson => $state.composableBuilder(
      column: $state.table.settingsJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SessionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get starred => $state.composableBuilder(
      column: $state.table.starred,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get copilotId => $state.composableBuilder(
      column: $state.table.copilotId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get settingsJson => $state.composableBuilder(
      column: $state.table.settingsJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MessagesTableCreateCompanionBuilder = MessagesCompanion Function({
  required String id,
  required String sessionId,
  required String role,
  required String contentJson,
  Value<String?> model,
  Value<int?> inputTokens,
  Value<int?> outputTokens,
  Value<bool> generating,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$MessagesTableUpdateCompanionBuilder = MessagesCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> role,
  Value<String> contentJson,
  Value<String?> model,
  Value<int?> inputTokens,
  Value<int?> outputTokens,
  Value<bool> generating,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$MessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MessagesTable,
    Message,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder> {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MessagesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MessagesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> contentJson = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<int?> inputTokens = const Value.absent(),
            Value<int?> outputTokens = const Value.absent(),
            Value<bool> generating = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MessagesCompanion(
            id: id,
            sessionId: sessionId,
            role: role,
            contentJson: contentJson,
            model: model,
            inputTokens: inputTokens,
            outputTokens: outputTokens,
            generating: generating,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String role,
            required String contentJson,
            Value<String?> model = const Value.absent(),
            Value<int?> inputTokens = const Value.absent(),
            Value<int?> outputTokens = const Value.absent(),
            Value<bool> generating = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MessagesCompanion.insert(
            id: id,
            sessionId: sessionId,
            role: role,
            contentJson: contentJson,
            model: model,
            inputTokens: inputTokens,
            outputTokens: outputTokens,
            generating: generating,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$MessagesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sessionId => $state.composableBuilder(
      column: $state.table.sessionId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get contentJson => $state.composableBuilder(
      column: $state.table.contentJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get model => $state.composableBuilder(
      column: $state.table.model,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get inputTokens => $state.composableBuilder(
      column: $state.table.inputTokens,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get outputTokens => $state.composableBuilder(
      column: $state.table.outputTokens,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get generating => $state.composableBuilder(
      column: $state.table.generating,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MessagesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sessionId => $state.composableBuilder(
      column: $state.table.sessionId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get contentJson => $state.composableBuilder(
      column: $state.table.contentJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get model => $state.composableBuilder(
      column: $state.table.model,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get inputTokens => $state.composableBuilder(
      column: $state.table.inputTokens,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get outputTokens => $state.composableBuilder(
      column: $state.table.outputTokens,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get generating => $state.composableBuilder(
      column: $state.table.generating,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String valueJson,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> valueJson,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> valueJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            key: key,
            valueJson: valueJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String valueJson,
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            key: key,
            valueJson: valueJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$SettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer(super.$state);
  ColumnFilters<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get valueJson => $state.composableBuilder(
      column: $state.table.valueJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get valueJson => $state.composableBuilder(
      column: $state.table.valueJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$McpServersTableCreateCompanionBuilder = McpServersCompanion Function({
  required String id,
  required String name,
  Value<bool> enabled,
  required String transportJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$McpServersTableUpdateCompanionBuilder = McpServersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<bool> enabled,
  Value<String> transportJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$McpServersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $McpServersTable,
    McpServer,
    $$McpServersTableFilterComposer,
    $$McpServersTableOrderingComposer,
    $$McpServersTableCreateCompanionBuilder,
    $$McpServersTableUpdateCompanionBuilder> {
  $$McpServersTableTableManager(_$AppDatabase db, $McpServersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$McpServersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$McpServersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
            Value<String> transportJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              McpServersCompanion(
            id: id,
            name: name,
            enabled: enabled,
            transportJson: transportJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<bool> enabled = const Value.absent(),
            required String transportJson,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              McpServersCompanion.insert(
            id: id,
            name: name,
            enabled: enabled,
            transportJson: transportJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$McpServersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $McpServersTable> {
  $$McpServersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enabled => $state.composableBuilder(
      column: $state.table.enabled,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get transportJson => $state.composableBuilder(
      column: $state.table.transportJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$McpServersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $McpServersTable> {
  $$McpServersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enabled => $state.composableBuilder(
      column: $state.table.enabled,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get transportJson => $state.composableBuilder(
      column: $state.table.transportJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$KnowledgeBasesTableCreateCompanionBuilder = KnowledgeBasesCompanion
    Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<String> indexStatus,
  Value<String?> indexError,
  Value<int> fileCount,
  Value<int> chunkCount,
  Value<int> embeddingDimensions,
  Value<String?> embeddingProviderId,
  Value<String?> embeddingModel,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$KnowledgeBasesTableUpdateCompanionBuilder = KnowledgeBasesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<String> indexStatus,
  Value<String?> indexError,
  Value<int> fileCount,
  Value<int> chunkCount,
  Value<int> embeddingDimensions,
  Value<String?> embeddingProviderId,
  Value<String?> embeddingModel,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$KnowledgeBasesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeBasesTable,
    KnowledgeBase,
    $$KnowledgeBasesTableFilterComposer,
    $$KnowledgeBasesTableOrderingComposer,
    $$KnowledgeBasesTableCreateCompanionBuilder,
    $$KnowledgeBasesTableUpdateCompanionBuilder> {
  $$KnowledgeBasesTableTableManager(
      _$AppDatabase db, $KnowledgeBasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$KnowledgeBasesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$KnowledgeBasesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> indexStatus = const Value.absent(),
            Value<String?> indexError = const Value.absent(),
            Value<int> fileCount = const Value.absent(),
            Value<int> chunkCount = const Value.absent(),
            Value<int> embeddingDimensions = const Value.absent(),
            Value<String?> embeddingProviderId = const Value.absent(),
            Value<String?> embeddingModel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnowledgeBasesCompanion(
            id: id,
            name: name,
            description: description,
            indexStatus: indexStatus,
            indexError: indexError,
            fileCount: fileCount,
            chunkCount: chunkCount,
            embeddingDimensions: embeddingDimensions,
            embeddingProviderId: embeddingProviderId,
            embeddingModel: embeddingModel,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String> indexStatus = const Value.absent(),
            Value<String?> indexError = const Value.absent(),
            Value<int> fileCount = const Value.absent(),
            Value<int> chunkCount = const Value.absent(),
            Value<int> embeddingDimensions = const Value.absent(),
            Value<String?> embeddingProviderId = const Value.absent(),
            Value<String?> embeddingModel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnowledgeBasesCompanion.insert(
            id: id,
            name: name,
            description: description,
            indexStatus: indexStatus,
            indexError: indexError,
            fileCount: fileCount,
            chunkCount: chunkCount,
            embeddingDimensions: embeddingDimensions,
            embeddingProviderId: embeddingProviderId,
            embeddingModel: embeddingModel,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$KnowledgeBasesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $KnowledgeBasesTable> {
  $$KnowledgeBasesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get indexStatus => $state.composableBuilder(
      column: $state.table.indexStatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get indexError => $state.composableBuilder(
      column: $state.table.indexError,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get fileCount => $state.composableBuilder(
      column: $state.table.fileCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get chunkCount => $state.composableBuilder(
      column: $state.table.chunkCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get embeddingDimensions => $state.composableBuilder(
      column: $state.table.embeddingDimensions,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get embeddingProviderId => $state.composableBuilder(
      column: $state.table.embeddingProviderId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get embeddingModel => $state.composableBuilder(
      column: $state.table.embeddingModel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter knowledgeBaseFilesRefs(
      ComposableFilter Function($$KnowledgeBaseFilesTableFilterComposer f) f) {
    final $$KnowledgeBaseFilesTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.knowledgeBaseFiles,
            getReferencedColumn: (t) => t.knowledgeBaseId,
            builder: (joinBuilder, parentComposers) =>
                $$KnowledgeBaseFilesTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.knowledgeBaseFiles,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$KnowledgeBasesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $KnowledgeBasesTable> {
  $$KnowledgeBasesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get indexStatus => $state.composableBuilder(
      column: $state.table.indexStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get indexError => $state.composableBuilder(
      column: $state.table.indexError,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get fileCount => $state.composableBuilder(
      column: $state.table.fileCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get chunkCount => $state.composableBuilder(
      column: $state.table.chunkCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get embeddingDimensions => $state.composableBuilder(
      column: $state.table.embeddingDimensions,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get embeddingProviderId => $state.composableBuilder(
      column: $state.table.embeddingProviderId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get embeddingModel => $state.composableBuilder(
      column: $state.table.embeddingModel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$KnowledgeBaseFilesTableCreateCompanionBuilder
    = KnowledgeBaseFilesCompanion Function({
  required String id,
  required String knowledgeBaseId,
  required String fileName,
  required String filePath,
  Value<String> mimeType,
  Value<int> fileSize,
  Value<String> indexStatus,
  Value<String?> indexError,
  Value<int> chunkCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$KnowledgeBaseFilesTableUpdateCompanionBuilder
    = KnowledgeBaseFilesCompanion Function({
  Value<String> id,
  Value<String> knowledgeBaseId,
  Value<String> fileName,
  Value<String> filePath,
  Value<String> mimeType,
  Value<int> fileSize,
  Value<String> indexStatus,
  Value<String?> indexError,
  Value<int> chunkCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$KnowledgeBaseFilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeBaseFilesTable,
    KnowledgeBaseFile,
    $$KnowledgeBaseFilesTableFilterComposer,
    $$KnowledgeBaseFilesTableOrderingComposer,
    $$KnowledgeBaseFilesTableCreateCompanionBuilder,
    $$KnowledgeBaseFilesTableUpdateCompanionBuilder> {
  $$KnowledgeBaseFilesTableTableManager(
      _$AppDatabase db, $KnowledgeBaseFilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$KnowledgeBaseFilesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$KnowledgeBaseFilesTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> knowledgeBaseId = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String> mimeType = const Value.absent(),
            Value<int> fileSize = const Value.absent(),
            Value<String> indexStatus = const Value.absent(),
            Value<String?> indexError = const Value.absent(),
            Value<int> chunkCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnowledgeBaseFilesCompanion(
            id: id,
            knowledgeBaseId: knowledgeBaseId,
            fileName: fileName,
            filePath: filePath,
            mimeType: mimeType,
            fileSize: fileSize,
            indexStatus: indexStatus,
            indexError: indexError,
            chunkCount: chunkCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String knowledgeBaseId,
            required String fileName,
            required String filePath,
            Value<String> mimeType = const Value.absent(),
            Value<int> fileSize = const Value.absent(),
            Value<String> indexStatus = const Value.absent(),
            Value<String?> indexError = const Value.absent(),
            Value<int> chunkCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnowledgeBaseFilesCompanion.insert(
            id: id,
            knowledgeBaseId: knowledgeBaseId,
            fileName: fileName,
            filePath: filePath,
            mimeType: mimeType,
            fileSize: fileSize,
            indexStatus: indexStatus,
            indexError: indexError,
            chunkCount: chunkCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$KnowledgeBaseFilesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $KnowledgeBaseFilesTable> {
  $$KnowledgeBaseFilesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mimeType => $state.composableBuilder(
      column: $state.table.mimeType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get fileSize => $state.composableBuilder(
      column: $state.table.fileSize,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get indexStatus => $state.composableBuilder(
      column: $state.table.indexStatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get indexError => $state.composableBuilder(
      column: $state.table.indexError,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get chunkCount => $state.composableBuilder(
      column: $state.table.chunkCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$KnowledgeBasesTableFilterComposer get knowledgeBaseId {
    final $$KnowledgeBasesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.knowledgeBaseId,
        referencedTable: $state.db.knowledgeBases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$KnowledgeBasesTableFilterComposer(ComposerState($state.db,
                $state.db.knowledgeBases, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$KnowledgeBaseFilesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $KnowledgeBaseFilesTable> {
  $$KnowledgeBaseFilesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mimeType => $state.composableBuilder(
      column: $state.table.mimeType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get fileSize => $state.composableBuilder(
      column: $state.table.fileSize,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get indexStatus => $state.composableBuilder(
      column: $state.table.indexStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get indexError => $state.composableBuilder(
      column: $state.table.indexError,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get chunkCount => $state.composableBuilder(
      column: $state.table.chunkCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$KnowledgeBasesTableOrderingComposer get knowledgeBaseId {
    final $$KnowledgeBasesTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.knowledgeBaseId,
            referencedTable: $state.db.knowledgeBases,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$KnowledgeBasesTableOrderingComposer(ComposerState($state.db,
                    $state.db.knowledgeBases, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CopilotsTableCreateCompanionBuilder = CopilotsCompanion Function({
  required String id,
  required String name,
  Value<String?> picUrl,
  required String prompt,
  Value<bool> starred,
  Value<int> usedCount,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$CopilotsTableUpdateCompanionBuilder = CopilotsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> picUrl,
  Value<String> prompt,
  Value<bool> starred,
  Value<int> usedCount,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$CopilotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CopilotsTable,
    Copilot,
    $$CopilotsTableFilterComposer,
    $$CopilotsTableOrderingComposer,
    $$CopilotsTableCreateCompanionBuilder,
    $$CopilotsTableUpdateCompanionBuilder> {
  $$CopilotsTableTableManager(_$AppDatabase db, $CopilotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CopilotsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CopilotsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> picUrl = const Value.absent(),
            Value<String> prompt = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<int> usedCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CopilotsCompanion(
            id: id,
            name: name,
            picUrl: picUrl,
            prompt: prompt,
            starred: starred,
            usedCount: usedCount,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> picUrl = const Value.absent(),
            required String prompt,
            Value<bool> starred = const Value.absent(),
            Value<int> usedCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CopilotsCompanion.insert(
            id: id,
            name: name,
            picUrl: picUrl,
            prompt: prompt,
            starred: starred,
            usedCount: usedCount,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$CopilotsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CopilotsTable> {
  $$CopilotsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get picUrl => $state.composableBuilder(
      column: $state.table.picUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get prompt => $state.composableBuilder(
      column: $state.table.prompt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get starred => $state.composableBuilder(
      column: $state.table.starred,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get usedCount => $state.composableBuilder(
      column: $state.table.usedCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CopilotsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CopilotsTable> {
  $$CopilotsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get picUrl => $state.composableBuilder(
      column: $state.table.picUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get prompt => $state.composableBuilder(
      column: $state.table.prompt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get starred => $state.composableBuilder(
      column: $state.table.starred,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get usedCount => $state.composableBuilder(
      column: $state.table.usedCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$McpServersTableTableManager get mcpServers =>
      $$McpServersTableTableManager(_db, _db.mcpServers);
  $$KnowledgeBasesTableTableManager get knowledgeBases =>
      $$KnowledgeBasesTableTableManager(_db, _db.knowledgeBases);
  $$KnowledgeBaseFilesTableTableManager get knowledgeBaseFiles =>
      $$KnowledgeBaseFilesTableTableManager(_db, _db.knowledgeBaseFiles);
  $$CopilotsTableTableManager get copilots =>
      $$CopilotsTableTableManager(_db, _db.copilots);
}
