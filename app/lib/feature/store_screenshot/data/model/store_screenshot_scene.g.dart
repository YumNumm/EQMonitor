// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'store_screenshot_scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreScreenshotReplayScene _$StoreScreenshotReplaySceneFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'StoreScreenshotReplayScene',
  json,
  ($checkedConvert) {
    final val = StoreScreenshotReplayScene(
      name: $checkedConvert('name', (v) => v as String),
      settleMilliseconds: $checkedConvert(
        'settle_milliseconds',
        (v) => (v as num).toInt(),
      ),
      fixture: $checkedConvert('fixture', (v) => v as String),
      time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
      $type: $checkedConvert('kind', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'settleMilliseconds': 'settle_milliseconds',
    r'$type': 'kind',
  },
);

Map<String, dynamic> _$StoreScreenshotReplaySceneToJson(
  StoreScreenshotReplayScene instance,
) => <String, dynamic>{
  'name': instance.name,
  'settle_milliseconds': instance.settleMilliseconds,
  'fixture': instance.fixture,
  'time': instance.time.toIso8601String(),
  'kind': instance.$type,
};

StoreScreenshotRouteScene _$StoreScreenshotRouteSceneFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'StoreScreenshotRouteScene',
  json,
  ($checkedConvert) {
    final val = StoreScreenshotRouteScene(
      name: $checkedConvert('name', (v) => v as String),
      settleMilliseconds: $checkedConvert(
        'settle_milliseconds',
        (v) => (v as num).toInt(),
      ),
      location: $checkedConvert('location', (v) => v as String),
      $type: $checkedConvert('kind', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'settleMilliseconds': 'settle_milliseconds',
    r'$type': 'kind',
  },
);

Map<String, dynamic> _$StoreScreenshotRouteSceneToJson(
  StoreScreenshotRouteScene instance,
) => <String, dynamic>{
  'name': instance.name,
  'settle_milliseconds': instance.settleMilliseconds,
  'location': instance.location,
  'kind': instance.$type,
};

StoreScreenshotLiveActivityScene _$StoreScreenshotLiveActivitySceneFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'StoreScreenshotLiveActivityScene',
  json,
  ($checkedConvert) {
    final val = StoreScreenshotLiveActivityScene(
      name: $checkedConvert('name', (v) => v as String),
      settleMilliseconds: $checkedConvert(
        'settle_milliseconds',
        (v) => (v as num).toInt(),
      ),
      preset: $checkedConvert(
        'preset',
        (v) => $enumDecode(_$DebugEewPresetEnumMap, v),
      ),
      $type: $checkedConvert('kind', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'settleMilliseconds': 'settle_milliseconds',
    r'$type': 'kind',
  },
);

Map<String, dynamic> _$StoreScreenshotLiveActivitySceneToJson(
  StoreScreenshotLiveActivityScene instance,
) => <String, dynamic>{
  'name': instance.name,
  'settle_milliseconds': instance.settleMilliseconds,
  'preset': _$DebugEewPresetEnumMap[instance.preset]!,
  'kind': instance.$type,
};

const _$DebugEewPresetEnumMap = {
  DebugEewPreset.warning: 'warning',
  DebugEewPreset.finalReport: 'finalReport',
  DebugEewPreset.forecast: 'forecast',
  DebugEewPreset.plum: 'plum',
  DebugEewPreset.levelMethod: 'levelMethod',
  DebugEewPreset.onePoint: 'onePoint',
  DebugEewPreset.canceled: 'canceled',
};
