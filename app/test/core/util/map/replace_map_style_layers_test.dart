import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

import 'fake_style_controller.dart';

void main() {
  const staleLayer = FillStyleLayer(id: 'target', sourceId: 'source');
  const replacementLayer = FillStyleLayer(id: 'target', sourceId: 'source');

  test('同じ ID の既存 layer を削除してから追加する', () async {
    final style = FakeStyleController(throwOnDuplicateLayerIds: true);
    await style.addLayer(staleLayer);

    await MapStyleLayerReplacer.replace(
      styleController: style,
      layerIds: const ['target'],
      layers: const [
        (
          layer: replacementLayer,
          belowLayerId: 'base',
          aboveLayerId: null,
          atIndex: null,
        ),
      ],
    );

    expect(style.removedLayerIds, ['target']);
    expect(style.addedLayers.map((layer) => layer.id), ['target', 'target']);
  });

  test('今回追加しない stale layer も削除する', () async {
    final style = FakeStyleController(throwOnDuplicateLayerIds: true);
    await style.addLayer(const FillStyleLayer(id: 'fill', sourceId: 'source'));
    await style.addLayer(const LineStyleLayer(id: 'line', sourceId: 'source'));

    await MapStyleLayerReplacer.replace(
      styleController: style,
      layerIds: const ['fill', 'line'],
      layers: const [
        (
          layer: FillStyleLayer(id: 'fill', sourceId: 'source'),
          belowLayerId: null,
          aboveLayerId: null,
          atIndex: null,
        ),
      ],
    );

    expect(style.removedLayerIds, ['fill', 'line']);
    expect(style.activeLayerIds, {'fill'});
  });
}
