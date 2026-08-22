// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_image_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinMonitorImageRequest _$KyoshinMonitorImageRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_KyoshinMonitorImageRequest',
  json,
  ($checkedConvert) {
    final val = _KyoshinMonitorImageRequest(
      layer: $checkedConvert(
        'layer',
        (v) => $enumDecode(_$RealtimeLayerEnumMap, v),
      ),
      source: $checkedConvert(
        'source',
        (v) => $enumDecode(_$KyoshinMonitorSourceEnumMap, v),
      ),
      delayProfile: $checkedConvert(
        'delay_profile',
        (v) => $enumDecode(_$KyoshinMonitorDelayProfileEnumMap, v),
      ),
      canSelectRealtimeLayer: $checkedConvert(
        'can_select_realtime_layer',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'delayProfile': 'delay_profile',
    'canSelectRealtimeLayer': 'can_select_realtime_layer',
  },
);

Map<String, dynamic> _$KyoshinMonitorImageRequestToJson(
  _KyoshinMonitorImageRequest instance,
) => <String, dynamic>{
  'layer': _$RealtimeLayerEnumMap[instance.layer]!,
  'source': _$KyoshinMonitorSourceEnumMap[instance.source]!,
  'delay_profile': _$KyoshinMonitorDelayProfileEnumMap[instance.delayProfile]!,
  'can_select_realtime_layer': instance.canSelectRealtimeLayer,
};

const _$RealtimeLayerEnumMap = {
  RealtimeLayer.surface: 'surface',
  RealtimeLayer.underground: 'underground',
};

const _$KyoshinMonitorSourceEnumMap = {
  KyoshinMonitorSource.kmoni: 'kmoni',
  KyoshinMonitorSource.lmoni: 'lmoni',
};

const _$KyoshinMonitorDelayProfileEnumMap = {
  KyoshinMonitorDelayProfile.kmoni: 'kmoni',
  KyoshinMonitorDelayProfile.lpgm: 'lpgm',
};
