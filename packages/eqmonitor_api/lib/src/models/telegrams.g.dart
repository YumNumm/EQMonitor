// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegrams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Telegrams _$TelegramsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Telegrams', json, ($checkedConvert) {
      final val = _Telegrams(
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

Map<String, dynamic> _$TelegramsToJson(_Telegrams instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'comments': instance.comments,
    };
