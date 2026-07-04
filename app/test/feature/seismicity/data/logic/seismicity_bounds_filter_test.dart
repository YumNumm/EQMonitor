import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_bounds_filter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter_test/flutter_test.dart';

SeismicityEvent _event({
  required String eventId,
  required double latitude,
  required double longitude,
}) => SeismicityEvent(
  eventId: eventId,
  originTime: DateTime.utc(2026, 1, 1),
  magnitude: 4,
  depth: 10,
  latitude: latitude,
  longitude: longitude,
  maxIntensity: null,
);

void main() {
  test('矩形範囲内のイベントのみ返す', () {
    const filter = SeismicityBoundsFilter();
    final events = [
      _event(eventId: 'in', latitude: 35, longitude: 139),
      _event(eventId: 'out-lat', latitude: 50, longitude: 139),
      _event(eventId: 'out-lng', latitude: 35, longitude: 160),
      _event(eventId: 'edge', latitude: 30, longitude: 130),
    ];

    final result = filter.filter(
      events: events,
      minLatitude: 30,
      maxLatitude: 40,
      minLongitude: 130,
      maxLongitude: 145,
    );

    expect(result.map((e) => e.eventId), ['in', 'edge']);
  });
}
