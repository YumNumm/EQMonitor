// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TelegramUrlModel _$$_TelegramUrlModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramUrlModel',
      json,
      ($checkedConvert) {
        final val = _$_TelegramUrlModel(
          restApiUrl: $checkedConvert('restApiUrl', (v) => v as String),
          wsApiUrl: $checkedConvert('wsApiUrl', (v) => v as String),
          apiAuthorization:
              $checkedConvert('apiAuthorization', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TelegramUrlModelToJson(_$_TelegramUrlModel instance) =>
    <String, dynamic>{
      'restApiUrl': instance.restApiUrl,
      'wsApiUrl': instance.wsApiUrl,
      'apiAuthorization': instance.apiAuthorization,
    };
