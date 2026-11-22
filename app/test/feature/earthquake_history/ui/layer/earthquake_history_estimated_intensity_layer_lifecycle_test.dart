import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';

import '../../../../core/util/map/fake_style_controller.dart';

const _colors = EstimatedIntensityColors(
  four: IntensityColorEntry(
    background: Color(0xFF111111),
    foreground: IntensityTextColor.auto(),
  ),
  fiveLower: IntensityColorEntry(
    background: Color(0xFF222222),
    foreground: IntensityTextColor.auto(),
  ),
  fiveUpper: IntensityColorEntry(
    background: Color(0xFF333333),
    foreground: IntensityTextColor.auto(),
  ),
  sixLower: IntensityColorEntry(
    background: Color(0xFF444444),
    foreground: IntensityTextColor.auto(),
  ),
  sixUpper: IntensityColorEntry(
    background: Color(0xFF555555),
    foreground: IntensityTextColor.auto(),
  ),
  seven: IntensityColorEntry(
    background: Color(0xFF666666),
    foreground: IntensityTextColor.auto(),
  ),
);

void main() {
  const style = EarthquakeHistoryEstimatedIntensityStyle();

  test('推計震度のフル URL に pmtiles scheme を一度だけ付与する', () async {
    final controller = await baseStyleController();

    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/estimated.pmtiles',
      colors: _colors,
      isDisposed: () => false,
    );

    final source = controller.backend.addedSources.single as VectorSourceUrl;
    expect(source.id, EarthquakeHistoryEstimatedIntensityStyle.sourceId);
    expect(source.url, 'pmtiles://https://example.com/estimated.pmtiles');
  });

  test('name 属性をテーマの推計震度色にマッピングする', () async {
    final controller = await baseStyleController();

    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/estimated.pmtiles',
      colors: _colors,
      isDisposed: () => false,
    );

    const expectedExpression = [
      'match',
      ['get', 'name'],
      'intensity:4',
      '#111111',
      'intensity:5-',
      '#222222',
      'intensity:5+',
      '#333333',
      'intensity:6-',
      '#444444',
      'intensity:6+',
      '#555555',
      'intensity:7',
      '#666666',
      ['get', 'fill'],
    ];
    final fillLayer = controller
        .layers[EarthquakeHistoryEstimatedIntensityStyle.fillLayerId]!;
    final lineLayer = controller
        .layers[EarthquakeHistoryEstimatedIntensityStyle.lineLayerId]!;
    expect(fillLayer, isA<FillStyleLayer>());
    expect(lineLayer, isA<LineStyleLayer>());
    expect(paintOf(fillLayer)['fill-color'], expectedExpression);
    expect(paintOf(lineLayer)['line-color'], expectedExpression);
  });

  test('固定 ID の推計震度リソースを再適用前に除去する', () async {
    final controller = await baseStyleController();

    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/first.pmtiles',
      colors: _colors,
      isDisposed: () => false,
    );
    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/second.pmtiles',
      colors: _colors,
      isDisposed: () => false,
    );

    expect(
      controller.sources.map((source) => source.id),
      contains(EarthquakeHistoryEstimatedIntensityStyle.sourceId),
    );
    expect(controller.activeLayerIds, [
      EarthquakeHistoryEstimatedIntensityStyle.fillLayerId,
      EarthquakeHistoryEstimatedIntensityStyle.lineLayerId,
      BaseLayer.areaForecastLocalELine.name,
    ]);
  });

  test('推計震度リソースを layer から source の順で除去する', () async {
    final controller = await baseStyleController();
    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/estimated.pmtiles',
      colors: _colors,
      isDisposed: () => false,
    );

    await style.remove(styleController: controller);

    expect(controller.backend.removedLayerIds, [
      EarthquakeHistoryEstimatedIntensityStyle.lineLayerId,
      EarthquakeHistoryEstimatedIntensityStyle.fillLayerId,
    ]);
    // layer が残っている source の削除は StateError になり backend へ届かない。
    expect(controller.backend.removedSourceIds, [
      EarthquakeHistoryEstimatedIntensityStyle.sourceId,
    ]);
  });
}

Future<FakeStyleController> baseStyleController() async {
  final controller = FakeStyleController();
  await controller.layers.add(
    BackgroundStyleLayer(id: BaseLayer.areaForecastLocalELine.name),
  );
  return controller;
}

Map<String, Object?> paintOf(StyleLayer layer) =>
    layer.toJson()['paint']! as Map<String, Object?>;
