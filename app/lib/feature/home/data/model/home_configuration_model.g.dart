// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeShakeDetectionSettings _$HomeShakeDetectionSettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_HomeShakeDetectionSettings', json, ($checkedConvert) {
  final val = _HomeShakeDetectionSettings(
    show: $checkedConvert('show', (v) => v as bool? ?? true),
    animationMode: $checkedConvert(
      'animation_mode',
      (v) =>
          $enumDecodeNullable(_$HomeShakeDetectionAnimationModeEnumMap, v) ??
          HomeShakeDetectionAnimationMode.blink,
    ),
  );
  return val;
}, fieldKeyMap: const {'animationMode': 'animation_mode'});

Map<String, dynamic> _$HomeShakeDetectionSettingsToJson(
  _HomeShakeDetectionSettings instance,
) => <String, dynamic>{
  'show': instance.show,
  'animation_mode':
      _$HomeShakeDetectionAnimationModeEnumMap[instance.animationMode]!,
};

const _$HomeShakeDetectionAnimationModeEnumMap = {
  HomeShakeDetectionAnimationMode.blink: 'blink',
  HomeShakeDetectionAnimationMode.fade: 'fade',
  HomeShakeDetectionAnimationMode.solid: 'solid',
};

_HomeEewSettings _$HomeEewSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_HomeEewSettings',
      json,
      ($checkedConvert) {
        final val = _HomeEewSettings(
          fillMode: $checkedConvert(
            'fill_mode',
            (v) =>
                $enumDecodeNullable(_$HomeEewFillModeEnumMap, v) ??
                HomeEewFillMode.intensity,
          ),
          animationRate: $checkedConvert(
            'animation_rate',
            (v) =>
                $enumDecodeNullable(_$HomeEewAnimationRateEnumMap, v) ??
                HomeEewAnimationRate.unlimited,
          ),
          autoZoom: $checkedConvert('auto_zoom', (v) => v as bool? ?? true),
          showPSWaveCircle: $checkedConvert(
            'show_p_s_wave_circle',
            (v) => v as bool? ?? true,
          ),
          alignPSWaveCircleToKyoshinMonitor: $checkedConvert(
            'align_p_s_wave_circle_to_kyoshin_monitor',
            (v) => v as bool? ?? false,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'fillMode': 'fill_mode',
        'animationRate': 'animation_rate',
        'autoZoom': 'auto_zoom',
        'showPSWaveCircle': 'show_p_s_wave_circle',
        'alignPSWaveCircleToKyoshinMonitor':
            'align_p_s_wave_circle_to_kyoshin_monitor',
      },
    );

Map<String, dynamic> _$HomeEewSettingsToJson(_HomeEewSettings instance) =>
    <String, dynamic>{
      'fill_mode': _$HomeEewFillModeEnumMap[instance.fillMode]!,
      'animation_rate': _$HomeEewAnimationRateEnumMap[instance.animationRate]!,
      'auto_zoom': instance.autoZoom,
      'show_p_s_wave_circle': instance.showPSWaveCircle,
      'align_p_s_wave_circle_to_kyoshin_monitor':
          instance.alignPSWaveCircleToKyoshinMonitor,
    };

const _$HomeEewFillModeEnumMap = {
  HomeEewFillMode.intensity: 'intensity',
  HomeEewFillMode.warning: 'warning',
  HomeEewFillMode.none: 'none',
};

const _$HomeEewAnimationRateEnumMap = {
  HomeEewAnimationRate.unlimited: 'unlimited',
  HomeEewAnimationRate.oneHz: 'oneHz',
};

_HomeKyoshinMonitorSettings _$HomeKyoshinMonitorSettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_HomeKyoshinMonitorSettings',
  json,
  ($checkedConvert) {
    final val = _HomeKyoshinMonitorSettings(
      minRealtimeShindo: $checkedConvert(
        'min_realtime_shindo',
        (v) => (v as num?)?.toDouble() ?? null,
      ),
      markerSize: $checkedConvert(
        'marker_size',
        (v) =>
            $enumDecodeNullable(_$HomeKmoniMarkerSizeEnumMap, v) ??
            HomeKmoniMarkerSize.medium,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'minRealtimeShindo': 'min_realtime_shindo',
    'markerSize': 'marker_size',
  },
);

Map<String, dynamic> _$HomeKyoshinMonitorSettingsToJson(
  _HomeKyoshinMonitorSettings instance,
) => <String, dynamic>{
  'min_realtime_shindo': instance.minRealtimeShindo,
  'marker_size': _$HomeKmoniMarkerSizeEnumMap[instance.markerSize]!,
};

const _$HomeKmoniMarkerSizeEnumMap = {
  HomeKmoniMarkerSize.small: 'small',
  HomeKmoniMarkerSize.medium: 'medium',
  HomeKmoniMarkerSize.large: 'large',
};

_HomeMapGridSettings _$HomeMapGridSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HomeMapGridSettings', json, ($checkedConvert) {
      final val = _HomeMapGridSettings(
        enabled: $checkedConvert('enabled', (v) => v as bool? ?? false),
      );
      return val;
    });

Map<String, dynamic> _$HomeMapGridSettingsToJson(
  _HomeMapGridSettings instance,
) => <String, dynamic>{'enabled': instance.enabled};

