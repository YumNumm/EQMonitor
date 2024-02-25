// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'app_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppInformationImpl _$$AppInformationImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$AppInformationImpl',
      json,
      ($checkedConvert) {
        final val = _$AppInformationImpl(
          iosLatestVersion:
              $checkedConvert('ios_latest_version', (v) => v as String),
          androidLatestVersion:
              $checkedConvert('android_latest_version', (v) => v as String),
          iosMinimumVersion:
              $checkedConvert('ios_minimum_version', (v) => v as String?),
          androidMinimumVersion:
              $checkedConvert('android_minimum_version', (v) => v as String?),
          iosDownloadUrl:
              $checkedConvert('ios_download_url', (v) => v as String?),
          androidDownloadUrl:
              $checkedConvert('android_download_url', (v) => v as String?),
          forceUpdateMessage:
              $checkedConvert('force_update_message', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'iosLatestVersion': 'ios_latest_version',
        'androidLatestVersion': 'android_latest_version',
        'iosMinimumVersion': 'ios_minimum_version',
        'androidMinimumVersion': 'android_minimum_version',
        'iosDownloadUrl': 'ios_download_url',
        'androidDownloadUrl': 'android_download_url',
        'forceUpdateMessage': 'force_update_message'
      },
    );

Map<String, dynamic> _$$AppInformationImplToJson(
        _$AppInformationImpl instance) =>
    <String, dynamic>{
      'ios_latest_version': instance.iosLatestVersion,
      'android_latest_version': instance.androidLatestVersion,
      'ios_minimum_version': instance.iosMinimumVersion,
      'android_minimum_version': instance.androidMinimumVersion,
      'ios_download_url': instance.iosDownloadUrl,
      'android_download_url': instance.androidDownloadUrl,
      'force_update_message': instance.forceUpdateMessage,
    };
