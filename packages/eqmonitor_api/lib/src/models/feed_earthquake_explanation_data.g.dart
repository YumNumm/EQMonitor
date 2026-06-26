// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_explanation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeExplanationData _$FeedEarthquakeExplanationDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedEarthquakeExplanationData', json, ($checkedConvert) {
  final val = _FeedEarthquakeExplanationData(
    type: $checkedConvert('type', (v) => v as String),
    infoType: $checkedConvert(
      'infoType',
      (v) => $enumDecode(_$InfoTypeEnumMap, v),
    ),
    text: $checkedConvert('text', (v) => v as String),
    naming: $checkedConvert(
      'naming',
      (v) => v == null ? null : FeedNaming.fromJson(v as Map<String, dynamic>),
    ),
    comments: $checkedConvert(
      'comments',
      (v) =>
          v == null ? null : FeedComments.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$FeedEarthquakeExplanationDataToJson(
  _FeedEarthquakeExplanationData instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'text': instance.text,
  'naming': ?instance.naming,
  'comments': ?instance.comments,
};

const _$InfoTypeEnumMap = {
  InfoType.publication: 'PUBLICATION',
  InfoType.correction: 'CORRECTION',
  InfoType.cancellation: 'CANCELLATION',
};
