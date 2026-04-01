// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramItem _$TsunamiTelegramItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiTelegramItem', json, ($checkedConvert) {
      final val = _TsunamiTelegramItem(
        telegram: $checkedConvert(
          'telegram',
          (v) => TsunamiTelegramHeader.fromJson(v as Map<String, dynamic>),
        ),
        body: $checkedConvert(
          'body',
          (v) => TsunamiTelegramBody.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiTelegramItemToJson(
  _TsunamiTelegramItem instance,
) => <String, dynamic>{'telegram': instance.telegram, 'body': instance.body};
