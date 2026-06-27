// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramComments _$TsunamiTelegramCommentsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiTelegramComments', json, ($checkedConvert) {
  final val = _TsunamiTelegramComments(
    free: $checkedConvert('free', (v) => v as String?),
    warning: $checkedConvert(
      'warning',
      (v) => v == null
          ? null
          : TsunamiTelegramCommentsWarning.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiTelegramCommentsToJson(
  _TsunamiTelegramComments instance,
) => <String, dynamic>{'free': ?instance.free, 'warning': ?instance.warning};
