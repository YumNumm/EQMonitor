import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import 'seismicity_mvt_fixture_builder.dart';
import 'seismicity_mvt_mutation.dart';

void main() {
  test('typed mutations return isolated fixtures', () {
    final baseline = SeismicityMvtFixtureBuilder().build(
      layerName: 'base',
      layerVersion: 2,
      layerExtent: 4096,
      featureId: '1',
      featureTags: const [0, 0],
      featureType: VectorTile_GeomType.POINT,
      point: (x: 1, y: 1),
      keys: const ['key'],
      values: [SeismicityFixtureScalar.string('old')],
    );
    final original = List<int>.of(baseline);
    final replacement = VectorTile.fromBuffer(baseline).layers.single.deepCopy()
      ..name = 'replacement';
    final replaced = baseline.replaceMvtLayer(at: 0, layer: replacement);
    final removed = baseline.removeMvtLayer(at: 0);
    final appended = baseline.appendMvtLayer(layer: replacement);
    final changedFeature = VectorTile.fromBuffer(
      baseline.replaceMvtFeature(
        layerAt: 0,
        featureAt: 0,
        tags: const [2, 2],
        geometry: const [9, 4, 4],
        type: VectorTile_GeomType.LINESTRING,
      ),
    ).layers.single.features.single;
    final changedValue = VectorTile.fromBuffer(
      baseline.replaceMvtValue(
        layerAt: 0,
        valueAt: 0,
        value: createVectorTileValue(stringValue: 'new'),
      ),
    ).layers.single.values.single;
    final truncated = baseline.truncateMvtBytes(length: baseline.length - 1);

    expect(VectorTile.fromBuffer(replaced).layers.single.name, 'replacement');
    expect(VectorTile.fromBuffer(removed).layers, isEmpty);
    expect(VectorTile.fromBuffer(appended).layers.last.name, 'replacement');
    expect(changedFeature.tags, [2, 2]);
    expect(changedFeature.geometry, [9, 4, 4]);
    expect(changedFeature.type, VectorTile_GeomType.LINESTRING);
    expect(changedValue.stringValue, 'new');
    expect(truncated, original.sublist(0, original.length - 1));
    expect(baseline, original);
  });
}
