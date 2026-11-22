import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'fake_style_controller.dart';

void main() {
  setUpAll(() {
    try {
      talker_lib.talker = Talker();
      // ignore: avoid_catching_errors
    } on Error catch (_) {}
  });

  const emptyGeoJson = '{"type":"FeatureCollection","features":[]}';

  Future<void> addResources({
    required FakeStyleController style,
    List<String> layerIds = const [],
    List<String> sourceIds = const [],
  }) async {
    await style.sources.add(
      const GeoJsonSource.data(id: 'layer-source', data: .text(emptyGeoJson)),
    );
    for (final id in sourceIds) {
      await style.sources.add(
        GeoJsonSource.data(id: id, data: const .text(emptyGeoJson)),
      );
    }
    for (final id in layerIds) {
      await style.layers.add(FillStyleLayer(id: id, sourceId: 'layer-source'));
    }
  }

  test('先頭 layer の削除失敗後も残りの resource を削除する', () async {
    final style = FakeStyleController(failingLayerIds: {'first'});
    await addResources(
      style: style,
      layerIds: const ['first', 'second'],
      sourceIds: const ['source'],
    );

    await MapStyleResourceRemover.remove(
      styleController: style,
      layerIds: const ['first', 'second'],
      sourceIds: const ['source'],
      imageIds: const ['image'],
    );

    expect(style.backend.removedLayerIds, ['first', 'second']);
    expect(style.backend.removedSourceIds, ['source']);
    expect(style.removedImageIds, ['image']);
  });

  test('source の削除失敗後も残りの source と image を削除する', () async {
    final style = FakeStyleController(failingSourceIds: {'first-source'});
    await addResources(
      style: style,
      sourceIds: const ['first-source', 'second-source'],
    );

    await MapStyleResourceRemover.remove(
      styleController: style,
      sourceIds: const ['first-source', 'second-source'],
      imageIds: const ['image'],
    );

    expect(style.backend.removedSourceIds, ['first-source', 'second-source']);
    expect(style.removedImageIds, ['image']);
  });

  test('複数 layer/source の途中失敗でも全 resource を順に試行する', () async {
    final style = FakeStyleController(
      failingLayerIds: {'second-layer'},
      failingSourceIds: {'first-source'},
    );
    await addResources(
      style: style,
      layerIds: const ['first-layer', 'second-layer', 'third-layer'],
      sourceIds: const ['first-source', 'second-source'],
    );

    await MapStyleResourceRemover.remove(
      styleController: style,
      layerIds: const ['first-layer', 'second-layer', 'third-layer'],
      sourceIds: const ['first-source', 'second-source'],
      imageIds: const ['first-image', 'second-image'],
    );

    expect(style.backend.removedLayerIds, [
      'first-layer',
      'second-layer',
      'third-layer',
    ]);
    expect(style.backend.removedSourceIds, ['first-source', 'second-source']);
    expect(style.removedImageIds, ['first-image', 'second-image']);
  });
}
