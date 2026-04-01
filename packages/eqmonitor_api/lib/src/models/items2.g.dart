// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'items2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Items2 _$Items2FromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Items2',
  json,
  ($checkedConvert) {
    final val = _Items2(
      id: $checkedConvert('id', (v) => v as String),
      startTime: $checkedConvert('start_time', (v) => v as String),
      endTime: $checkedConvert('end_time', (v) => v as String),
      objectKey: $checkedConvert('object_key', (v) => v as String),
      fileSizeBytes: $checkedConvert('file_size_bytes', (v) => v as num?),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      downloadUrl: $checkedConvert('download_url', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'startTime': 'start_time',
    'endTime': 'end_time',
    'objectKey': 'object_key',
    'fileSizeBytes': 'file_size_bytes',
    'createdAt': 'created_at',
    'downloadUrl': 'download_url',
  },
);

Map<String, dynamic> _$Items2ToJson(_Items2 instance) => <String, dynamic>{
  'id': instance.id,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'object_key': instance.objectKey,
  'file_size_bytes': instance.fileSizeBytes,
  'created_at': instance.createdAt,
  'download_url': instance.downloadUrl,
};
