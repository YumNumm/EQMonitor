import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
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

@riverpod
EarthquakeMapOverlayBuilder earthquakeMapOverlayBuilder(Ref ref) =>
    const EarthquakeMapOverlayBuilder();

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

LatestEarthquakeOverlayData latestEarthquakeOverlayDataFor({
  required Earthquake earthquake,
  required EarthquakeMapOverlayBuildResult result,
}) => switch (result) {
  EarthquakeMapOverlayAvailable(:final snapshot) => LatestEarthquakeOverlayData(
    eventId: earthquake.eventId,
    originTime: earthquake.originTime,
    telegramStatus: earthquake.status,
    availability: .available,
    overlay: snapshot,
  ),
  EarthquakeMapOverlayUnavailable(:final reason) => LatestEarthquakeOverlayData(
    eventId: earthquake.eventId,
    originTime: earthquake.originTime,
    telegramStatus: earthquake.status,
    availability: switch (reason) {
      EarthquakeMapOverlayUnavailableReason.noIntensity => .noIntensity,
      EarthquakeMapOverlayUnavailableReason.missingTelegramMetadata =>
        .missingTelegramMetadata,
    },
    overlay: null,
  ),
};

@riverpod
class LatestEarthquakeOverlay extends _$LatestEarthquakeOverlay {
  var _generation = 0;

  @override
  Future<LatestEarthquakeOverlayData> build() async {
    final generation = ++_generation;
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
    if (generation != _generation || earthquake.eventId != eventId) {
      return LatestEarthquakeOverlayData(
        eventId: eventId,
        originTime: null,
        telegramStatus: null,
        availability: .superseded,
        overlay: null,
      );
    }
    final overlayBuilder = ref.watch(earthquakeMapOverlayBuilderProvider);
    return latestEarthquakeOverlayDataFor(
      earthquake: earthquake,
      result: overlayBuilder.build(
        earthquake: earthquake,
        colorModel: colorModel,
      ),
    );
  }
}
