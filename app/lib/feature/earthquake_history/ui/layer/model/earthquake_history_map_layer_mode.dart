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

/// 自動表示で地域・市区町村を切り替えるズーム境界。
@freezed
abstract class EarthquakeHistoryMapLayerZoomThresholds
    with _$EarthquakeHistoryMapLayerZoomThresholds {
  const factory EarthquakeHistoryMapLayerZoomThresholds({
    required double regionToCity,
  }) = _EarthquakeHistoryMapLayerZoomThresholds;

  factory EarthquakeHistoryMapLayerZoomThresholds.fromJson(
    Map<String, dynamic> json,
  ) => _$EarthquakeHistoryMapLayerZoomThresholdsFromJson(json);
}

const defaultEarthquakeHistoryMapLayerZoomThresholds =
    EarthquakeHistoryMapLayerZoomThresholds(regionToCity: 8);

class EarthquakeHistoryMapLayerModeResolver {
  const EarthquakeHistoryMapLayerModeResolver();

  EarthquakeHistoryMapLayerMode resolveFillLayerMode({
    required Earthquake earthquake,
    required EarthquakeHistoryDetailConfig config,
  }) {
    final availability = resolveAvailability(
      earthquake: earthquake,
      showingLpgmIntensity: config.showingLpgmIntensity,
    );
    return switch (config.fillMode) {
      EarthquakeHistoryFillMode.none => EarthquakeHistoryMapLayerMode.none,
      EarthquakeHistoryFillMode.auto
          when availability.region && availability.city =>
        EarthquakeHistoryMapLayerMode.auto,
      EarthquakeHistoryFillMode.auto when availability.region =>
        EarthquakeHistoryMapLayerMode.region,
      EarthquakeHistoryFillMode.auto when availability.city =>
        EarthquakeHistoryMapLayerMode.city,
      EarthquakeHistoryFillMode.auto => EarthquakeHistoryMapLayerMode.none,
      EarthquakeHistoryFillMode.region when availability.region =>
        EarthquakeHistoryMapLayerMode.region,
      EarthquakeHistoryFillMode.region => EarthquakeHistoryMapLayerMode.none,
      EarthquakeHistoryFillMode.city when availability.city =>
        EarthquakeHistoryMapLayerMode.city,
      EarthquakeHistoryFillMode.city when availability.region =>
        EarthquakeHistoryMapLayerMode.region,
      EarthquakeHistoryFillMode.city => EarthquakeHistoryMapLayerMode.none,
    };
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
    ];
  }

  bool showsRegionFill(EarthquakeHistoryMapLayerMode mode) =>
      mode == EarthquakeHistoryMapLayerMode.auto ||
      mode == EarthquakeHistoryMapLayerMode.region;

  bool showsCityFill(EarthquakeHistoryMapLayerMode mode) =>
      mode == EarthquakeHistoryMapLayerMode.auto ||
      mode == EarthquakeHistoryMapLayerMode.city;

  EarthquakeHistoryMapLayerAvailability resolveJmaAvailability(
    EarthquakeIntensity intensity,
  ) {
    return EarthquakeHistoryMapLayerAvailability(
      region: intensity.regions.values.any(
        (regions) => regions.any(
          (region) => region.maxIntensity != null,
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
