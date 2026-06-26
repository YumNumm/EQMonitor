// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_comments_warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramCommentsWarning _$TsunamiTelegramCommentsWarningFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiTelegramCommentsWarning', json, ($checkedConvert) {
  final val = _TsunamiTelegramCommentsWarning(
    text: $checkedConvert('text', (v) => v as String),
    codes: $checkedConvert(
      'codes',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiTelegramCommentsWarningToJson(
  _TsunamiTelegramCommentsWarning instance,
) => <String, dynamic>{'text': instance.text, 'codes': instance.codes};
