import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/v1/information.dart';
import 'package:eqapi_types/model/v1/tsunami.dart';
import 'package:eqapi_types/model/v1/v1_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_postgres_changes_payload.freezed.dart';
part 'realtime_postgres_changes_payload.g.dart';

sealed class RealtimePostgresChangesPayloadBase {
  RealtimePostgresChangesPayloadBase({
    required this.schema,
    required this.table,
    required this.commitTimestamp,
    required this.errors,
  });

  factory RealtimePostgresChangesPayloadBase.fromJson(
    Map<String, dynamic> json,
  ) {
    final eventTypeStr = json['eventType'].toString();
    final eventType =
        RealtimePostgresChangesListenEvent.values.firstWhereOrNull(
      (e) => e.value == eventTypeStr,
    );
    if (eventType == null) {
      throw ArgumentError.value(
        eventTypeStr,
        'json["eventType"]',
        'Invalid value',
      );
    }
    final tableStr = json['table'].toString();
    final table = PublicTable.values.firstWhereOrNull(
      (e) => e.name == tableStr,
    );
    if (table == null) {
      throw ArgumentError.value(
        tableStr,
        'json["table"]',
        'Invalid value',
      );
    }

    return switch (eventType) {
      RealtimePostgresChangesListenEvent.insert => switch (table) {
          PublicTable.earthquake =>
            RealtimePostgresInsertPayload<EarthquakeV1>.fromJson(
              json,
              (v) => EarthquakeV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.eew => RealtimePostgresInsertPayload<EewV1>.fromJson(
              json,
              (v) => EewV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.information =>
            RealtimePostgresInsertPayload<InformationV1>.fromJson(
              json,
              (v) => InformationV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.intensitySubDivision =>
            RealtimePostgresInsertPayload<IntensitySubDivision>.fromJson(
              json,
              (v) => IntensitySubDivision.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.telegram =>
            RealtimePostgresInsertPayload<TelegramV1>.fromJson(
              json,
              (v) => TelegramV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.tsunami =>
            RealtimePostgresInsertPayload<TsunamiV1>.fromJson(
              json,
              (v) => TsunamiV1.fromJson(v! as Map<String, dynamic>),
            ),
        },
      RealtimePostgresChangesListenEvent.update => switch (table) {
          PublicTable.earthquake =>
            RealtimePostgresUpdatePayload<EarthquakeV1>.fromJson(
              json,
              (v) => EarthquakeV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.eew => RealtimePostgresUpdatePayload<EewV1>.fromJson(
              json,
              (v) => EewV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.information =>
            RealtimePostgresUpdatePayload<InformationV1>.fromJson(
              json,
              (v) => InformationV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.intensitySubDivision =>
            RealtimePostgresUpdatePayload<IntensitySubDivision>.fromJson(
              json,
              (v) => IntensitySubDivision.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.telegram =>
            RealtimePostgresUpdatePayload<TelegramV1>.fromJson(
              json,
              (v) => TelegramV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.tsunami =>
            RealtimePostgresUpdatePayload<TsunamiV1>.fromJson(
              json,
              (v) => TsunamiV1.fromJson(v! as Map<String, dynamic>),
            ),
        },
      RealtimePostgresChangesListenEvent.delete => switch (table) {
          PublicTable.earthquake =>
            RealtimePostgresDeletePayload<EarthquakeV1>.fromJson(
              json,
              (v) => EarthquakeV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.eew => RealtimePostgresDeletePayload<EewV1>.fromJson(
              json,
              (v) => EewV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.information =>
            RealtimePostgresDeletePayload<InformationV1>.fromJson(
              json,
              (v) => InformationV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.intensitySubDivision =>
            RealtimePostgresDeletePayload<IntensitySubDivision>.fromJson(
              json,
              (v) => IntensitySubDivision.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.telegram =>
            RealtimePostgresDeletePayload<TelegramV1>.fromJson(
              json,
              (v) => TelegramV1.fromJson(v! as Map<String, dynamic>),
            ),
          PublicTable.tsunami =>
            RealtimePostgresDeletePayload<TsunamiV1>.fromJson(
              json,
              (v) => TsunamiV1.fromJson(v! as Map<String, dynamic>),
            ),
        }
    };
  }

  final String schema;
  final String table;
  final DateTime commitTimestamp;
  final List<String> errors;
}

enum PublicTable {
  earthquake,
  eew,
  information,
  intensitySubDivision,
  telegram,
  tsunami,
  ;
}

@Freezed(genericArgumentFactories: true)
class RealtimePostgresInsertPayload<T extends V1Database>
    with _$RealtimePostgresInsertPayload<T>
    implements RealtimePostgresChangesPayloadBase {
  const factory RealtimePostgresInsertPayload({
    required String schema,
    required String table,
    required DateTime commitTimestamp,
    required List<String> errors,
    @JsonKey(name: 'new') required T newData,
  }) = _RealtimePostgresInsertPayload<T>;

  factory RealtimePostgresInsertPayload.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$RealtimePostgresInsertPayloadFromJson(json, fromJsonT);

  static const RealtimePostgresChangesListenEvent eventType =
      RealtimePostgresChangesListenEvent.insert;
  static const Map<String, dynamic> old = {};
}

@Freezed(genericArgumentFactories: true)
class RealtimePostgresUpdatePayload<T extends V1Database>
    with _$RealtimePostgresUpdatePayload<T>
    implements RealtimePostgresChangesPayloadBase {
  const factory RealtimePostgresUpdatePayload({
    required String schema,
    required String table,
    required DateTime commitTimestamp,
    required List<String> errors,
    @JsonKey(name: 'new') required T newData,

    /// Partical<T> | null
    required Map<String, dynamic>? old,
  }) = _RealtimePostgresUpdatePayload<T>;

  factory RealtimePostgresUpdatePayload.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$RealtimePostgresUpdatePayloadFromJson(json, fromJsonT);

  static const RealtimePostgresChangesListenEvent eventType =
      RealtimePostgresChangesListenEvent.update;
}

@Freezed(genericArgumentFactories: true)
class RealtimePostgresDeletePayload<T extends V1Database>
    with _$RealtimePostgresDeletePayload<T>
    implements RealtimePostgresChangesPayloadBase {
  const factory RealtimePostgresDeletePayload({
    required String schema,
    required String table,
    required DateTime commitTimestamp,
    required List<String> errors,

    /// Partical<T> | null
    required Map<String, dynamic>? old,
  }) = _RealtimePostgresDeletePayload<T>;

  factory RealtimePostgresDeletePayload.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$RealtimePostgresDeletePayloadFromJson(json, fromJsonT);

  static const RealtimePostgresChangesListenEvent eventType =
      RealtimePostgresChangesListenEvent.delete;

  static const Map<String, dynamic> newData = {};
}

enum RealtimePostgresChangesListenEvent {
  insert('INSERT'),
  update('UPDATE'),
  delete('DELETE'),
  ;

  const RealtimePostgresChangesListenEvent(this.value);
  final String value;
}
