// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'whats_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WhatsNew _$WhatsNewFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WhatsNew', json, ($checkedConvert) {
      final val = _WhatsNew(
        content: $checkedConvert('content', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$WhatsNewToJson(_WhatsNew instance) => <String, dynamic>{
  'content': instance.content,
  'title': ?instance.title,
};
