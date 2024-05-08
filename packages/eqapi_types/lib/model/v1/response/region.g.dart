// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegionItemImpl _$$RegionItemImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$RegionItemImpl',
      json,
      ($checkedConvert) {
        final val = _$RegionItemImpl(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          areaCode: $checkedConvert('area_code', (v) => v as String),
          maxIntensity: $checkedConvert(
              'max_intensity', (v) => $enumDecode(_$JmaIntensityEnumMap, v)),
          maxLpgmIntensity: $checkedConvert('max_lpgm_intensity',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v)),
          earthquake: $checkedConvert('earthquake',
              (v) => EarthquakeV1Base.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'areaCode': 'area_code',
        'maxIntensity': 'max_intensity',
        'maxLpgmIntensity': 'max_lpgm_intensity'
      },
    );

Map<String, dynamic> _$$RegionItemImplToJson(_$RegionItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'area_code': instance.areaCode,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
      'max_lpgm_intensity': _$JmaLgIntensityEnumMap[instance.maxLpgmIntensity],
      'earthquake': instance.earthquake,
    };

const _$JmaIntensityEnumMap = {
  JmaIntensity.one: '1',
  JmaIntensity.two: '2',
  JmaIntensity.three: '3',
  JmaIntensity.four: '4',
  JmaIntensity.fiveLower: '5-',
  JmaIntensity.fiveUpper: '5+',
  JmaIntensity.sixLower: '6-',
  JmaIntensity.sixUpper: '6+',
  JmaIntensity.seven: '7',
  JmaIntensity.fiveUpperNoInput: '!5-',
};

const _$JmaLgIntensityEnumMap = {
  JmaLgIntensity.zero: '0',
  JmaLgIntensity.one: '1',
  JmaLgIntensity.two: '2',
  JmaLgIntensity.three: '3',
  JmaLgIntensity.four: '4',
};
