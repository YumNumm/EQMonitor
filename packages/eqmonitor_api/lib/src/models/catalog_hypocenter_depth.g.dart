// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_hypocenter_depth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogHypocenterDepth _$CatalogHypocenterDepthFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CatalogHypocenterDepth', json, ($checkedConvert) {
  final val = _CatalogHypocenterDepth(
    value: $checkedConvert('value', (v) => v as num),
    isFree: $checkedConvert('is_free', (v) => v as bool),
    stderr: $checkedConvert('stderr', (v) => v as num?),
  );
  return val;
}, fieldKeyMap: const {'isFree': 'is_free'});

Map<String, dynamic> _$CatalogHypocenterDepthToJson(
  _CatalogHypocenterDepth instance,
) => <String, dynamic>{
  'value': instance.value,
  'is_free': instance.isFree,
  'stderr': ?instance.stderr,
};
