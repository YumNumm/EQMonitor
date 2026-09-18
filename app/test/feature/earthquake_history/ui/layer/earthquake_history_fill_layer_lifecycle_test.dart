import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
// ignore: implementation_imports
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

import '../../../../core/util/map/fake_style_controller.dart';

void main() {
  testWidgets('JMAから長周期へ切り替えると長周期レイヤーだけが残る', (tester) async {
    final styleController = FakeStyleController();
    final showingLpgm = ValueNotifier(false);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MapOperationQueueScope(
            child: MapLibreInheritedModel(
              mapController: EarthquakeHistoryLayerMapController(
                styleController: styleController,
              ),
              mapCamera: null,
              child: ValueListenableBuilder<bool>(
                valueListenable: showingLpgm,
                builder: (context, value, child) => EarthquakeHistoryFillLayer(
                  earthquake: earthquake,
                  parameter: const EarthquakeHistoryMapLayerParameter(),
                  showingLpgmIntensity: value,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    showingLpgm.value = true;
    await tester.pumpAndSettle();

    expect(styleController.activeLayerIds, {
      'eq-history-lpgm-two-region-fill',
      'eq-history-lpgm-two-region-line',
    });
  });

  testWidgets('震度データ更新で同じIDを再構築してもJMAレイヤーが残る', (tester) async {
    final styleController = FakeStyleController();
    final currentEarthquake = ValueNotifier(earthquake);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MapOperationQueueScope(
            child: MapLibreInheritedModel(
              mapController: EarthquakeHistoryLayerMapController(
                styleController: styleController,
              ),
              mapCamera: null,
              child: ValueListenableBuilder<Earthquake>(
                valueListenable: currentEarthquake,
                builder: (context, value, child) => EarthquakeHistoryFillLayer(
                  earthquake: value,
                  parameter: const EarthquakeHistoryMapLayerParameter(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    currentEarthquake.value = updatedEarthquake;
    await tester.pumpAndSettle();

    expect(styleController.activeLayerIds, {
      'eq-history-jma-four-region-fill',
      'eq-history-jma-four-region-line',
    });
  });

  testWidgets('JMAから長周期を経て推計震度へ切り替えると推計震度レイヤーだけが残る', (
    tester,
  ) async {
    final styleController = FakeStyleController();
    final displayMode = ValueNotifier(IntensityDisplayMode.jma);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MapOperationQueueScope(
            child: MapLibreInheritedModel(
              mapController: EarthquakeHistoryLayerMapController(
                styleController: styleController,
              ),
              mapCamera: null,
              child: ValueListenableBuilder<IntensityDisplayMode>(
                valueListenable: displayMode,
                builder: (context, value, child) => switch (value) {
                  IntensityDisplayMode.jma => EarthquakeHistoryFillLayer(
                    earthquake: earthquake,
                    parameter: const EarthquakeHistoryMapLayerParameter(),
                  ),
                  IntensityDisplayMode.lpgm => EarthquakeHistoryFillLayer(
                    earthquake: earthquake,
                    parameter: const EarthquakeHistoryMapLayerParameter(),
                    showingLpgmIntensity: true,
                  ),
                  IntensityDisplayMode.estimated =>
                    const EarthquakeHistoryDetailsEstimatedIntensityLayer(
                      tileUrl: 'https://example.com/estimated.pmtiles',
                    ),
                },
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    displayMode.value = IntensityDisplayMode.lpgm;
    await tester.pumpAndSettle();
    displayMode.value = IntensityDisplayMode.estimated;
    await tester.pumpAndSettle();

    expect(styleController.activeLayerIds, {
      'earthquake-history-estimated-intensity-fill',
      'earthquake-history-estimated-intensity-line',
    });
  });
}

class EarthquakeHistoryLayerMapController implements MapController {
  new({required this.styleController});

  final StyleController styleController;

  @override
  StyleController get style => styleController;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const region = EarthquakeParameterRegionItem(
  code: '001',
  name: LocalizedName(ja: 'テスト地域'),
  kana: null,
  cities: [],
);

const updatedRegion = EarthquakeParameterRegionItem(
  code: '002',
  name: LocalizedName(ja: '更新地域'),
  kana: null,
  cities: [],
);

final earthquake = Earthquake(
  eventId: 'layer-lifecycle-test',
  status: TelegramStatus.normal,
  originTime: DateTime(2026),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime(2026),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [],
  hypocenter: null,
  intensity: const EarthquakeIntensity(
    maxIntensity: JmaIntensity.four,
    maxLpgmIntensity: JmaLpgmIntensity.two,
    regions: {
      JmaIntensity.four: [
        IntensityRegion(region: region, maxIntensity: JmaIntensity.four),
      ],
    },
    intensityTree: {},
    lpgmIntensityTree: {
      JmaLpgmIntensity.two: [
        PrefectureLpgmIntensityNode(
          region: region,
          maxLpgmIntensity: JmaLpgmIntensity.two,
          cities: [],
        ),
      ],
    },
  ),
  estimatedIntensityTileUrl: 'https://example.com/estimated.pmtiles',
);

final updatedEarthquake = earthquake.copyWith(
  intensity: const EarthquakeIntensity(
    maxIntensity: JmaIntensity.four,
    maxLpgmIntensity: JmaLpgmIntensity.two,
    regions: {
      JmaIntensity.four: [
        IntensityRegion(region: region, maxIntensity: JmaIntensity.four),
        IntensityRegion(
          region: updatedRegion,
          maxIntensity: JmaIntensity.four,
        ),
      ],
    },
    intensityTree: {},
    lpgmIntensityTree: {
      JmaLpgmIntensity.two: [
        PrefectureLpgmIntensityNode(
          region: region,
          maxLpgmIntensity: JmaLpgmIntensity.two,
          cities: [],
        ),
      ],
    },
  ),
);
