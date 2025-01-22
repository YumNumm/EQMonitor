// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'kyoshin_monitor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KyoshinMonitorTimerStateImpl _$$KyoshinMonitorTimerStateImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$KyoshinMonitorTimerStateImpl',
      json,
      ($checkedConvert) {
        final val = _$KyoshinMonitorTimerStateImpl(
          delayFromDevice: $checkedConvert('delayFromDevice',
              (v) => Duration(microseconds: (v as num).toInt())),
          lastSyncedAt: $checkedConvert('lastSyncedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KyoshinMonitorTimerStateImplToJson(
        _$KyoshinMonitorTimerStateImpl instance) =>
    <String, dynamic>{
      'delayFromDevice': instance.delayFromDevice.inMicroseconds,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
    };
