// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedListResponse _$FeedListResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeedListResponse', json, ($checkedConvert) {
      final val = _FeedListResponse(
        feeds: $checkedConvert(
          'feeds',
          (v) => (v as List<dynamic>)
              .map((e) => FeedItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('next_cursor', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'nextCursor': 'next_cursor'});

Map<String, dynamic> _$FeedListResponseToJson(_FeedListResponse instance) =>
    <String, dynamic>{
      'feeds': instance.feeds,
      'next_cursor': instance.nextCursor,
    };
