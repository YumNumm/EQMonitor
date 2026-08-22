// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_time_sync_samples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinMonitorTimeSyncSamples _$KyoshinMonitorTimeSyncSamplesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinMonitorTimeSyncSamples', json, ($checkedConvert) {
  final val = _KyoshinMonitorTimeSyncSamples(
    roundTripTimes: $checkedConvert(
      'round_trip_times',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => Duration(microseconds: (e as num).toInt()))
              .toList() ??
          const [],
    ),
    shifts: $checkedConvert(
      'shifts',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => Duration(microseconds: (e as num).toInt()))
              .toList() ??
          const [],
    ),
  );
  return val;
}, fieldKeyMap: const {'roundTripTimes': 'round_trip_times'});

Map<String, dynamic> _$KyoshinMonitorTimeSyncSamplesToJson(
  _KyoshinMonitorTimeSyncSamples instance,
) => <String, dynamic>{
  'round_trip_times': instance.roundTripTimes
      .map((e) => e.inMicroseconds)
      .toList(),
  'shifts': instance.shifts.map((e) => e.inMicroseconds).toList(),
};
