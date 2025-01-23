// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'kyoshin_monitor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KyoshinMonitorStateImpl _$$KyoshinMonitorStateImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$KyoshinMonitorStateImpl',
      json,
      ($checkedConvert) {
        final val = _$KyoshinMonitorStateImpl(
          currentRealtimeDataType: $checkedConvert('currentRealtimeDataType',
              (v) => $enumDecodeNullable(_$RealtimeDataTypeEnumMap, v)),
          currentRealtimeLayer: $checkedConvert('currentRealtimeLayer',
              (v) => $enumDecodeNullable(_$RealtimeLayerEnumMap, v)),
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$KyoshinMonitorStatusEnumMap, v) ??
                  KyoshinMonitorStatus.initializing),
          lastUpdatedAt: $checkedConvert('lastUpdatedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
          lastImageFetchTargetTime: $checkedConvert('lastImageFetchTargetTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          lastImageFetchDuration: $checkedConvert(
              'lastImageFetchDuration',
              (v) => v == null
                  ? null
                  : Duration(microseconds: (v as num).toInt())),
          analyzedPoints: $checkedConvert(
              'analyzedPoints',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => KyoshinMonitorObservationAnalyzedPoint.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KyoshinMonitorStateImplToJson(
        _$KyoshinMonitorStateImpl instance) =>
    <String, dynamic>{
      'currentRealtimeDataType':
          _$RealtimeDataTypeEnumMap[instance.currentRealtimeDataType],
      'currentRealtimeLayer':
          _$RealtimeLayerEnumMap[instance.currentRealtimeLayer],
      'status': _$KyoshinMonitorStatusEnumMap[instance.status]!,
      'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
      'lastImageFetchTargetTime':
          instance.lastImageFetchTargetTime?.toIso8601String(),
      'lastImageFetchDuration': instance.lastImageFetchDuration?.inMicroseconds,
      'analyzedPoints': instance.analyzedPoints,
    };

const _$RealtimeDataTypeEnumMap = {
  RealtimeDataType.shindo: 'jma',
  RealtimeDataType.pga: 'acmap',
  RealtimeDataType.pgv: 'vcmap',
  RealtimeDataType.pgd: 'dcmap',
  RealtimeDataType.response0125Hz: 'rsp0125',
  RealtimeDataType.response025Hz: 'rsp0250',
  RealtimeDataType.response05Hz: 'rsp0500',
  RealtimeDataType.response1Hz: 'rsp1000',
  RealtimeDataType.response2Hz: 'rsp2000',
  RealtimeDataType.response4Hz: 'rsp4000',
  RealtimeDataType.abrspmx: 'abrspmx',
  RealtimeDataType.abrsp1s: 'abrsp1s',
  RealtimeDataType.abrsp2s: 'abrsp2s',
  RealtimeDataType.abrsp3s: 'abrsp3s',
  RealtimeDataType.abrsp4s: 'abrsp4s',
  RealtimeDataType.abrsp5s: 'abrsp5s',
  RealtimeDataType.abrsp6s: 'abrsp6s',
  RealtimeDataType.abrsp7s: 'abrsp7s',
};

const _$RealtimeLayerEnumMap = {
  RealtimeLayer.surface: 'surface',
  RealtimeLayer.underground: 'underground',
};

const _$KyoshinMonitorStatusEnumMap = {
  KyoshinMonitorStatus.realtime: 'realtime',
  KyoshinMonitorStatus.delayed: 'delayed',
  KyoshinMonitorStatus.playback: 'playback',
  KyoshinMonitorStatus.stopped: 'stopped',
  KyoshinMonitorStatus.initializing: 'initializing',
};
