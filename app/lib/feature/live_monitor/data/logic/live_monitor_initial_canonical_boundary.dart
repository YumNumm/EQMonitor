import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';

typedef LiveMonitorCanonicalEventIdentity = ({String eventId, int serialNo});

class LiveMonitorInitialCanonicalBoundary {
  final _rawEewIdentities = <LiveMonitorCanonicalEventIdentity>{};
  final _rawShakeIdentities = <int, Set<LiveMonitorCanonicalEventIdentity>>{};

  void record(RealtimeEvent event) {
    switch (event) {
      case RealtimeEewUpsertEvent(:final record):
        _rawEewIdentities.add((
          eventId: record.eventId,
          serialNo: record.serialNo.toInt(),
        ));
      case RealtimeShakeSnapshotEvent(:final record):
        _rawShakeIdentities
            .putIfAbsent(record.revision, () => {})
            .addAll(
              record.events.map(
                (event) => (eventId: event.eventId, serialNo: event.serialNo),
              ),
            );
      case RealtimeReadyEvent() ||
          RealtimeEarthquakeUpsertEvent() ||
          RealtimeEarthquakeDeleteEvent() ||
          RealtimeTsunamiUpsertEvent() ||
          RealtimeTsunamiDeleteEvent() ||
          RealtimeEstimatedIntensityUpsertEvent():
        return;
    }
  }

  List<EewTelegramItem> eewBaseline(List<EewTelegramItem> canonical) {
    final baseline = canonical
        .where(
          (eew) => !_rawEewIdentities.contains((
            eventId: eew.eventId,
            serialNo: eew.serialNo,
          )),
        )
        .toList(growable: false);
    _rawEewIdentities.clear();
    return baseline;
  }

  ShakeDetectionSnapshot shakeBaseline(ShakeDetectionSnapshot canonical) {
    final rawIdentities = _rawShakeIdentities[canonical.revision];
    _rawShakeIdentities.clear();
    if (rawIdentities == null || rawIdentities.isEmpty) {
      return canonical;
    }
    final baselineEvents = canonical.events
        .where(
          (event) => !rawIdentities.contains((
            eventId: event.eventId,
            serialNo: event.serialNo,
          )),
        )
        .toList(growable: false);
    if (baselineEvents.length == canonical.events.length) {
      return canonical;
    }
    return canonical.copyWith(
      revision: canonical.revision - 1,
      events: baselineEvents,
    );
  }
}
