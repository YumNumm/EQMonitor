import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('small medium largeの係数をcircle radiusへ適用する', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    const interpolation = [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      1,
      10,
      10,
    ];

    for (final testCase in <({double scale, List<Object> expected})>[
      (scale: 0.65, expected: ['*', 0.65, interpolation]),
      (scale: 1, expected: ['*', 1.0, interpolation]),
      (scale: 1.35, expected: ['*', 1.35, interpolation]),
    ]) {
      expect(
        builder
            .build(
              radiusScaleFactor: testCase.scale,
              markerType: .never,
              hasActiveEew: false,
            )
            .paint['circle-radius'],
        testCase.expected,
      );
    }
  });

  test('marker size係数をcircle stroke widthへ適用する', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    const interpolation = [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      0.2,
      10,
      1,
    ];

    for (final testCase in <({double scale, List<Object> expected})>[
      (scale: 0.65, expected: ['*', 0.65, interpolation]),
      (scale: 1.35, expected: ['*', 1.35, interpolation]),
    ]) {
      expect(
        builder
            .build(
              radiusScaleFactor: testCase.scale,
              markerType: .always,
              hasActiveEew: false,
            )
            .paint['circle-stroke-width'],
        testCase.expected,
      );
    }
  });

  test('marker typeとEEW状態から枠表示を決定する', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    final visibleStrokeWidth = [
      '*',
      1.0,
      [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        0.2,
        10,
        1,
      ],
    ];
    Object? strokeWidth({
      required KyoshinMonitorMarkerType markerType,
      required bool hasActiveEew,
    }) => builder
        .build(
          radiusScaleFactor: 1,
          markerType: markerType,
          hasActiveEew: hasActiveEew,
        )
        .paint['circle-stroke-width'];

    expect(
      strokeWidth(markerType: .always, hasActiveEew: false),
      visibleStrokeWidth,
    );
    expect(
      strokeWidth(markerType: .onlyEew, hasActiveEew: true),
      visibleStrokeWidth,
    );
    expect(strokeWidth(markerType: .onlyEew, hasActiveEew: false), 0);
    expect(strokeWidth(markerType: .never, hasActiveEew: true), 0);
  });
}
