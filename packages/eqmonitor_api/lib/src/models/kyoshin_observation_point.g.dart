// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_observation_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinObservationPoint _$KyoshinObservationPointFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_KyoshinObservationPoint',
  json,
  ($checkedConvert) {
    final val = _KyoshinObservationPoint(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$KyoshinObservationPointTypeEnumMap, v),
      ),
      sourceType: $checkedConvert('source_type', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      code: $checkedConvert('code', (v) => v as String),
      prefectureCode: $checkedConvert('prefecture_code', (v) => v as String?),
      regionCode: $checkedConvert('region_code', (v) => v as String?),
      isSuspended: $checkedConvert('is_suspended', (v) => v as bool),
      location: $checkedConvert(
        'location',
        (v) => ParameterLocation.fromJson(v as Map<String, dynamic>),
      ),
      point: $checkedConvert(
        'point',
        (v) => v == null
            ? null
            : KyoshinObservationPointMapPoint.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
      arv400: $checkedConvert('arv_400', (v) => v as num?),
    );
    return val;
  },
  fieldKeyMap: const {
    'sourceType': 'source_type',
    'prefectureCode': 'prefecture_code',
    'regionCode': 'region_code',
    'isSuspended': 'is_suspended',
    'arv400': 'arv_400',
  },
);

Map<String, dynamic> _$KyoshinObservationPointToJson(
  _KyoshinObservationPoint instance,
) => <String, dynamic>{
  'type': instance.type,
  'source_type': instance.sourceType,
  'name': instance.name,
  'code': instance.code,
  'prefecture_code': instance.prefectureCode,
  'region_code': instance.regionCode,
  'is_suspended': instance.isSuspended,
  'location': instance.location,
  'point': instance.point,
  'arv_400': instance.arv400,
};

const _$KyoshinObservationPointTypeEnumMap = {
  KyoshinObservationPointType.kNet: 'k_net',
  KyoshinObservationPointType.kikNet: 'kik_net',
  KyoshinObservationPointType.unknown: 'unknown',
};
