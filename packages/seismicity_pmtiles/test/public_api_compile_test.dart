import 'dart:typed_data';

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

void main() {
  test('stable reader and archive contracts compile through the barrel', () {
    const factory = SeismicityRandomAccessReaderFactory(
      assetLoader: loadPublicApiAsset,
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
    expect(entry.runLength, 1);
  });
}
