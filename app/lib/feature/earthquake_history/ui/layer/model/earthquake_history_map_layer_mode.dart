import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';

enum EarthquakeHistoryMapLayerMode { none, region, city, station, auto }

class EarthquakeHistoryMapLayerModeResolver {
  const EarthquakeHistoryMapLayerModeResolver();

  EarthquakeHistoryMapLayerMode resolveFillLayerMode({
    required Earthquake earthquake,
    required EarthquakeHistoryFillMode fillMode,
    required bool showingLpgmIntensity,
  }) {
    final availability = resolveAvailability(
      earthquake: earthquake,
      showingLpgmIntensity: showingLpgmIntensity,
    );
    return switch (fillMode) {
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

  ({bool region, bool city, bool station}) resolveAvailability({
    required Earthquake earthquake,
    required bool showingLpgmIntensity,
  }) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return (region: false, city: false, station: false);
    }

    if (showingLpgmIntensity) {
      return _resolveLpgmAvailability(intensity);
    }
    return _resolveJmaAvailability(intensity);
  }

  Object regionFillOpacity({
    required EarthquakeHistoryMapLayerMode mode,
    required double regionToCity,
    required double visibleOpacity,
  }) {
    if (mode != .auto) {
      return visibleOpacity;
    }
    return [
      'step',
      ['zoom'],
      visibleOpacity,
      regionToCity,
      0.0,
    ];
  }

  Object cityFillOpacity({
    required EarthquakeHistoryMapLayerMode mode,
    required double regionToCity,
    required double visibleOpacity,
  }) {
    if (mode != .auto) {
      return visibleOpacity;
    }
    return [
      'step',
      ['zoom'],
      0.0,
      regionToCity,
      visibleOpacity,
    ];
  }

  bool showsRegionFill(EarthquakeHistoryMapLayerMode mode) =>
      mode == .auto || mode == .region;

  bool showsCityFill(EarthquakeHistoryMapLayerMode mode) =>
      mode == .auto || mode == .city;

  ({bool region, bool city, bool station}) _resolveJmaAvailability(
    EarthquakeIntensity intensity,
  ) {
    return (
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

  ({bool region, bool city, bool station}) _resolveLpgmAvailability(
    EarthquakeIntensity intensity,
  ) {
    return (
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
