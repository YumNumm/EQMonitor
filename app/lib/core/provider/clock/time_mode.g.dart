// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'time_mode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeTimeMode _$RealtimeTimeModeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RealtimeTimeMode', json, ($checkedConvert) {
      final val = RealtimeTimeMode(
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$RealtimeTimeModeToJson(RealtimeTimeMode instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

TimeShiftTimeMode _$TimeShiftTimeModeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TimeShiftTimeMode', json, ($checkedConvert) {
      final val = TimeShiftTimeMode(
        offset: $checkedConvert(
          'offset',
          (v) => Duration(microseconds: (v as num).toInt()),
        ),
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$TimeShiftTimeModeToJson(TimeShiftTimeMode instance) =>
    <String, dynamic>{
      'offset': instance.offset.inMicroseconds,
      'runtimeType': instance.$type,
    };

ReplayTimeMode _$ReplayTimeModeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReplayTimeMode', json, ($checkedConvert) {
  final val = ReplayTimeMode(
    currentTime: $checkedConvert(
      'current_time',
      (v) => DateTime.parse(v as String),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'currentTime': 'current_time', r'$type': 'runtimeType'});

Map<String, dynamic> _$ReplayTimeModeToJson(ReplayTimeMode instance) =>
    <String, dynamic>{
      'current_time': instance.currentTime.toIso8601String(),
      'runtimeType': instance.$type,
    };
