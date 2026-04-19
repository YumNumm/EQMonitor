// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinMonitorState _$KyoshinMonitorStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_KyoshinMonitorState',
      json,
      ($checkedConvert) {
        final val = _KyoshinMonitorState(
          currentRealtimeDataType: $checkedConvert(
            'current_realtime_data_type',
            (v) => $enumDecodeNullable(_$RealtimeDataTypeEnumMap, v),
          ),
          currentRealtimeLayer: $checkedConvert(
            'current_realtime_layer',
            (v) => $enumDecodeNullable(_$RealtimeLayerEnumMap, v),
          ),
          status: $checkedConvert(
            'status',
            (v) =>
                $enumDecodeNullable(_$KyoshinMonitorStatusEnumMap, v) ??
                KyoshinMonitorStatus.initializing,
          ),
          lastUpdatedAt: $checkedConvert(
            'last_updated_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          lastImageFetchTargetTime: $checkedConvert(
            'last_image_fetch_target_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          lastImageFetchDuration: $checkedConvert(
            'last_image_fetch_duration',
            (v) =>
                v == null ? null : Duration(microseconds: (v as num).toInt()),
          ),
          geoJson: $checkedConvert('geo_json', (v) => v as String?),
          analyzedPointsCount: $checkedConvert(
            'analyzed_points_count',
            (v) => (v as num?)?.toInt(),
          ),
          currentImageRaw: $checkedConvert(
            'current_image_raw',
            (v) =>
                (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentRealtimeDataType': 'current_realtime_data_type',
        'currentRealtimeLayer': 'current_realtime_layer',
        'lastUpdatedAt': 'last_updated_at',
        'lastImageFetchTargetTime': 'last_image_fetch_target_time',
        'lastImageFetchDuration': 'last_image_fetch_duration',
        'geoJson': 'geo_json',
        'analyzedPointsCount': 'analyzed_points_count',
        'currentImageRaw': 'current_image_raw',
      },
    );

Map<String, dynamic> _$KyoshinMonitorStateToJson(
  _KyoshinMonitorState instance,
) => <String, dynamic>{
  'current_realtime_data_type':
      _$RealtimeDataTypeEnumMap[instance.currentRealtimeDataType],
  'current_realtime_layer':
      _$RealtimeLayerEnumMap[instance.currentRealtimeLayer],
  'status': _$KyoshinMonitorStatusEnumMap[instance.status]!,
  'last_updated_at': instance.lastUpdatedAt?.toIso8601String(),
  'last_image_fetch_target_time': instance.lastImageFetchTargetTime
      ?.toIso8601String(),
  'last_image_fetch_duration': instance.lastImageFetchDuration?.inMicroseconds,
  'geo_json': instance.geoJson,
  'analyzed_points_count': instance.analyzedPointsCount,
  'current_image_raw': instance.currentImageRaw,
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
