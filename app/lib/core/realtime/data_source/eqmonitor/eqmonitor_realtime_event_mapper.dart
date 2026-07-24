import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart'
    show WsMessage, WsPingMessage, WsReadyMessage, WsRealtimeMessage;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_realtime_event_mapper.g.dart';

@Riverpod(keepAlive: true)
EqMonitorRealtimeEventMapper eqMonitorRealtimeEventMapper(Ref ref) =>
    const EqMonitorRealtimeEventMapper();

class EqMonitorRealtimeEventMapper {
  const EqMonitorRealtimeEventMapper();

  List<RealtimeEvent> map(WsMessage message) => switch (message) {
    WsRealtimeMessage(:final data) => switch (data) {
      api.RealtimeEewUpsertEvent(:final payload) => [
        RealtimeEvent.eewUpsert(
          record: payload.record,
          source: RealtimeSource.eqmonitor,
        ),
      ],
      api.RealtimeEarthquakeUpsertEvent(:final payload) => [
        RealtimeEvent.earthquakeUpsert(
          record: payload.record,
          source: RealtimeSource.eqmonitor,
        ),
      ],
      api.RealtimeEarthquakeDeleteEvent(:final payload) => [
        RealtimeEvent.earthquakeDelete(
          eventId: payload.eventId,
          source: RealtimeSource.eqmonitor,
        ),
      ],
      api.RealtimeShakeDetectionSnapshotEvent(:final payload) => [
        RealtimeEvent.shakeSnapshot(
          record: payload,
          source: RealtimeSource.eqmonitor,
        ),
      ],
      api.RealtimeTsunamiUpsertEvent(:final payload) => [
        RealtimeEvent.tsunamiUpsert(
          eventId: payload.eventId,
          groupId: payload.groupId,
          source: RealtimeSource.eqmonitor,
        ),
      ],
      api.RealtimeTsunamiDeleteEvent(:final payload) => [
        RealtimeEvent.tsunamiDelete(
          eventId: payload.eventId,
          groupId: payload.groupId,
          source: RealtimeSource.eqmonitor,
        ),
      ],
      api.RealtimeEstimatedIntensityUpsertEvent(:final payload) => [
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: payload.eventId,
          estimatedIntensityTile: payload.record.estimatedIntensityKey,
          source: RealtimeSource.eqmonitor,
        ),
      ],
    },
    WsPingMessage() => const <RealtimeEvent>[],
    WsReadyMessage() => [
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    ],
  };
}
