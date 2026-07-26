// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveMonitorSettings _$LiveMonitorSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_LiveMonitorSettings',
      json,
      ($checkedConvert) {
        final val = _LiveMonitorSettings(
          displayMode: $checkedConvert(
            'display_mode',
            (v) =>
                $enumDecodeNullable(_$LiveMonitorDisplayModeEnumMap, v) ??
                LiveMonitorDisplayMode.automatic,
          ),
          earthquakeDisplaySeconds: $checkedConvert(
            'earthquake_display_seconds',
            (v) => (v as num?)?.toInt() ?? 10,
          ),
          keepScreenAwake: $checkedConvert(
            'keep_screen_awake',
            (v) => v as bool? ?? true,
          ),
          portraitRealtimeRatio: $checkedConvert(
            'portrait_realtime_ratio',
            (v) => (v as num?)?.toDouble() ?? 0.5,
          ),
          landscapeRealtimeRatio: $checkedConvert(
            'landscape_realtime_ratio',
            (v) => (v as num?)?.toDouble() ?? 0.5,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayMode': 'display_mode',
        'earthquakeDisplaySeconds': 'earthquake_display_seconds',
        'keepScreenAwake': 'keep_screen_awake',
        'portraitRealtimeRatio': 'portrait_realtime_ratio',
        'landscapeRealtimeRatio': 'landscape_realtime_ratio',
      },
    );

Map<String, dynamic> _$LiveMonitorSettingsToJson(
  _LiveMonitorSettings instance,
) => <String, dynamic>{
  'display_mode': _$LiveMonitorDisplayModeEnumMap[instance.displayMode]!,
  'earthquake_display_seconds': instance.earthquakeDisplaySeconds,
  'keep_screen_awake': instance.keepScreenAwake,
  'portrait_realtime_ratio': instance.portraitRealtimeRatio,
  'landscape_realtime_ratio': instance.landscapeRealtimeRatio,
};

const _$LiveMonitorDisplayModeEnumMap = {
  LiveMonitorDisplayMode.automatic: 'automatic',
  LiveMonitorDisplayMode.split: 'split',
};
