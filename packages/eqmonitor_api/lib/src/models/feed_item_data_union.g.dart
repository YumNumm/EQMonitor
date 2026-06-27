// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_item_data_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItemDataUnionVariant1 _$FeedItemDataUnionVariant1FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FeedItemDataUnionVariant1', json, ($checkedConvert) {
  final val = FeedItemDataUnionVariant1(
    type: $checkedConvert('type', (v) => v as String),
    text: $checkedConvert('text', (v) => v as String),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$FeedItemDataUnionVariant1ToJson(
  FeedItemDataUnionVariant1 instance,
) => <String, dynamic>{
  'type': instance.type,
  'text': instance.text,
  'runtimeType': instance.$type,
};

FeedItemDataUnionVariant2 _$FeedItemDataUnionVariant2FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FeedItemDataUnionVariant2', json, ($checkedConvert) {
  final val = FeedItemDataUnionVariant2(
    type: $checkedConvert('type', (v) => v as String),
    infoType: $checkedConvert(
      'infoType',
      (v) => $enumDecode(_$InfoTypeEnumMap, v),
    ),
    text: $checkedConvert('text', (v) => v as String),
    naming: $checkedConvert(
      'naming',
      (v) => v == null ? null : Naming.fromJson(v as Map<String, dynamic>),
    ),
    comments: $checkedConvert(
      'comments',
      (v) => v == null ? null : Comments.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$FeedItemDataUnionVariant2ToJson(
  FeedItemDataUnionVariant2 instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'text': instance.text,
  'naming': ?instance.naming,
  'comments': ?instance.comments,
  'runtimeType': instance.$type,
};

const _$InfoTypeEnumMap = {
  InfoType.publication: 'PUBLICATION',
  InfoType.correction: 'CORRECTION',
  InfoType.cancellation: 'CANCELLATION',
};

FeedItemDataUnionVariant3 _$FeedItemDataUnionVariant3FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FeedItemDataUnionVariant3', json, ($checkedConvert) {
  final val = FeedItemDataUnionVariant3(
    type: $checkedConvert('type', (v) => v as String),
    infoType: $checkedConvert(
      'infoType',
      (v) => $enumDecode(_$InfoTypeEnumMap, v),
    ),
    earthquakeCounts: $checkedConvert(
      'earthquakeCounts',
      (v) => (v as List<dynamic>?)
          ?.map((e) => EarthquakeCounts.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    nextAdvisory: $checkedConvert('nextAdvisory', (v) => v as String?),
    text: $checkedConvert('text', (v) => v as String?),
    comments: $checkedConvert(
      'comments',
      (v) => v == null ? null : Comments2.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$FeedItemDataUnionVariant3ToJson(
  FeedItemDataUnionVariant3 instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'earthquakeCounts': ?instance.earthquakeCounts,
  'nextAdvisory': ?instance.nextAdvisory,
  'text': ?instance.text,
  'comments': ?instance.comments,
  'runtimeType': instance.$type,
};

FeedItemDataUnionVariant4 _$FeedItemDataUnionVariant4FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FeedItemDataUnionVariant4', json, ($checkedConvert) {
  final val = FeedItemDataUnionVariant4(
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
      (v) =>
          v == null ? null : EarthquakeInfo.fromJson(v as Map<String, dynamic>),
    ),
    nextAdvisory: $checkedConvert('nextAdvisory', (v) => v as String?),
    text: $checkedConvert('text', (v) => v as String?),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$FeedItemDataUnionVariant4ToJson(
  FeedItemDataUnionVariant4 instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'telegramType': instance.telegramType,
  'earthquakeInfo': ?instance.earthquakeInfo,
  'nextAdvisory': ?instance.nextAdvisory,
  'text': ?instance.text,
  'runtimeType': instance.$type,
};

const _$TelegramTypeEnumMap = {
  TelegramType.undefined0: '南海トラフ地震臨時情報',
  TelegramType.undefined1: '南海トラフ地震関連解説情報',
  TelegramType.undefined2: '北海道・三陸沖後発地震注意情報',
};

FeedItemDataUnionVariant5 _$FeedItemDataUnionVariant5FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FeedItemDataUnionVariant5', json, ($checkedConvert) {
  final val = FeedItemDataUnionVariant5(
    type: $checkedConvert('type', (v) => v as String),
    version: $checkedConvert('version', (v) => v as String?),
    url: $checkedConvert('url', (v) => v as String?),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$FeedItemDataUnionVariant5ToJson(
  FeedItemDataUnionVariant5 instance,
) => <String, dynamic>{
  'type': instance.type,
  'version': ?instance.version,
  'url': ?instance.url,
  'runtimeType': instance.$type,
};

FeedItemDataUnionVariant6 _$FeedItemDataUnionVariant6FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FeedItemDataUnionVariant6', json, ($checkedConvert) {
  final val = FeedItemDataUnionVariant6(
    type: $checkedConvert('type', (v) => v as String),
    url: $checkedConvert('url', (v) => v as String?),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$FeedItemDataUnionVariant6ToJson(
  FeedItemDataUnionVariant6 instance,
) => <String, dynamic>{
  'type': instance.type,
  'url': ?instance.url,
  'runtimeType': instance.$type,
};

FeedItemDataUnionVariant7 _$FeedItemDataUnionVariant7FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FeedItemDataUnionVariant7', json, ($checkedConvert) {
  final val = FeedItemDataUnionVariant7(
    type: $checkedConvert('type', (v) => v as String),
    url: $checkedConvert('url', (v) => v as String?),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$FeedItemDataUnionVariant7ToJson(
  FeedItemDataUnionVariant7 instance,
) => <String, dynamic>{
  'type': instance.type,
  'url': ?instance.url,
  'runtimeType': instance.$type,
};
