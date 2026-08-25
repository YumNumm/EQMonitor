import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';

const earthquakeOverlayRegionToCityZoom = 6.0;
const earthquakeOverlayStationMinZoom = 6.0;

enum EarthquakeMapOverlayUnavailableReason {
  noIntensity,
  missingTelegramMetadata,
}

sealed class EarthquakeMapOverlayBuildResult {
  const new();
}

final class EarthquakeMapOverlayAvailable
    extends EarthquakeMapOverlayBuildResult {
  const new({required this.snapshot});

  final EarthquakeMapOverlaySnapshot snapshot;
}

final class EarthquakeMapOverlayUnavailable
    extends EarthquakeMapOverlayBuildResult {
  const new({required this.reason});

  final EarthquakeMapOverlayUnavailableReason reason;
}

typedef EarthquakeStationObservation = ({
  EarthquakeParameterStationItem station,
  JmaIntensity intensity,
});

final class EarthquakeMapOverlayBuilder {
  const new();

  EarthquakeMapOverlayBuildResult build({
    required Earthquake earthquake,
    required IntensityColors colorModel,
    required MapOverlayVersionStamp versionStamp,
  }) {
    final reason = unavailableReason(earthquake);
    if (reason != null) {
      return EarthquakeMapOverlayUnavailable(reason: reason);
    }
    final intensity = earthquake.intensity as EarthquakeIntensity;
    if (versionStamp.sourceIdentity.value != earthquake.eventId) {
      throw ArgumentError.value(
        versionStamp.sourceIdentity.value,
        'versionStamp.sourceIdentity',
        'must match earthquake.eventId',
      );
    }
    return EarthquakeMapOverlayAvailable(
      snapshot: createEarthquakeMapOverlaySnapshot(
        versionStamp: versionStamp,
        regionToCityZoom: earthquakeOverlayRegionToCityZoom,
        stationMinZoom: earthquakeOverlayStationMinZoom,
        regionStyles: regionStyles(
          intensity: intensity,
          colorModel: colorModel,
        ),
        cityStyles: cityStyles(
          intensity: intensity,
          colorModel: colorModel,
        ),
        stations: observationPoints(
          intensity: intensity,
          colorModel: colorModel,
        ),
      ),
    );
  }

  EarthquakeMapOverlayUnavailableReason? unavailableReason(
    Earthquake earthquake,
  ) {
    if (earthquake.intensity == null) {
      return EarthquakeMapOverlayUnavailableReason.noIntensity;
    }
    if (earthquake.telegramMetadata.isEmpty) {
      return EarthquakeMapOverlayUnavailableReason.missingTelegramMetadata;
    }
    return null;
  }

  List<EarthquakeAreaStyle> regionStyles({
    required EarthquakeIntensity intensity,
    required IntensityColors colorModel,
  }) => areaStyles(
    levels: regionIntensityLevels(intensity: intensity),
    colorModel: colorModel,
  );

  Map<String, JmaIntensity> regionIntensityLevels({
    required EarthquakeIntensity intensity,
  }) {
    final levels = <String, JmaIntensity>{};
    for (final nodes in intensity.regions.values) {
      for (final node in nodes) {
        final level = node.maxIntensity;
        if (level != null) {
          recordMaximumIntensity(
            levels: levels,
            code: node.region.code,
            intensity: level,
          );
        }
      }
    }
    return levels;
  }

  List<EarthquakeAreaStyle> cityStyles({
    required EarthquakeIntensity intensity,
    required IntensityColors colorModel,
  }) => areaStyles(
    levels: cityIntensityLevels(intensity: intensity),
    colorModel: colorModel,
  );

  Map<String, JmaIntensity> cityIntensityLevels({
    required EarthquakeIntensity intensity,
  }) {
    final levels = <String, JmaIntensity>{};
    for (final prefectures in intensity.intensityTree.values) {
      for (final prefecture in prefectures) {
        for (final city in prefecture.cities) {
          final level = city.maxIntensity;
          if (level != null) {
            recordMaximumIntensity(
              levels: levels,
              code: city.city.code,
              intensity: level,
            );
          }
        }
      }
    }
    return levels;
  }

  void recordMaximumIntensity({
    required Map<String, JmaIntensity> levels,
    required String code,
    required JmaIntensity intensity,
  }) {
    final current = levels[code];
    if (current == null || intensity.orderIndex > current.orderIndex) {
      levels[code] = intensity;
    }
  }

  List<EarthquakeAreaStyle> areaStyles({
    required Map<String, JmaIntensity> levels,
    required IntensityColors colorModel,
  }) {
    final entries = levels.entries.toList()
      ..sort((first, second) => first.key.compareTo(second.key));
    return [
      for (final entry in entries)
        EarthquakeAreaStyle(
          code: entry.key,
          color: colorModel.fromJmaIntensity(entry.value).background,
          opacity: 0.6,
        ),
    ];
  }

  List<EarthquakeObservationPoint> observationPoints({
    required EarthquakeIntensity intensity,
    required IntensityColors colorModel,
  }) {
    final observations = stationObservations(intensity: intensity);
    final entries = observations.entries.toList()
      ..sort((first, second) => first.key.compareTo(second.key));
    return [
      for (final entry in entries)
        EarthquakeObservationPoint(
          id: entry.key,
          longitude: entry.value.station.location.lon,
          latitude: entry.value.station.location.lat,
          color: colorModel.fromJmaIntensity(entry.value.intensity).background,
          radiusLogicalPixels: entry.value.intensity == intensity.maxIntensity
              ? 6.7
              : 4.0,
        ),
    ];
  }

  Map<String, EarthquakeStationObservation> stationObservations({
    required EarthquakeIntensity intensity,
  }) {
    final observations = <String, EarthquakeStationObservation>{};
    for (final prefectures in intensity.intensityTree.values) {
      for (final prefecture in prefectures) {
        for (final city in prefecture.cities) {
          for (final node in city.stations) {
            final level = node.intensity?.maxIntensity;
            if (level == null) {
              continue;
            }
            final code = node.station.code;
            final current = observations[code];
            if (current == null ||
                level.orderIndex > current.intensity.orderIndex) {
              observations[code] = (station: node.station, intensity: level);
            }
          }
        }
      }
    }
    return observations;
  }
}
