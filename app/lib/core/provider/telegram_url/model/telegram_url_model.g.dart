// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'telegram_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelegramUrlModelImpl _$$TelegramUrlModelImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$TelegramUrlModelImpl',
  json,
  ($checkedConvert) {
    final val = _$TelegramUrlModelImpl(
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

Map<String, dynamic> _$$TelegramUrlModelImplToJson(
  _$TelegramUrlModelImpl instance,
) => <String, dynamic>{
  'rest_api_url': instance.restApiUrl,
  'ws_api_url': instance.wsApiUrl,
  'api_authorization': instance.apiAuthorization,
};
