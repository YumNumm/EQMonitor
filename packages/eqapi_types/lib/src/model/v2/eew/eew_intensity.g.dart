// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewIntensityValue _$EewIntensityValueFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewIntensityValue', json, ($checkedConvert) {
      final val = _EewIntensityValue(
        value: $checkedConvert(
          'value',
          (v) => $enumDecode(_$IntensityValueEnumMap, v),
        ),
        isOver: $checkedConvert('is_over', (v) => v as bool),
      );
      return val;
    }, fieldKeyMap: const {'isOver': 'is_over'});

Map<String, dynamic> _$EewIntensityValueToJson(_EewIntensityValue instance) =>
    <String, dynamic>{
      'value': _$IntensityValueEnumMap[instance.value]!,
      'is_over': instance.isOver,
    };

const _$IntensityValueEnumMap = {
  IntensityValue.zero: '0',
  IntensityValue.one: '1',
  IntensityValue.two: '2',
  IntensityValue.three: '3',
  IntensityValue.four: '4',
  IntensityValue.fiveLowerNoInput: '!5-',
  IntensityValue.fiveLower: '5-',
  IntensityValue.fiveUpper: '5+',
  IntensityValue.sixLower: '6-',
  IntensityValue.sixUpper: '6+',
  IntensityValue.seven: '7',
};

_EewIntensityLpgmValue _$EewIntensityLpgmValueFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewIntensityLpgmValue', json, ($checkedConvert) {
  final val = _EewIntensityLpgmValue(
    value: $checkedConvert(
      'value',
      (v) => $enumDecode(_$LpgmIntensityValueEnumMap, v),
    ),
    isOver: $checkedConvert('is_over', (v) => v as bool),
  );
  return val;
}, fieldKeyMap: const {'isOver': 'is_over'});

Map<String, dynamic> _$EewIntensityLpgmValueToJson(
  _EewIntensityLpgmValue instance,
) => <String, dynamic>{
  'value': _$LpgmIntensityValueEnumMap[instance.value]!,
  'is_over': instance.isOver,
};

const _$LpgmIntensityValueEnumMap = {
  LpgmIntensityValue.zero: '0',
  LpgmIntensityValue.one: '1',
  LpgmIntensityValue.two: '2',
  LpgmIntensityValue.three: '3',
  LpgmIntensityValue.four: '4',
};

EewArrivalTimeTime _$EewArrivalTimeTimeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EewArrivalTimeTime', json, ($checkedConvert) {
      final val = EewArrivalTimeTime(
        value: $checkedConvert('value', (v) => DateTime.parse(v as String)),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$EewArrivalTimeTimeToJson(EewArrivalTimeTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'type': instance.$type,
    };

EewArrivalTimeArrived _$EewArrivalTimeArrivedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EewArrivalTimeArrived', json, ($checkedConvert) {
  final val = EewArrivalTimeArrived(
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$EewArrivalTimeArrivedToJson(
  EewArrivalTimeArrived instance,
) => <String, dynamic>{'type': instance.$type};

_EewIntensityItem _$EewIntensityItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewIntensityItem',
      json,
      ($checkedConvert) {
        final val = _EewIntensityItem(
          value: $checkedConvert(
            'value',
            (v) => CodeName.fromJson(v as Map<String, dynamic>),
          ),
          isPlum: $checkedConvert('is_plum', (v) => v as bool),
          isWarning: $checkedConvert('is_warning', (v) => v as bool),
          intensity: $checkedConvert(
            'intensity',
            (v) => EewIntensityValue.fromJson(v as Map<String, dynamic>),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => v == null
                ? null
                : EewIntensityLpgmValue.fromJson(v as Map<String, dynamic>),
          ),
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => EewArrivalTime.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'isPlum': 'is_plum',
        'isWarning': 'is_warning',
        'lpgmIntensity': 'lpgm_intensity',
        'arrivalTime': 'arrival_time',
      },
    );

Map<String, dynamic> _$EewIntensityItemToJson(_EewIntensityItem instance) =>
    <String, dynamic>{
      'value': instance.value,
      'is_plum': instance.isPlum,
      'is_warning': instance.isWarning,
      'intensity': instance.intensity,
      'lpgm_intensity': instance.lpgmIntensity,
      'arrival_time': instance.arrivalTime,
    };

_EewIntensity _$EewIntensityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewIntensity',
      json,
      ($checkedConvert) {
        final val = _EewIntensity(
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => v == null
                ? null
                : EewIntensityValue.fromJson(v as Map<String, dynamic>),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) => v == null
                ? null
                : EewIntensityLpgmValue.fromJson(v as Map<String, dynamic>),
          ),
          regions: $checkedConvert(
            'regions',
            (v) => (v as List<dynamic>)
                .map(
                  (e) => EewIntensityItem.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxIntensity': 'max_intensity',
        'maxLpgmIntensity': 'max_lpgm_intensity',
      },
    );

Map<String, dynamic> _$EewIntensityToJson(_EewIntensity instance) =>
    <String, dynamic>{
      'max_intensity': instance.maxIntensity,
      'max_lpgm_intensity': instance.maxLpgmIntensity,
      'regions': instance.regions,
    };
