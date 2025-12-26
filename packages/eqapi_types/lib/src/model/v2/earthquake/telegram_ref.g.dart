// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'telegram_ref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegramRef _$EarthquakeTelegramRefFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeTelegramRef', json, ($checkedConvert) {
  final val = _EarthquakeTelegramRef(
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

Map<String, dynamic> _$EarthquakeTelegramRefToJson(
  _EarthquakeTelegramRef instance,
) => <String, dynamic>{
  'telegram': instance.telegram,
  'comments': instance.comments,
};
