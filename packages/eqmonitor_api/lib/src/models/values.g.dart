// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Values _$ValuesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Values', json, ($checkedConvert) {
      final val = _Values(
        all: $checkedConvert('all', (v) => v as String?),
        felt: $checkedConvert('felt', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ValuesToJson(_Values instance) => <String, dynamic>{
  'all': instance.all,
  'felt': instance.felt,
};
