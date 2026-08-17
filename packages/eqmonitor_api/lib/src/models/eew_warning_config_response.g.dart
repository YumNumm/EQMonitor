// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewWarningConfigResponse _$EewWarningConfigResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EewWarningConfigResponse',
  json,
  ($checkedConvert) {
    final val = _EewWarningConfigResponse(
      target: $checkedConvert('target', (v) => $enumDecode(_$TargetEnumMap, v)),
      currentLocationInterruptionLevel: $checkedConvert(
        'current_location_interruption_level',
        (v) => $enumDecode(_$CurrentLocationInterruptionLevelEnumMap, v),
      ),
      nationwideInterruptionLevel: $checkedConvert(
        'nationwide_interruption_level',
        (v) => $enumDecodeNullable(_$NationwideInterruptionLevelEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'currentLocationInterruptionLevel': 'current_location_interruption_level',
    'nationwideInterruptionLevel': 'nationwide_interruption_level',
  },
);

Map<String, dynamic> _$EewWarningConfigResponseToJson(
  _EewWarningConfigResponse instance,
) => <String, dynamic>{
  'target': instance.target,
  'current_location_interruption_level':
      instance.currentLocationInterruptionLevel,
  'nationwide_interruption_level': instance.nationwideInterruptionLevel,
};

const _$TargetEnumMap = {
  Target.currentLocationOnly: 'current_location_only',
  Target.currentLocationAndNationwide: 'current_location_and_nationwide',
};

const _$CurrentLocationInterruptionLevelEnumMap = {
  CurrentLocationInterruptionLevel.passive: 'passive',
  CurrentLocationInterruptionLevel.active: 'active',
  CurrentLocationInterruptionLevel.timeSensitive: 'time_sensitive',
  CurrentLocationInterruptionLevel.critical: 'critical',
};

const _$NationwideInterruptionLevelEnumMap = {
  NationwideInterruptionLevel.passive: 'passive',
  NationwideInterruptionLevel.active: 'active',
  NationwideInterruptionLevel.timeSensitive: 'time_sensitive',
};
