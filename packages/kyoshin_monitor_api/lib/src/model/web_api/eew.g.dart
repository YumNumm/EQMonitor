// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Eew _$EewFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Eew',
  json,
  ($checkedConvert) {
    final val = _Eew(
      result: $checkedConvert(
        'result',
        (v) => v == null ? null : Result.fromJson(v as Map<String, dynamic>),
      ),
      reportTime: $checkedConvert(
        'report_time',
        (v) => dateTimeOrNullFromString(v as String?),
      ),
      regionCode: $checkedConvert('region_code', (v) => v as String?),
      requestTime: $checkedConvert('request_time', (v) => v as String?),
      regionName: $checkedConvert('region_name', (v) => v as String?),
      longitude: $checkedConvert(
        'longitude',
        (v) => doubleOrNullFromString(v as String?),
      ),
      isCancel: $checkedConvert('is_cancel', (v) => boolFromDynamic(v)),
      depth: $checkedConvert('depth', (v) => depthFromString(v as String?)),
      intensity: $checkedConvert(
        'calcintensity',
        (v) => JmaIntensity.fromString(v as String?),
      ),
      isFinal: $checkedConvert('is_final', (v) => boolFromDynamic(v)),
      isTraining: $checkedConvert('isTraining', (v) => boolFromDynamic(v)),
      latitude: $checkedConvert(
        'latitude',
        (v) => doubleOrNullFromString(v as String?),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => originTimeFromString(v as String?),
      ),
      security: $checkedConvert(
        'security',
        (v) => v == null ? null : Security.fromJson(v as Map<String, dynamic>),
      ),
      magnitude: $checkedConvert(
        'magnitude',
        (v) => doubleOrNullFromString(v as String?),
      ),
      reportNum: $checkedConvert(
        'report_num',
        (v) => intFromString(v as String?),
      ),
      requestHypoType: $checkedConvert(
        'request_hypo_type',
        (v) => v as String?,
      ),
      reportId: $checkedConvert('report_id', (v) => v as String?),
      alertFlag: $checkedConvert('alertflg', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'reportTime': 'report_time',
    'regionCode': 'region_code',
    'requestTime': 'request_time',
    'regionName': 'region_name',
    'isCancel': 'is_cancel',
    'intensity': 'calcintensity',
    'isFinal': 'is_final',
    'originTime': 'origin_time',
    'reportNum': 'report_num',
    'requestHypoType': 'request_hypo_type',
    'reportId': 'report_id',
    'alertFlag': 'alertflg',
  },
);

Map<String, dynamic> _$EewToJson(_Eew instance) => <String, dynamic>{
  'result': instance.result,
  'report_time': dateTimeOrNullToString(instance.reportTime),
  'region_code': instance.regionCode,
  'request_time': instance.requestTime,
  'region_name': instance.regionName,
  'longitude': doubleOrNullToString(instance.longitude),
  'is_cancel': instance.isCancel,
  'depth': depthToString(instance.depth),
  'calcintensity': _$JmaIntensityEnumMap[instance.intensity],
  'is_final': instance.isFinal,
  'isTraining': instance.isTraining,
  'latitude': doubleOrNullToString(instance.latitude),
  'origin_time': instance.originTime?.toIso8601String(),
  'security': instance.security,
  'magnitude': doubleOrNullToString(instance.magnitude),
  'report_num': intToString(instance.reportNum),
  'request_hypo_type': instance.requestHypoType,
  'report_id': instance.reportId,
  'alertflg': instance.alertFlag,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};
