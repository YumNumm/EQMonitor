// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Warning _$WarningFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Warning', json, ($checkedConvert) {
      final val = _Warning(
        text: $checkedConvert('text', (v) => v as String),
        codes: $checkedConvert(
          'codes',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WarningToJson(_Warning instance) => <String, dynamic>{
  'text': instance.text,
  'codes': instance.codes,
};
