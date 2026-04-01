// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Environment _$EnvironmentFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Environment',
  json,
  ($checkedConvert) {
    final val = _Environment(
      restApiUrl: $checkedConvert('rest_api_url', (v) => v as String),
      appIdSuffix: $checkedConvert('app_id_suffix', (v) => v as String),
      appName: $checkedConvert('app_name', (v) => v as String),
      commitInformation: $checkedConvert(
        'commit_information',
        (v) => v as String,
      ),
      flavor: $checkedConvert('flavor', (v) => $enumDecode(_$FlavorEnumMap, v)),
      wsApiUrl: $checkedConvert('ws_api_url', (v) => v as String),
      betterAuthUrl: $checkedConvert('better_auth_url', (v) => v as String),
      googleIosClientId: $checkedConvert(
        'google_ios_client_id',
        (v) => v as String,
      ),
      googleAndroidClientId: $checkedConvert(
        'google_android_client_id',
        (v) => v as String,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'restApiUrl': 'rest_api_url',
    'appIdSuffix': 'app_id_suffix',
    'appName': 'app_name',
    'commitInformation': 'commit_information',
    'wsApiUrl': 'ws_api_url',
    'betterAuthUrl': 'better_auth_url',
    'googleIosClientId': 'google_ios_client_id',
    'googleAndroidClientId': 'google_android_client_id',
  },
);

Map<String, dynamic> _$EnvironmentToJson(_Environment instance) =>
    <String, dynamic>{
      'rest_api_url': instance.restApiUrl,
      'app_id_suffix': instance.appIdSuffix,
      'app_name': instance.appName,
      'commit_information': instance.commitInformation,
      'flavor': _$FlavorEnumMap[instance.flavor]!,
      'ws_api_url': instance.wsApiUrl,
      'better_auth_url': instance.betterAuthUrl,
      'google_ios_client_id': instance.googleIosClientId,
      'google_android_client_id': instance.googleAndroidClientId,
    };

const _$FlavorEnumMap = {Flavor.dev: 'dev', Flavor.prod: 'prod'};
