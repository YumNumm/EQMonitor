// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'plan_constraints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanConstraints _$PlanConstraintsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_PlanConstraints',
      json,
      ($checkedConvert) {
        final val = _PlanConstraints(
          isPro: $checkedConvert('is_pro', (v) => v as bool),
          maxRegions: $checkedConvert('max_regions', (v) => v as num),
          eewWarningNationwide: $checkedConvert(
            'eew_warning_nationwide',
            (v) => v as bool,
          ),
          shakeDetection: $checkedConvert('shake_detection', (v) => v as bool),
          overridesAllowed: $checkedConvert(
            'overrides_allowed',
            (v) => v as bool,
          ),
          earthquakeDefaultInterruptionLevel: $checkedConvert(
            'earthquake_default_interruption_level',
            (v) => v as String,
          ),
          eewDefaultInterruptionLevel: $checkedConvert(
            'eew_default_interruption_level',
            (v) => v as String,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'isPro': 'is_pro',
        'maxRegions': 'max_regions',
        'eewWarningNationwide': 'eew_warning_nationwide',
        'shakeDetection': 'shake_detection',
        'overridesAllowed': 'overrides_allowed',
        'earthquakeDefaultInterruptionLevel':
            'earthquake_default_interruption_level',
        'eewDefaultInterruptionLevel': 'eew_default_interruption_level',
      },
    );

Map<String, dynamic> _$PlanConstraintsToJson(_PlanConstraints instance) =>
    <String, dynamic>{
      'is_pro': instance.isPro,
      'max_regions': instance.maxRegions,
      'eew_warning_nationwide': instance.eewWarningNationwide,
      'shake_detection': instance.shakeDetection,
      'overrides_allowed': instance.overridesAllowed,
      'earthquake_default_interruption_level':
          instance.earthquakeDefaultInterruptionLevel,
      'eew_default_interruption_level': instance.eewDefaultInterruptionLevel,
    };
