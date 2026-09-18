import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sizeScale = createMapZoomLinearRange(
    startZoom: 3,
    startValue: 0.15,
    endZoom: 20,
    endValue: 0.4,
  );
  final opacity = createMapZoomStep(
    thresholdZoom: 8,
    belowValue: 1,
    atOrAboveValue: 0.6,
  );

  MapPointSpriteFeature feature({
    String id = 'hypocenter:event-a',
    double longitude = 139.6917,
    double latitude = 35.6895,
    String spriteRegionId = 'normal',
    int priority = 10,
  }) => createMapPointSpriteFeature(
    id: id,
    longitude: longitude,
    latitude: latitude,
    spriteRegionId: spriteRegionId,
    sizeScale: sizeScale,
    opacity: opacity,
    priority: priority,
  );

  test('retains validated coordinates policies and priority', () {
    final result = feature();

    expect(result.id, 'hypocenter:event-a');
    expect(result.longitude, 139.6917);
    expect(result.latitude, 35.6895);
    expect(result.spriteRegionId, 'normal');
    expect(result.sizeScale, sizeScale);
    expect(result.opacity, opacity);
    expect(result.priority, 10);
  });

  test('rejects blank feature and sprite region IDs', () {
    expect(() => feature(id: ' \n '), throwsArgumentError);
    expect(() => feature(spriteRegionId: '\t'), throwsArgumentError);
  });

  test('rejects non-finite or out-of-range longitude', () {
    expect(() => feature(longitude: double.nan), throwsArgumentError);
    expect(() => feature(longitude: double.infinity), throwsArgumentError);
    expect(() => feature(longitude: -180.01), throwsArgumentError);
    expect(() => feature(longitude: 180.01), throwsArgumentError);
  });

  test('rejects non-finite or out-of-range latitude', () {
    expect(() => feature(latitude: double.nan), throwsArgumentError);
    expect(
      () => feature(latitude: double.negativeInfinity),
      throwsArgumentError,
    );
    expect(() => feature(latitude: -90.01), throwsArgumentError);
    expect(() => feature(latitude: 90.01), throwsArgumentError);
  });

  test('accepts closed coordinate boundaries and priority zero', () {
    expect(feature(longitude: -180, latitude: -90, priority: 0).priority, 0);
    expect(feature(longitude: 180, latitude: 90).longitude, 180);
  });

  test('rejects negative priority', () {
    expect(() => feature(priority: -1), throwsArgumentError);
  });
}
