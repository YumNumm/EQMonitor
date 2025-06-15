// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'app_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppInformation _$AppInformationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AppInformation', json, ($checkedConvert) {
      final val = _AppInformation(
        ios: $checkedConvert(
          'ios',
          (v) => PlatformAppInformation.fromJson(v as Map<String, dynamic>),
        ),
        android: $checkedConvert(
          'android',
          (v) => PlatformAppInformation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AppInformationToJson(_AppInformation instance) =>
    <String, dynamic>{'ios': instance.ios, 'android': instance.android};

_PlatformAppInformation _$PlatformAppInformationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PlatformAppInformation', json, ($checkedConvert) {
  final val = _PlatformAppInformation(
    latest: $checkedConvert(
      'latest',
      (v) => v == null ? null : AppVersion.fromJson(v as Map<String, dynamic>),
    ),
    minimum: $checkedConvert(
      'minimum',
      (v) => v == null ? null : AppVersion.fromJson(v as Map<String, dynamic>),
    ),
    downloadUrl: $checkedConvert('download_url', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'downloadUrl': 'download_url'});

Map<String, dynamic> _$PlatformAppInformationToJson(
  _PlatformAppInformation instance,
) => <String, dynamic>{
  'latest': instance.latest,
  'minimum': instance.minimum,
  'download_url': instance.downloadUrl,
};

_AppVersion _$AppVersionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AppVersion', json, ($checkedConvert) {
      final val = _AppVersion(
        version: $checkedConvert('version', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AppVersionToJson(_AppVersion instance) =>
    <String, dynamic>{'version': instance.version, 'message': instance.message};
