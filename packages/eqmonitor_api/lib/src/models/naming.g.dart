// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'naming.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Naming _$NamingFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Naming', json, ($checkedConvert) {
      final val = _Naming(
        text: $checkedConvert('text', (v) => v as String),
        en: $checkedConvert('en', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$NamingToJson(_Naming instance) => <String, dynamic>{
  'text': instance.text,
  'en': ?instance.en,
};
