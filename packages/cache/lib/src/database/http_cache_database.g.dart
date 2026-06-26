// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_cache_database.dart';

// ignore_for_file: type=lint
class $HttpCacheEntriesTable extends HttpCacheEntries
    with TableInfo<$HttpCacheEntriesTable, HttpCacheEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HttpCacheEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusCodeMeta = const VerificationMeta(
    'statusCode',
  );
  @override
  late final GeneratedColumn<int> statusCode = GeneratedColumn<int>(
    'status_code',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eTagMeta = const VerificationMeta('eTag');
  @override
  late final GeneratedColumn<String> eTag = GeneratedColumn<String>(
    'e_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headersMeta = const VerificationMeta(
    'headers',
  );
  @override
  late final GeneratedColumn<String> headers = GeneratedColumn<String>(
    'headers',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responseTypeMeta = const VerificationMeta(
    'responseType',
  );
  @override
  late final GeneratedColumn<String> responseType = GeneratedColumn<String>(
    'response_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<Uint8List> body = GeneratedColumn<Uint8List>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    key,
    statusCode,
    eTag,
    headers,
    responseType,
    body,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'http_cache_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<HttpCacheEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('status_code')) {
      context.handle(
        _statusCodeMeta,
        statusCode.isAcceptableOrUnknown(data['status_code']!, _statusCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_statusCodeMeta);
    }
    if (data.containsKey('e_tag')) {
      context.handle(
        _eTagMeta,
        eTag.isAcceptableOrUnknown(data['e_tag']!, _eTagMeta),
      );
    }
    if (data.containsKey('headers')) {
      context.handle(
        _headersMeta,
        headers.isAcceptableOrUnknown(data['headers']!, _headersMeta),
      );
    } else if (isInserting) {
      context.missing(_headersMeta);
    }
    if (data.containsKey('response_type')) {
      context.handle(
        _responseTypeMeta,
        responseType.isAcceptableOrUnknown(
          data['response_type']!,
          _responseTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_responseTypeMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  HttpCacheEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HttpCacheEntryRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      statusCode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status_code'],
      )!,
      eTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}e_tag'],
      ),
      headers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}headers'],
      )!,
      responseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_type'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}body'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $HttpCacheEntriesTable createAlias(String alias) {
    return $HttpCacheEntriesTable(attachedDatabase, alias);
  }
}

