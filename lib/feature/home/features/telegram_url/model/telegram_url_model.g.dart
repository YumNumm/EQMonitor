// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelegramUrlModelImpl _$$TelegramUrlModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramUrlModelImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramUrlModelImpl(
          restApiUrl: $checkedConvert('restApiUrl', (v) => v as String),
          wsApiUrl: $checkedConvert('wsApiUrl', (v) => v as String),
          apiAuthorization:
              $checkedConvert('apiAuthorization', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramUrlModelImplToJson(
        _$TelegramUrlModelImpl instance) =>
    <String, dynamic>{
      'restApiUrl': instance.restApiUrl,
      'wsApiUrl': instance.wsApiUrl,
      'apiAuthorization': instance.apiAuthorization,
    };
