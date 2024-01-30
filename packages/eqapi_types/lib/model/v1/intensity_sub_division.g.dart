// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'intensity_sub_division.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntensitySubDivisionImpl _$$IntensitySubDivisionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$IntensitySubDivisionImpl',
      json,
      ($checkedConvert) {
        final val = _$IntensitySubDivisionImpl(
          id: $checkedConvert('id', (v) => v as int),
          eventId: $checkedConvert('eventId', (v) => v as int),
          maxIntensity: $checkedConvert(
              'maxIntensity', (v) => $enumDecode(_$JmaIntensityEnumMap, v)),
          maxLpgmIntensity: $checkedConvert('maxLpgmIntensity',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$IntensitySubDivisionImplToJson(
        _$IntensitySubDivisionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'maxIntensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
      'maxLpgmIntensity': _$JmaLgIntensityEnumMap[instance.maxLpgmIntensity],
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
