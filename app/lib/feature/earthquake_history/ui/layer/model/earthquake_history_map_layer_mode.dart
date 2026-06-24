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

/// 各レイヤーのズーム閾値。
@freezed
abstract class EarthquakeHistoryMapLayerZoomThresholds
    with _$EarthquakeHistoryMapLayerZoomThresholds {
  const factory EarthquakeHistoryMapLayerZoomThresholds({
    /// 自動表示で地域→市区町村に切り替えるズーム
    @Default(8) double regionToCity,

    /// 観測点（円・アイコン）の最小表示ズーム
    @Default(8) double stationMinZoom,

    /// 観測点名ラベルの最小表示ズーム
    @Default(9) double stationLabelMinZoom,

    /// 震央マーカーが半透明になるズーム（zoomFade モード用）
    @Default(8) double hypocenterFadeZoom,

    /// 震央誤差矩形が表示されるズーム
    @Default(8) double hypocenterErrorMinZoom,
  }) = _EarthquakeHistoryMapLayerZoomThresholds;

  factory EarthquakeHistoryMapLayerZoomThresholds.fromJson(
    Map<String, dynamic> json,
  ) => _$EarthquakeHistoryMapLayerZoomThresholdsFromJson(json);
}

const defaultEarthquakeHistoryMapLayerZoomThresholds =
    EarthquakeHistoryMapLayerZoomThresholds();

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
      .none => .none,
      .auto when availability.region && availability.city => .auto,
      .auto when availability.region => .region,
      .auto when availability.city => .city,
      .auto => .none,
      .region when availability.region => .region,
      .region => .none,
      .city when availability.city => .city,
      .city when availability.region => .region,
      .city => .none,
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
    if (mode != .auto) {
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
    if (mode != .auto) {
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
      mode == .auto || mode == .region;

  bool showsCityFill(EarthquakeHistoryMapLayerMode mode) =>
      mode == .auto || mode == .city;

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
