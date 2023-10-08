// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_ws_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TelegramWsModel _$$_TelegramWsModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramWsModel',
      json,
      ($checkedConvert) {
        final val = _$_TelegramWsModel(
          telegramStream: $checkedConvert('telegramStream',
              (v) => telegramWsModelFromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TelegramWsModelToJson(_$_TelegramWsModel instance) =>
    <String, dynamic>{
      'telegramStream': telegramWsModelToJson(instance.telegramStream),
    };
