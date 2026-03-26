// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_header_only_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramHeaderOnlyItem _$TsunamiTelegramHeaderOnlyItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiTelegramHeaderOnlyItem', json, ($checkedConvert) {
  final val = _TsunamiTelegramHeaderOnlyItem(
    telegram: $checkedConvert(
      'telegram',
      (v) => TsunamiTelegramHeader.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiTelegramHeaderOnlyItemToJson(
  _TsunamiTelegramHeaderOnlyItem instance,
) => <String, dynamic>{'telegram': instance.telegram};
