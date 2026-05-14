// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_code_table_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JmaCodeTableItem _$JmaCodeTableItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_JmaCodeTableItem', json, ($checkedConvert) {
      final val = _JmaCodeTableItem(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JmaCodeTableItemToJson(_JmaCodeTableItem instance) =>
    <String, dynamic>{'code': instance.code, 'name': instance.name};
