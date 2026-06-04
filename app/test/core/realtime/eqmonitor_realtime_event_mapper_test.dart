import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = EqMonitorRealtimeEventMapper();

  group('EqMonitorRealtimeEventMapper', () {
    test('snapshot の揺れ検知範囲を RealtimeShakeData に変換できること', () {
      final result = mapper.map(
        WsMessage.snapshot(
          data: WsSnapshotData(
            revision: 1,
            updatedAt: DateTime.utc(2026),
            shakes: [
              WsSnapshotShakeEntry(
                eventId: 'shake-1',
                createdAt: DateTime.utc(2026, 5, 1, 9),
                level: 'medium',
                isReplay: false,
                pointCount: 12,
                region: const WsShakeRegionPayload(
                  topLeft: WsShakeLocationPayload(
                    latitude: 36,
                    longitude: 139,
                  ),
                  bottomRight: WsShakeLocationPayload(
                    latitude: 35,
                    longitude: 140,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      expect(result, hasLength(1));
      final event = result.single;
      expect(event, isA<RealtimeSnapshotEvent>());
      final snapshot = event as RealtimeSnapshotEvent;
      expect(snapshot.source, RealtimeSource.eqmonitor);
      expect(snapshot.shakes.single.eventId, 'shake-1');
      expect(snapshot.shakes.single.minLat, 35);
      expect(snapshot.shakes.single.maxLat, 36);
      expect(snapshot.shakes.single.minLng, 139);
      expect(snapshot.shakes.single.maxLng, 140);
    });

    test('earthquake delete を削除イベントに変換できること', () {
      final result = mapper.map(
        const WsMessage.realtime(
          data: RealtimeEventEnvelope.earthquake(
            operation: .delete,
            eventId: '20260501090000',
          ),
        ),
      );

      expect(result, hasLength(1));
      final event = result.single;
      expect(event, isA<RealtimeEarthquakeDeleteEvent>());
      final delete = event as RealtimeEarthquakeDeleteEvent;
      expect(delete.eventId, '20260501090000');
      expect(delete.source, RealtimeSource.eqmonitor);
    });

    test('EARTHQUAKE broadcast を地震 upsert イベントに変換できること', () {
      const record = EarthquakePartial(
        eventId: '20260501090000',
        status: .normal,
        originTimePrecision: .second,
        datasource: .jmaDisasterInformationXml,
      );
      final result = mapper.map(
        const WsMessage.realtime(
          data: RealtimeEventEnvelope.earthquakeBroadcast(item: record),
        ),
      );

      expect(result, hasLength(1));
      final event = result.single;
      expect(event, isA<RealtimeEarthquakeUpsertEvent>());
      final upsert = event as RealtimeEarthquakeUpsertEvent;
      expect(upsert.record, record);
      expect(upsert.source, RealtimeSource.eqmonitor);
    });

    test('推計震度イベントのタイル URL を構築できること', () {
      final result = mapper.map(
        WsMessage.realtime(
          data: RealtimeEventEnvelope.estimatedIntensity(
            estimatedIntensity: WsEstimatedIntensityPayload(
              eventId: '20260501090100',
              estimatedIntensityKey: '20260501090100/1.json',
              createdAt: DateTime.utc(2026, 5, 1, 9, 1),
            ),
          ),
        ),
      );

      expect(result, hasLength(1));
      final event = result.single;
      expect(event, isA<RealtimeEstimatedIntensityUpsertEvent>());
      final upsert = event as RealtimeEstimatedIntensityUpsertEvent;
      expect(upsert.eventId, '20260501090100');
      expect(
        upsert.estimatedIntensityTile,
        'https://tiles.eqmonitor.app/20260501090100/1.json',
      );
    });

    test('津波 realtime event は現状未対応として明示的に破棄すること', () {
      final result = mapper.map(
        const WsMessage.realtime(
          data: RealtimeEventEnvelope.tsunami(
            operation: .upsert,
            eventId: 'tsunami-1',
          ),
        ),
      );

      expect(result, isEmpty);
    });
  });
}
