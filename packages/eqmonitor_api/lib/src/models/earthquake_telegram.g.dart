// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_telegram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegram _$EarthquakeTelegramFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeTelegram', json, ($checkedConvert) {
      final val = _EarthquakeTelegram(
        telegram: $checkedConvert(
          'telegram',
          (v) => Telegram.fromJson(v as Map<String, dynamic>),
        ),
        comments: $checkedConvert(
          'comments',
          (v) => v == null
              ? null
              : TelegramComments.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeTelegramToJson(_EarthquakeTelegram instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'comments': instance.comments,
    };
