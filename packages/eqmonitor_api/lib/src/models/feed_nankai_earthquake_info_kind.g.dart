// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_nankai_earthquake_info_kind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedNankaiEarthquakeInfoKind _$FeedNankaiEarthquakeInfoKindFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedNankaiEarthquakeInfoKind', json, ($checkedConvert) {
  final val = _FeedNankaiEarthquakeInfoKind(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$FeedNankaiEarthquakeInfoKindToJson(
  _FeedNankaiEarthquakeInfoKind instance,
) => <String, dynamic>{'code': instance.code, 'name': instance.name};
