// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'widget_region_selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WidgetRegionSelection _$WidgetRegionSelectionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WidgetRegionSelection', json, ($checkedConvert) {
  final val = _WidgetRegionSelection(
    searchType: $checkedConvert(
      'search_type',
      (v) => $enumDecode(_$RegionSearchTypeEnumMap, v),
    ),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'searchType': 'search_type'});

Map<String, dynamic> _$WidgetRegionSelectionToJson(
  _WidgetRegionSelection instance,
) => <String, dynamic>{
  'search_type': _$RegionSearchTypeEnumMap[instance.searchType]!,
  'code': instance.code,
  'name': instance.name,
};

const _$RegionSearchTypeEnumMap = {
  RegionSearchType.prefecture: 'prefecture',
  RegionSearchType.region: 'region',
  RegionSearchType.city: 'city',
  RegionSearchType.station: 'station',
};
