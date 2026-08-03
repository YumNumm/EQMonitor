import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_filter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../earthquake_activity_test_data.dart';

void main() {
  final baseTime = DateTime.utc(2026, 7, 1, 12);
  final query = EarthquakeActivityQuery(
    baseEventId: 'base',
    baseOriginTime: baseTime,
    latitude: 35,
    longitude: 139,
    depth: 40,
    beforeDays: 1,
    afterDays: 7,
    radiusKm: 25,
    depthOffsetKm: 20,
  );

  test('矩形内でも半径25km外の地震を除外する', () {
    final inside = testActivityEarthquake(
      eventId: 'inside',
      originTime: baseTime.add(const Duration(hours: 1)),
      latitude: 35.1,
    );
    final outside = testActivityEarthquake(
      eventId: 'outside',
      originTime: baseTime.add(const Duration(hours: 2)),
      latitude: 35.3,
    );

    final result = const EarthquakeActivityFilter().apply(
      query: query,
      candidates: [inside, outside],
      now: baseTime.add(const Duration(days: 8)),
    );

    expect(result.map((item) => item.eventId), ['inside']);
  });

  test('時刻不明・期間外・深さ不明・通常地震以外・基準地震を除外する', () {
    final valid = testActivityEarthquake(
      eventId: 'valid',
      originTime: baseTime.add(const Duration(hours: 1)),
    );
    final result = const EarthquakeActivityFilter().apply(
      query: query,
      candidates: [
        valid,
        testActivityEarthquake(eventId: 'no-time', originTime: null),
        testActivityEarthquake(
          eventId: 'too-early',
          originTime: baseTime.subtract(const Duration(days: 2)),
        ),
        testActivityEarthquake(
          eventId: 'no-depth',
          originTime: baseTime,
          depth: const EarthquakeDepth.unknown(),
        ),
        testActivityEarthquake(
          eventId: 'distant',
          originTime: baseTime,
          earthquakeType: EarthquakeType.distant,
        ),
        testActivityEarthquake(eventId: 'base', originTime: baseTime),
      ],
      now: baseTime.add(const Duration(days: 8)),
    );

    expect(result.map((item) => item.eventId), ['valid']);
  });

  test('重複を除去してoriginTimeの新しい順に並べる', () {
    final older = testActivityEarthquake(
      eventId: 'older',
      originTime: baseTime.subtract(const Duration(hours: 1)),
    );
    final newer = testActivityEarthquake(
      eventId: 'newer',
      originTime: baseTime.add(const Duration(hours: 1)),
    );

    final result = const EarthquakeActivityFilter().apply(
      query: query,
      candidates: [older, newer, older],
      now: baseTime.add(const Duration(days: 8)),
    );

    expect(result.map((item) => item.eventId), ['newer', 'older']);
  });
}
