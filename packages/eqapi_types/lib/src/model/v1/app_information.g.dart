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
          ios: $checkedConvert(
              'ios',
              (v) =>
                  PlatformAppInformation.fromJson(v as Map<String, dynamic>)),
          android: $checkedConvert(
              'android',
              (v) =>
                  PlatformAppInformation.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$AppInformationImplToJson(
        _$AppInformationImpl instance) =>
    <String, dynamic>{
      'ios': instance.ios,
      'android': instance.android,
    };

_$PlatformAppInformationImpl _$$PlatformAppInformationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PlatformAppInformationImpl',
      json,
      ($checkedConvert) {
        final val = _$PlatformAppInformationImpl(
          latest: $checkedConvert(
              'latest',
              (v) => v == null
                  ? null
                  : AppVersion.fromJson(v as Map<String, dynamic>)),
          minimum: $checkedConvert(
              'minimum',
              (v) => v == null
                  ? null
                  : AppVersion.fromJson(v as Map<String, dynamic>)),
          downloadUrl: $checkedConvert('download_url', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'downloadUrl': 'download_url'},
    );

Map<String, dynamic> _$$PlatformAppInformationImplToJson(
        _$PlatformAppInformationImpl instance) =>
    <String, dynamic>{
      'latest': instance.latest,
      'minimum': instance.minimum,
      'download_url': instance.downloadUrl,
    };

_$AppVersionImpl _$$AppVersionImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$AppVersionImpl',
      json,
      ($checkedConvert) {
        final val = _$AppVersionImpl(
          version: $checkedConvert('version', (v) => v as String),
          message: $checkedConvert('message', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$AppVersionImplToJson(_$AppVersionImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
      'message': instance.message,
    };
