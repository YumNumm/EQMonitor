import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/clock/map_clock_source_identity_provider.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_overlay_digest_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_map_sprite_atlas_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_overlay_source_incarnation_provider.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_latest_earthquake_selector.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_earthquake_overlay_provider.g.dart';

const latestEarthquakeOverlayParameter = EarthquakeHistoryParameter.all(
  sortBy: EarthquakeSortBy.eventId,
  sortOrder: SortOrder.desc,
  intensityGte: JmaIntensity.one,
);

const latestEarthquakeOverlaySpriteAtlasLimits = MapSpriteAtlasLimits(
  maxWidth: 1024,
  maxHeight: 512,
  maxPixelBytes: 1024 * 512 * MapSpriteAtlas.bytesPerPixel,
  maxRegions: 2,
);

@riverpod
EarthquakeMapOverlayBuilder earthquakeMapOverlayBuilder(Ref ref) =>
    const EarthquakeMapOverlayBuilder();

@riverpod
EarthquakeMapOverlayDigestBuilder earthquakeMapOverlayDigestBuilder(Ref ref) =>
    const EarthquakeMapOverlayDigestBuilder();

@Riverpod(retry: EarthquakeMapSpriteAtlasRetryPolicy.noRetry)
Future<MapSpriteAtlas> latestEarthquakeOverlaySpriteAtlas(Ref ref) => ref.watch(
  earthquakeMapSpriteAtlasProvider(
    latestEarthquakeOverlaySpriteAtlasLimits.earthquakeMapSpriteAtlasLimitsKey,
  ).future,
);

@riverpod
Future<EarthquakeHistoryMapLayerParameter>
latestEarthquakeOverlayMapLayerParameter(Ref ref) => ref.watch(
  earthquakeHistoryMapLayerParameterProvider.future,
);

enum LatestEarthquakeOverlayAvailability {
  available,
  noEarthquake,
  noIntensity,
  missingTelegramMetadata,
  superseded,
}

@immutable
final class LatestEarthquakeOverlayData {
  const new({
    required this.eventId,
    required this.originTime,
    required this.telegramStatus,
    required this.availability,
    required this.overlay,
  }) : assert(
         availability == LatestEarthquakeOverlayAvailability.available
             ? overlay != null
             : overlay == null,
       );

  final String? eventId;
  final DateTime? originTime;
  final TelegramStatus? telegramStatus;
  final LatestEarthquakeOverlayAvailability availability;
  final EarthquakeMapOverlaySnapshot? overlay;
}

@riverpod
class LatestEarthquakeOverlay extends _$LatestEarthquakeOverlay {
  final _versionOwner = EarthquakeOverlayVersionOwner();

