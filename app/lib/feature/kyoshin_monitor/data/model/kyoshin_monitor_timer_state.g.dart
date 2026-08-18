// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinMonitorTimerState _$KyoshinMonitorTimerStateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_KyoshinMonitorTimerState',
  json,
  ($checkedConvert) {
    final val = _KyoshinMonitorTimerState(
      shift: $checkedConvert(
        'shift',
        (v) => Duration(microseconds: (v as num).toInt()),
      ),
      roundTripTime: $checkedConvert(
        'round_trip_time',
        (v) => Duration(microseconds: (v as num).toInt()),
      ),
      source: $checkedConvert(
        'source',
        (v) => $enumDecode(_$KyoshinMonitorSourceEnumMap, v),
      ),
      sampleCount: $checkedConvert('sample_count', (v) => (v as num).toInt()),
      lastSyncedAt: $checkedConvert(
        'last_synced_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'roundTripTime': 'round_trip_time',
    'sampleCount': 'sample_count',
    'lastSyncedAt': 'last_synced_at',
  },
);

Map<String, dynamic> _$KyoshinMonitorTimerStateToJson(
  _KyoshinMonitorTimerState instance,
) => <String, dynamic>{
  'shift': instance.shift.inMicroseconds,
  'round_trip_time': instance.roundTripTime.inMicroseconds,
  'source': _$KyoshinMonitorSourceEnumMap[instance.source]!,
  'sample_count': instance.sampleCount,
  'last_synced_at': instance.lastSyncedAt?.toIso8601String(),
};

const _$KyoshinMonitorSourceEnumMap = {
  KyoshinMonitorSource.kmoni: 'kmoni',
  KyoshinMonitorSource.lmoni: 'lmoni',
};
