// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_period_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogPeriodValue _$CatalogPeriodValueFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CatalogPeriodValue', json, ($checkedConvert) {
      final val = _CatalogPeriodValue(
        kind: $checkedConvert(
          'kind',
          (v) => $enumDecode(_$CatalogPeriodKindEnumMap, v),
        ),
        value: $checkedConvert('value', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$CatalogPeriodValueToJson(_CatalogPeriodValue instance) =>
    <String, dynamic>{'kind': instance.kind, 'value': ?instance.value};

const _$CatalogPeriodKindEnumMap = {
  CatalogPeriodKind.frequency: 'FREQUENCY',
  CatalogPeriodKind.period: 'PERIOD',
};
