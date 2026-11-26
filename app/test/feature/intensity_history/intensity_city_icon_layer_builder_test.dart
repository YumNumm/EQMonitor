import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_city_icon_layer.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter_test/flutter_test.dart';

CityMaxIntensityEntry _entry(String cityCode, JmaIntensity intensity) =>
    CityMaxIntensityEntry(cityCode: cityCode, intensity: intensity);

void main() {
  const builder = IntensityCityIconLayerBuilder();

  test('震度ごとに市区町村ラベル位置のアイコンレイヤーを震度の小さい順に返す', () {
    final layers = builder.build(
      cityMaxIntensities: [
        _entry('0110100', JmaIntensity.fiveLower),
        _entry('0410000', JmaIntensity.four),
        _entry('0420100', JmaIntensity.fiveLower),
      ],
    );

    expect(layers.map((entry) => entry.layer.id), [
      IntensityCityIconLayerBuilder.layerIdOf(JmaIntensity.four),
      IntensityCityIconLayerBuilder.layerIdOf(JmaIntensity.fiveLower),
    ]);
    expect(
      layers.map((entry) => entry.belowLayerId),
      everyElement(BaseLayer.areaIconAnchor.name),
    );

    final json = layers.last.layer.toJson();
    expect(json['source-layer'], 'areaInformationCityQuakeLabel');
    expect(json['minzoom'], IntensityCityIconLayerBuilder.minZoom);
    expect(json['filter'], [
      'in',
      ['get', 'regioncode'],
      [
        'literal',
        ['0110100', '0420100'],
      ],
    ]);
    expect(
      (json['layout']! as Map<String, Object?>)['icon-image'],
      'JmaIntensity.filled.fiveLower',
    );
  });

  test('同じ市区町村が複数あれば最大震度のレイヤーだけに含める', () {
    final layers = builder.build(
      cityMaxIntensities: [
        _entry('0110100', JmaIntensity.three),
        _entry('0110100', JmaIntensity.sixLower),
      ],
    );

    expect(layers.map((entry) => entry.layer.id), [
      IntensityCityIconLayerBuilder.layerIdOf(JmaIntensity.sixLower),
    ]);
  });

  test('最大震度が空なら何も返さない', () {
    expect(builder.build(cityMaxIntensities: const []), isEmpty);
  });

  test('管理対象のレイヤー ID は全震度分を持つ', () {
    expect(
      IntensityCityIconLayerBuilder.layerIds,
      hasLength(JmaIntensity.values.length),
    );
  });
}
