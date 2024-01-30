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
              $checkedConvert('iosLatestVersion', (v) => v as String),
          androidLatestVersion:
              $checkedConvert('androidLatestVersion', (v) => v as String),
          iosMinimumVersion:
              $checkedConvert('iosMinimumVersion', (v) => v as String?),
          androidMinimumVersion:
              $checkedConvert('androidMinimumVersion', (v) => v as String?),
          iosDownloadUrl:
              $checkedConvert('iosDownloadUrl', (v) => v as String?),
          androidDownloadUrl:
              $checkedConvert('androidDownloadUrl', (v) => v as String?),
          forceUpdateMessage:
              $checkedConvert('forceUpdateMessage', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$AppInformationImplToJson(
        _$AppInformationImpl instance) =>
    <String, dynamic>{
      'iosLatestVersion': instance.iosLatestVersion,
      'androidLatestVersion': instance.androidLatestVersion,
      'iosMinimumVersion': instance.iosMinimumVersion,
      'androidMinimumVersion': instance.androidMinimumVersion,
      'iosDownloadUrl': instance.iosDownloadUrl,
      'androidDownloadUrl': instance.androidDownloadUrl,
      'forceUpdateMessage': instance.forceUpdateMessage,
    };
