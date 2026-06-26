// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_nankai_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeNankaiData _$FeedEarthquakeNankaiDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedEarthquakeNankaiData', json, ($checkedConvert) {
  final val = _FeedEarthquakeNankaiData(
    type: $checkedConvert('type', (v) => v as String),
    infoType: $checkedConvert(
      'infoType',
      (v) => $enumDecode(_$InfoTypeEnumMap, v),
    ),
    telegramType: $checkedConvert(
      'telegramType',
      (v) => $enumDecode(_$TelegramTypeEnumMap, v),
    ),
    earthquakeInfo: $checkedConvert(
      'earthquakeInfo',
      (v) => v == null
          ? null
          : FeedNankaiEarthquakeInfo.fromJson(v as Map<String, dynamic>),
    ),
    nextAdvisory: $checkedConvert('nextAdvisory', (v) => v as String?),
    text: $checkedConvert('text', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$FeedEarthquakeNankaiDataToJson(
  _FeedEarthquakeNankaiData instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'telegramType': instance.telegramType,
  'earthquakeInfo': ?instance.earthquakeInfo,
  'nextAdvisory': ?instance.nextAdvisory,
  'text': ?instance.text,
};

const _$InfoTypeEnumMap = {
  InfoType.publication: 'PUBLICATION',
  InfoType.correction: 'CORRECTION',
  InfoType.cancellation: 'CANCELLATION',
};

const _$TelegramTypeEnumMap = {
  TelegramType.undefined0: '南海トラフ地震臨時情報',
  TelegramType.undefined1: '南海トラフ地震関連解説情報',
  TelegramType.undefined2: '北海道・三陸沖後発地震注意情報',
};
