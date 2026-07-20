import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = EqMonitorRealtimeEventMapper();

  group('EqMonitorRealtimeEventMapper', () {
    test('shake_detection をrevision付き完全snapshotへ変換できること', () {
      final result = mapper.map(
        WsMessage.realtime(
          data: RealtimeEventEnvelope.shakeDetection(
            revision: 42,
            responseAt: DateTime.utc(2026, 7, 18, 12, 34, 56),
            events: [
              WsShakeDetectionEvent(
                type: 'shake_detection',
                eventId: 'shake-1',
                serialNo: 3,
                createdAt: DateTime.utc(2026, 7, 18, 12, 34, 30),
                updatedAt: DateTime.utc(2026, 7, 18, 12, 34, 55),
                expiresAt: DateTime.utc(2026, 7, 18, 12, 35, 35),
                level: 'Strong',
                changeReasons: const ['level_up'],
                mergedEvents: const [],
                pointCount: 12,
                region: const WsShakeRegionPayload(
                  topLeft: WsShakeLocationPayload(latitude: 36, longitude: 139),
                  bottomRight: WsShakeLocationPayload(
                    latitude: 35,
                    longitude: 140,
                  ),
                ),
                points: const [],
                correlatedEew: const WsShakeCorrelatedEew(
                  eventId: 'eew-1',
                  score: 0.8,
                ),
              ),
            ],
          ),
        ),
      );

      final event = result.single as RealtimeShakeSnapshotEvent;
      expect(event.data.revision, 42);
      expect(event.data.events.single.serialNo, 3);
      expect(event.data.events.single.correlatedEewEventId, 'eew-1');
      expect(event.data.events.single.minLat, 35);
      expect(event.data.events.single.maxLng, 140);
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
        datasources: [.jmaDisasterInformationXml],
        telegramTypes: [],
        earthquakeType: .normal,
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

    test('津波 realtime event を upsert イベントに変換できること', () {
      final result = mapper.map(
        const WsMessage.realtime(
          data: RealtimeEventEnvelope.tsunami(
            operation: .upsert,
            eventId: 'tsunami-1',
          ),
        ),
      );

      expect(result.single, isA<RealtimeTsunamiUpsertEvent>());
    });
  });
}
