import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer_builder.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

CityMaxIntensityEntry _entry(String cityCode, JmaIntensity intensity) =>
    CityMaxIntensityEntry(cityCode: cityCode, intensity: intensity);

const _selected = IntensityHistoryState(
  selectedCity: IntensityHistorySelectedCity(
    code: '0110100',
    name: '札幌市中央区',
    prefectureName: '北海道',
  ),
);

void main() {
  const builder = IntensityFillLayerBuilder();
  late IntensityColors colorModel;

  setUp(() {
    colorModel = AppTheme.eqmonitorDefault().light!.intensity;
  });

  List<MapStyleLayerEntry> layersOf(
    IntensityHistoryState state, {
    List<CityMaxIntensityEntry> cityMaxIntensities = const [],
  }) => builder.build(
    state: state,
    cityMaxIntensities: cityMaxIntensities,
    colorModel: colorModel,
    isDarkMode: false,
  );

  List<String> idsOf(
    IntensityHistoryState state, {
    List<CityMaxIntensityEntry> cityMaxIntensities = const [],
  }) => layersOf(
    state,
    cityMaxIntensities: cityMaxIntensities,
  ).map((entry) => entry.layer.id).toList();

  group('build', () {
    test('下→上 の決定的な順序で返す', () {
      expect(
        idsOf(
          _selected,
          cityMaxIntensities: [_entry('0110100', JmaIntensity.fiveLower)],
        ),
        [
          IntensityFillLayerBuilder.cityFillLayerId,
          IntensityFillLayerBuilder.selectedCityLineLayerId,
        ],
      );
    });

    test('市区町村が未選択なら輪郭線レイヤーを追加しない', () {
      expect(
        idsOf(
          const IntensityHistoryState(),
          cityMaxIntensities: [_entry('0110100', JmaIntensity.fiveLower)],
        ),
        [IntensityFillLayerBuilder.cityFillLayerId],
      );
    });

    test('最大震度が未取得なら塗りレイヤーを追加しない', () {
      expect(idsOf(const IntensityHistoryState()), isEmpty);
    });

    test('最大震度が未取得でも選択中の輪郭線だけは描く', () {
      expect(idsOf(_selected), [
        IntensityFillLayerBuilder.selectedCityLineLayerId,
      ]);
    });

    test('市区町村の塗りはズームに依らず一定の不透明度で塗る', () {
      final cityFill = layersOf(
        const IntensityHistoryState(),
        cityMaxIntensities: [_entry('0110100', JmaIntensity.fiveLower)],
      ).single;

      expect(
        cityFill.layer.paint['fill-opacity'],
        IntensityFillLayerBuilder.cityFillOpacity,
      );
    });

    test('市区町村の塗りは regioncode で照合する', () {
      final cityFill = layersOf(
        const IntensityHistoryState(),
        cityMaxIntensities: [_entry('0110100', JmaIntensity.fiveLower)],
      ).single;

      final fillColor = cityFill.layer.paint['fill-color']! as List<Object>;
      expect(fillColor[0], 'match');
      expect(fillColor[1], ['get', 'regioncode']);
      expect(fillColor[2], '0110100');
    });

    test('選択中の輪郭線は選択市区町村コードで絞り込む', () {
      final line = layersOf(
        _selected,
        cityMaxIntensities: [_entry('0110100', JmaIntensity.fiveLower)],
      ).where((entry) => entry.layer is LineStyleLayer).single;

      expect(line.layer.filter, [
        '==',
        ['get', 'regioncode'],
        '0110100',
      ]);
    });

    test('塗りは細分区域の境界線より下、選択輪郭線はその上に挿入する', () {
      final layers = layersOf(
        _selected,
        cityMaxIntensities: [_entry('0110100', JmaIntensity.fiveLower)],
      );

      for (final entry in layers) {
        if (entry.layer.id ==
            IntensityFillLayerBuilder.selectedCityLineLayerId) {
          expect(entry.aboveLayerId, BaseLayer.areaForecastLocalELine.name);
          expect(entry.belowLayerId, isNull);
        } else {
          expect(entry.belowLayerId, BaseLayer.areaForecastLocalELine.name);
          expect(entry.aboveLayerId, isNull);
        }
      }
    });
  });
}
