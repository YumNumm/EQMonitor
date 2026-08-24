import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';

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

class EarthquakeMapOverlayBuilder {
  const new();

  EarthquakeMapOverlayBuildResult build({
    required Earthquake earthquake,
    required IntensityColors colorModel,
  }) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const EarthquakeMapOverlayUnavailable(
        reason: .noIntensity,
      );
    }
    if (earthquake.telegramMetadata.isEmpty) {
      return const EarthquakeMapOverlayUnavailable(
        reason: .missingTelegramMetadata,
      );
    }
    return EarthquakeMapOverlayAvailable(
      snapshot: createEarthquakeMapOverlaySnapshot(
        sourceId: earthquake.eventId,
        revision: latestEarthquakeOverlayRevision(earthquake),
        regionToCityZoom: 6,
        stationMinZoom: 6,
        regionStyles: earthquakeRegionStyles(
          intensity: intensity,
          colorModel: colorModel,
        ),
        cityStyles: earthquakeCityStyles(
          intensity: intensity,
          colorModel: colorModel,
        ),
        stations: earthquakeObservationPoints(
          intensity: intensity,
          colorModel: colorModel,
        ),
      ),
    );
  }
}

int latestEarthquakeOverlayRevision(Earthquake earthquake) {
  final metadata = earthquake.telegramMetadata;
  var latest = metadata.first.reportedAt.toUtc().microsecondsSinceEpoch;
  for (final item in metadata.skip(1)) {
    final revision = item.reportedAt.toUtc().microsecondsSinceEpoch;
    if (revision > latest) {
      latest = revision;
    }
  }
  return latest;
}

List<EarthquakeAreaStyle> earthquakeRegionStyles({
  required EarthquakeIntensity intensity,
  required IntensityColors colorModel,
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
  return earthquakeAreaStyles(levels: levels, colorModel: colorModel);
}

List<EarthquakeAreaStyle> earthquakeCityStyles({
  required EarthquakeIntensity intensity,
  required IntensityColors colorModel,
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
  return earthquakeAreaStyles(levels: levels, colorModel: colorModel);
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

List<EarthquakeAreaStyle> earthquakeAreaStyles({
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

typedef EarthquakeStationObservation = ({
  EarthquakeParameterStationItem station,
  JmaIntensity intensity,
});

List<EarthquakeObservationPoint> earthquakeObservationPoints({
  required EarthquakeIntensity intensity,
  required IntensityColors colorModel,
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
