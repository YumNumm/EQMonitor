// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_hypocenter_magnitude.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogHypocenterMagnitude _$CatalogHypocenterMagnitudeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CatalogHypocenterMagnitude', json, ($checkedConvert) {
  final val = _CatalogHypocenterMagnitude(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$CatalogMagnitudeTypeEnumMap, v),
    ),
    value: $checkedConvert('value', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$CatalogHypocenterMagnitudeToJson(
  _CatalogHypocenterMagnitude instance,
) => <String, dynamic>{'type': instance.type, 'value': instance.value};

const _$CatalogMagnitudeTypeEnumMap = {
  CatalogMagnitudeType.j: 'J',
  CatalogMagnitudeType.upperD: 'D',
  CatalogMagnitudeType.lowerD: 'd',
  CatalogMagnitudeType.upperV: 'V',
  CatalogMagnitudeType.lowerV: 'v',
  CatalogMagnitudeType.w: 'W',
  CatalogMagnitudeType.b: 'B',
  CatalogMagnitudeType.s: 'S',
};
