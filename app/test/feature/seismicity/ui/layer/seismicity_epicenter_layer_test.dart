import 'dart:convert';

import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SeismicityEpicenterGeoJsonBuilder', () {
    test('イベントの座標と表示プロパティを GeoJSON に変換する', () {
      final geoJson = const SeismicityEpicenterGeoJsonBuilder().build(
        events: [
          SeismicityEvent(
            eventId: 'event-1',
            originTime: DateTime.utc(2026, 7, 20, 9),
            magnitude: 4.2,
            depth: 30,
            latitude: 35.5,
            longitude: 139.7,
            maxIntensity: '4',
          ),
        ],
        now: DateTime.utc(2026, 7, 20, 12),
      );
      final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
      final features = decoded['features'] as List<dynamic>;
      final feature = features.single as Map<String, dynamic>;

      expect((feature['geometry'] as Map<String, dynamic>)['coordinates'], [
        139.7,
        35.5,
      ]);
      expect(feature['properties'], {
        'event_id': 'event-1',
        'magnitude': 4.2,
        'elapsed_hours': 3.0,
      });
    });

    test('イベント更新で同じ source 向けの GeoJSON だけが変化する', () {
      const builder = SeismicityEpicenterGeoJsonBuilder();
      final now = DateTime.utc(2026, 7, 20, 12);
      final first = builder.build(
        events: [_event(eventId: 'first', longitude: 139)],
        now: now,
      );
      final second = builder.build(
        events: [_event(eventId: 'second', longitude: 140)],
        now: now,
      );

      expect(first, isNot(second));
      expect(SeismicityEpicenterLayer.sourceId, 'seismicity-epicenter');
      expect(SeismicityEpicenterLayer.layerId, 'seismicity-epicenter-circle');
    });
  });

  group('SeismicityEpicenterLayer.elapsedHours', () {
    test('originTime から now までの経過時間を時間単位で返す', () {
      final now = DateTime.utc(2026, 7, 4, 12);
      final originTime = DateTime.utc(2026, 7, 1, 12);

      final result = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: now,
      );

      expect(result, 72.0);
    });

    test('ローカルタイムの originTime/now も UTC 換算で計算する', () {
      final now = DateTime.utc(2026, 7, 4).toLocal();
      final originTime = DateTime.utc(2026, 7, 3).toLocal();

      final result = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: now,
      );

      expect(result, 24.0);
    });

    test('now が更新されると経過時間も増加する(定期更新の前提)', () {
      final originTime = DateTime.utc(2026, 7, 1);

      final earlier = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: DateTime.utc(2026, 7, 2),
      );
      final later = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: DateTime.utc(2026, 7, 3),
      );

      expect(later, greaterThan(earlier));
    });
  });
}

SeismicityEvent _event({required String eventId, required double longitude}) =>
    SeismicityEvent(
      eventId: eventId,
      originTime: DateTime.utc(2026, 7, 20, 9),
      magnitude: 3,
      depth: 10,
      latitude: 35,
      longitude: longitude,
      maxIntensity: null,
    );
