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
      nationwideInterruptionLevel: $checkedConvert(
        'nationwide_interruption_level',
        (v) => $enumDecodeNullable(_$NationwideInterruptionLevelEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'nationwideInterruptionLevel': 'nationwide_interruption_level',
  },
);

Map<String, dynamic> _$EewWarningConfigRequestToJson(
  _EewWarningConfigRequest instance,
) => <String, dynamic>{
  'target': ?instance.target,
  'nationwide_interruption_level': ?instance.nationwideInterruptionLevel,
};

const _$TargetEnumMap = {
  Target.currentLocationOnly: 'current_location_only',
  Target.currentLocationAndNationwide: 'current_location_and_nationwide',
};

const _$NationwideInterruptionLevelEnumMap = {
  NationwideInterruptionLevel.passive: 'passive',
  NationwideInterruptionLevel.active: 'active',
};
