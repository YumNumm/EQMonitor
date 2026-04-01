// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_replay_file_detail_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminReplayFileDetailResponseItem _$AdminReplayFileDetailResponseItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_AdminReplayFileDetailResponseItem',
  json,
  ($checkedConvert) {
    final val = _AdminReplayFileDetailResponseItem(
      id: $checkedConvert('id', (v) => v as String),
      startTime: $checkedConvert('start_time', (v) => v as String),
      endTime: $checkedConvert('end_time', (v) => v as String),
      objectKey: $checkedConvert('object_key', (v) => v as String),
      fileSizeBytes: $checkedConvert('file_size_bytes', (v) => v as num?),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      downloadUrl: $checkedConvert('download_url', (v) => v as String?),
      triggers: $checkedConvert(
        'triggers',
        (v) => (v as List<dynamic>)
            .map((e) => Triggers.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
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

Map<String, dynamic> _$AdminReplayFileDetailResponseItemToJson(
  _AdminReplayFileDetailResponseItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'object_key': instance.objectKey,
  'file_size_bytes': instance.fileSizeBytes,
  'created_at': instance.createdAt,
  'download_url': instance.downloadUrl,
  'triggers': instance.triggers,
};
