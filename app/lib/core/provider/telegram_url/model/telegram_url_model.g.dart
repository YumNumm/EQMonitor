// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramUrlModel _$TelegramUrlModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TelegramUrlModel',
      json,
      ($checkedConvert) {
        final val = _TelegramUrlModel(
          restApiUrl: $checkedConvert('rest_api_url', (v) => v as String),
          wsApiUrl: $checkedConvert('ws_api_url', (v) => v as String),
          apiAuthorization: $checkedConvert(
            'api_authorization',
            (v) => v as String?,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'restApiUrl': 'rest_api_url',
        'wsApiUrl': 'ws_api_url',
        'apiAuthorization': 'api_authorization',
      },
    );

Map<String, dynamic> _$TelegramUrlModelToJson(_TelegramUrlModel instance) =>
    <String, dynamic>{
      'rest_api_url': instance.restApiUrl,
      'ws_api_url': instance.wsApiUrl,
      'api_authorization': instance.apiAuthorization,
    };
