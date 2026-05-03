import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_map_layer_mode.freezed.dart';
part 'earthquake_history_map_layer_mode.g.dart';

enum EarthquakeHistoryMapLayerMode { none, region, city, station, auto }

/// 地震データに含まれる地図レイヤー粒度ごとの表示可否。
@freezed
abstract class EarthquakeHistoryMapLayerAvailability
    with _$EarthquakeHistoryMapLayerAvailability {
  const factory EarthquakeHistoryMapLayerAvailability({
    required bool region,
    required bool city,
    required bool station,
  }) = _EarthquakeHistoryMapLayerAvailability;

  factory EarthquakeHistoryMapLayerAvailability.fromJson(
    Map<String, dynamic> json,
  ) => _$EarthquakeHistoryMapLayerAvailabilityFromJson(json);
}

/// 自動表示で地域・市区町村・観測点を切り替えるズーム境界。
@freezed
abstract class EarthquakeHistoryMapLayerZoomThresholds
    with _$EarthquakeHistoryMapLayerZoomThresholds {
  const factory EarthquakeHistoryMapLayerZoomThresholds({
    required double regionToCity,
    required double cityToStation,
  }) = _EarthquakeHistoryMapLayerZoomThresholds;

  factory EarthquakeHistoryMapLayerZoomThresholds.fromJson(
    Map<String, dynamic> json,
  ) => _$EarthquakeHistoryMapLayerZoomThresholdsFromJson(json);
}

const defaultEarthquakeHistoryMapLayerZoomThresholds =
    EarthquakeHistoryMapLayerZoomThresholds(
      regionToCity: 9,
      cityToStation: 11,
    );

class EarthquakeHistoryMapLayerModeResolver {
  const EarthquakeHistoryMapLayerModeResolver();

  EarthquakeHistoryMapLayerMode resolveMapLayerMode({
    required Earthquake earthquake,
    required EarthquakeHistoryDetailConfig config,
  }) {
    final availability = resolveAvailability(
      earthquake: earthquake,
      showingLpgmIntensity: config.showingLpgmIntensity,
    );
    return resolvePreferredMapLayerMode(
      preferredMode: config.iconMode,
      availability: availability,
    );
  }

  EarthquakeHistoryMapLayerMode resolveFillLayerMode({
    required Earthquake earthquake,
    required EarthquakeHistoryDetailConfig config,
  }) {
    if (config.fillMode == EarthquakeHistoryFillMode.none) {
      return EarthquakeHistoryMapLayerMode.none;
    }
    return resolveMapLayerMode(
      earthquake: earthquake,
      config: config,
    );
  }

