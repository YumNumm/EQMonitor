import 'dart:convert';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_tile_decoder.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/seismicity_mvt_fixture_mutator.dart';

void main() {
  test(
    'streams valid Point features in source order without a result list',
    () {
      final tile = VectorTile.fromBuffer(
        buildSeismicityMvtFixtureCatalog().valid,
      );
      final second = tile.layers.single.features.single.deepCopy();
      second.geometry
        ..clear()
        ..addAll([9, 4096, 4096]);
      tile.layers.single.features.add(second);
      final rows = <SeismicityDecodedHypocenter>[];
      var returned = false;

      final count = const SeismicityMvtTileDecoder().decode(
        tileId: 0,
        dataZoom: 0,
        tileBytes: tile.writeToBuffer(),
        onHypocenter: (row) {
          expect(returned, isFalse);
          rows.add(row);
        },
      );
      returned = true;

      expect(count, 2);
      expect(
        rows.map(
          (row) => (
            featureIndex: row.featureIndex,
            globalX: row.point.globalX,
            globalY: row.point.globalY,
          ),
        ),
        [
          (featureIndex: 0, globalX: 1, globalY: 1),
          (featureIndex: 1, globalX: 2048, globalY: 2048),
        ],
      );
      for (final row in rows) {
        expect(
          (row.tileId, row.originTimeUnixMilliseconds),
          (0, 1700000000000),
        );
        expect(
          row.hypocenterId,
          orderedEquals([0, 0, 0, 0, 0, 0, 64, 0, 128, 0, 0, 0, 0, 0, 0, 1]),
        );
        expect(
          row.magnitude,
          (canonicalValue: 5.1, storageValue: 5.099999904632568),
        );
        expect(
          (row.depthKm, row.maxIntensityUtf8, row.determinationFlagUtf8),
          (null, null, null),
        );
        expect(
          row.earthquakeEventIdUtf8,
          orderedEquals(utf8.encode('event-1')),
        );
        expect(row.geometryClamped, isNull);
      }
    },
  );
}
