// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'plan_constraints.dart';

part 'plan_constraint_variants.freezed.dart';
part 'plan_constraint_variants.g.dart';

@Freezed()
abstract class PlanConstraintVariants with _$PlanConstraintVariants {
  const factory PlanConstraintVariants({
    required PlanConstraints free,
    required PlanConstraints subscription,
  }) = _PlanConstraintVariants;
  
  factory PlanConstraintVariants.fromJson(Map<String, Object?> json) => _$PlanConstraintVariantsFromJson(json);
}
