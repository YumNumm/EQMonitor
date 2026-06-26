// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_developer_message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedDeveloperMessageData _$FeedDeveloperMessageDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedDeveloperMessageData', json, ($checkedConvert) {
  final val = _FeedDeveloperMessageData(
    type: $checkedConvert('type', (v) => v as String),
    url: $checkedConvert('url', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$FeedDeveloperMessageDataToJson(
  _FeedDeveloperMessageData instance,
) => <String, dynamic>{'type': instance.type, 'url': ?instance.url};
