// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_override.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationOverride _$NotificationOverrideFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationOverride',
  json,
  ($checkedConvert) {
    final val = _NotificationOverride(
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      sound: $checkedConvert('sound', (v) => v as String),
      interruptionLevel: $checkedConvert(
        'interruption_level',
        (v) => $enumDecode(_$InterruptionLevelEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'minJmaIntensity': 'min_jma_intensity',
    'interruptionLevel': 'interruption_level',
  },
);

Map<String, dynamic> _$NotificationOverrideToJson(
  _NotificationOverride instance,
) => <String, dynamic>{
  'min_jma_intensity': _$JmaIntensityEnumMap[instance.minJmaIntensity]!,
  'sound': instance.sound,
  'interruption_level': _$InterruptionLevelEnumMap[instance.interruptionLevel]!,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixUnknown: 'sixUnknown',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};

const _$InterruptionLevelEnumMap = {
  InterruptionLevel.passive: 'passive',
  InterruptionLevel.active: 'active',
  InterruptionLevel.timeSensitive: 'timeSensitive',
  InterruptionLevel.critical: 'critical',
};
