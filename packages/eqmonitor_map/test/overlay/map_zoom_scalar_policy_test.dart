import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MapZoomLinearRange linear({
    double startZoom = 3,
    double startValue = 0.15,
    double endZoom = 20,
    double endValue = 0.4,
  }) => createMapZoomLinearRange(
    startZoom: startZoom,
    startValue: startValue,
    endZoom: endZoom,
    endValue: endValue,
  );

  MapZoomStep step({
    double thresholdZoom = 8,
    double belowValue = 1,
    double atOrAboveValue = 0.6,
  }) => createMapZoomStep(
    thresholdZoom: thresholdZoom,
    belowValue: belowValue,
    atOrAboveValue: atOrAboveValue,
  );

  test('matches the MapLibre linear size fixture and clamps endpoints', () {
    final policy = linear();

    expect(policy.valueAt(zoom: 2), 0.15);
    expect(policy.valueAt(zoom: 3), 0.15);
    expect(policy.valueAt(zoom: 11.5), closeTo(0.275, 1e-12));
    expect(policy.valueAt(zoom: 20), 0.4);
    expect(policy.valueAt(zoom: 21), 0.4);
  });

  test('matches the MapLibre opacity step exactly at the threshold', () {
    final policy = step();

    expect(policy.valueAt(zoom: 7.999999), 1);
    expect(policy.valueAt(zoom: 8), 0.6);
    expect(policy.valueAt(zoom: 8.000001), 0.6);
  });

  test('rejects non-finite linear inputs and evaluation zooms', () {
    expect(() => linear(startZoom: double.nan), throwsArgumentError);
    expect(() => linear(startValue: double.infinity), throwsArgumentError);
    expect(() => linear(endZoom: double.negativeInfinity), throwsArgumentError);
    expect(() => linear(endValue: double.nan), throwsArgumentError);
    expect(() => linear().valueAt(zoom: double.nan), throwsArgumentError);
    expect(
      () => linear().valueAt(zoom: double.infinity),
      throwsArgumentError,
    );
  });

  test('requires an increasing zoom range and positive size values', () {
    expect(() => linear(endZoom: 3), throwsArgumentError);
    expect(() => linear(startZoom: 4, endZoom: 3), throwsArgumentError);
    expect(() => linear(startValue: 0), throwsArgumentError);
    expect(() => linear(endValue: -0.1), throwsArgumentError);
  });

  test('rejects non-finite step inputs and evaluation zooms', () {
    expect(() => step(thresholdZoom: double.nan), throwsArgumentError);
    expect(() => step(belowValue: double.infinity), throwsArgumentError);
    expect(() => step(atOrAboveValue: double.nan), throwsArgumentError);
    expect(() => step().valueAt(zoom: double.nan), throwsArgumentError);
    expect(() => step().valueAt(zoom: double.infinity), throwsArgumentError);
  });

  test('requires opacity values in the closed unit interval', () {
    expect(() => step(belowValue: -0.01), throwsArgumentError);
    expect(() => step(belowValue: 1.01), throwsArgumentError);
    expect(() => step(atOrAboveValue: -0.01), throwsArgumentError);
    expect(() => step(atOrAboveValue: 1.01), throwsArgumentError);

    expect(step(belowValue: 0, atOrAboveValue: 1).belowValue, 0);
  });

  test('policies use all canonical fields for value equality', () {
    expect(linear(), linear());
    expect(linear().hashCode, linear().hashCode);
    expect(linear(), isNot(linear(endValue: 0.5)));
    expect(step(), step());
    expect(step().hashCode, step().hashCode);
    expect(step(), isNot(step(thresholdZoom: 9)));
  });
}
