// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_ws_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelegramWsModelImpl _$$TelegramWsModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramWsModelImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramWsModelImpl(
          telegramStream: $checkedConvert('telegramStream',
              (v) => telegramWsModelFromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramWsModelImplToJson(
        _$TelegramWsModelImpl instance) =>
    <String, dynamic>{
      'telegramStream': telegramWsModelToJson(instance.telegramStream),
    };
