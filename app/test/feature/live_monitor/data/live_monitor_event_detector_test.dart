import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_event_detector.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:flutter_test/flutter_test.dart';

final _reportedAt = DateTime.utc(2026, 7, 27);
final _now = DateTime.utc(2026, 7, 27, 12);

EewTelegramItem eew({required String eventId, required int serialNo}) =>
    EewTelegramItem(
      eventId: eventId,
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: serialNo,
      isCanceled: false,
      isLastInfo: false,
      reportTime: _now,
      isPlum: false,
    );

ShakeDetectionEvent shakeEvent({
  required String eventId,
  required int serialNo,
  DateTime? expiresAt,
  String? correlatedEewEventId,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: serialNo,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: expiresAt ?? _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);

ShakeDetectionSnapshot snapshot({
  required int revision,
  required List<ShakeDetectionEvent> events,
}) => ShakeDetectionSnapshot(
  revision: revision,
  responseAt: _now,
  events: events,
);

ShakeDetectionSnapshot visibleSnapshot({
  required int revision,
  required List<ShakeDetectionEvent> events,
}) => snapshot(
  revision: revision,
  events: events
      .where(
        (event) =>
            event.correlatedEewEventId == null &&
            event.expiresAt.toUtc().isAfter(_now),
      )
      .toList(growable: false),
);

Earthquake earthquake({
  required String eventId,
  String? tileUrl,
  List<EarthquakeTelegramMetadata> metadata = const [],
}) => Earthquake(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: _reportedAt,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: _reportedAt,
  dataSources: const [],
  telegramTypes: metadata.map((item) => item.type).toList(growable: false),
  telegramMetadata: metadata,
  hypocenter: null,
  intensity: null,
  estimatedIntensityTileUrl: tileUrl,
);

EarthquakeTelegramMetadata metadata({
  required EarthquakeTelegramType type,
  required int minute,
}) => EarthquakeTelegramMetadata(
  type: type,
  reportedAt: _reportedAt.add(Duration(minutes: minute)),
);

void main() {
  group('LiveMonitorEventDetector', () {
    test('初回EEWは基準化し新eventIdとserial増加だけを返す', () {
      final detector = LiveMonitorEventDetector();

      expect(detector.detectEews([eew(eventId: 'A', serialNo: 1)]), isEmpty);
      expect(
        detector.detectEews([eew(eventId: 'A', serialNo: 2)]).single,
        isA<LiveMonitorEewUpdatedEvent>(),
      );
      expect(
        detector.detectEews([
          eew(eventId: 'A', serialNo: 2),
          eew(eventId: 'B', serialNo: 1),
        ]).single,
        isA<LiveMonitorEewStartedEvent>(),
      );
      expect(detector.detectEews([eew(eventId: 'A', serialNo: 1)]), isEmpty);
    });

    test('snapshot revisionとevent serialの両方で未結合揺れ検知を重複排除する', () {
      final detector = LiveMonitorEventDetector();

      expect(
        detector.detectShakeSnapshot(
          snapshot(
            revision: 10,
            events: [shakeEvent(eventId: 'A', serialNo: 1)],
          ),
        ),
        isEmpty,
      );
      expect(
        detector.detectShakeSnapshot(
          snapshot(
            revision: 10,
            events: [shakeEvent(eventId: 'A', serialNo: 2)],
          ),
        ),
        isEmpty,
      );
      expect(
        detector
            .detectShakeSnapshot(
              snapshot(
                revision: 11,
                events: [shakeEvent(eventId: 'A', serialNo: 2)],
              ),
            )
            .single,
        isA<LiveMonitorShakeDetectedEvent>(),
      );
      expect(
        detector.detectShakeSnapshot(
          snapshot(
            revision: 12,
            events: [shakeEvent(eventId: 'A', serialNo: 1)],
          ),
        ),
        isEmpty,
      );
    });

    test('correlatedまたは期限切れの揺れ検知は入力前の可視条件で除外する', () {
      final detector = LiveMonitorEventDetector();
      detector.detectShakeSnapshot(
        visibleSnapshot(
          revision: 1,
          events: [shakeEvent(eventId: 'baseline', serialNo: 1)],
        ),
      );

      final events = detector.detectShakeSnapshot(
        visibleSnapshot(
          revision: 2,
          events: [
            shakeEvent(eventId: 'visible', serialNo: 1),
            shakeEvent(
              eventId: 'correlated',
              serialNo: 1,
              correlatedEewEventId: 'eew-1',
            ),
            shakeEvent(eventId: 'expired', serialNo: 1, expiresAt: _now),
          ],
        ),
      );

      expect(events.map((event) => event.eventId), ['visible']);
    });

    test('VXSE51/52/53/61/62だけをreportedAt順で検出する', () {
      final detector = LiveMonitorEventDetector();
      detector.seedEarthquake(earthquake(eventId: 'A'));

      final events = detector.detectEarthquake(
        earthquake(
          eventId: 'A',
          metadata: [
            metadata(type: .vxse62, minute: 5),
            metadata(type: .vxse45Warning, minute: 0),
            metadata(type: .vxse53, minute: 3),
            metadata(type: .vxse51, minute: 1),
            metadata(type: .vxse61, minute: 4),
            metadata(type: .vxse45Forecast, minute: 6),
            metadata(type: .vxse52, minute: 2),
          ],
        ),
      );

      expect(events.map((event) => event.trigger.kind), [
        LiveMonitorEarthquakeTriggerKind.vxse51,
        LiveMonitorEarthquakeTriggerKind.vxse52,
        LiveMonitorEarthquakeTriggerKind.vxse53,
        LiveMonitorEarthquakeTriggerKind.vxse61,
        LiveMonitorEarthquakeTriggerKind.vxse62,
      ]);
      expect(detector.detectEarthquake(earthquake(eventId: 'A')), isEmpty);
    });

    test('seed済み電文は無視し同typeの新しいreportedAtだけを検出する', () {
      final detector = LiveMonitorEventDetector();
      detector.seedEarthquake(
        earthquake(
          eventId: 'A',
          metadata: [metadata(type: .vxse62, minute: 1)],
        ),
      );

      final events = detector.detectEarthquake(
        earthquake(
          eventId: 'A',
          metadata: [
            metadata(type: .vxse62, minute: 1),
            metadata(type: .vxse62, minute: 2),
          ],
        ),
      );

      expect(
        events.single.trigger.kind,
        LiveMonitorEarthquakeTriggerKind.vxse62,
      );
      expect(
        (events.single.trigger as LiveMonitorTelegramTrigger).reportedAt,
        _reportedAt.add(const Duration(minutes: 2)),
      );
    });

    test('推計震度はeventId・識別値・full URLで重複排除する', () {
      final detector = LiveMonitorEventDetector()
        ..seedEarthquake(earthquake(eventId: 'A', tileUrl: 'https://tiles/1'));

      expect(
        detector.acceptEstimatedIdentifier(eventId: 'A', identifier: 'tile-1'),
        isTrue,
      );
      expect(
        detector.detectEstimatedIntensity(
          eventId: 'A',
          identifier: 'tile-1',
          generatedAt: null,
          earthquake: earthquake(eventId: 'A', tileUrl: 'https://tiles/1'),
        ),
        isNull,
      );
      expect(
        detector.acceptEstimatedIdentifier(eventId: 'A', identifier: 'tile-2'),
        isTrue,
      );
      expect(
        detector
            .detectEstimatedIntensity(
              eventId: 'A',
              identifier: 'tile-2',
              generatedAt: _reportedAt,
              earthquake: earthquake(eventId: 'A', tileUrl: 'https://tiles/2'),
            )
            ?.trigger
            .kind,
        LiveMonitorEarthquakeTriggerKind.estimatedIntensity,
      );
      expect(
        detector.acceptEstimatedIdentifier(eventId: 'A', identifier: 'tile-2'),
        isFalse,
      );
      expect(
        detector.acceptEstimatedIdentifier(eventId: 'B', identifier: 'tile-2'),
        isTrue,
      );
      expect(
        detector.detectEarthquake(
          earthquake(eventId: 'A', tileUrl: 'https://tiles/2'),
        ),
        isEmpty,
      );
    });

    test('RESTだけのfull URL変更も推計震度として一度だけ検出する', () {
      final detector = LiveMonitorEventDetector()
        ..seedEarthquake(earthquake(eventId: 'A', tileUrl: 'https://tiles/1'));
      final changed = earthquake(eventId: 'A', tileUrl: 'https://tiles/2');

      expect(
        detector.detectEarthquake(changed).single.trigger.kind,
        LiveMonitorEarthquakeTriggerKind.estimatedIntensity,
      );
      expect(detector.detectEarthquake(changed), isEmpty);
    });
  });
}
