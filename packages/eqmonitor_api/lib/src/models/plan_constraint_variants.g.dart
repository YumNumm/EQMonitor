// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'plan_constraint_variants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanConstraintVariants _$PlanConstraintVariantsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PlanConstraintVariants', json, ($checkedConvert) {
  final val = _PlanConstraintVariants(
    free: $checkedConvert(
      'free',
      (v) => PlanConstraints.fromJson(v as Map<String, dynamic>),
    ),
    subscription: $checkedConvert(
      'subscription',
      (v) => PlanConstraints.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$PlanConstraintVariantsToJson(
  _PlanConstraintVariants instance,
) => <String, dynamic>{
  'free': instance.free,
  'subscription': instance.subscription,
};
