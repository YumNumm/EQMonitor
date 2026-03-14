// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'epicenter_search_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EpicenterSearchInfo _$EpicenterSearchInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EpicenterSearchInfo', json, ($checkedConvert) {
      final val = _EpicenterSearchInfo(
        code: $checkedConvert('code', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EpicenterSearchInfoToJson(
  _EpicenterSearchInfo instance,
) => <String, dynamic>{'code': instance.code, 'name': instance.name};
