// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_nankai_earthquake_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedNankaiEarthquakeInfo _$FeedNankaiEarthquakeInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedNankaiEarthquakeInfo', json, ($checkedConvert) {
  final val = _FeedNankaiEarthquakeInfo(
    text: $checkedConvert('text', (v) => v as String),
    kind: $checkedConvert(
      'kind',
      (v) => v == null
          ? null
          : FeedNankaiEarthquakeInfoKind.fromJson(v as Map<String, dynamic>),
    ),
    appendix: $checkedConvert('appendix', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$FeedNankaiEarthquakeInfoToJson(
  _FeedNankaiEarthquakeInfo instance,
) => <String, dynamic>{
  'text': instance.text,
  'kind': ?instance.kind,
  'appendix': ?instance.appendix,
};
