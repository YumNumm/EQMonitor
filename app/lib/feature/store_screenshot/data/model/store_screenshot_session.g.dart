// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'store_screenshot_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoreScreenshotSession _$StoreScreenshotSessionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_StoreScreenshotSession', json, ($checkedConvert) {
  final val = _StoreScreenshotSession(
    preferences: $checkedConvert(
      'preferences',
      (v) => v as Map<String, dynamic>,
    ),
    scenes: $checkedConvert(
      'scenes',
      (v) => (v as List<dynamic>)
          .map((e) => StoreScreenshotScene.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$StoreScreenshotSessionToJson(
  _StoreScreenshotSession instance,
) => <String, dynamic>{
  'preferences': instance.preferences,
  'scenes': instance.scenes,
};
