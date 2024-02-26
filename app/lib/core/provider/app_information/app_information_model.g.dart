// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'app_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppInformationModelImpl _$$AppInformationModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$AppInformationModelImpl',
      json,
      ($checkedConvert) {
        final val = _$AppInformationModelImpl(
          latestVersion: $checkedConvert(
              'latestVersion', (v) => versionFromJson(v as String)),
          minimumVersion: $checkedConvert(
              'minimumVersion', (v) => versionFromJsonNullable(v as String?)),
          downloadUrl: $checkedConvert(
              'downloadUrl', (v) => uriFromJsonNullable(v as String?)),
          forceUpdateMessage:
              $checkedConvert('forceUpdateMessage', (v) => v as String?),
          hasUpdate: $checkedConvert('hasUpdate', (v) => v as bool),
          hasForceUpdate: $checkedConvert('hasForceUpdate', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$$AppInformationModelImplToJson(
        _$AppInformationModelImpl instance) =>
    <String, dynamic>{
      'latestVersion': versionToJson(instance.latestVersion),
      'minimumVersion': versionToJsonNullable(instance.minimumVersion),
      'downloadUrl': uriToJsonNullable(instance.downloadUrl),
      'forceUpdateMessage': instance.forceUpdateMessage,
      'hasUpdate': instance.hasUpdate,
      'hasForceUpdate': instance.hasForceUpdate,
    };