  EarthquakeHistoryMapLayerAvailability resolveAvailability({
    required Earthquake earthquake,
    required bool showingLpgmIntensity,
  }) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const EarthquakeHistoryMapLayerAvailability(
        region: false,
        city: false,
        station: false,
      );
    }

    if (showingLpgmIntensity) {
      return resolveLpgmAvailability(intensity);
    }
    return resolveJmaAvailability(intensity);
  }

  Object regionFillOpacity({
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
    required double visibleOpacity,
  }) {
    if (mode != EarthquakeHistoryMapLayerMode.auto) {
      return visibleOpacity;
    }
    return [
      'step',
      ['zoom'],
      visibleOpacity,
      zoomThresholds.regionToCity,
      0.0,
    ];
  }

  Object cityFillOpacity({
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
    required double visibleOpacity,
  }) {
    if (mode != EarthquakeHistoryMapLayerMode.auto) {
      return visibleOpacity;
    }
    return [
      'step',
      ['zoom'],
      0.0,
      zoomThresholds.regionToCity,
      visibleOpacity,
      zoomThresholds.cityToStation,
      0.0,
    ];
  }

  Object regionIconOpacity({
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    if (mode != EarthquakeHistoryMapLayerMode.auto) {
      return 1.0;
    }
    return [
      'step',
      ['zoom'],
      1.0,
      zoomThresholds.regionToCity,
      0.0,
    ];
  }

  Object cityIconOpacity({
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    if (mode != EarthquakeHistoryMapLayerMode.auto) {
      return 1.0;
    }
    return [
      'step',
      ['zoom'],
      0.0,
      zoomThresholds.regionToCity,
      1.0,
      zoomThresholds.cityToStation,
      0.0,
    ];
  }

  Object stationIconOpacity({
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    if (mode != EarthquakeHistoryMapLayerMode.auto) {
      return 1.0;
    }
    return [
      'step',
      ['zoom'],
      0.0,
      zoomThresholds.cityToStation,
      1.0,
    ];
  }

  bool showsRegionFill(EarthquakeHistoryMapLayerMode mode) =>
      mode == EarthquakeHistoryMapLayerMode.auto ||
      mode == EarthquakeHistoryMapLayerMode.region;

  bool showsCityFill(EarthquakeHistoryMapLayerMode mode) =>
      mode == EarthquakeHistoryMapLayerMode.auto ||
      mode == EarthquakeHistoryMapLayerMode.city;

  bool showsRegionIcon(EarthquakeHistoryMapLayerMode mode) =>
      mode == EarthquakeHistoryMapLayerMode.auto ||
      mode == EarthquakeHistoryMapLayerMode.region;

  bool showsCityIcon(EarthquakeHistoryMapLayerMode mode) =>
      mode == EarthquakeHistoryMapLayerMode.auto ||
      mode == EarthquakeHistoryMapLayerMode.city;

  bool showsStationIcon(EarthquakeHistoryMapLayerMode mode) =>
      mode == EarthquakeHistoryMapLayerMode.auto ||
      mode == EarthquakeHistoryMapLayerMode.station;

  EarthquakeHistoryMapLayerMode resolvePreferredMapLayerMode({
    required EarthquakeHistoryIconMode preferredMode,
    required EarthquakeHistoryMapLayerAvailability availability,
  }) {
    return switch (preferredMode) {
      EarthquakeHistoryIconMode.none => EarthquakeHistoryMapLayerMode.none,
      EarthquakeHistoryIconMode.region when availability.region =>
        EarthquakeHistoryMapLayerMode.region,
      EarthquakeHistoryIconMode.region => EarthquakeHistoryMapLayerMode.none,
      EarthquakeHistoryIconMode.municipality when availability.city =>
        EarthquakeHistoryMapLayerMode.city,
      EarthquakeHistoryIconMode.municipality when availability.region =>
        EarthquakeHistoryMapLayerMode.region,
      EarthquakeHistoryIconMode.municipality =>
        EarthquakeHistoryMapLayerMode.none,
      EarthquakeHistoryIconMode.station when availability.station =>
        EarthquakeHistoryMapLayerMode.station,
      EarthquakeHistoryIconMode.station when availability.region =>
        EarthquakeHistoryMapLayerMode.region,
      EarthquakeHistoryIconMode.station when availability.city =>
        EarthquakeHistoryMapLayerMode.city,
      EarthquakeHistoryIconMode.station => EarthquakeHistoryMapLayerMode.none,
      EarthquakeHistoryIconMode.auto
          when availability.region && availability.city =>
        EarthquakeHistoryMapLayerMode.auto,
      EarthquakeHistoryIconMode.auto when availability.region =>
        EarthquakeHistoryMapLayerMode.region,
      EarthquakeHistoryIconMode.auto when availability.city =>
        EarthquakeHistoryMapLayerMode.city,
      EarthquakeHistoryIconMode.auto when availability.station =>
        EarthquakeHistoryMapLayerMode.station,
      EarthquakeHistoryIconMode.auto => EarthquakeHistoryMapLayerMode.none,
    };
  }

  EarthquakeHistoryMapLayerAvailability resolveJmaAvailability(
    EarthquakeIntensity intensity,
  ) {
    return EarthquakeHistoryMapLayerAvailability(
      region: intensity.intensityTree.values.any(
        (regions) => regions.any(
          (region) => region.region.maxIntensity != null,
        ),
      ),
      city: intensity.intensityTree.values.any(
        (regions) => regions.any(
          (region) => region.cities.any((city) => city.maxIntensity != null),
        ),
      ),
      station: intensity.intensityTree.values.any(
        (regions) => regions.any(
          (region) => region.cities.any(
            (city) => city.stations.any(
              (station) => station.intensity?.maxIntensity != null,
            ),
          ),
        ),
      ),
    );
  }

  EarthquakeHistoryMapLayerAvailability resolveLpgmAvailability(
    EarthquakeIntensity intensity,
  ) {
    return EarthquakeHistoryMapLayerAvailability(
      region: intensity.lpgmIntensityTree.values.any(
        (regions) => regions.any(
          (region) => region.maxLpgmIntensity != null,
        ),
      ),
      city: intensity.lpgmIntensityTree.values.any(
        (regions) => regions.any(
          (region) => region.cities.any(
            (city) => city.maxLpgmIntensity != null,
          ),
        ),
      ),
      station: intensity.lpgmIntensityTree.values.any(
        (regions) => regions.any(
          (region) => region.cities.any(
            (city) => city.stations.any(
              (station) => station.intensity?.maxLpgmIntensity != null,
            ),
          ),
        ),
      ),
    );
  }
}
