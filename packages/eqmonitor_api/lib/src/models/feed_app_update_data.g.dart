// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_app_update_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedAppUpdateData _$FeedAppUpdateDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeedAppUpdateData', json, ($checkedConvert) {
      final val = _FeedAppUpdateData(
        type: $checkedConvert('type', (v) => v as String),
        version: $checkedConvert('version', (v) => v as String?),
        url: $checkedConvert('url', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$FeedAppUpdateDataToJson(_FeedAppUpdateData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'version': ?instance.version,
      'url': ?instance.url,
    };
