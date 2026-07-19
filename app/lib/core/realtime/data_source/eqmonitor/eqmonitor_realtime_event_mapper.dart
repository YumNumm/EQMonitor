import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_snapshot.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_realtime_event_mapper.g.dart';

@Riverpod(keepAlive: true)
EqMonitorRealtimeEventMapper eqMonitorRealtimeEventMapper(Ref ref) =>
    const EqMonitorRealtimeEventMapper();

class EqMonitorRealtimeEventMapper {
  const EqMonitorRealtimeEventMapper();

  static const tilesBaseUrl = 'https://tiles.eqmonitor.app';

  List<RealtimeEvent> map(WsMessage message) => switch (message) {
    WsSnapshotMessage() => const <RealtimeEvent>[],
    WsRealtimeMessage(:final data) => switch (data) {
      WsEewRealtimeEvent(:final item) => [
        RealtimeEvent.eewUpsert(item: item, source: RealtimeSource.eqmonitor),
      ],
      WsEarthquakeBroadcastEvent(:final item) => [
        RealtimeEvent.earthquakeUpsert(
          record: item,
          source: RealtimeSource.eqmonitor,
        ),
      ],
      WsEarthquakeRealtimeEvent(
        :final operation,
        :final eventId,
        :final record,
      ) =>
        switch (operation) {
          WsRealtimeOperation.upsert when record != null => [
            RealtimeEvent.earthquakeUpsert(
              record: record,
              source: RealtimeSource.eqmonitor,
            ),
          ],
          WsRealtimeOperation.delete => [
            RealtimeEvent.earthquakeDelete(
              eventId: eventId,
              source: RealtimeSource.eqmonitor,
            ),
          ],
          _ => const <RealtimeEvent>[],
        },
      WsTsunamiRealtimeEvent(
        :final operation,
        :final eventId,
        :final groupId,
      ) =>
        switch (operation) {
          WsRealtimeOperation.upsert => [
            RealtimeEvent.tsunamiUpsert(
              eventId: eventId,
              groupId: groupId,
              source: RealtimeSource.eqmonitor,
            ),
          ],
          WsRealtimeOperation.delete => [
            RealtimeEvent.tsunamiDelete(
              eventId: eventId,
              groupId: groupId,
              source: RealtimeSource.eqmonitor,
            ),
          ],
        },
      WsShakeDetectionRealtimeEvent(
        :final revision,
        :final responseAt,
        :final events,
      ) =>
        [
          RealtimeEvent.shakeSnapshot(
            data: RealtimeShakeSnapshot(
              revision: revision,
              responseAt: responseAt,
              events: events
                  .map(
                    (event) => RealtimeShakeEventData(
                      eventId: event.eventId,
                      serialNo: event.serialNo,
                      createdAt: event.createdAt,
                      updatedAt: event.updatedAt,
                      expiresAt: event.expiresAt,
                      level: event.level,
                      pointCount: event.pointCount,
                      minLat: event.region.bottomRight.latitude,
                      maxLat: event.region.topLeft.latitude,
                      minLng: event.region.topLeft.longitude,
                      maxLng: event.region.bottomRight.longitude,
                      changeReasons: event.changeReasons,
                      correlatedEewEventId: event.correlatedEew?.eventId,
                    ),
                  )
                  .toList(growable: false),
            ),
            source: RealtimeSource.eqmonitor,
          ),
        ],
      WsEstimatedIntensityRealtimeEvent(:final estimatedIntensity) => [
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: estimatedIntensity.eventId,
          estimatedIntensityTile:
              '$tilesBaseUrl/${estimatedIntensity.estimatedIntensityKey}',
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
