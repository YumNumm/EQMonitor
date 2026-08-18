// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinMonitorSettingsModel _$KyoshinMonitorSettingsModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_KyoshinMonitorSettingsModel',
  json,
  ($checkedConvert) {
    final val = _KyoshinMonitorSettingsModel(
      minRealtimeShindo: $checkedConvert(
        'min_realtime_shindo',
        (v) => (v as num?)?.toDouble() ?? null,
      ),
      showScale: $checkedConvert('show_scale', (v) => v as bool? ?? true),
      useKmoni: $checkedConvert('use_kmoni', (v) => v as bool? ?? true),
      kmoniMarkerType: $checkedConvert(
        'kmoni_marker_type',
        (v) =>
            $enumDecodeNullable(_$KyoshinMonitorMarkerTypeEnumMap, v) ??
            KyoshinMonitorMarkerType.onlyEew,
      ),
      monitorSource: $checkedConvert(
        'monitor_source',
        (v) =>
            $enumDecodeNullable(
              _$KyoshinMonitorSourceEnumMap,
              v,
              unknownValue: KyoshinMonitorSource.kmoni,
            ) ??
            KyoshinMonitorSource.kmoni,
      ),
      realtimeDataType: $checkedConvert(
        'realtime_data_type',
        (v) =>
            $enumDecodeNullable(_$RealtimeDataTypeEnumMap, v) ??
            RealtimeDataType.shindo,
      ),
      realtimeLayer: $checkedConvert(
        'realtime_layer',
        (v) =>
            $enumDecodeNullable(_$RealtimeLayerEnumMap, v) ??
            RealtimeLayer.surface,
      ),
      api: $checkedConvert(
        'api',
        (v) => v == null
            ? const KyoshinMonitorSettingsApiModel()
            : KyoshinMonitorSettingsApiModel.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'minRealtimeShindo': 'min_realtime_shindo',
    'showScale': 'show_scale',
    'useKmoni': 'use_kmoni',
    'kmoniMarkerType': 'kmoni_marker_type',
    'monitorSource': 'monitor_source',
    'realtimeDataType': 'realtime_data_type',
    'realtimeLayer': 'realtime_layer',
  },
);

Map<String, dynamic> _$KyoshinMonitorSettingsModelToJson(
  _KyoshinMonitorSettingsModel instance,
) => <String, dynamic>{
  'min_realtime_shindo': instance.minRealtimeShindo,
  'show_scale': instance.showScale,
  'use_kmoni': instance.useKmoni,
  'kmoni_marker_type':
      _$KyoshinMonitorMarkerTypeEnumMap[instance.kmoniMarkerType]!,
  'monitor_source': _$KyoshinMonitorSourceEnumMap[instance.monitorSource]!,
  'realtime_data_type': _$RealtimeDataTypeEnumMap[instance.realtimeDataType]!,
  'realtime_layer': _$RealtimeLayerEnumMap[instance.realtimeLayer]!,
  'api': instance.api,
};

const _$KyoshinMonitorMarkerTypeEnumMap = {
  KyoshinMonitorMarkerType.always: 'always',
  KyoshinMonitorMarkerType.onlyEew: 'onlyEew',
  KyoshinMonitorMarkerType.never: 'never',
};

const _$KyoshinMonitorSourceEnumMap = {
  KyoshinMonitorSource.kmoni: 'kmoni',
  KyoshinMonitorSource.lmoni: 'lmoni',
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

_KyoshinMonitorSettingsApiModel _$KyoshinMonitorSettingsApiModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_KyoshinMonitorSettingsApiModel',
  json,
  ($checkedConvert) {
    final val = _KyoshinMonitorSettingsApiModel(
      endpoint: $checkedConvert(
        'endpoint',
        (v) =>
            $enumDecodeNullable(
              _$KyoshinMonitorEndpointEnumMap,
              v,
              unknownValue: KyoshinMonitorEndpoint.kmoni,
            ) ??
            KyoshinMonitorEndpoint.kmoni,
      ),
      imageFetchInterval: $checkedConvert(
        'image_fetch_interval',
        (v) => v == null
            ? const Duration(seconds: 1)
            : Duration(microseconds: (v as num).toInt()),
      ),
      delayAdjustInterval: $checkedConvert(
        'delay_adjust_interval',
        (v) => v == null
            ? const Duration(seconds: 60)
            : Duration(microseconds: (v as num).toInt()),
      ),
      delayAdjustType: $checkedConvert(
        'delay_adjust_type',
        (v) =>
            $enumDecodeNullable(
              _$KyoshinMonitorDelayAdjustTypeEnumMap,
              v,
              unknownValue: KyoshinMonitorDelayAdjustType.imageFetch404Ntp,
            ) ??
            KyoshinMonitorDelayAdjustType.imageFetch404Ntp,
      ),
      autoOffsetIncrement: $checkedConvert(
        'auto_offset_increment',
        (v) => v as bool? ?? true,
      ),
      offsetAdjustments: $checkedConvert(
        'offset_adjustments',
        (v) =>
            (v as Map<String, dynamic>?)?.map(
              (k, e) => MapEntry(
                $enumDecode(_$KyoshinMonitorSourceEnumMap, k),
                Duration(microseconds: (e as num).toInt()),
              ),
            ) ??
            const <KyoshinMonitorSource, Duration>{},
      ),
      minOffset: $checkedConvert(
        'min_offset',
        (v) => v == null
            ? const Duration(milliseconds: 600)
            : Duration(microseconds: (v as num).toInt()),
      ),
      maxOffset: $checkedConvert(
        'max_offset',
        (v) => v == null
            ? const Duration(milliseconds: 5000)
            : Duration(microseconds: (v as num).toInt()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'imageFetchInterval': 'image_fetch_interval',
    'delayAdjustInterval': 'delay_adjust_interval',
    'delayAdjustType': 'delay_adjust_type',
    'autoOffsetIncrement': 'auto_offset_increment',
    'offsetAdjustments': 'offset_adjustments',
    'minOffset': 'min_offset',
    'maxOffset': 'max_offset',
  },
);

Map<String, dynamic> _$KyoshinMonitorSettingsApiModelToJson(
  _KyoshinMonitorSettingsApiModel instance,
) => <String, dynamic>{
  'endpoint': _$KyoshinMonitorEndpointEnumMap[instance.endpoint]!,
  'image_fetch_interval': instance.imageFetchInterval.inMicroseconds,
  'delay_adjust_interval': instance.delayAdjustInterval.inMicroseconds,
  'delay_adjust_type':
      _$KyoshinMonitorDelayAdjustTypeEnumMap[instance.delayAdjustType]!,
  'auto_offset_increment': instance.autoOffsetIncrement,
  'offset_adjustments': instance.offsetAdjustments.map(
    (k, e) => MapEntry(_$KyoshinMonitorSourceEnumMap[k]!, e.inMicroseconds),
  ),
  'min_offset': instance.minOffset.inMicroseconds,
  'max_offset': instance.maxOffset.inMicroseconds,
};

const _$KyoshinMonitorEndpointEnumMap = {
  KyoshinMonitorEndpoint.kmoni: 'http://www.kmoni.bosai.go.jp',
  KyoshinMonitorEndpoint.lmoniexp: 'https://smi.lmoniexp.bosai.go.jp',
};

const _$KyoshinMonitorDelayAdjustTypeEnumMap = {
  KyoshinMonitorDelayAdjustType.latestJson: 'latestJson',
  KyoshinMonitorDelayAdjustType.latestJsonMultiple: 'latestJsonMultiple',
  KyoshinMonitorDelayAdjustType.imageFetch404DeviceTime:
      'imageFetch404DeviceTime',
  KyoshinMonitorDelayAdjustType.imageFetch404Ntp: 'imageFetch404Ntp',
};
