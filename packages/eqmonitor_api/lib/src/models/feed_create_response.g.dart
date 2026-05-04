// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedCreateResponse _$FeedCreateResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeedCreateResponse', json, ($checkedConvert) {
      final val = _FeedCreateResponse(
        id: $checkedConvert('id', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FeedCreateResponseToJson(_FeedCreateResponse instance) =>
    <String, dynamic>{'id': instance.id};
