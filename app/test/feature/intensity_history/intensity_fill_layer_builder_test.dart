import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer_builder.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter_test/flutter_test.dart';

CityMaxIntensityEntry _entry(String cityCode, JmaIntensity intensity) =>
    CityMaxIntensityEntry(cityCode: cityCode, intensity: intensity);

final _entries = [
  _entry('0110100', JmaIntensity.fiveLower),
  _entry('0410000', JmaIntensity.four),
];

void main() {
  const builder = IntensityFillLayerBuilder();
  late IntensityColors colorModel;

  setUp(() {
    colorModel = AppTheme.eqmonitorDefault().light!.intensity;
  });

  group('buildFill', () {
    test('市区町村の塗り 1 枚だけを返す', () {
      final layers = builder.buildFill(
        cityMaxIntensities: _entries,
        colorModel: colorModel,
      );

      expect(
        layers.map((entry) => entry.layer.id),
        [IntensityFillLayerBuilder.cityFillLayerId],
      );
    });

    test('最大震度が空なら何も返さない', () {
      expect(
        builder.buildFill(cityMaxIntensities: const [], colorModel: colorModel),
        isEmpty,
      );
    });

    test('regioncode で照合する match 式を組む', () {
      final cityFill = builder
          .buildFill(cityMaxIntensities: _entries, colorModel: colorModel)
          .single;

      final fillColor = cityFill.layer.paint['fill-color']! as List<Object>;
      expect(fillColor[0], 'match');
      expect(fillColor[1], ['get', 'regioncode']);
      expect(fillColor.sublist(2), contains('0110100'));
      expect(fillColor.sublist(2), contains('0410000'));
    });

    test('ズームに依らず一定の不透明度で塗る', () {
      final cityFill = builder
          .buildFill(cityMaxIntensities: _entries, colorModel: colorModel)
          .single;

      expect(
        cityFill.layer.paint['fill-opacity'],
        IntensityFillLayerBuilder.cityFillOpacity,
      );
    });

    test('細分区域の境界線より下に挿入する', () {
      final cityFill = builder
          .buildFill(cityMaxIntensities: _entries, colorModel: colorModel)
          .single;

      expect(cityFill.belowLayerId, BaseLayer.areaForecastLocalELine.name);
      expect(cityFill.aboveLayerId, isNull);
    });
  });

  group('buildSelectedCityLine', () {
    test('選択中の市区町村コードで絞り込む輪郭線を返す', () {
      final line = builder
          .buildSelectedCityLine(
            selectedCityCode: '0110100',
            isDarkMode: false,
          )
          .single;

      expect(line.layer.id, IntensityFillLayerBuilder.selectedCityLineLayerId);
      expect(line.layer.filter, [
        '==',
        ['get', 'regioncode'],
        '0110100',
      ]);
    });

    test('未選択なら何も返さない', () {
      expect(
        builder.buildSelectedCityLine(
          selectedCityCode: null,
          isDarkMode: false,
        ),
        isEmpty,
      );
    });

    test('細分区域の境界線より上に挿入する', () {
      final line = builder
          .buildSelectedCityLine(
            selectedCityCode: '0110100',
            isDarkMode: false,
          )
          .single;

      expect(line.aboveLayerId, BaseLayer.areaForecastLocalELine.name);
      expect(line.belowLayerId, isNull);
    });

    test('ダークモードでは白い輪郭線にする', () {
      final dark = builder
          .buildSelectedCityLine(selectedCityCode: '0110100', isDarkMode: true)
          .single;
      final light = builder
          .buildSelectedCityLine(selectedCityCode: '0110100', isDarkMode: false)
          .single;

      expect(dark.layer.paint['line-color'], '#FFFFFF');
      expect(light.layer.paint['line-color'], '#000000');
    });
  });

  group('レイヤー ID の管理範囲', () {
    test('塗りと輪郭線は別々の ID 集合を管理する', () {
      expect(
        IntensityFillLayerBuilder.fillLayerIds,
        [IntensityFillLayerBuilder.cityFillLayerId],
      );
      expect(
        IntensityFillLayerBuilder.selectedCityLineLayerIds,
        [IntensityFillLayerBuilder.selectedCityLineLayerId],
      );
      // 片方の入れ替えが他方を巻き込むと、市区町村をタップするたびに
      // ~1900 分岐の塗りを作り直して消えたように見える。
      expect(
        IntensityFillLayerBuilder.fillLayerIds.toSet().intersection(
          IntensityFillLayerBuilder.selectedCityLineLayerIds.toSet(),
        ),
        isEmpty,
      );
    });
  });
}
