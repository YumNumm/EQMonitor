import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_sprite_atlas_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';

const earthquakeOverlayRegionToCityZoom = 6.0;
const earthquakeOverlayStationMinZoom = 6.0;
const earthquakeOverlayMaxSpritePolicyBatches = 1;

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
    required EarthquakeHistoryMapLayerParameter parameter,
    required MapSpriteAtlas spriteAtlas,
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
        regionToCityZoom: parameter.regionToCity,
        stationMinZoom: parameter.stationMinZoom,
        regionStyles: regionStyles(
          intensity: intensity,
          colorModel: colorModel,
          opacity: parameter.regionFillOpacity,
        ),
        cityStyles: cityStyles(
          intensity: intensity,
          colorModel: colorModel,
          opacity: parameter.cityFillOpacity,
        ),
        stations: observationPoints(
          intensity: intensity,
          colorModel: colorModel,
        ),
        spriteAtlas: spriteAtlas,
        sprites: hypocenterSprites(
          earthquake: earthquake,
          parameter: parameter,
        ),
        maxSpritePolicyBatches: earthquakeOverlayMaxSpritePolicyBatches,
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
    required double opacity,
  }) => areaStyles(
    levels: regionIntensityLevels(intensity: intensity),
    colorModel: colorModel,
    opacity: opacity,
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
    required double opacity,
  }) => areaStyles(
    levels: cityIntensityLevels(intensity: intensity),
    colorModel: colorModel,
    opacity: opacity,
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
    required double opacity,
  }) {
    final entries = levels.entries.toList()
      ..sort((first, second) => first.key.compareTo(second.key));
    return [
      for (final entry in entries)
        EarthquakeAreaStyle(
          code: entry.key,
          color: colorModel.fromJmaIntensity(entry.value).background,
          opacity: opacity,
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

  List<MapPointSpriteFeature> hypocenterSprites({
    required Earthquake earthquake,
    required EarthquakeHistoryMapLayerParameter parameter,
  }) {
    final coordinates = earthquake.hypocenter?.coordinates;
    if (coordinates case CoordinateLatLng(:final longitude, :final latitude)
        when longitude.isFinite &&
            longitude >= -180 &&
            longitude <= 180 &&
            latitude.isFinite &&
            latitude >= -90 &&
            latitude <= 90) {
      return [
        createMapPointSpriteFeature(
          id: 'hypocenter:${earthquake.eventId}',
          longitude: longitude,
          latitude: latitude,
          spriteRegionId: earthquakeMapNormalSpriteRegionId,
          sizeScale: createMapZoomLinearRange(
            startZoom: 3,
            startValue: parameter.hypocenterIconSizeMin,
            endZoom: 20,
            endValue: parameter.hypocenterIconSizeMax,
          ),
          opacity: createMapZoomStep(
            thresholdZoom: parameter.hypocenterFadeZoom,
            belowValue: 1,
            atOrAboveValue: parameter.hypocenterFadeOpacity,
          ),
          priority: 0,
        ),
      ];
    }
    return const [];
  }
}
