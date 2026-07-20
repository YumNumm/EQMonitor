// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Alert _$AlertFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Alert', json, ($checkedConvert) {
      final val = _Alert(
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AlertToJson(_Alert instance) => <String, dynamic>{
  'title': instance.title,
  'body': instance.body,
};
