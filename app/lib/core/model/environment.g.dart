// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BuildConfig _$BuildConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_BuildConfig',
  json,
  ($checkedConvert) {
    final val = _BuildConfig(
      restApiUrl: $checkedConvert('rest_api_url', (v) => v as String),
      appIdSuffix: $checkedConvert('app_id_suffix', (v) => v as String),
      appName: $checkedConvert('app_name', (v) => v as String),
      commitInformation: $checkedConvert(
        'commit_information',
        (v) => v as String,
      ),
      flavor: $checkedConvert('flavor', (v) => $enumDecode(_$FlavorEnumMap, v)),
      wsApiUrl: $checkedConvert('ws_api_url', (v) => v as String),
      googleIosClientId: $checkedConvert(
        'google_ios_client_id',
        (v) => v as String,
      ),
      googleAndroidClientId: $checkedConvert(
        'google_android_client_id',
        (v) => v as String,
      ),
      buildTimestamp: $checkedConvert('build_timestamp', (v) => v as String),
      buildCommitMessage: $checkedConvert(
        'build_commit_message',
        (v) => v as String,
      ),
      revenueCatApiKeyIos: $checkedConvert(
        'revenue_cat_api_key_ios',
        (v) => v as String,
      ),
      revenueCatApiKeyAndroid: $checkedConvert(
        'revenue_cat_api_key_android',
        (v) => v as String,
      ),
      isBetaTesting: $checkedConvert(
        'is_beta_testing',
        (v) => v as bool? ?? false,
      ),
      isProFeaturesEnabled: $checkedConvert(
        'is_pro_features_enabled',
        (v) => v as bool? ?? false,
      ),
      isShakeDetectionEnabled: $checkedConvert(
        'is_shake_detection_enabled',
        (v) => v as bool? ?? true,
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
    'googleIosClientId': 'google_ios_client_id',
    'googleAndroidClientId': 'google_android_client_id',
    'buildTimestamp': 'build_timestamp',
    'buildCommitMessage': 'build_commit_message',
    'revenueCatApiKeyIos': 'revenue_cat_api_key_ios',
    'revenueCatApiKeyAndroid': 'revenue_cat_api_key_android',
    'isBetaTesting': 'is_beta_testing',
    'isProFeaturesEnabled': 'is_pro_features_enabled',
    'isShakeDetectionEnabled': 'is_shake_detection_enabled',
  },
);

Map<String, dynamic> _$BuildConfigToJson(_BuildConfig instance) =>
    <String, dynamic>{
      'rest_api_url': instance.restApiUrl,
      'app_id_suffix': instance.appIdSuffix,
      'app_name': instance.appName,
      'commit_information': instance.commitInformation,
      'flavor': _$FlavorEnumMap[instance.flavor]!,
      'ws_api_url': instance.wsApiUrl,
      'google_ios_client_id': instance.googleIosClientId,
      'google_android_client_id': instance.googleAndroidClientId,
      'build_timestamp': instance.buildTimestamp,
      'build_commit_message': instance.buildCommitMessage,
      'revenue_cat_api_key_ios': instance.revenueCatApiKeyIos,
      'revenue_cat_api_key_android': instance.revenueCatApiKeyAndroid,
      'is_beta_testing': instance.isBetaTesting,
      'is_pro_features_enabled': instance.isProFeaturesEnabled,
      'is_shake_detection_enabled': instance.isShakeDetectionEnabled,
    };

const _$FlavorEnumMap = {Flavor.dev: 'dev', Flavor.prod: 'prod'};
