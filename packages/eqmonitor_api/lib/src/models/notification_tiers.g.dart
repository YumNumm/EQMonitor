// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_tiers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationTiers _$NotificationTiersFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_NotificationTiers',
      json,
      ($checkedConvert) {
        final val = _NotificationTiers(
          minJmaIntensity: $checkedConvert(
            'min_jma_intensity',
            (v) => $enumDecode(_$MinJmaIntensityEnumMap, v),
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

Map<String, dynamic> _$NotificationTiersToJson(_NotificationTiers instance) =>
    <String, dynamic>{
      'min_jma_intensity': instance.minJmaIntensity,
      'sound': instance.sound,
      'interruption_level': instance.interruptionLevel,
    };

const _$MinJmaIntensityEnumMap = {
  MinJmaIntensity.value0: '0',
  MinJmaIntensity.value1: '1',
  MinJmaIntensity.value2: '2',
  MinJmaIntensity.value3: '3',
  MinJmaIntensity.value4: '4',
  MinJmaIntensity.value5unknown: '!5-',
  MinJmaIntensity.value5minus: '5-',
  MinJmaIntensity.value5plus: '5+',
  MinJmaIntensity.undefined1: '!6-',
  MinJmaIntensity.value6minus: '6-',
  MinJmaIntensity.value6plus: '6+',
  MinJmaIntensity.value7: '7',
};

const _$InterruptionLevelEnumMap = {
  InterruptionLevel.passive: 'passive',
  InterruptionLevel.active: 'active',
  InterruptionLevel.timeSensitive: 'time_sensitive',
  InterruptionLevel.critical: 'critical',
};
