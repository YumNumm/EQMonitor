// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_replay_file_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminReplayFileListResponse _$AdminReplayFileListResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_AdminReplayFileListResponse',
  json,
  ($checkedConvert) {
    final val = _AdminReplayFileListResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => Items2.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$AdminReplayFileListResponseToJson(
  _AdminReplayFileListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': ?instance.nextToken,
  'next_pooling': ?instance.nextPooling,
};
