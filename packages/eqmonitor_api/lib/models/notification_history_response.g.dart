// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationHistoryResponse _$NotificationHistoryResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationHistoryResponse',
  json,
  ($checkedConvert) {
    final val = _NotificationHistoryResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => NotificationLogItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      nextCursor: $checkedConvert('next_cursor', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextCursor': 'next_cursor'},
);

Map<String, dynamic> _$NotificationHistoryResponseToJson(
  _NotificationHistoryResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_cursor': ?instance.nextCursor,
};
