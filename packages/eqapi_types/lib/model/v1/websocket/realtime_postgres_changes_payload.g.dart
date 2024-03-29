// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'realtime_postgres_changes_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RealtimePostgresInsertPayloadImpl<T>
    _$$RealtimePostgresInsertPayloadImplFromJson<T extends V1Database>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
        $checkedCreate(
          r'_$RealtimePostgresInsertPayloadImpl',
          json,
          ($checkedConvert) {
            final val = _$RealtimePostgresInsertPayloadImpl<T>(
              schema: $checkedConvert('schema', (v) => v as String),
              table: $checkedConvert('table', (v) => v as String),
              commitTimestamp: $checkedConvert(
                  'commit_timestamp', (v) => DateTime.parse(v as String)),
              errors: $checkedConvert('errors',
                  (v) => (v as List<dynamic>).map((e) => e as String).toList()),
              newData: $checkedConvert('new', (v) => fromJsonT(v)),
            );
            return val;
          },
          fieldKeyMap: const {
            'commitTimestamp': 'commit_timestamp',
            'newData': 'new'
          },
        );

Map<String, dynamic>
    _$$RealtimePostgresInsertPayloadImplToJson<T extends V1Database>(
  _$RealtimePostgresInsertPayloadImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
        <String, dynamic>{
          'schema': instance.schema,
          'table': instance.table,
          'commit_timestamp': instance.commitTimestamp.toIso8601String(),
          'errors': instance.errors,
          'new': toJsonT(instance.newData),
        };

_$RealtimePostgresUpdatePayloadImpl<T>
    _$$RealtimePostgresUpdatePayloadImplFromJson<T extends V1Database>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
        $checkedCreate(
          r'_$RealtimePostgresUpdatePayloadImpl',
          json,
          ($checkedConvert) {
            final val = _$RealtimePostgresUpdatePayloadImpl<T>(
              schema: $checkedConvert('schema', (v) => v as String),
              table: $checkedConvert('table', (v) => v as String),
              commitTimestamp: $checkedConvert(
                  'commit_timestamp', (v) => DateTime.parse(v as String)),
              errors: $checkedConvert('errors',
                  (v) => (v as List<dynamic>).map((e) => e as String).toList()),
              newData: $checkedConvert('new', (v) => fromJsonT(v)),
              old: $checkedConvert('old', (v) => v as Map<String, dynamic>?),
            );
            return val;
          },
          fieldKeyMap: const {
            'commitTimestamp': 'commit_timestamp',
            'newData': 'new'
          },
        );

Map<String, dynamic>
    _$$RealtimePostgresUpdatePayloadImplToJson<T extends V1Database>(
  _$RealtimePostgresUpdatePayloadImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
        <String, dynamic>{
          'schema': instance.schema,
          'table': instance.table,
          'commit_timestamp': instance.commitTimestamp.toIso8601String(),
          'errors': instance.errors,
          'new': toJsonT(instance.newData),
          'old': instance.old,
        };

_$RealtimePostgresDeletePayloadImpl<T>
    _$$RealtimePostgresDeletePayloadImplFromJson<T extends V1Database>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
        $checkedCreate(
          r'_$RealtimePostgresDeletePayloadImpl',
          json,
          ($checkedConvert) {
            final val = _$RealtimePostgresDeletePayloadImpl<T>(
              schema: $checkedConvert('schema', (v) => v as String),
              table: $checkedConvert('table', (v) => v as String),
              commitTimestamp: $checkedConvert(
                  'commit_timestamp', (v) => DateTime.parse(v as String)),
              errors: $checkedConvert('errors',
                  (v) => (v as List<dynamic>).map((e) => e as String).toList()),
              old: $checkedConvert('old', (v) => v as Map<String, dynamic>?),
            );
            return val;
          },
          fieldKeyMap: const {'commitTimestamp': 'commit_timestamp'},
        );

Map<String, dynamic>
    _$$RealtimePostgresDeletePayloadImplToJson<T extends V1Database>(
  _$RealtimePostgresDeletePayloadImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
        <String, dynamic>{
          'schema': instance.schema,
          'table': instance.table,
          'commit_timestamp': instance.commitTimestamp.toIso8601String(),
          'errors': instance.errors,
          'old': instance.old,
        };
