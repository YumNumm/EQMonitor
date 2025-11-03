// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'aqua_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AquaEvent _$AquaEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AquaEvent', json, ($checkedConvert) {
  final val = _AquaEvent(
    id: $checkedConvert('id', (v) => v as String),
    originTime: $checkedConvert(
      'originTime',
      (v) => const TZDateTimeJstJsonConverter().fromJson(v as String),
    ),
    region: $checkedConvert('region', (v) => v as String),
    latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
    longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
    depth: $checkedConvert('depth', (v) => (v as num).toDouble()),
    magnitude: $checkedConvert('magnitude', (v) => (v as num).toDouble()),
    focalMechanism: $checkedConvert(
      'focalMechanism',
      (v) =>
          v == null ? null : FocalMechanism.fromJson(v as Map<String, dynamic>),
    ),
    varianceReduction: $checkedConvert(
      'varianceReduction',
      (v) => (v as num?)?.toDouble(),
    ),
    stationCount: $checkedConvert('stationCount', (v) => (v as num).toInt()),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$AquaEventTypeEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$AquaEventToJson(
  _AquaEvent instance,
) => <String, dynamic>{
  'id': instance.id,
  'originTime': const TZDateTimeJstJsonConverter().toJson(instance.originTime),
  'region': instance.region,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'depth': instance.depth,
  'magnitude': instance.magnitude,
  'focalMechanism': instance.focalMechanism,
  'varianceReduction': instance.varianceReduction,
  'stationCount': instance.stationCount,
  'type': _$AquaEventTypeEnumMap[instance.type]!,
};

const _$AquaEventTypeEnumMap = {AquaEventType.cmt: 'C', AquaEventType.mt: 'M'};
