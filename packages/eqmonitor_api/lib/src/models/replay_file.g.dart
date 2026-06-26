// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplayFile _$ReplayFileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ReplayFile', json, ($checkedConvert) {
      final val = _ReplayFile(
        id: $checkedConvert('id', (v) => v as String),
        startTime: $checkedConvert('startTime', (v) => v as String),
        endTime: $checkedConvert('endTime', (v) => v as String),
        objectKey: $checkedConvert('objectKey', (v) => v as String),
        fileSizeBytes: $checkedConvert('fileSizeBytes', (v) => v as num?),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        downloadUrl: $checkedConvert('downloadUrl', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ReplayFileToJson(_ReplayFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'objectKey': instance.objectKey,
      'fileSizeBytes': instance.fileSizeBytes,
      'createdAt': instance.createdAt,
      'downloadUrl': instance.downloadUrl,
    };
