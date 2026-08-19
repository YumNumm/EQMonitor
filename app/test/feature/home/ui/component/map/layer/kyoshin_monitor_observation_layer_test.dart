import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('small medium largeの係数をcircle radiusのstop出力へ畳み込む', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    List<Object> interpolation(double scale) => [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      1 * scale,
      10,
      10 * scale,
    ];

    for (final scale in <double>[0.65, 1, 1.35]) {
      expect(
        builder
            .build(
              radiusScaleFactor: scale,
              markerType: .never,
              hasActiveEew: false,
            )
            .paint['circle-radius'],
        interpolation(scale),
      );
    }
  });

  test('marker size係数をcircle stroke widthのstop出力へ畳み込む', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    List<Object> interpolation(double scale) => [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      0.2 * scale,
      10,
      1 * scale,
    ];

    for (final scale in <double>[0.65, 1.35]) {
      expect(
        builder
            .build(
              radiusScaleFactor: scale,
              markerType: .always,
              hasActiveEew: false,
            )
            .paint['circle-stroke-width'],
        interpolation(scale),
      );
    }
  });

  test('zoom依存の式を式ツリーの最上位に置く (MapLibre iOS制約)', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    final paint = builder
        .build(radiusScaleFactor: 1.35, markerType: .always, hasActiveEew: true)
        .paint;

    for (final key in ['circle-radius', 'circle-stroke-width']) {
      final expression = paint[key];
      expect(
        expression,
        isA<List<Object>>().having(
          (e) => e.first,
          'root operator',
          'interpolate',
        ),
        reason: '$key のzoom式は最上位に置く必要がある',
      );
    }
  });

  test('marker typeとEEW状態から枠表示を決定する', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    final visibleStrokeWidth = [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      0.2,
      10,
      1.0,
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