class HttpCacheEntryRow extends DataClass
    implements Insertable<HttpCacheEntryRow> {
  final String key;
  final int statusCode;
  final String? eTag;
  final String headers;
  final String responseType;
  final Uint8List body;
  final int updatedAtMs;
  const HttpCacheEntryRow({
    required this.key,
    required this.statusCode,
    this.eTag,
    required this.headers,
    required this.responseType,
    required this.body,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['status_code'] = Variable<int>(statusCode);
    if (!nullToAbsent || eTag != null) {
      map['e_tag'] = Variable<String>(eTag);
    }
    map['headers'] = Variable<String>(headers);
    map['response_type'] = Variable<String>(responseType);
    map['body'] = Variable<Uint8List>(body);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  HttpCacheEntriesCompanion toCompanion(bool nullToAbsent) {
    return HttpCacheEntriesCompanion(
      key: Value(key),
      statusCode: Value(statusCode),
      eTag: eTag == null && nullToAbsent ? const Value.absent() : Value(eTag),
      headers: Value(headers),
      responseType: Value(responseType),
      body: Value(body),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory HttpCacheEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HttpCacheEntryRow(
      key: serializer.fromJson<String>(json['key']),
      statusCode: serializer.fromJson<int>(json['statusCode']),
      eTag: serializer.fromJson<String?>(json['eTag']),
      headers: serializer.fromJson<String>(json['headers']),
      responseType: serializer.fromJson<String>(json['responseType']),
      body: serializer.fromJson<Uint8List>(json['body']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'statusCode': serializer.toJson<int>(statusCode),
      'eTag': serializer.toJson<String?>(eTag),
      'headers': serializer.toJson<String>(headers),
      'responseType': serializer.toJson<String>(responseType),
      'body': serializer.toJson<Uint8List>(body),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  HttpCacheEntryRow copyWith({
    String? key,
    int? statusCode,
    Value<String?> eTag = const Value.absent(),
    String? headers,
    String? responseType,
    Uint8List? body,
    int? updatedAtMs,
  }) => HttpCacheEntryRow(
    key: key ?? this.key,
    statusCode: statusCode ?? this.statusCode,
    eTag: eTag.present ? eTag.value : this.eTag,
    headers: headers ?? this.headers,
    responseType: responseType ?? this.responseType,
    body: body ?? this.body,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  HttpCacheEntryRow copyWithCompanion(HttpCacheEntriesCompanion data) {
    return HttpCacheEntryRow(
      key: data.key.present ? data.key.value : this.key,
      statusCode: data.statusCode.present
          ? data.statusCode.value
          : this.statusCode,
      eTag: data.eTag.present ? data.eTag.value : this.eTag,
      headers: data.headers.present ? data.headers.value : this.headers,
      responseType: data.responseType.present
          ? data.responseType.value
          : this.responseType,
      body: data.body.present ? data.body.value : this.body,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HttpCacheEntryRow(')
          ..write('key: $key, ')
          ..write('statusCode: $statusCode, ')
          ..write('eTag: $eTag, ')
          ..write('headers: $headers, ')
          ..write('responseType: $responseType, ')
          ..write('body: $body, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    key,
    statusCode,
    eTag,
    headers,
    responseType,
    $driftBlobEquality.hash(body),
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HttpCacheEntryRow &&
          other.key == this.key &&
          other.statusCode == this.statusCode &&
          other.eTag == this.eTag &&
          other.headers == this.headers &&
          other.responseType == this.responseType &&
          $driftBlobEquality.equals(other.body, this.body) &&
          other.updatedAtMs == this.updatedAtMs);
}

class HttpCacheEntriesCompanion extends UpdateCompanion<HttpCacheEntryRow> {
  final Value<String> key;
  final Value<int> statusCode;
  final Value<String?> eTag;
  final Value<String> headers;
  final Value<String> responseType;
  final Value<Uint8List> body;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const HttpCacheEntriesCompanion({
    this.key = const Value.absent(),
    this.statusCode = const Value.absent(),
    this.eTag = const Value.absent(),
    this.headers = const Value.absent(),
    this.responseType = const Value.absent(),
    this.body = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HttpCacheEntriesCompanion.insert({
    required String key,
    required int statusCode,
    this.eTag = const Value.absent(),
    required String headers,
    required String responseType,
    required Uint8List body,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       statusCode = Value(statusCode),
       headers = Value(headers),
       responseType = Value(responseType),
       body = Value(body),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<HttpCacheEntryRow> custom({
    Expression<String>? key,
    Expression<int>? statusCode,
    Expression<String>? eTag,
    Expression<String>? headers,
    Expression<String>? responseType,
    Expression<Uint8List>? body,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (statusCode != null) 'status_code': statusCode,
      if (eTag != null) 'e_tag': eTag,
      if (headers != null) 'headers': headers,
      if (responseType != null) 'response_type': responseType,
      if (body != null) 'body': body,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HttpCacheEntriesCompanion copyWith({
    Value<String>? key,
    Value<int>? statusCode,
    Value<String?>? eTag,
    Value<String>? headers,
    Value<String>? responseType,
    Value<Uint8List>? body,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return HttpCacheEntriesCompanion(
      key: key ?? this.key,
      statusCode: statusCode ?? this.statusCode,
      eTag: eTag ?? this.eTag,
      headers: headers ?? this.headers,
      responseType: responseType ?? this.responseType,
      body: body ?? this.body,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (statusCode.present) {
      map['status_code'] = Variable<int>(statusCode.value);
    }
    if (eTag.present) {
      map['e_tag'] = Variable<String>(eTag.value);
    }
    if (headers.present) {
      map['headers'] = Variable<String>(headers.value);
    }
    if (responseType.present) {
      map['response_type'] = Variable<String>(responseType.value);
    }
    if (body.present) {
      map['body'] = Variable<Uint8List>(body.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HttpCacheEntriesCompanion(')
          ..write('key: $key, ')
          ..write('statusCode: $statusCode, ')
          ..write('eTag: $eTag, ')
          ..write('headers: $headers, ')
          ..write('responseType: $responseType, ')
          ..write('body: $body, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CacheDatabase extends GeneratedDatabase {
  _$CacheDatabase(QueryExecutor e) : super(e);
  $CacheDatabaseManager get managers => $CacheDatabaseManager(this);
  late final $HttpCacheEntriesTable httpCacheEntries = $HttpCacheEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [httpCacheEntries];
}

typedef $$HttpCacheEntriesTableCreateCompanionBuilder =
    HttpCacheEntriesCompanion Function({
      required String key,
      required int statusCode,
      Value<String?> eTag,
      required String headers,
      required String responseType,
      required Uint8List body,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$HttpCacheEntriesTableUpdateCompanionBuilder =
    HttpCacheEntriesCompanion Function({
      Value<String> key,
      Value<int> statusCode,
      Value<String?> eTag,
      Value<String> headers,
      Value<String> responseType,
      Value<Uint8List> body,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

class $$HttpCacheEntriesTableFilterComposer
    extends Composer<_$CacheDatabase, $HttpCacheEntriesTable> {
  $$HttpCacheEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statusCode => $composableBuilder(
    column: $table.statusCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eTag => $composableBuilder(
    column: $table.eTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get headers => $composableBuilder(
    column: $table.headers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseType => $composableBuilder(
    column: $table.responseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HttpCacheEntriesTableOrderingComposer
    extends Composer<_$CacheDatabase, $HttpCacheEntriesTable> {
  $$HttpCacheEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statusCode => $composableBuilder(
    column: $table.statusCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eTag => $composableBuilder(
    column: $table.eTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get headers => $composableBuilder(
    column: $table.headers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseType => $composableBuilder(
    column: $table.responseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HttpCacheEntriesTableAnnotationComposer
    extends Composer<_$CacheDatabase, $HttpCacheEntriesTable> {
  $$HttpCacheEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get statusCode => $composableBuilder(
    column: $table.statusCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eTag =>
      $composableBuilder(column: $table.eTag, builder: (column) => column);

  GeneratedColumn<String> get headers =>
      $composableBuilder(column: $table.headers, builder: (column) => column);

  GeneratedColumn<String> get responseType => $composableBuilder(
    column: $table.responseType,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$HttpCacheEntriesTableTableManager
    extends
        RootTableManager<
          _$CacheDatabase,
          $HttpCacheEntriesTable,
          HttpCacheEntryRow,
          $$HttpCacheEntriesTableFilterComposer,
          $$HttpCacheEntriesTableOrderingComposer,
          $$HttpCacheEntriesTableAnnotationComposer,
          $$HttpCacheEntriesTableCreateCompanionBuilder,
          $$HttpCacheEntriesTableUpdateCompanionBuilder,
          (
            HttpCacheEntryRow,
            BaseReferences<
              _$CacheDatabase,
              $HttpCacheEntriesTable,
              HttpCacheEntryRow
            >,
          ),
          HttpCacheEntryRow,
          PrefetchHooks Function()
        > {
  $$HttpCacheEntriesTableTableManager(
    _$CacheDatabase db,
    $HttpCacheEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HttpCacheEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HttpCacheEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HttpCacheEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<int> statusCode = const Value.absent(),
                Value<String?> eTag = const Value.absent(),
                Value<String> headers = const Value.absent(),
                Value<String> responseType = const Value.absent(),
                Value<Uint8List> body = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HttpCacheEntriesCompanion(
                key: key,
                statusCode: statusCode,
                eTag: eTag,
                headers: headers,
                responseType: responseType,
                body: body,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required int statusCode,
                Value<String?> eTag = const Value.absent(),
                required String headers,
                required String responseType,
                required Uint8List body,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => HttpCacheEntriesCompanion.insert(
                key: key,
                statusCode: statusCode,
                eTag: eTag,
                headers: headers,
                responseType: responseType,
                body: body,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HttpCacheEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$CacheDatabase,
      $HttpCacheEntriesTable,
      HttpCacheEntryRow,
      $$HttpCacheEntriesTableFilterComposer,
      $$HttpCacheEntriesTableOrderingComposer,
      $$HttpCacheEntriesTableAnnotationComposer,
      $$HttpCacheEntriesTableCreateCompanionBuilder,
      $$HttpCacheEntriesTableUpdateCompanionBuilder,
      (
        HttpCacheEntryRow,
        BaseReferences<
          _$CacheDatabase,
          $HttpCacheEntriesTable,
          HttpCacheEntryRow
        >,
      ),
      HttpCacheEntryRow,
      PrefetchHooks Function()
    >;

class $CacheDatabaseManager {
  final _$CacheDatabase _db;
  $CacheDatabaseManager(this._db);
  $$HttpCacheEntriesTableTableManager get httpCacheEntries =>
      $$HttpCacheEntriesTableTableManager(_db, _db.httpCacheEntries);
}
