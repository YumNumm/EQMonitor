import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_forecast_region_intensity_filter_updater.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

import '../../../../core/util/map/fake_style_controller.dart';

void main() {
  const updater = EewForecastRegionIntensityFilterUpdater();
  final regions = [
    for (final (code, intensity) in [
      ('350', JmaIntensity.four),
      ('351', JmaIntensity.four),
      ('360', JmaIntensity.three),
    ])
      EewForecastRegionInfo(
        code: code,
        name: code,
        isPlum: false,
        isWarning: false,
        intensity: intensity,
        intensityIsOver: false,
      ),
  ];

  test('存在する震度別 layer の filter だけを更新する', () async {
    final controller = FakeStyleController();
    await controller.sources.add(
      const VectorSource.url(id: 'eqmonitor_map', url: 'pmtiles://map'),
    );
    for (final intensity in [JmaIntensity.three, JmaIntensity.four]) {
      await controller.layers.add(
        FillStyleLayer(
          id: updater.detailLayerId(intensity),
          sourceId: 'eqmonitor_map',
          sourceLayerId: 'areaForecastLocalE',
        ),
      );
    }

    await updater.update(
      styleController: controller,
      regionMaxIntensities: regions,
    );

    expect(controller.backend.updatedFilters, [
      (
        layerId: 'eew-details-intensity-fill-three',
        filter: [
          'in',
          ['get', 'code'],
          [
            'literal',
            ['360'],
          ],
        ],
      ),
      (
        layerId: 'eew-details-intensity-fill-four',
        filter: [
          'in',
          ['get', 'code'],
          [
            'literal',
            ['350', '351'],
          ],
        ],
      ),
    ]);
  });

  test('layer が未追加でも例外にしない', () async {
    final controller = FakeStyleController();

    await updater.update(
      styleController: controller,
      regionMaxIntensities: regions,
    );

    expect(controller.backend.updatedFilters, isEmpty);
  });
}
