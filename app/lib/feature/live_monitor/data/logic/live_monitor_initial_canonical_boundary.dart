import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';

typedef LiveMonitorCanonicalEventIdentity = ({String eventId, int serialNo});

class LiveMonitorInitialCanonicalBoundary {
  final _rawEewIdentities = <LiveMonitorCanonicalEventIdentity>{};

  void record(RealtimeEvent event) {
    switch (event) {
      case RealtimeEewUpsertEvent(:final record):
        _rawEewIdentities.add((
          eventId: record.eventId,
          serialNo: record.serialNo.toInt(),
        ));
      case RealtimeReadyEvent() ||
          RealtimeEarthquakeUpsertEvent() ||
          RealtimeEarthquakeDeleteEvent() ||
          RealtimeTsunamiUpsertEvent() ||
          RealtimeTsunamiDeleteEvent() ||
          RealtimeShakeSnapshotEvent() ||
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
}
