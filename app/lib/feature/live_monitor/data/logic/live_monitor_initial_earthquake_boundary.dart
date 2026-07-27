import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_event_detector.dart';

typedef LiveMonitorTelegramIdentity = ({
  String eventId,
  EarthquakeTelegramType type,
  DateTime reportedAt,
});

class LiveMonitorInitialEarthquakeBoundary {
  final Set<LiveMonitorTelegramIdentity> realtimeTelegrams = {};
  final Set<(String, String)> realtimeEstimatedIdentifiers = {};

  void record(RealtimeEvent event) {
    switch (event) {
      case RealtimeEarthquakeUpsertEvent(:final record):
        final supported = record.telegrams
            .map((entry) {
              final type = entry.telegram.type.toEarthquakeTelegramTypeOrNull;
              return type == null
                  ? null
                  : (
                      eventId: record.eventId,
                      type: type,
                      reportedAt: entry.telegram.reportedAt,
                    );
            })
            .whereType<LiveMonitorTelegramIdentity>()
            .toList(growable: false);
        if (supported.isEmpty) {
          return;
        }
        final latest = supported.reduce(
          (left, right) =>
              left.reportedAt.isAfter(right.reportedAt) ? left : right,
        );
        realtimeTelegrams.add(latest);
      case RealtimeEstimatedIntensityUpsertEvent(
        :final eventId,
        estimatedIntensityTile: final identifier,
      ):
        realtimeEstimatedIdentifiers.add((eventId, identifier));
      case RealtimeReadyEvent() ||
          RealtimeEewUpsertEvent() ||
          RealtimeEarthquakeDeleteEvent() ||
          RealtimeTsunamiUpsertEvent() ||
          RealtimeTsunamiDeleteEvent() ||
          RealtimeShakeSnapshotEvent():
        return;
    }
  }

  Earthquake baselineSnapshot(Earthquake earthquake) {
    final estimatedIntensityTileUrl = earthquake.estimatedIntensityTileUrl;
    final hasRealtimeEstimatedArrival =
        estimatedIntensityTileUrl != null &&
        realtimeEstimatedIdentifiers.any(
          (arrival) =>
              arrival.$1 == earthquake.eventId &&
              liveMonitorEstimatedIntensityUrlMatchesIdentifier(
                fullUrl: estimatedIntensityTileUrl,
                identifier: arrival.$2,
              ),
        );
    return earthquake.copyWith(
      telegramMetadata: earthquake.telegramMetadata
          .where(
            (metadata) => !realtimeTelegrams.contains((
              eventId: earthquake.eventId,
              type: metadata.type,
              reportedAt: metadata.reportedAt,
            )),
          )
          .toList(growable: false),
      estimatedIntensityTileUrl: hasRealtimeEstimatedArrival
          ? null
          : estimatedIntensityTileUrl,
    );
  }
}