  @override
  Future<LatestEarthquakeOverlayData> build() async {
    final asyncGenerationOwner = AsyncGenerationOwner();
    ref.onDispose(asyncGenerationOwner.dispose);
    final asyncGeneration = asyncGenerationOwner.begin();
    ref.watch(mapClockSourceIdentityProvider);
    final sourceIncarnation = ref.watch(
      earthquakeOverlaySourceIncarnationProvider,
    );
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final page = await ref.watch(
      earthquakeHistoryProvider(latestEarthquakeOverlayParameter).future,
    );
    final eventId = const LiveMonitorLatestEarthquakeSelector().selectEventId(
      page.items,
    );
    if (eventId == null) {
      return const LatestEarthquakeOverlayData(
        eventId: null,
        originTime: null,
        telegramStatus: null,
        availability: .noEarthquake,
        overlay: null,
      );
    }
    final earthquake = await ref.watch(
      earthquakeHistoryDetailsProvider(eventId).future,
    );
    if (!asyncGeneration.isCurrent || earthquake.eventId != eventId) {
      return LatestEarthquakeOverlayData(
        eventId: eventId,
        originTime: null,
        telegramStatus: null,
        availability: .superseded,
        overlay: null,
      );
    }
    final overlayBuilder = ref.watch(earthquakeMapOverlayBuilderProvider);
    final unavailableReason = overlayBuilder.unavailableReason(earthquake);
    if (unavailableReason != null) {
      return LatestEarthquakeOverlayData(
        eventId: earthquake.eventId,
        originTime: earthquake.originTime,
        telegramStatus: earthquake.status,
        availability: switch (unavailableReason) {
          EarthquakeMapOverlayUnavailableReason.noIntensity => .noIntensity,
          EarthquakeMapOverlayUnavailableReason.missingTelegramMetadata =>
            .missingTelegramMetadata,
        },
        overlay: null,
      );
    }
    final parameter = await ref.watch(
      latestEarthquakeOverlayMapLayerParameterProvider.future,
    );
    final spriteAtlas = await ref.watch(
      latestEarthquakeOverlaySpriteAtlasProvider.future,
    );
    if (!asyncGeneration.isCurrent) {
      return LatestEarthquakeOverlayData(
        eventId: eventId,
        originTime: null,
        telegramStatus: null,
        availability: .superseded,
        overlay: null,
      );
    }
    final intensity = earthquake.intensity as EarthquakeIntensity;
    final regionLevels = overlayBuilder.regionIntensityLevels(
      intensity: intensity,
    );
    final cityLevels = overlayBuilder.cityIntensityLevels(intensity: intensity);
    final stationObservations = overlayBuilder.stationObservations(
      intensity: intensity,
    );
    final regionStyles = overlayBuilder.areaStyles(
      levels: regionLevels,
      colorModel: colorModel,
      opacity: parameter.regionFillOpacity,
    );
    final cityStyles = overlayBuilder.areaStyles(
      levels: cityLevels,
      colorModel: colorModel,
      opacity: parameter.cityFillOpacity,
    );
    final stations = overlayBuilder.observationPoints(
      intensity: intensity,
      colorModel: colorModel,
    );
    final sprites = overlayBuilder.hypocenterSprites(
      earthquake: earthquake,
      parameter: parameter,
    );
    final digestBuilder = ref.watch(earthquakeMapOverlayDigestBuilderProvider);
    final hypocenterInput = digestBuilder.hypocenterInput(earthquake);
    final dataDigest = digestBuilder.buildDataDigest(
      regions: [
        for (final entry in regionLevels.entries)
          (stableId: entry.key, intensityOrder: entry.value.orderIndex),
      ],
      cities: [
        for (final entry in cityLevels.entries)
          (stableId: entry.key, intensityOrder: entry.value.orderIndex),
      ],
      stations: [
        for (final entry in stationObservations.entries)
          (
            stableId: entry.key,
            longitude: entry.value.station.location.lon,
            latitude: entry.value.station.location.lat,
            intensityOrder: entry.value.intensity.orderIndex,
            isMaximum: entry.value.intensity == intensity.maxIntensity,
          ),
      ],
      hypocenterState: hypocenterInput.state,
      hypocenterLongitude: hypocenterInput.longitude,
      hypocenterLatitude: hypocenterInput.latitude,
    );
    final versionCandidate = _versionOwner.preview(
      sourceIdentity: createMapSourceIdentity(value: eventId),
      sourceIncarnation: sourceIncarnation,
      dataDigest: dataDigest,
      renderDigestFor: (dataSequence) => digestBuilder.buildRenderDigest(
        dataSequence: dataSequence,
        dataDigest: dataDigest,
        regionToCityZoom: parameter.regionToCity,
        stationMinZoom: parameter.stationMinZoom,
        regionStyles: regionStyles,
        cityStyles: cityStyles,
        stations: stations,
        spriteAtlas: spriteAtlas,
        sprites: sprites,
      ),
    );
    final result = overlayBuilder.build(
      earthquake: earthquake,
      colorModel: colorModel,
      versionStamp: versionCandidate.versionStamp,
      parameter: parameter,
      spriteAtlas: spriteAtlas,
    );
    switch (result) {
      case EarthquakeMapOverlayAvailable(:final snapshot):
        if (!asyncGeneration.isCurrent) {
          return LatestEarthquakeOverlayData(
            eventId: eventId,
            originTime: null,
            telegramStatus: null,
            availability: .superseded,
            overlay: null,
          );
        }
        _versionOwner.commit(versionCandidate);
        return LatestEarthquakeOverlayData(
          eventId: earthquake.eventId,
          originTime: earthquake.originTime,
          telegramStatus: earthquake.status,
          availability: .available,
          overlay: snapshot,
        );
      case EarthquakeMapOverlayUnavailable(:final reason):
        return LatestEarthquakeOverlayData(
          eventId: earthquake.eventId,
          originTime: earthquake.originTime,
          telegramStatus: earthquake.status,
          availability: switch (reason) {
            EarthquakeMapOverlayUnavailableReason.noIntensity => .noIntensity,
            EarthquakeMapOverlayUnavailableReason.missingTelegramMetadata =>
              .missingTelegramMetadata,
          },
          overlay: null,
        );
    }
  }
}

final class EarthquakeOverlayVersionCandidate {
  new _({
    required EarthquakeOverlayVersionOwner owner,
    required MapOverlayVersionStamp? previous,
    required this.versionStamp,
  }) : _owner = owner,
       _previous = previous;

  final EarthquakeOverlayVersionOwner _owner;
  final MapOverlayVersionStamp? _previous;
  final MapOverlayVersionStamp versionStamp;
  bool _committed = false;
}

final class EarthquakeOverlayVersionOwner {
  MapOverlayVersionStamp? _current;

  EarthquakeOverlayVersionCandidate preview({
    required MapSourceIdentity sourceIdentity,
    required MapSourceIncarnation sourceIncarnation,
    required String dataDigest,
    required String Function(int dataSequence) renderDigestFor,
  }) {
    final current = _current;
    final isSameSource =
        current != null &&
        current.sourceIdentity == sourceIdentity &&
        current.sourceIncarnation == sourceIncarnation;
    final dataSequence = !isSameSource
        ? 0
        : current.dataDigest == dataDigest
        ? current.dataSequence
        : current.dataSequence + 1;
    final renderDigest = renderDigestFor(dataSequence);
    final renderGeneration = !isSameSource
        ? 0
        : current.renderDigest == renderDigest
        ? current.renderGeneration
        : current.renderGeneration + 1;
    final next = createMapOverlayVersionStamp(
      sourceIdentity: sourceIdentity,
      sourceIncarnation: sourceIncarnation,
      dataSequence: dataSequence,
      dataDigest: dataDigest,
      renderGeneration: renderGeneration,
      renderDigest: renderDigest,
    );
    if (current != null &&
        !canAdvanceMapOverlayVersionStamp(current: current, next: next)) {
      throw StateError('Invalid earthquake overlay version transition.');
    }
    return EarthquakeOverlayVersionCandidate._(
      owner: this,
      previous: current,
      versionStamp: next,
    );
  }

  void commit(EarthquakeOverlayVersionCandidate candidate) {
    if (!identical(candidate._owner, this)) {
      throw ArgumentError.value(candidate, 'candidate', 'belongs to owner');
    }
    if (candidate._committed || !identical(_current, candidate._previous)) {
      throw StateError('Stale earthquake overlay version candidate.');
    }
    _current = candidate.versionStamp;
    candidate._committed = true;
  }
}
