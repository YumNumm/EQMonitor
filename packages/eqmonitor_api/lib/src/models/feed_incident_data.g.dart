// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_incident_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedIncidentData _$FeedIncidentDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeedIncidentData', json, ($checkedConvert) {
      final val = _FeedIncidentData(
        type: $checkedConvert('type', (v) => v as String),
        url: $checkedConvert('url', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$FeedIncidentDataToJson(_FeedIncidentData instance) =>
    <String, dynamic>{'type': instance.type, 'url': ?instance.url};
