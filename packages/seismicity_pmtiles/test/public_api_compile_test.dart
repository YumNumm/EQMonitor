import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

final class PublicApiReader implements PmTilesRandomAccessReader {
  @override
  int get sizeBytes => 1;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) {
    return Future<Uint8List>.value(Uint8List(length));
  }

  @override
  Future<void> close() => Future<void>.value();
}

Future<Uint8List> loadPublicApiAsset({required String assetKey}) {
  return Future<Uint8List>.value(Uint8List.fromList(assetKey.codeUnits));
}

Future<SeismicityPmTilesArchive> openPublicApiArchive({
  required PmTilesRandomAccessReader reader,
  required SeismicityPmTilesArchiveDescriptor descriptor,
}) {
  return SeismicityPmTilesArchive.open(
    reader: reader,
    descriptor: descriptor,
  );
}

SeismicityPmTilesArchiveDescriptor readPublicApiArchiveDescriptor({
  required SeismicityPmTilesArchive archive,
}) => archive.descriptor;

SeismicityPmTilesDataset replacePublicApiChunks({
  required SeismicityPmTilesDataset dataset,
  required List<SeismicityPmTilesChunk> chunks,
}) => dataset.copyWith(chunks: chunks);

void main() {
  test('stable reader and archive contracts compile through the barrel', () {
    final factory = SeismicityRandomAccessReaderFactory(
      assetLoader: loadPublicApiAsset,
      dio: Dio(),
      networkMaxCacheBytes: 1024,
    );
    final reader = PublicApiReader();
    const entry = PmTilesV3DirectoryEntry(
      tileId: 0,
      offset: 0,
      length: 1,
      runLength: 1,
    );

    expect(factory.assetLoader, loadPublicApiAsset);
    expect(reader.sizeBytes, 1);
    expect(openPublicApiArchive, isA<Function>());
    expect(readPublicApiArchiveDescriptor, isA<Function>());
    expect(replacePublicApiChunks, isA<Function>());
    expect(
      const SeismicityPmTilesDecodeProgress(
        decodedTileCount: 0,
        rawFeatureCount: 0,
        uniqueFeatureCount: 0,
      ).uniqueFeatureCount,
      0,
    );
    expect(entry.runLength, 1);
  });
}