_HomeMapSettings _$HomeMapSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_HomeMapSettings',
      json,
      ($checkedConvert) {
        final val = _HomeMapSettings(
          maxZoom: $checkedConvert(
            'max_zoom',
            (v) => (v as num?)?.toDouble() ?? null,
          ),
          defaultBounds: $checkedConvert(
            'default_bounds',
            (v) =>
                $enumDecodeNullable(_$HomeMapDefaultBoundsEnumMap, v) ??
                HomeMapDefaultBounds.mainIsland,
          ),
          customBounds: $checkedConvert(
            'custom_bounds',
            (v) =>
                _$JsonConverterFromJson<Map<String, dynamic>, LatLngBoundary>(
                  v,
                  const LatLngBoundaryJsonConverter().fromJson,
                ),
          ),
          lockBearing: $checkedConvert(
            'lock_bearing',
            (v) => v as bool? ?? false,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxZoom': 'max_zoom',
        'defaultBounds': 'default_bounds',
        'customBounds': 'custom_bounds',
        'lockBearing': 'lock_bearing',
      },
    );

Map<String, dynamic> _$HomeMapSettingsToJson(
  _HomeMapSettings instance,
) => <String, dynamic>{
  'max_zoom': instance.maxZoom,
  'default_bounds': _$HomeMapDefaultBoundsEnumMap[instance.defaultBounds]!,
  'custom_bounds': _$JsonConverterToJson<Map<String, dynamic>, LatLngBoundary>(
    instance.customBounds,
    const LatLngBoundaryJsonConverter().toJson,
  ),
  'lock_bearing': instance.lockBearing,
};

const _$HomeMapDefaultBoundsEnumMap = {
  HomeMapDefaultBounds.mainIsland: 'mainIsland',
  HomeMapDefaultBounds.all: 'all',
  HomeMapDefaultBounds.custom: 'custom',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_HomeCommonSettings _$HomeCommonSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_HomeCommonSettings',
      json,
      ($checkedConvert) {
        final val = _HomeCommonSettings(
          showLocation: $checkedConvert(
            'show_location',
            (v) => v as bool? ?? false,
          ),
          earthquakeHistoryScope: $checkedConvert(
            'earthquake_history_scope',
            (v) =>
                $enumDecodeNullable(_$HomeEarthquakeHistoryScopeEnumMap, v) ??
                HomeEarthquakeHistoryScope.nationwide,
          ),
          parameter: $checkedConvert(
            'parameter',
            (v) => v == null
                ? null
                : EarthquakeHistoryParameter.fromJson(
                    v as Map<String, dynamic>,
                  ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'showLocation': 'show_location',
        'earthquakeHistoryScope': 'earthquake_history_scope',
      },
    );

Map<String, dynamic> _$HomeCommonSettingsToJson(_HomeCommonSettings instance) =>
    <String, dynamic>{
      'show_location': instance.showLocation,
      'earthquake_history_scope':
          _$HomeEarthquakeHistoryScopeEnumMap[instance.earthquakeHistoryScope]!,
      'parameter': instance.parameter?.toJson(),
    };

const _$HomeEarthquakeHistoryScopeEnumMap = {
  HomeEarthquakeHistoryScope.nationwide: 'nationwide',
  HomeEarthquakeHistoryScope.currentLocation: 'currentLocation',
  HomeEarthquakeHistoryScope.custom: 'custom',
};

_HomeConfigurationModel _$HomeConfigurationModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_HomeConfigurationModel',
  json,
  ($checkedConvert) {
    final val = _HomeConfigurationModel(
      eew: $checkedConvert(
        'eew',
        (v) => v == null
            ? const HomeEewSettings()
            : HomeEewSettings.fromJson(v as Map<String, dynamic>),
      ),
      kyoshinMonitor: $checkedConvert(
        'kyoshin_monitor',
        (v) => v == null
            ? const HomeKyoshinMonitorSettings()
            : HomeKyoshinMonitorSettings.fromJson(v as Map<String, dynamic>),
      ),
      map: $checkedConvert(
        'map',
        (v) => v == null
            ? const HomeMapSettings()
            : HomeMapSettings.fromJson(v as Map<String, dynamic>),
      ),
      common: $checkedConvert(
        'common',
        (v) => v == null
            ? const HomeCommonSettings()
            : HomeCommonSettings.fromJson(v as Map<String, dynamic>),
      ),
      shakeDetection: $checkedConvert(
        'shake_detection',
        (v) => v == null
            ? const HomeShakeDetectionSettings()
            : HomeShakeDetectionSettings.fromJson(v as Map<String, dynamic>),
      ),
      mapGrid: $checkedConvert(
        'map_grid',
        (v) => v == null
            ? const HomeMapGridSettings()
            : HomeMapGridSettings.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'kyoshinMonitor': 'kyoshin_monitor',
    'shakeDetection': 'shake_detection',
    'mapGrid': 'map_grid',
  },
);

Map<String, dynamic> _$HomeConfigurationModelToJson(
  _HomeConfigurationModel instance,
) => <String, dynamic>{
  'eew': instance.eew.toJson(),
  'kyoshin_monitor': instance.kyoshinMonitor.toJson(),
  'map': instance.map.toJson(),
  'common': instance.common.toJson(),
  'shake_detection': instance.shakeDetection.toJson(),
  'map_grid': instance.mapGrid.toJson(),
};
