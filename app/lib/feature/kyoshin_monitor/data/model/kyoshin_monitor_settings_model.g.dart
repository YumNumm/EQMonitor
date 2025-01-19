// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

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
              'minRealtimeShindo', (v) => (v as num?)?.toDouble() ?? null),
          showRealtimeShindoScale: $checkedConvert(
              'showRealtimeShindoScale', (v) => v as bool? ?? true),
          useKmoni: $checkedConvert('useKmoni', (v) => v as bool? ?? false),
          showCurrentLocationMarker: $checkedConvert(
              'showCurrentLocationMarker', (v) => v as bool? ?? false),
          kmoniMarkerType: $checkedConvert(
              'kmoniMarkerType',
              (v) =>
                  $enumDecodeNullable(_$KmoniMarkerTypeEnumMap, v) ??
                  KmoniMarkerType.onlyEew),
          api: $checkedConvert(
              'api',
              (v) => v == null
                  ? const KyoshinMonitorSettingsApiModel()
                  : KyoshinMonitorSettingsApiModel.fromJson(
                      v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KyoshinMonitorSettingsModelImplToJson(
        _$KyoshinMonitorSettingsModelImpl instance) =>
    <String, dynamic>{
      'minRealtimeShindo': instance.minRealtimeShindo,
      'showRealtimeShindoScale': instance.showRealtimeShindoScale,
      'useKmoni': instance.useKmoni,
      'showCurrentLocationMarker': instance.showCurrentLocationMarker,
      'kmoniMarkerType': _$KmoniMarkerTypeEnumMap[instance.kmoniMarkerType]!,
      'api': instance.api,
    };

const _$KmoniMarkerTypeEnumMap = {
  KmoniMarkerType.always: 'always',
  KmoniMarkerType.onlyEew: 'onlyEew',
  KmoniMarkerType.never: 'never',
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
                  'imageFetchInterval',
                  (v) => v == null
                      ? const Duration(seconds: 1)
                      : Duration(microseconds: (v as num).toInt())),
              delayAdjustInterval: $checkedConvert(
                  'delayAdjustInterval',
                  (v) => v == null
                      ? const Duration(minutes: 10)
                      : Duration(microseconds: (v as num).toInt())),
            );
            return val;
          },
        );

Map<String, dynamic> _$$KyoshinMonitorSettingsApiModelImplToJson(
        _$KyoshinMonitorSettingsApiModelImpl instance) =>
    <String, dynamic>{
      'endpoint': _$KyoshinMonitorEndpointEnumMap[instance.endpoint]!,
      'imageFetchInterval': instance.imageFetchInterval.inMicroseconds,
      'delayAdjustInterval': instance.delayAdjustInterval.inMicroseconds,
    };

const _$KyoshinMonitorEndpointEnumMap = {
  KyoshinMonitorEndpoint.kmoni: 'http://www.kmoni.bosai.go.jp',
  KyoshinMonitorEndpoint.lmoniexp: 'https://smi.lmoniexp.bosai.go.jp',
};
