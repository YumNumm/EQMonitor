import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_depth_projection.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('緯度軸投影は latitude を axisValue にする', () {
    const projection = SeismicityDepthProjection();
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 30,
        latitude: 35.5,
        longitude: 139.5,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'no-depth',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 3,
        depth: null,
        latitude: 36,
        longitude: 140,
        maxIntensity: null,
      ),
    ];

    final points = projection.project(
      events: events,
      axis: SeismicityDepthProjectionAxis.latitude,
    );

    expect(points.length, 1);
    expect(points.single.axisValue, 35.5);
    expect(points.single.depth, 30);
    expect(points.single.eventId, 'a');
  });

  test('経度軸投影は longitude を axisValue にする', () {
    const projection = SeismicityDepthProjection();
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 30,
        latitude: 35.5,
        longitude: 139.5,
        maxIntensity: null,
      ),
    ];

    final points = projection.project(
      events: events,
      axis: SeismicityDepthProjectionAxis.longitude,
    );

    expect(points.single.axisValue, 139.5);
  });
}
