import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_tile_decoder.dart';
import 'package:test/test.dart';

import '../../benchmark/support/seismicity_benchmark_archive.dart';
import '../../benchmark/support/seismicity_benchmark_feature_source.dart';

void main() {
  const featureCount = 10_000;
  const featuresPerTile = 1_000;
  const tileIdCodec = PmTilesV3TileId();
  const featureSource = SeismicityBenchmarkFeatureSource();

  test(
    'exposes deterministic on-demand archive without retained tiles',
    () async {
      var expectedTotalPublicBytes = 0;
      for (var index = 0; index < featureCount; index++) {
        expectedTotalPublicBytes += featureSource
            .featureAt(index: index)
            .expectedPublicBytes;
      }
      final archive = SeismicityBenchmarkArchive(
        featureCount: featureCount,
        featuresPerTile: featuresPerTile,
      );
      final expectedIds = [
        for (var tileIndex = 0; tileIndex < 10; tileIndex++)
          tileIdCodec.tileIdForZxy(
            z: SeismicityBenchmarkFeatureSource.dataZoom,
            x: tileIndex,
            y: 0,
          ),
      ];
      final expectedDescriptor = SeismicityPmTilesArchiveDescriptor(
        source: const SeismicityPmTilesSource.asset(
          assetKey: 'benchmark.seismicity.pmtiles',
        ),
        schemaVersion: 1,
        dataZoom: SeismicityBenchmarkFeatureSource.dataZoom,
        expectedSizeBytes: expectedTotalPublicBytes,
        expectedFeatureCount: featureCount,
        archiveRevision: 'benchmark-$featureCount-$featuresPerTile',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      );

      expect(archive.descriptor, expectedDescriptor);
      expect(archive.occupiedTileIds, expectedIds);
      expect(
        archive.firstHypocenterId,
        featureSource.featureAt(index: 0).hypocenterId,
      );
      expect(
        archive.lastHypocenterId,
        featureSource.featureAt(index: featureCount - 1).hypocenterId,
      );
      expect(archive.expectedTotalPublicBytes, expectedTotalPublicBytes);
      expect(
        await archive
            .occupiedTileIdsAtZoom(
              zoom: SeismicityBenchmarkFeatureSource.dataZoom,
            )
            .toList(),
        expectedIds,
      );

      final firstBytes = await archive.readTile(tileId: expectedIds.first);
      final lastBytes = await archive.readTile(tileId: expectedIds.last);
      expect(firstBytes, archive.tileBytesAt(tileIndex: 0));
      expect(lastBytes, archive.tileBytesAt(tileIndex: 9));
      expect(firstBytes, isNot(equals(lastBytes)));
      expect(archive.readCount, 2);
      expect(archive.maxRetainedPayloads, 1);
      expect(archive.retainedPayloads, 0);

      final decoded = <({int globalX, int globalY})>[];
      const SeismicityMvtTileDecoder().decode(
        tileId: expectedIds[1],
        dataZoom: SeismicityBenchmarkFeatureSource.dataZoom,
        tileBytes: archive.tileBytesAt(tileIndex: 1),
        onHypocenter: (hypocenter) {
          decoded.add((
            globalX: hypocenter.point.globalX,
            globalY: hypocenter.point.globalY,
          ));
        },
      );
      final sourceFeature = featureSource.featureAt(index: featuresPerTile);
      expect(
        decoded.first,
        (globalX: sourceFeature.globalX, globalY: sourceFeature.globalY),
      );

      for (final tileId in expectedIds) {
        final again = await archive.readTile(tileId: tileId);
        expect(again, isNotEmpty);
      }
      expect(archive.readCount, 12);
      expect(archive.maxRetainedPayloads, 1);
      expect(archive.retainedPayloads, 0);

      await archive.close();
      await archive.close();
      expect(archive.closeCount, 1);
      expect(
        () => archive.readTile(tileId: expectedIds.first),
        throwsA(isA<SeismicityPmTilesException>()),
      );
    },
  );
}
