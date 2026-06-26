// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_counts_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeCountsData _$FeedEarthquakeCountsDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedEarthquakeCountsData', json, ($checkedConvert) {
  final val = _FeedEarthquakeCountsData(
    type: $checkedConvert('type', (v) => v as String),
    infoType: $checkedConvert(
      'infoType',
      (v) => $enumDecode(_$InfoTypeEnumMap, v),
    ),
    earthquakeCounts: $checkedConvert(
      'earthquakeCounts',
      (v) => (v as List<dynamic>?)
          ?.map((e) => FeedEarthquakeCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    nextAdvisory: $checkedConvert('nextAdvisory', (v) => v as String?),
    text: $checkedConvert('text', (v) => v as String?),
    comments: $checkedConvert(
      'comments',
      (v) =>
          v == null ? null : FeedComments.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$FeedEarthquakeCountsDataToJson(
  _FeedEarthquakeCountsData instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'earthquakeCounts': ?instance.earthquakeCounts,
  'nextAdvisory': ?instance.nextAdvisory,
  'text': ?instance.text,
  'comments': ?instance.comments,
};

const _$InfoTypeEnumMap = {
  InfoType.publication: 'PUBLICATION',
  InfoType.correction: 'CORRECTION',
  InfoType.cancellation: 'CANCELLATION',
};
