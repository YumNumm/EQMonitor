// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'kyoshin_monitor_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KyoshinMonitorSettingsModelImpl _$$KyoshinMonitorSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$KyoshinMonitorSettingsModelImpl',
      json,
      ($checkedConvert) {
        final val = _$KyoshinMonitorSettingsModelImpl(
          minRealtimeShindo: $checkedConvert(
              'min_realtime_shindo', (v) => (v as num?)?.toDouble() ?? null),
          showScale: $checkedConvert('show_scale', (v) => v as bool? ?? true),
          useKmoni: $checkedConvert('use_kmoni', (v) => v as bool? ?? true),
          kmoniMarkerType: $checkedConvert(
              'kmoni_marker_type',
              (v) =>
                  $enumDecodeNullable(_$KyoshinMonitorMarkerTypeEnumMap, v) ??
                  KyoshinMonitorMarkerType.onlyEew),
          realtimeDataType: $checkedConvert(
              'realtime_data_type',
              (v) =>
                  $enumDecodeNullable(_$RealtimeDataTypeEnumMap, v) ??
                  RealtimeDataType.shindo),
          realtimeLayer: $checkedConvert(
              'realtime_layer',
              (v) =>
                  $enumDecodeNullable(_$RealtimeLayerEnumMap, v) ??
                  RealtimeLayer.surface),
          api: $checkedConvert(
              'api',
              (v) => v == null
                  ? const KyoshinMonitorSettingsApiModel()
                  : KyoshinMonitorSettingsApiModel.fromJson(
                      v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'minRealtimeShindo': 'min_realtime_shindo',
        'showScale': 'show_scale',
        'useKmoni': 'use_kmoni',
        'kmoniMarkerType': 'kmoni_marker_type',
        'realtimeDataType': 'realtime_data_type',
        'realtimeLayer': 'realtime_layer'
      },
    );

Map<String, dynamic> _$$KyoshinMonitorSettingsModelImplToJson(
        _$KyoshinMonitorSettingsModelImpl instance) =>
    <String, dynamic>{
      'min_realtime_shindo': instance.minRealtimeShindo,
      'show_scale': instance.showScale,
      'use_kmoni': instance.useKmoni,
      'kmoni_marker_type':
          _$KyoshinMonitorMarkerTypeEnumMap[instance.kmoniMarkerType]!,
      'realtime_data_type':
          _$RealtimeDataTypeEnumMap[instance.realtimeDataType]!,
      'realtime_layer': _$RealtimeLayerEnumMap[instance.realtimeLayer]!,
      'api': instance.api,
    };

const _$KyoshinMonitorMarkerTypeEnumMap = {
  KyoshinMonitorMarkerType.always: 'always',
  KyoshinMonitorMarkerType.onlyEew: 'onlyEew',
  KyoshinMonitorMarkerType.never: 'never',
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

_$KyoshinMonitorSettingsApiModelImpl
    _$$KyoshinMonitorSettingsApiModelImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$KyoshinMonitorSettingsApiModelImpl',
          json,
          ($checkedConvert) {
            final val = _$KyoshinMonitorSettingsApiModelImpl(
              endpoint: $checkedConvert(
                  'endpoint',
                  (v) =>
                      $enumDecodeNullable(_$KyoshinMonitorEndpointEnumMap, v,
                          unknownValue: KyoshinMonitorEndpoint.kmoni) ??
                      KyoshinMonitorEndpoint.kmoni),
              imageFetchInterval: $checkedConvert(
                  'image_fetch_interval',
                  (v) => v == null
                      ? const Duration(seconds: 1)
                      : Duration(microseconds: (v as num).toInt())),
              delayAdjustInterval: $checkedConvert(
                  'delay_adjust_interval',
                  (v) => v == null
                      ? const Duration(minutes: 10)
                      : Duration(microseconds: (v as num).toInt())),
            );
            return val;
          },
          fieldKeyMap: const {
            'imageFetchInterval': 'image_fetch_interval',
            'delayAdjustInterval': 'delay_adjust_interval'
          },
        );

Map<String, dynamic> _$$KyoshinMonitorSettingsApiModelImplToJson(
        _$KyoshinMonitorSettingsApiModelImpl instance) =>
    <String, dynamic>{
      'endpoint': _$KyoshinMonitorEndpointEnumMap[instance.endpoint]!,
      'image_fetch_interval': instance.imageFetchInterval.inMicroseconds,
      'delay_adjust_interval': instance.delayAdjustInterval.inMicroseconds,
    };

const _$KyoshinMonitorEndpointEnumMap = {
  KyoshinMonitorEndpoint.kmoni: 'http://www.kmoni.bosai.go.jp',
  KyoshinMonitorEndpoint.lmoniexp: 'https://smi.lmoniexp.bosai.go.jp',
};
