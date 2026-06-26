// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_item_data_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItemDataUnionFeedEarthquakeNoticeData
_$FeedItemDataUnionFeedEarthquakeNoticeDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'FeedItemDataUnionFeedEarthquakeNoticeData',
  json,
  ($checkedConvert) {
    final val = FeedItemDataUnionFeedEarthquakeNoticeData(
      type: $checkedConvert('type', (v) => v as String),
      text: $checkedConvert('text', (v) => v as String),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$FeedItemDataUnionFeedEarthquakeNoticeDataToJson(
  FeedItemDataUnionFeedEarthquakeNoticeData instance,
) => <String, dynamic>{
  'type': instance.type,
  'text': instance.text,
  'runtimeType': instance.$type,
};

FeedItemDataUnionFeedEarthquakeExplanationData
_$FeedItemDataUnionFeedEarthquakeExplanationDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'FeedItemDataUnionFeedEarthquakeExplanationData',
  json,
  ($checkedConvert) {
    final val = FeedItemDataUnionFeedEarthquakeExplanationData(
      type: $checkedConvert('type', (v) => v as String),
      infoType: $checkedConvert(
        'infoType',
        (v) => $enumDecode(_$InfoTypeEnumMap, v),
      ),
      text: $checkedConvert('text', (v) => v as String),
      naming: $checkedConvert(
        'naming',
        (v) =>
            v == null ? null : FeedNaming.fromJson(v as Map<String, dynamic>),
      ),
      comments: $checkedConvert(
        'comments',
        (v) =>
            v == null ? null : FeedComments.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$FeedItemDataUnionFeedEarthquakeExplanationDataToJson(
  FeedItemDataUnionFeedEarthquakeExplanationData instance,
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

FeedItemDataUnionFeedEarthquakeCountsData
_$FeedItemDataUnionFeedEarthquakeCountsDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'FeedItemDataUnionFeedEarthquakeCountsData',
  json,
  ($checkedConvert) {
    final val = FeedItemDataUnionFeedEarthquakeCountsData(
      type: $checkedConvert('type', (v) => v as String),
      infoType: $checkedConvert(
        'infoType',
        (v) => $enumDecode(_$InfoTypeEnumMap, v),
      ),
      earthquakeCounts: $checkedConvert(
        'earthquakeCounts',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => FeedEarthquakeCount.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      nextAdvisory: $checkedConvert('nextAdvisory', (v) => v as String?),
      text: $checkedConvert('text', (v) => v as String?),
      comments: $checkedConvert(
        'comments',
        (v) =>
            v == null ? null : FeedComments.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$FeedItemDataUnionFeedEarthquakeCountsDataToJson(
  FeedItemDataUnionFeedEarthquakeCountsData instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'earthquakeCounts': ?instance.earthquakeCounts,
  'nextAdvisory': ?instance.nextAdvisory,
  'text': ?instance.text,
  'comments': ?instance.comments,
  'runtimeType': instance.$type,
};

FeedItemDataUnionFeedEarthquakeNankaiData
_$FeedItemDataUnionFeedEarthquakeNankaiDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'FeedItemDataUnionFeedEarthquakeNankaiData',
  json,
  ($checkedConvert) {
    final val = FeedItemDataUnionFeedEarthquakeNankaiData(
      type: $checkedConvert('type', (v) => v as String),
      infoType: $checkedConvert(
        'infoType',
        (v) => $enumDecode(_$InfoTypeEnumMap, v),
      ),
      telegramType: $checkedConvert(
        'telegramType',
        (v) => $enumDecode(_$NankaiTelegramTypeEnumMap, v),
      ),
      earthquakeInfo: $checkedConvert(
        'earthquakeInfo',
        (v) => v == null
            ? null
            : FeedNankaiEarthquakeInfo.fromJson(v as Map<String, dynamic>),
      ),
      nextAdvisory: $checkedConvert('nextAdvisory', (v) => v as String?),
      text: $checkedConvert('text', (v) => v as String?),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$FeedItemDataUnionFeedEarthquakeNankaiDataToJson(
  FeedItemDataUnionFeedEarthquakeNankaiData instance,
) => <String, dynamic>{
  'type': instance.type,
  'infoType': instance.infoType,
  'telegramType': instance.telegramType,
  'earthquakeInfo': ?instance.earthquakeInfo,
  'nextAdvisory': ?instance.nextAdvisory,
  'text': ?instance.text,
  'runtimeType': instance.$type,
};

const _$NankaiTelegramTypeEnumMap = {
  NankaiTelegramType.undefined0: '南海トラフ地震臨時情報',
  NankaiTelegramType.undefined1: '南海トラフ地震関連解説情報',
  NankaiTelegramType.undefined2: '北海道・三陸沖後発地震注意情報',
};

FeedItemDataUnionFeedAppUpdateData _$FeedItemDataUnionFeedAppUpdateDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'FeedItemDataUnionFeedAppUpdateData',
  json,
  ($checkedConvert) {
    final val = FeedItemDataUnionFeedAppUpdateData(
      type: $checkedConvert('type', (v) => v as String),
      version: $checkedConvert('version', (v) => v as String?),
      url: $checkedConvert('url', (v) => v as String?),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$FeedItemDataUnionFeedAppUpdateDataToJson(
  FeedItemDataUnionFeedAppUpdateData instance,
) => <String, dynamic>{
  'type': instance.type,
  'version': ?instance.version,
  'url': ?instance.url,
  'runtimeType': instance.$type,
};

FeedItemDataUnionFeedIncidentData _$FeedItemDataUnionFeedIncidentDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'FeedItemDataUnionFeedIncidentData',
  json,
  ($checkedConvert) {
    final val = FeedItemDataUnionFeedIncidentData(
      type: $checkedConvert('type', (v) => v as String),
      url: $checkedConvert('url', (v) => v as String?),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$FeedItemDataUnionFeedIncidentDataToJson(
  FeedItemDataUnionFeedIncidentData instance,
) => <String, dynamic>{
  'type': instance.type,
  'url': ?instance.url,
  'runtimeType': instance.$type,
};

FeedItemDataUnionFeedDeveloperMessageData
_$FeedItemDataUnionFeedDeveloperMessageDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'FeedItemDataUnionFeedDeveloperMessageData',
  json,
  ($checkedConvert) {
    final val = FeedItemDataUnionFeedDeveloperMessageData(
      type: $checkedConvert('type', (v) => v as String),
      url: $checkedConvert('url', (v) => v as String?),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$FeedItemDataUnionFeedDeveloperMessageDataToJson(
  FeedItemDataUnionFeedDeveloperMessageData instance,
) => <String, dynamic>{
  'type': instance.type,
  'url': ?instance.url,
  'runtimeType': instance.$type,
};
