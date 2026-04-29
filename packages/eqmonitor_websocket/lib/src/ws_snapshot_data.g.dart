// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_snapshot_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsSnapshotShakeEntry _$WsSnapshotShakeEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsSnapshotShakeEntry', json, ($checkedConvert) {
  final val = _WsSnapshotShakeEntry(
    eventId: $checkedConvert('eventId', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    level: $checkedConvert('level', (v) => v as String),
    changeReasons: $checkedConvert(
      'changeReasons',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    ),
    isReplay: $checkedConvert('isReplay', (v) => v as bool),
    pointCount: $checkedConvert('pointCount', (v) => (v as num).toInt()),
    region: $checkedConvert(
      'region',
      (v) => WsShakeRegionPayload.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WsSnapshotShakeEntryToJson(
  _WsSnapshotShakeEntry instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'createdAt': instance.createdAt.toIso8601String(),
  'level': instance.level,
  'changeReasons': instance.changeReasons,
  'isReplay': instance.isReplay,
  'pointCount': instance.pointCount,
  'region': instance.region,
};

_WsSnapshotData _$WsSnapshotDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsSnapshotData', json, ($checkedConvert) {
  final val = _WsSnapshotData(
    revision: $checkedConvert('revision', (v) => (v as num).toInt()),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    shakes: $checkedConvert(
      'shakes',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => WsSnapshotShakeEntry.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    ),
    eews: $checkedConvert(
      'eews',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => EewItemWithRelations.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    ),
    earthquakes: $checkedConvert(
      'earthquakes',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => EarthquakePartial.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    ),
  );
  return val;
});

Map<String, dynamic> _$WsSnapshotDataToJson(_WsSnapshotData instance) =>
    <String, dynamic>{
      'revision': instance.revision,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'shakes': instance.shakes,
      'eews': instance.eews,
      'earthquakes': instance.earthquakes,
    };
