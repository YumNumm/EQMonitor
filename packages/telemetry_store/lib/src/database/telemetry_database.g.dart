// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_database.dart';

// ignore_for_file: type=lint
class $TelemetryEventsTable extends TelemetryEvents
    with TableInfo<$TelemetryEventsTable, TelemetryEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TelemetryEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMsMeta = const VerificationMeta(
    'timestampMs',
  );
  @override
  late final GeneratedColumn<int> timestampMs = GeneratedColumn<int>(
    'timestamp_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventType,
    timestampMs,
    eventId,
    payload,
    synced,
    createdAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'telemetry_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<TelemetryEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('timestamp_ms')) {
      context.handle(
        _timestampMsMeta,
        timestampMs.isAcceptableOrUnknown(
          data['timestamp_ms']!,
          _timestampMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampMsMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TelemetryEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TelemetryEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      timestampMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_ms'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
    );
  }

  @override
  $TelemetryEventsTable createAlias(String alias) {
    return $TelemetryEventsTable(attachedDatabase, alias);
  }
}

class TelemetryEventRow extends DataClass
    implements Insertable<TelemetryEventRow> {
  final int id;
  final String eventType;
  final int timestampMs;
  final String? eventId;
  final String payload;
  final bool synced;
  final int createdAtMs;
  const TelemetryEventRow({
    required this.id,
    required this.eventType,
    required this.timestampMs,
    this.eventId,
    required this.payload,
    required this.synced,
    required this.createdAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_type'] = Variable<String>(eventType);
    map['timestamp_ms'] = Variable<int>(timestampMs);
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<String>(eventId);
    }
    map['payload'] = Variable<String>(payload);
    map['synced'] = Variable<bool>(synced);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    return map;
  }

  TelemetryEventsCompanion toCompanion(bool nullToAbsent) {
    return TelemetryEventsCompanion(
      id: Value(id),
      eventType: Value(eventType),
      timestampMs: Value(timestampMs),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      payload: Value(payload),
      synced: Value(synced),
      createdAtMs: Value(createdAtMs),
    );
  }

  factory TelemetryEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TelemetryEventRow(
      id: serializer.fromJson<int>(json['id']),
      eventType: serializer.fromJson<String>(json['eventType']),
      timestampMs: serializer.fromJson<int>(json['timestampMs']),
      eventId: serializer.fromJson<String?>(json['eventId']),
      payload: serializer.fromJson<String>(json['payload']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventType': serializer.toJson<String>(eventType),
      'timestampMs': serializer.toJson<int>(timestampMs),
      'eventId': serializer.toJson<String?>(eventId),
      'payload': serializer.toJson<String>(payload),
      'synced': serializer.toJson<bool>(synced),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
    };
  }

  TelemetryEventRow copyWith({
    int? id,
    String? eventType,
    int? timestampMs,
    Value<String?> eventId = const Value.absent(),
    String? payload,
    bool? synced,
    int? createdAtMs,
  }) => TelemetryEventRow(
    id: id ?? this.id,
    eventType: eventType ?? this.eventType,
    timestampMs: timestampMs ?? this.timestampMs,
    eventId: eventId.present ? eventId.value : this.eventId,
    payload: payload ?? this.payload,
    synced: synced ?? this.synced,
    createdAtMs: createdAtMs ?? this.createdAtMs,
  );
  TelemetryEventRow copyWithCompanion(TelemetryEventsCompanion data) {
    return TelemetryEventRow(
      id: data.id.present ? data.id.value : this.id,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      timestampMs: data.timestampMs.present
          ? data.timestampMs.value
          : this.timestampMs,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      payload: data.payload.present ? data.payload.value : this.payload,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TelemetryEventRow(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('eventId: $eventId, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventType,
    timestampMs,
    eventId,
    payload,
    synced,
    createdAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TelemetryEventRow &&
          other.id == this.id &&
          other.eventType == this.eventType &&
          other.timestampMs == this.timestampMs &&
          other.eventId == this.eventId &&
          other.payload == this.payload &&
          other.synced == this.synced &&
          other.createdAtMs == this.createdAtMs);
}

class TelemetryEventsCompanion extends UpdateCompanion<TelemetryEventRow> {
  final Value<int> id;
  final Value<String> eventType;
  final Value<int> timestampMs;
  final Value<String?> eventId;
  final Value<String> payload;
  final Value<bool> synced;
  final Value<int> createdAtMs;
  const TelemetryEventsCompanion({
    this.id = const Value.absent(),
    this.eventType = const Value.absent(),
    this.timestampMs = const Value.absent(),
    this.eventId = const Value.absent(),
    this.payload = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAtMs = const Value.absent(),
  });
  TelemetryEventsCompanion.insert({
    this.id = const Value.absent(),
    required String eventType,
    required int timestampMs,
    this.eventId = const Value.absent(),
    required String payload,
    this.synced = const Value.absent(),
    required int createdAtMs,
  }) : eventType = Value(eventType),
       timestampMs = Value(timestampMs),
       payload = Value(payload),
       createdAtMs = Value(createdAtMs);
  static Insertable<TelemetryEventRow> custom({
    Expression<int>? id,
    Expression<String>? eventType,
    Expression<int>? timestampMs,
    Expression<String>? eventId,
    Expression<String>? payload,
    Expression<bool>? synced,
    Expression<int>? createdAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventType != null) 'event_type': eventType,
      if (timestampMs != null) 'timestamp_ms': timestampMs,
      if (eventId != null) 'event_id': eventId,
      if (payload != null) 'payload': payload,
      if (synced != null) 'synced': synced,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
    });
  }

  TelemetryEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? eventType,
    Value<int>? timestampMs,
    Value<String?>? eventId,
    Value<String>? payload,
    Value<bool>? synced,
    Value<int>? createdAtMs,
  }) {
    return TelemetryEventsCompanion(
      id: id ?? this.id,
      eventType: eventType ?? this.eventType,
      timestampMs: timestampMs ?? this.timestampMs,
      eventId: eventId ?? this.eventId,
      payload: payload ?? this.payload,
      synced: synced ?? this.synced,
      createdAtMs: createdAtMs ?? this.createdAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (timestampMs.present) {
      map['timestamp_ms'] = Variable<int>(timestampMs.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TelemetryEventsCompanion(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('eventId: $eventId, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }
}

abstract class _$TelemetryDatabase extends GeneratedDatabase {
  _$TelemetryDatabase(QueryExecutor e) : super(e);
  $TelemetryDatabaseManager get managers => $TelemetryDatabaseManager(this);
  late final $TelemetryEventsTable telemetryEvents = $TelemetryEventsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [telemetryEvents];
}

typedef $$TelemetryEventsTableCreateCompanionBuilder =
    TelemetryEventsCompanion Function({
      Value<int> id,
      required String eventType,
      required int timestampMs,
      Value<String?> eventId,
      required String payload,
      Value<bool> synced,
      required int createdAtMs,
    });
typedef $$TelemetryEventsTableUpdateCompanionBuilder =
    TelemetryEventsCompanion Function({
      Value<int> id,
      Value<String> eventType,
      Value<int> timestampMs,
      Value<String?> eventId,
      Value<String> payload,
      Value<bool> synced,
      Value<int> createdAtMs,
    });

class $$TelemetryEventsTableFilterComposer
    extends Composer<_$TelemetryDatabase, $TelemetryEventsTable> {
  $$TelemetryEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TelemetryEventsTableOrderingComposer
    extends Composer<_$TelemetryDatabase, $TelemetryEventsTable> {
  $$TelemetryEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TelemetryEventsTableAnnotationComposer
    extends Composer<_$TelemetryDatabase, $TelemetryEventsTable> {
  $$TelemetryEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );
}

class $$TelemetryEventsTableTableManager
    extends
        RootTableManager<
          _$TelemetryDatabase,
          $TelemetryEventsTable,
          TelemetryEventRow,
          $$TelemetryEventsTableFilterComposer,
          $$TelemetryEventsTableOrderingComposer,
          $$TelemetryEventsTableAnnotationComposer,
          $$TelemetryEventsTableCreateCompanionBuilder,
          $$TelemetryEventsTableUpdateCompanionBuilder,
          (
            TelemetryEventRow,
            BaseReferences<
              _$TelemetryDatabase,
              $TelemetryEventsTable,
              TelemetryEventRow
            >,
          ),
          TelemetryEventRow,
          PrefetchHooks Function()
        > {
  $$TelemetryEventsTableTableManager(
    _$TelemetryDatabase db,
    $TelemetryEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TelemetryEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TelemetryEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TelemetryEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int> timestampMs = const Value.absent(),
                Value<String?> eventId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
              }) => TelemetryEventsCompanion(
                id: id,
                eventType: eventType,
                timestampMs: timestampMs,
                eventId: eventId,
                payload: payload,
                synced: synced,
                createdAtMs: createdAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String eventType,
                required int timestampMs,
                Value<String?> eventId = const Value.absent(),
                required String payload,
                Value<bool> synced = const Value.absent(),
                required int createdAtMs,
              }) => TelemetryEventsCompanion.insert(
                id: id,
                eventType: eventType,
                timestampMs: timestampMs,
                eventId: eventId,
                payload: payload,
                synced: synced,
                createdAtMs: createdAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TelemetryEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$TelemetryDatabase,
      $TelemetryEventsTable,
      TelemetryEventRow,
      $$TelemetryEventsTableFilterComposer,
      $$TelemetryEventsTableOrderingComposer,
      $$TelemetryEventsTableAnnotationComposer,
      $$TelemetryEventsTableCreateCompanionBuilder,
      $$TelemetryEventsTableUpdateCompanionBuilder,
      (
        TelemetryEventRow,
        BaseReferences<
          _$TelemetryDatabase,
          $TelemetryEventsTable,
          TelemetryEventRow
        >,
      ),
      TelemetryEventRow,
      PrefetchHooks Function()
    >;

class $TelemetryDatabaseManager {
  final _$TelemetryDatabase _db;
  $TelemetryDatabaseManager(this._db);
  $$TelemetryEventsTableTableManager get telemetryEvents =>
      $$TelemetryEventsTableTableManager(_db, _db.telemetryEvents);
}
