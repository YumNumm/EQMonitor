// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data _$DataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Data', json, ($checkedConvert) {
      final val = _Data(
        version: $checkedConvert('version', (v) => v as String?),
        url: $checkedConvert('url', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
  'version': ?instance.version,
  'url': ?instance.url,
};
