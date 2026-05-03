// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedItem _$FeedItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_FeedItem',
  json,
  ($checkedConvert) {
    final val = _FeedItem(
      id: $checkedConvert('id', (v) => v as String),
      feedType: $checkedConvert('feed_type', (v) => v),
      priority: $checkedConvert('priority', (v) => v),
      isImportant: $checkedConvert('is_important', (v) => v as bool),
      publishedAt: $checkedConvert('published_at', (v) => v as String),
      expiresAt: $checkedConvert('expires_at', (v) => v as String?),
      title: $checkedConvert('title', (v) => v as String?),
      summary: $checkedConvert('summary', (v) => v as String?),
      data: $checkedConvert(
        'data',
        (v) => FeedItemDataUnion.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'feedType': 'feed_type',
    'isImportant': 'is_important',
    'publishedAt': 'published_at',
    'expiresAt': 'expires_at',
  },
);

Map<String, dynamic> _$FeedItemToJson(_FeedItem instance) => <String, dynamic>{
  'id': instance.id,
  'feed_type': instance.feedType,
  'priority': instance.priority,
  'is_important': instance.isImportant,
  'published_at': instance.publishedAt,
  'expires_at': instance.expiresAt,
  'title': instance.title,
  'summary': instance.summary,
  'data': instance.data,
};
