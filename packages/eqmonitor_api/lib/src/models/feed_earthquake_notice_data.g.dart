// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_notice_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeNoticeData _$FeedEarthquakeNoticeDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedEarthquakeNoticeData', json, ($checkedConvert) {
  final val = _FeedEarthquakeNoticeData(
    type: $checkedConvert('type', (v) => v as String),
    text: $checkedConvert('text', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$FeedEarthquakeNoticeDataToJson(
  _FeedEarthquakeNoticeData instance,
) => <String, dynamic>{'type': instance.type, 'text': instance.text};
