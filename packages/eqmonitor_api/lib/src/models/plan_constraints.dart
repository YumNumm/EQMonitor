// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_constraints.freezed.dart';
part 'plan_constraints.g.dart';

@Freezed()
abstract class PlanConstraints with _$PlanConstraints {
  const factory PlanConstraints({
    @JsonKey(name: 'is_pro')
    required bool isPro,
    @JsonKey(name: 'max_regions')
    required num maxRegions,
    @JsonKey(name: 'eew_warning_nationwide')
    required bool eewWarningNationwide,
    @JsonKey(name: 'shake_detection')
    required bool shakeDetection,
    @JsonKey(name: 'overrides_allowed')
    required bool overridesAllowed,
    @JsonKey(name: 'earthquake_default_interruption_level')
    required String earthquakeDefaultInterruptionLevel,
    @JsonKey(name: 'eew_default_interruption_level')
    required String eewDefaultInterruptionLevel,
  }) = _PlanConstraints;
  
  factory PlanConstraints.fromJson(Map<String, Object?> json) => _$PlanConstraintsFromJson(json);
}
