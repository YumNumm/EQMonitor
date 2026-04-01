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
      appIdSuffix: $checkedConvert('app_id_suffix', (v) => v),
      appName: $checkedConvert('app_name', (v) => v as String),
      commitInformation: $checkedConvert(
        'commit_information',
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
  },
);

Map<String, dynamic> _$EnvironmentToJson(_Environment instance) =>
    <String, dynamic>{
      'rest_api_url': instance.restApiUrl,
      'app_id_suffix': instance.appIdSuffix,
      'app_name': instance.appName,
      'commit_information': instance.commitInformation,
    };
