// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_replay_file_detail_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminReplayFileDetailResponseItem _$AdminReplayFileDetailResponseItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AdminReplayFileDetailResponseItem', json, (
  $checkedConvert,
) {
  final val = _AdminReplayFileDetailResponseItem(
    id: $checkedConvert('id', (v) => v as String),
    startTime: $checkedConvert('startTime', (v) => v as String),
    endTime: $checkedConvert('endTime', (v) => v as String),
    objectKey: $checkedConvert('objectKey', (v) => v as String),
    fileSizeBytes: $checkedConvert('fileSizeBytes', (v) => v as num?),
    createdAt: $checkedConvert('createdAt', (v) => v as String),
    downloadUrl: $checkedConvert('downloadUrl', (v) => v as String?),
    triggers: $checkedConvert(
      'triggers',
      (v) => (v as List<dynamic>)
          .map((e) => Triggers.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AdminReplayFileDetailResponseItemToJson(
  _AdminReplayFileDetailResponseItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'objectKey': instance.objectKey,
  'fileSizeBytes': instance.fileSizeBytes,
  'createdAt': instance.createdAt,
  'downloadUrl': instance.downloadUrl,
  'triggers': instance.triggers,
};
