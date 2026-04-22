// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_snapshot_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsSnapshotData _$WsSnapshotDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsSnapshotData', json, ($checkedConvert) {
  final val = _WsSnapshotData(
    revision: $checkedConvert('revision', (v) => (v as num).toInt()),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
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
      'eews': instance.eews,
      'earthquakes': instance.earthquakes,
    };
