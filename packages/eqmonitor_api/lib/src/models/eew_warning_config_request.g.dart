// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_config_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewWarningConfigRequest _$EewWarningConfigRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EewWarningConfigRequest',
  json,
  ($checkedConvert) {
    final val = _EewWarningConfigRequest(
      target: $checkedConvert(
        'target',
        (v) => $enumDecodeNullable(_$TargetEnumMap, v),
      ),
      currentLocationInterruptionLevel: $checkedConvert(
        'current_location_interruption_level',
        (v) =>
            $enumDecodeNullable(_$CurrentLocationInterruptionLevelEnumMap, v),
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

Map<String, dynamic> _$EewWarningConfigRequestToJson(
  _EewWarningConfigRequest instance,
) => <String, dynamic>{
  'target': ?instance.target,
  'current_location_interruption_level':
      ?instance.currentLocationInterruptionLevel,
  'nationwide_interruption_level': ?instance.nationwideInterruptionLevel,
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
  NationwideInterruptionLevel.critical: 'critical',
};
