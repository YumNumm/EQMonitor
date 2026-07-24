import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart' show WsMessage;
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = EqMonitorRealtimeEventMapper();

  group('EqMonitorRealtimeEventMapper', () {
    test('shake_detection の完全snapshotを同一recordのまま保持すること', () {
      final record = _shakeSnapshot();
      final result = mapper.map(
        WsMessage.realtime(
          data: api.RealtimeShakeDetectionSnapshotEvent(
            api.RealtimeShakeDetectionSnapshotPayload(
              type: api.Type3.shakeDetection,
              operation: api.Operation3.snapshot,
              record: record,
            ),
          ),
        ),
      );

      final event = result.single as RealtimeShakeSnapshotEvent;
      expect(identical(event.record, record), isTrue);
      expect(event.record.events.single.points.single.code, 'point-1');
      expect(
        event.record.events.single.mergedEvents.single.eventId,
        'merged-1',
      );
    });

    test('earthquake delete を削除イベントに変換できること', () {
      final result = mapper.map(
        const WsMessage.realtime(
          data: api.RealtimeEarthquakeDeleteEvent(
            api.RealtimeEarthquakeDeletePayload(
              type: api.Type.earthquake,
              operation: api.Operation2.delete,
              eventId: '20260501090000',
            ),
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

    test('earthquake upsert の完全recordとtelegram commentを保持すること', () {
      final record = _earthquake();
      final result = mapper.map(
        WsMessage.realtime(
          data: api.RealtimeEarthquakeUpsertEvent(
            api.RealtimeEarthquakeUpsertPayload(
              type: api.Type.earthquake,
              operation: api.Operation.upsert,
              eventId: record.eventId,
              record: record,
            ),
          ),
        ),
      );

      final event = result.single as RealtimeEarthquakeUpsertEvent;
      expect(identical(event.record, record), isTrue);
      expect(event.record.telegrams.single.comments?.additional, '津波に注意');
    });

    test('EEW upsert の完全recordとwarning zoneを保持すること', () {
      final record = _eew(serialNo: 2);
      final result = mapper.map(
        WsMessage.realtime(
          data: api.RealtimeEewUpsertEvent(
            api.RealtimeEewUpsertPayload(
              type: api.Type2.eew,
              operation: api.Operation.upsert,
              eventId: record.eventId,
              record: record,
            ),
          ),
        ),
      );

      final event = result.single as RealtimeEewUpsertEvent;
      expect(identical(event.record, record), isTrue);
      expect(event.record.warning?.zones.single.code, '9011');
    });
  });
}

api.Earthquake _earthquake() => api.Earthquake(
  eventId: '20260501090000',
  status: api.TelegramStatus.normal,
  originTimePrecision: api.OriginTimePrecision.second,
  datasources: const [api.EarthquakeDatasource.jmaDisasterInformationXml],
  telegrams: [
    api.EarthquakeTelegram(
      telegram: api.Telegram(
        id: 'telegram-1',
        eventId: '20260501090000',
        type: api.TelegramType.vxse53,
        title: '震源・震度情報',
        status: api.TelegramStatus.normal,
        infoType: api.InfoType.publication,
        editorialOffice: '気象庁本庁',
        publishingOffice: const ['気象庁'],
        pressedAt: DateTime.utc(2026, 5, 1, 9),
        reportedAt: DateTime.utc(2026, 5, 1, 9),
        infoKind: '地震情報',
        infoKindVersion: '1.0_0',
        hash: 'hash',
        createdAt: DateTime.utc(2026, 5, 1, 9),
      ),
      comments: const api.TelegramComments(additional: '津波に注意'),
    ),
  ],
);

api.EewItemWithRelations _eew({required int serialNo}) =>
    api.EewItemWithRelations(
      eventId: '20260501090000',
      type: api.TelegramType.vxse45,
      status: api.TelegramStatus.normal,
      infoType: api.InfoType.publication,
      serialNo: serialNo,
      headline: null,
      isCanceled: false,
      isWarning: true,
      isLastInfo: false,
      originTime: null,
      arrivalTime: null,
      accuracy: null,
      isPlum: false,
      editorialOffice: '気象庁',
      reportTime: DateTime.utc(2026, 5, 1, 9),
      warning: const api.EewWarning(
        zones: [
          api.EewWarningZoneItem(
            code: '9011',
            name: '北海道道央',
            hadWarning: false,
          ),
        ],
        prefectures: [],
        regions: [],
      ),
    );

api.ShakeDetectionActiveSnapshot _shakeSnapshot() =>
    api.ShakeDetectionActiveSnapshot(
      type: 'shake_detection',
      revision: 42,
      responseAt: DateTime.utc(2026, 7, 18, 12, 34, 56),
      events: [
        api.ShakeDetectionActiveEvent(
          type: 'shake_detection',
          eventId: 'shake-1',
          serialNo: 3,
          createdAt: DateTime.utc(2026, 7, 18, 12, 34, 30),
          updatedAt: DateTime.utc(2026, 7, 18, 12, 34, 55),
          expiresAt: DateTime.utc(2026, 7, 18, 12, 35, 35),
          level: api.Level.strong,
          changeReasons: const [api.ChangeReasons.levelUp],
          mergedEvents: [
            api.MergedEvents(
              eventId: 'merged-1',
              mergedAt: DateTime.utc(2026, 7, 18, 12, 34, 50),
            ),
          ],
          pointCount: 1,
          region: const api.Region(
            topLeft: api.TopLeft(latitude: 36, longitude: 139),
            bottomRight: api.BottomRight(latitude: 35, longitude: 140),
          ),
          points: const [
            api.Points(
              code: 'point-1',
              name: '観測点1',
              region: '東京都',
              type: 'K-NET',
              location: api.Location(latitude: 35.5, longitude: 139.5),
              intensity: 3.2,
            ),
          ],
        ),
      ],
    );
