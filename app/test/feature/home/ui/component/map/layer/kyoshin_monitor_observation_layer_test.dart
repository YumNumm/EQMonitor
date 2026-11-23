import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  Map<String, Object?> paintOf(StyleLayer layer) =>
      layer.toJson()['paint']! as Map<String, Object?>;

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
        paintOf(
          builder.build(
            radiusScaleFactor: scale,
            markerType: .never,
            hasActiveEew: false,
            hasIcon: false,
          ),
        )['circle-radius'],
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
        paintOf(
          builder.build(
            radiusScaleFactor: scale,
            markerType: .always,
            hasActiveEew: false,
            hasIcon: false,
          ),
        )['circle-stroke-width'],
        interpolation(scale),
      );
    }
  });

  test('zoom依存の式を式ツリーの最上位に置く', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    final paint = paintOf(
      builder.build(
        radiusScaleFactor: 1.35,
        markerType: .always,
        hasActiveEew: true,
        hasIcon: false,
      ),
    );

    for (final key in ['circle-radius', 'circle-stroke-width']) {
      final expression = paint[key];
      expect(
        expression,
        isA<List<Object?>>().having(
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
    }) => paintOf(
      builder.build(
        radiusScaleFactor: 1,
        markerType: markerType,
        hasActiveEew: hasActiveEew,
        hasIcon: false,
      ),
    )['circle-stroke-width'];

    expect(
      strokeWidth(markerType: .always, hasActiveEew: false),
      visibleStrokeWidth,
    );
    expect(
      strokeWidth(markerType: .onlyEew, hasActiveEew: true),
      visibleStrokeWidth,
    );
    final lostOnlyStrokeWidth = [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      [
        'case',
        ['has', 'lost'],
        0.2,
        0,
      ],
      10,
      [
        'case',
        ['has', 'lost'],
        1.0,
        0,
      ],
    ];
    expect(
      strokeWidth(markerType: .onlyEew, hasActiveEew: false),
      lostOnlyStrokeWidth,
    );
    expect(
      strokeWidth(markerType: .never, hasActiveEew: true),
      lostOnlyStrokeWidth,
    );
  });

  test('欠測中の観測点は塗りを透明にして枠線だけを描く', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    final paint = paintOf(
      builder.build(
        radiusScaleFactor: 1,
        markerType: .never,
        hasActiveEew: false,
        hasIcon: false,
      ),
    );

    expect(paint['circle-opacity'], [
      'case',
      ['has', 'lost'],
      0,
      1,
    ]);
    expect(paint['circle-color'], [
      'coalesce',
      ['get', 'color'],
      '#808080',
    ]);
    expect(paint['circle-stroke-color'], '#808080');
  });

  test('アイコンレイヤーは震度0以上の観測点を震度順に描く', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    final json = builder.buildIconLayer(radiusScaleFactor: 2).toJson();
    final layout = json['layout']! as Map<String, Object?>;

    expect(json['filter'], [
      'all',
      ['has', 'intensity'],
      [
        '>=',
        ['get', 'intensity'],
        -0.001,
      ],
    ]);
    expect(json.containsKey('paint'), isFalse);
    expect(layout.keys, {
      'icon-image',
      'icon-allow-overlap',
      'icon-ignore-placement',
      'symbol-sort-key',
      'icon-size',
    });
    expect(layout['icon-allow-overlap'], isTrue);
    expect(layout['icon-ignore-placement'], isTrue);
    expect(layout['symbol-sort-key'], ['get', 'intensity']);
    expect(layout['icon-size'], [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      0.06,
      7,
      0.26,
      20,
      1.0,
    ]);
    expect(
      layout['icon-image'],
      isA<List<Object?>>()
          .having((e) => e.first, 'root operator', 'step')
          .having((e) => e[3], 'text min zoom', 7.0),
    );
  });
}
