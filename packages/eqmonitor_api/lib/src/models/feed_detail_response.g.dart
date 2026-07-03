// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedDetailResponse _$FeedDetailResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_FeedDetailResponse',
      json,
      ($checkedConvert) {
        final val = _FeedDetailResponse(
          id: $checkedConvert('id', (v) => v as String),
          feedType: $checkedConvert(
            'feed_type',
            (v) => $enumDecode(_$FeedTypeEnumMap, v),
          ),
          priority: $checkedConvert(
            'priority',
            (v) => $enumDecode(_$FeedPriorityEnumMap, v),
          ),
          isImportant: $checkedConvert('is_important', (v) => v as bool),
          publishedAt: $checkedConvert('published_at', (v) => v as String),
          expiresAt: $checkedConvert('expires_at', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String?),
          summary: $checkedConvert('summary', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as String?),
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

Map<String, dynamic> _$FeedDetailResponseToJson(_FeedDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feed_type': instance.feedType,
      'priority': instance.priority,
      'is_important': instance.isImportant,
      'published_at': instance.publishedAt,
      'expires_at': instance.expiresAt,
      'title': instance.title,
      'summary': instance.summary,
      'body': instance.body,
      'data': instance.data,
    };

const _$FeedTypeEnumMap = {
  FeedType.earthquakeNotice: 'EARTHQUAKE_NOTICE',
  FeedType.earthquakeExplanation: 'EARTHQUAKE_EXPLANATION',
  FeedType.earthquakeCounts: 'EARTHQUAKE_COUNTS',
  FeedType.earthquakeNankai: 'EARTHQUAKE_NANKAI',
  FeedType.appUpdate: 'APP_UPDATE',
  FeedType.incident: 'INCIDENT',
  FeedType.developerMessage: 'DEVELOPER_MESSAGE',
};

const _$FeedPriorityEnumMap = {
  FeedPriority.critical: 'CRITICAL',
  FeedPriority.high: 'HIGH',
  FeedPriority.normal: 'NORMAL',
  FeedPriority.low: 'LOW',
};
