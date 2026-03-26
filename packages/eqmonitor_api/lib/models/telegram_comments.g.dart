// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramComments _$TelegramCommentsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TelegramComments', json, ($checkedConvert) {
      final val = _TelegramComments(
        text: $checkedConvert('text', (v) => v as String?),
        free: $checkedConvert('free', (v) => v as String?),
        warning: $checkedConvert('warning', (v) => v as String?),
        forecast: $checkedConvert('forecast', (v) => v as String?),
        additional: $checkedConvert('additional', (v) => v as String?),
        uri: $checkedConvert('uri', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TelegramCommentsToJson(_TelegramComments instance) =>
    <String, dynamic>{
      'text': ?instance.text,
      'free': ?instance.free,
      'warning': ?instance.warning,
      'forecast': ?instance.forecast,
      'additional': ?instance.additional,
      'uri': ?instance.uri,
    };
