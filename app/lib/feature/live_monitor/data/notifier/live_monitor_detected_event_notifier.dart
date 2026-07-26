import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_event_detector.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/live_monitor/data/provider/live_monitor_latest_earthquake_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_detected_event_notifier.g.dart';

typedef LiveMonitorPendingEstimatedIntensity = ({
  String eventId,
  String identifier,
  DateTime? generatedAt,
});

@riverpod
class LiveMonitorDetectedEventNotifier
    extends _$LiveMonitorDetectedEventNotifier {
  final detector = LiveMonitorEventDetector();
  final pendingRealtimeEvents = <RealtimeEvent>[];
  final pendingEstimatedEvents = <LiveMonitorPendingEstimatedIntensity>[];
  var sequence = 0;
  var initialized = false;
  var isDrainingRealtimeEvents = false;
  var shouldResynchronize = false;

  @override
  Future<LiveMonitorEventEnvelope?> build() async {
    listenRealtimeEvents();
    await initializeBaselines();
    if (!ref.mounted) {
      return null;
    }
    listenCanonicalSources();
    return state.value;
  }

  void listenRealtimeEvents() {
    ref.listen(realtimeEventsProvider, (_, next) async {
      final event = next.value;
      if (event == null) {
        return;
      }
      pendingRealtimeEvents.add(event);
      if (initialized) {
        await drainRealtimeEvents();
      }
    });
  }

  void listenCanonicalSources() {
    ref
      ..listen(eewAliveTelegramProvider, (_, next) {
        if (next != null) {
          acceptEewState(next);
        }
      })
      ..listen(shakeDetectionAcceptedSnapshotProvider, (_, next) {
        if (next != null) {
          acceptShakeSnapshot(next);
        }
      })
      ..listen(appLifecycleProvider, (_, next) async {
        if (next == AppLifecycleState.resumed) {
          await resynchronizeEarthquakes();
        }
      });
  }

  Future<void> initializeBaselines() async {
    final earthquakeBaselines = <Earthquake>[];
    final page = await ref.read(
      earthquakeHistoryProvider(liveMonitorLatestParameter).future,
    );
    if (!ref.mounted) {
      return;
    }
    for (final item in page.items) {
      final earthquake = await loadEarthquakeDetail(
        eventId: item.earthquake.eventId,
        invalidate: false,
      );
      if (!ref.mounted) {
        return;
      }
      if (earthquake != null) {
        earthquakeBaselines.add(earthquake);
      }
    }

    final eews = ref.read(eewAliveTelegramProvider);
    if (eews != null) {
      detector.detectEews(eews);
    }
    final shakeSnapshot = ref.read(shakeDetectionAcceptedSnapshotProvider);
    if (shakeSnapshot != null) {
      detector.detectShakeSnapshot(visibleShakeSnapshot(shakeSnapshot));
    }
    await drainRealtimeEvents(
      initialEarthquakeBaselines: earthquakeBaselines,
      completeInitialization: true,
    );
  }

  Future<void> drainRealtimeEvents({
    List<Earthquake> initialEarthquakeBaselines = const [],
    bool completeInitialization = false,
  }) async {
    if (isDrainingRealtimeEvents) {
      return;
    }
    isDrainingRealtimeEvents = true;
    var shouldApplyInitialBaselines = completeInitialization;
    try {
      do {
        while (pendingRealtimeEvents.isNotEmpty && ref.mounted) {
          final event = pendingRealtimeEvents.removeAt(0);
          try {
            await acceptRealtimeEvent(event);
          } catch (error, stackTrace) {
            talker.error(
              '[LiveMonitor] failed to process realtime event',
              error,
              stackTrace,
            );
          }
          final nextIsReady =
              pendingRealtimeEvents.isNotEmpty &&
              pendingRealtimeEvents.first is RealtimeReadyEvent;
          if (initialized && shouldResynchronize && !nextIsReady) {
            shouldResynchronize = false;
            await resynchronizeEarthquakes();
          }
        }
        if (shouldApplyInitialBaselines) {
          // detail取得中に届いたrawを先に確定し、後着REST baselineへの吸収を防ぐ。
          for (final earthquake in initialEarthquakeBaselines) {
            detector.seedEarthquake(earthquake);
          }
          initialized = true;
          shouldApplyInitialBaselines = false;
        }
        if (initialized && shouldResynchronize) {
          shouldResynchronize = false;
          await resynchronizeEarthquakes();
        }
      } while (ref.mounted &&
          (pendingRealtimeEvents.isNotEmpty ||
              (initialized && shouldResynchronize)));
    } finally {
      isDrainingRealtimeEvents = false;
    }
  }

  void acceptEewState(List<EewTelegramItem> eews) {
    for (final event in detector.detectEews(eews)) {
      publish(event);
    }
  }

  void acceptShakeSnapshot(ShakeDetectionSnapshot snapshot) {
    for (final event in detector.detectShakeSnapshot(
      visibleShakeSnapshot(snapshot),
    )) {
      publish(event);
    }
  }

  ShakeDetectionSnapshot visibleShakeSnapshot(ShakeDetectionSnapshot snapshot) {
    final now = ref.read(appClockProvider.notifier).now().toUtc();
    return snapshot.copyWith(
      events: snapshot.events
          .where(
            (event) =>
                event.correlatedEewEventId == null &&
                event.expiresAt.toUtc().isAfter(now),
          )
          .toList(growable: false),
    );
  }

  Future<void> acceptRealtimeEvent(RealtimeEvent event) async {
    switch (event) {
      case RealtimeReadyEvent():
        shouldResynchronize = true;
        return;
      case RealtimeEarthquakeUpsertEvent(:final record):
        final repository = await ref.read(
          earthquakeHistoryRepositoryProvider.future,
        );
        if (!ref.mounted) {
          return;
        }
        acceptEarthquake(
          earthquakeFromRealtimeRecord(record: record, repository: repository),
        );
      case RealtimeEarthquakeDeleteEvent(:final eventId):
        publish(LiveMonitorDetectedEvent.earthquakeDeleted(eventId: eventId));
      case RealtimeEstimatedIntensityUpsertEvent(
        :final eventId,
        estimatedIntensityTile: final identifier,
        :final generatedAt,
      ):
        if (detector.acceptEstimatedIdentifier(
          eventId: eventId,
          identifier: identifier,
        )) {
          pendingEstimatedEvents.add((
            eventId: eventId,
            identifier: identifier,
            generatedAt: generatedAt,
          ));
        }
        await resolvePendingEstimatedIntensity(eventId: eventId);
      case RealtimeEewUpsertEvent() ||
          RealtimeShakeSnapshotEvent() ||
          RealtimeTsunamiUpsertEvent() ||
          RealtimeTsunamiDeleteEvent():
        return;
    }
  }

  Future<void> synchronizeEarthquakes() async {
    final pageProvider = earthquakeHistoryProvider(liveMonitorLatestParameter);
    ref.invalidate(pageProvider, asReload: true);
    final page = await ref.read(pageProvider.future);
    if (!ref.mounted) {
      return;
    }
    for (final item in page.items) {
      final earthquake = await loadEarthquakeDetail(
        eventId: item.earthquake.eventId,
        invalidate: true,
      );
      if (!ref.mounted) {
        return;
      }
      if (earthquake != null) {
        acceptEarthquake(earthquake);
      }
    }
  }

  Future<void> resynchronizeEarthquakes() async {
    try {
      await resolvePendingEstimatedIntensity();
      if (!ref.mounted) {
        return;
      }
      await synchronizeEarthquakes();
    } catch (error, stackTrace) {
      talker.error(
        '[LiveMonitor] failed to resynchronize earthquakes',
        error,
        stackTrace,
      );
    }
  }

  Future<void> resolvePendingEstimatedIntensity({String? eventId}) async {
    final pending = pendingEstimatedEvents
        .where((event) => eventId == null || event.eventId == eventId)
        .toList(growable: false);
    for (final event in pending) {
      await resolvePendingEstimatedEvent(event);
      if (!ref.mounted) {
        return;
      }
    }
  }

  Future<bool> resolvePendingEstimatedEvent(
    LiveMonitorPendingEstimatedIntensity event,
  ) async {
    final earthquake = await loadEarthquakeDetail(
      eventId: event.eventId,
      invalidate: true,
    );
    if (!ref.mounted) {
      return false;
    }
    final fullUrl = earthquake?.estimatedIntensityTileUrl;
    if (earthquake == null ||
        fullUrl == null ||
        !liveMonitorEstimatedIntensityUrlMatchesIdentifier(
          fullUrl: fullUrl,
          identifier: event.identifier,
        )) {
      return false;
    }
    final matchedIndex = pendingEstimatedEvents.indexOf(event);
    if (matchedIndex < 0) {
      return false;
    }
    final superseded = pendingEstimatedEvents
        .take(matchedIndex + 1)
        .where((candidate) => candidate.eventId == event.eventId)
        .toSet();
    pendingEstimatedEvents.removeWhere(superseded.contains);
    final detected = detector.detectEstimatedIntensity(
      eventId: event.eventId,
      identifier: event.identifier,
      generatedAt: event.generatedAt,
      earthquake: earthquake,
    );
    if (detected != null) {
      publish(detected);
    }
    return true;
  }

  Future<Earthquake?> loadEarthquakeDetail({
    required String eventId,
    required bool invalidate,
  }) async {
    final provider = earthquakeHistoryDetailsProvider(eventId);
    if (invalidate) {
      ref.invalidate(provider, asReload: true);
    }
    try {
      return await ref.read(provider.future);
    } catch (error, stackTrace) {
      talker.error(
        '[LiveMonitor] failed to load earthquake detail: $eventId',
        error,
        stackTrace,
      );
      return null;
    }
  }

  void acceptEarthquake(Earthquake earthquake) {
    for (final event in detector.detectEarthquake(earthquake)) {
      publish(event);
    }
  }

  void publish(LiveMonitorDetectedEvent event) {
    if (!ref.mounted) {
      return;
    }
    state = AsyncData(
      LiveMonitorEventEnvelope(sequence: ++sequence, event: event),
    );
  }
}
