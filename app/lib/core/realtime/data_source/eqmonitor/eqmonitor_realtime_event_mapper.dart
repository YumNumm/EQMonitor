import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
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
    WsSnapshotMessage(:final data) => [
      RealtimeEvent.snapshot(
        eews: data.eews,
        earthquakes: data.earthquakes,
        shakes: data.shakes.map(mapSnapshotShakeEntry).toList(),
        source: RealtimeSource.eqmonitor,
      ),
    ],
    WsRealtimeMessage(:final data) => switch (data) {
      WsEewRealtimeEvent(:final item) => [
        RealtimeEvent.eewUpsert(item: item, source: RealtimeSource.eqmonitor),
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
      WsShakeDetectedRealtimeEvent(
        :final eventId,
        :final createdAt,
        :final level,
        :final changeReasons,
        :final isReplay,
        :final pointCount,
        :final region,
      ) =>
        [
          RealtimeEvent.shakeDetected(
            data: RealtimeShakeData(
              eventId: eventId,
              createdAt: createdAt,
              level: level,
              isReplay: isReplay,
              pointCount: pointCount,
              minLat: region.bottomRight.latitude,
              maxLat: region.topLeft.latitude,
              minLng: region.topLeft.longitude,
              maxLng: region.bottomRight.longitude,
              changeReasons: changeReasons,
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
      _ => const <RealtimeEvent>[],
    },
    WsPingMessage() => const <RealtimeEvent>[],
  };

  RealtimeShakeData mapSnapshotShakeEntry(WsSnapshotShakeEntry entry) =>
      RealtimeShakeData(
        eventId: entry.eventId,
        createdAt: entry.createdAt,
        level: entry.level,
        isReplay: entry.isReplay,
        pointCount: entry.pointCount,
        minLat: entry.region.bottomRight.latitude,
        maxLat: entry.region.topLeft.latitude,
        minLng: entry.region.topLeft.longitude,
        maxLng: entry.region.bottomRight.longitude,
        changeReasons: entry.changeReasons,
      );
}
