// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeArchiveFrame _$EarthquakeArchiveFrameFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeArchiveFrame', json, ($checkedConvert) {
  final val = _EarthquakeArchiveFrame(
    frameType: $checkedConvert('frameType', (v) => v as num),
    frameTypeName: $checkedConvert('frameTypeName', (v) => v as String),
    frameCount: $checkedConvert('frameCount', (v) => v as num),
    totalBytes: $checkedConvert('totalBytes', (v) => v as num),
    firstTime: $checkedConvert('firstTime', (v) => v as String),
    lastTime: $checkedConvert('lastTime', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeArchiveFrameToJson(
  _EarthquakeArchiveFrame instance,
) => <String, dynamic>{
  'frameType': instance.frameType,
  'frameTypeName': instance.frameTypeName,
  'frameCount': instance.frameCount,
  'totalBytes': instance.totalBytes,
  'firstTime': instance.firstTime,
  'lastTime': instance.lastTime,
};
