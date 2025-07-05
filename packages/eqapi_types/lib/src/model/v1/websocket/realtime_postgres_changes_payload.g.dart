// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'realtime_postgres_changes_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimePostgresInsertPayload<T>
_$RealtimePostgresInsertPayloadFromJson<T extends V1Database>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate(
  '_RealtimePostgresInsertPayload',
  json,
  ($checkedConvert) {
    final val = _RealtimePostgresInsertPayload<T>(
      schema: $checkedConvert('schema', (v) => v as String),
      table: $checkedConvert('table', (v) => v as String),
      commitTimestamp: $checkedConvert(
        'commit_timestamp',
        (v) => DateTime.parse(v as String),
      ),
      errors: $checkedConvert(
        'errors',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      newData: $checkedConvert('new', (v) => fromJsonT(v)),
    );
    return val;
  },
  fieldKeyMap: const {'commitTimestamp': 'commit_timestamp', 'newData': 'new'},
);

Map<String, dynamic>
_$RealtimePostgresInsertPayloadToJson<T extends V1Database>(
  _RealtimePostgresInsertPayload<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'schema': instance.schema,
  'table': instance.table,
  'commit_timestamp': instance.commitTimestamp.toIso8601String(),
  'errors': instance.errors,
  'new': toJsonT(instance.newData),
};

_RealtimePostgresUpdatePayload<T>
_$RealtimePostgresUpdatePayloadFromJson<T extends V1Database>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate(
  '_RealtimePostgresUpdatePayload',
  json,
  ($checkedConvert) {
    final val = _RealtimePostgresUpdatePayload<T>(
      schema: $checkedConvert('schema', (v) => v as String),
      table: $checkedConvert('table', (v) => v as String),
      commitTimestamp: $checkedConvert(
        'commit_timestamp',
        (v) => DateTime.parse(v as String),
      ),
      errors: $checkedConvert(
        'errors',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      newData: $checkedConvert('new', (v) => fromJsonT(v)),
      old: $checkedConvert('old', (v) => v as Map<String, dynamic>?),
    );
    return val;
  },
  fieldKeyMap: const {'commitTimestamp': 'commit_timestamp', 'newData': 'new'},
);

Map<String, dynamic>
_$RealtimePostgresUpdatePayloadToJson<T extends V1Database>(
  _RealtimePostgresUpdatePayload<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'schema': instance.schema,
  'table': instance.table,
  'commit_timestamp': instance.commitTimestamp.toIso8601String(),
  'errors': instance.errors,
  'new': toJsonT(instance.newData),
  'old': instance.old,
};

_RealtimePostgresDeletePayload<T>
_$RealtimePostgresDeletePayloadFromJson<T extends V1Database>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate(
  '_RealtimePostgresDeletePayload',
  json,
  ($checkedConvert) {
    final val = _RealtimePostgresDeletePayload<T>(
      schema: $checkedConvert('schema', (v) => v as String),
      table: $checkedConvert('table', (v) => v as String),
      commitTimestamp: $checkedConvert(
        'commit_timestamp',
        (v) => DateTime.parse(v as String),
      ),
      errors: $checkedConvert(
        'errors',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      old: $checkedConvert('old', (v) => v as Map<String, dynamic>?),
    );
    return val;
  },
  fieldKeyMap: const {'commitTimestamp': 'commit_timestamp'},
);

Map<String, dynamic>
_$RealtimePostgresDeletePayloadToJson<T extends V1Database>(
  _RealtimePostgresDeletePayload<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'schema': instance.schema,
  'table': instance.table,
  'commit_timestamp': instance.commitTimestamp.toIso8601String(),
  'errors': instance.errors,
  'old': instance.old,
};
