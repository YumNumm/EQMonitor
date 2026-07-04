// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogHypocenter _$CatalogHypocenterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CatalogHypocenter',
  json,
  ($checkedConvert) {
    final val = _CatalogHypocenter(
      seq: $checkedConvert('seq', (v) => (v as num).toInt()),
      recordType: $checkedConvert(
        'record_type',
        (v) => $enumDecode(_$CatalogHypocenterRecordTypeEnumMap, v),
      ),
      magnitudes: $checkedConvert(
        'magnitudes',
        (v) => (v as List<dynamic>)
            .map(
              (e) => CatalogHypocenterMagnitude.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      epicenterName: $checkedConvert('epicenter_name', (v) => v as String),
      stationCount: $checkedConvert('station_count', (v) => (v as num).toInt()),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTimeStderrSeconds: $checkedConvert(
        'origin_time_stderr_seconds',
        (v) => v as num?,
      ),
      coordinates: $checkedConvert(
        'coordinates',
        (v) =>
            v == null ? null : Coordinate.fromJson(v as Map<String, dynamic>),
      ),
      depth: $checkedConvert(
        'depth',
        (v) => v == null
            ? null
            : CatalogHypocenterDepth.fromJson(v as Map<String, dynamic>),
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecodeNullable(_$CatalogIntensityClassEnumMap, v),
      ),
      largeAreaCode: $checkedConvert(
        'large_area_code',
        (v) => (v as num?)?.toInt(),
      ),
      smallAreaCode: $checkedConvert(
        'small_area_code',
        (v) => (v as num?)?.toInt(),
      ),
      determinationFlag: $checkedConvert(
        'determination_flag',
        (v) => $enumDecodeNullable(_$CatalogDeterminationFlagEnumMap, v),
      ),
      evaluation: $checkedConvert(
        'evaluation',
        (v) => $enumDecodeNullable(_$CatalogHypocenterEvaluationEnumMap, v),
      ),
      auxiliaryInfo: $checkedConvert(
        'auxiliary_info',
        (v) => $enumDecodeNullable(_$CatalogHypocenterAuxiliaryInfoEnumMap, v),
      ),
      travelTimeTable: $checkedConvert(
        'travel_time_table',
        (v) => $enumDecodeNullable(_$CatalogTravelTimeTableEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'recordType': 'record_type',
    'epicenterName': 'epicenter_name',
    'stationCount': 'station_count',
    'originTime': 'origin_time',
    'originTimeStderrSeconds': 'origin_time_stderr_seconds',
    'maxIntensity': 'max_intensity',
    'largeAreaCode': 'large_area_code',
    'smallAreaCode': 'small_area_code',
    'determinationFlag': 'determination_flag',
    'auxiliaryInfo': 'auxiliary_info',
    'travelTimeTable': 'travel_time_table',
  },
);

Map<String, dynamic> _$CatalogHypocenterToJson(_CatalogHypocenter instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'record_type': instance.recordType,
      'magnitudes': instance.magnitudes,
      'epicenter_name': instance.epicenterName,
      'station_count': instance.stationCount,
      'origin_time': ?instance.originTime?.toIso8601String(),
      'origin_time_stderr_seconds': ?instance.originTimeStderrSeconds,
      'coordinates': ?instance.coordinates,
      'depth': ?instance.depth,
      'max_intensity': ?instance.maxIntensity,
      'large_area_code': ?instance.largeAreaCode,
      'small_area_code': ?instance.smallAreaCode,
      'determination_flag': ?instance.determinationFlag,
      'evaluation': ?instance.evaluation,
      'auxiliary_info': ?instance.auxiliaryInfo,
      'travel_time_table': ?instance.travelTimeTable,
    };

const _$CatalogHypocenterRecordTypeEnumMap = {
  CatalogHypocenterRecordType.a: 'A',
  CatalogHypocenterRecordType.b: 'B',
  CatalogHypocenterRecordType.d: 'D',
};

const _$CatalogIntensityClassEnumMap = {
  CatalogIntensityClass.value1: '1',
  CatalogIntensityClass.value2: '2',
  CatalogIntensityClass.value3: '3',
  CatalogIntensityClass.value4: '4',
  CatalogIntensityClass.value5: '5',
  CatalogIntensityClass.value6: '6',
  CatalogIntensityClass.value7: '7',
  CatalogIntensityClass.value9: '9',
  CatalogIntensityClass.a: 'A',
  CatalogIntensityClass.b: 'B',
  CatalogIntensityClass.c: 'C',
  CatalogIntensityClass.d: 'D',
  CatalogIntensityClass.l: 'L',
  CatalogIntensityClass.s: 'S',
  CatalogIntensityClass.m: 'M',
  CatalogIntensityClass.r: 'R',
  CatalogIntensityClass.f: 'F',
  CatalogIntensityClass.x: 'X',
};

const _$CatalogDeterminationFlagEnumMap = {
  CatalogDeterminationFlag.upperK: 'K',
  CatalogDeterminationFlag.upperS: 'S',
  CatalogDeterminationFlag.lowerK: 'k',
  CatalogDeterminationFlag.lowerS: 's',
  CatalogDeterminationFlag.upperA: 'A',
  CatalogDeterminationFlag.lowerA: 'a',
  CatalogDeterminationFlag.n: 'N',
  CatalogDeterminationFlag.u: 'U',
  CatalogDeterminationFlag.i: 'I',
  CatalogDeterminationFlag.h: 'H',
  CatalogDeterminationFlag.d: 'D',
  CatalogDeterminationFlag.m: 'M',
};

const _$CatalogHypocenterEvaluationEnumMap = {
  CatalogHypocenterEvaluation.value1: '1',
  CatalogHypocenterEvaluation.value2: '2',
  CatalogHypocenterEvaluation.value3: '3',
  CatalogHypocenterEvaluation.value4: '4',
  CatalogHypocenterEvaluation.value5: '5',
  CatalogHypocenterEvaluation.value7: '7',
  CatalogHypocenterEvaluation.value8: '8',
};

const _$CatalogHypocenterAuxiliaryInfoEnumMap = {
  CatalogHypocenterAuxiliaryInfo.value1: '1',
  CatalogHypocenterAuxiliaryInfo.value2: '2',
  CatalogHypocenterAuxiliaryInfo.value3: '3',
  CatalogHypocenterAuxiliaryInfo.value4: '4',
  CatalogHypocenterAuxiliaryInfo.value5: '5',
};

const _$CatalogTravelTimeTableEnumMap = {
  CatalogTravelTimeTable.value1: '1',
  CatalogTravelTimeTable.value2: '2',
  CatalogTravelTimeTable.value3: '3',
  CatalogTravelTimeTable.value4: '4',
  CatalogTravelTimeTable.value5: '5',
  CatalogTravelTimeTable.value6: '6',
  CatalogTravelTimeTable.value7: '7',
};
