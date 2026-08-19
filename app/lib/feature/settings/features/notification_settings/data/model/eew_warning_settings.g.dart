// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewWarningSettings _$EewWarningSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewWarningSettings',
      json,
      ($checkedConvert) {
        final val = _EewWarningSettings(
          target: $checkedConvert(
            'target',
            (v) => $enumDecode(_$EewWarningTargetEnumMap, v),
          ),
          currentLocationInterruptionLevel: $checkedConvert(
            'current_location_interruption_level',
            (v) => $enumDecode(_$InterruptionLevelEnumMap, v),
          ),
          nationwideInterruptionLevel: $checkedConvert(
            'nationwide_interruption_level',
            (v) => $enumDecodeNullable(_$InterruptionLevelEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentLocationInterruptionLevel':
            'current_location_interruption_level',
        'nationwideInterruptionLevel': 'nationwide_interruption_level',
      },
    );

Map<String, dynamic> _$EewWarningSettingsToJson(
  _EewWarningSettings instance,
) => <String, dynamic>{
  'target': _$EewWarningTargetEnumMap[instance.target]!,
  'current_location_interruption_level':
      _$InterruptionLevelEnumMap[instance.currentLocationInterruptionLevel]!,
  'nationwide_interruption_level':
      _$InterruptionLevelEnumMap[instance.nationwideInterruptionLevel],
};

const _$EewWarningTargetEnumMap = {
  EewWarningTarget.currentLocationOnly: 'currentLocationOnly',
  EewWarningTarget.currentLocationAndNationwide: 'currentLocationAndNationwide',
};

const _$InterruptionLevelEnumMap = {
  InterruptionLevel.passive: 'passive',
  InterruptionLevel.active: 'active',
  InterruptionLevel.timeSensitive: 'timeSensitive',
  InterruptionLevel.critical: 'critical',
};
