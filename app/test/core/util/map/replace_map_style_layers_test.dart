import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

import 'fake_style_controller.dart';

void main() {
  const emptyGeoJson = '{"type":"FeatureCollection","features":[]}';

  Future<FakeStyleController> createStyle() async {
    final style = FakeStyleController();
    await style.sources.add(
      const GeoJsonSource.data(id: 'source', data: .text(emptyGeoJson)),
    );
    return style;
  }

  test('同じ ID の既存 layer を削除してから追加する', () async {
    final style = await createStyle();
    await style.layers.add(LineStyleLayer(id: 'base', sourceId: 'source'));
    await style.layers.add(FillStyleLayer(id: 'target', sourceId: 'source'));

    await MapStyleLayerReplacer.replace(
      styleController: style,
      layerIds: const ['target'],
      layers: [
        (
          layer: FillStyleLayer(id: 'target', sourceId: 'source'),
          belowLayerId: 'base',
        ),
      ],
    );

    expect(style.backend.removedLayerIds, ['target']);
    expect(
      style.backend.addedLayers.map(
        (layer) => (id: layer.json['id'], belowLayerId: layer.belowLayerId),
      ),
      [
        (id: 'base', belowLayerId: null),
        (id: 'target', belowLayerId: null),
        (id: 'target', belowLayerId: 'base'),
      ],
    );
    expect(style.activeLayerIds, ['target', 'base']);
  });

  test('今回追加しない stale layer も削除する', () async {
    final style = await createStyle();
    await style.layers.add(FillStyleLayer(id: 'fill', sourceId: 'source'));
    await style.layers.add(LineStyleLayer(id: 'line', sourceId: 'source'));

    await MapStyleLayerReplacer.replace(
      styleController: style,
      layerIds: const ['fill', 'line'],
      layers: [
        (
          layer: FillStyleLayer(id: 'fill', sourceId: 'source'),
          belowLayerId: null,
        ),
      ],
    );

    expect(style.backend.removedLayerIds, ['fill', 'line']);
    expect(style.activeLayerIds, {'fill'});
  });
}
