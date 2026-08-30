import 'dart:convert';

import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  test('観測点データがない場合も更新可能な空 GeoJSON を生成する', () {
    final geoJson = const EarthquakeHistoryStationGeoJsonBuilder().build(
      intensity: null,
      colorModel: AppTheme.eqmonitorDefault().light!.intensity,
      showingLpgmIntensity: false,
    );
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;

    expect(decoded['features'], isEmpty);
    expect(EarthquakeHistoryStationIntensityLayerBuilder.sourceId, isNotEmpty);
  });

  test('観測点を Symbol レイヤーだけで描画する', () {
    final layers = const EarthquakeHistoryStationIntensityLayerBuilder()
        .buildStyleLayers(
          parameter: const EarthquakeHistoryMapLayerParameter(),
          stationDisplayMode: StationDisplayMode.auto,
          showStationLabel: false,
          hasIcon: true,
        );

    expect(layers, hasLength(1));
    expect(layers.single, isA<SymbolStyleLayer>());
    expect(
      layers.single.id,
      EarthquakeHistoryStationIntensityLayerBuilder.iconLayerId,
    );
  });
}
