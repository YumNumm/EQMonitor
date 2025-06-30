// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

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
      delayFromDevice: $checkedConvert(
        'delay_from_device',
        (v) => Duration(microseconds: (v as num).toInt()),
      ),
      lastSyncedAt: $checkedConvert(
        'last_synced_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'delayFromDevice': 'delay_from_device',
    'lastSyncedAt': 'last_synced_at',
  },
);

Map<String, dynamic> _$KyoshinMonitorTimerStateToJson(
  _KyoshinMonitorTimerState instance,
) => <String, dynamic>{
  'delay_from_device': instance.delayFromDevice.inMicroseconds,
  'last_synced_at': instance.lastSyncedAt?.toIso8601String(),
};
