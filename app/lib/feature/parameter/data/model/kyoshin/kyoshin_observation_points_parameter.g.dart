// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_observation_points_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinObservationPointsParameter _$KyoshinObservationPointsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinObservationPointsParameter', json, (
  $checkedConvert,
) {
  final val = _KyoshinObservationPointsParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) => ParameterMetadata.fromJson(v as Map<String, dynamic>),
    ),
    points: $checkedConvert(
      'points',
      (v) => (v as List<dynamic>)
          .map(
            (e) => KyoshinObservationPoint.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$KyoshinObservationPointsParameterToJson(
  _KyoshinObservationPointsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'points': instance.points,
};

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
        (v) => LatLng.fromJson(v as Map<String, dynamic>),
      ),
      point: $checkedConvert(
        'point',
        (v) => v == null
            ? null
            : KyoshinObservationPointMapPoint.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
      arv400: $checkedConvert('arv_400', (v) => (v as num?)?.toDouble()),
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
  'type': _$KyoshinObservationPointTypeEnumMap[instance.type]!,
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

_KyoshinObservationPointMapPoint _$KyoshinObservationPointMapPointFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinObservationPointMapPoint', json, (
  $checkedConvert,
) {
  final val = _KyoshinObservationPointMapPoint(
    center: $checkedConvert(
      'center',
      (v) =>
          const ParameterPointConverter().fromJson(v as Map<String, dynamic>),
    ),
    offset: $checkedConvert(
      'offset',
      (v) =>
          const ParameterPointConverter().fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$KyoshinObservationPointMapPointToJson(
  _KyoshinObservationPointMapPoint instance,
) => <String, dynamic>{
  'center': const ParameterPointConverter().toJson(instance.center),
  'offset': const ParameterPointConverter().toJson(instance.offset),
};
