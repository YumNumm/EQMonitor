import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_publication_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

void main() {
  final fixtures = _Task49Fixtures();
  const validator = SeismicityDatasetPublicationValidator();

  test('accepts a valid multi-chunk dataset', () {
    final descriptor = fixtures.descriptor(expectedFeatureCount: 2);
    expect(
      () => validator.validate(
        dataset: fixtures.dataset(
          descriptor: descriptor,
          chunks: [fixtures.chunk(id: 1), fixtures.chunk(id: 2)],
        ),
        acceptedDescriptor: descriptor,
      ),
      returnsNormally,
    );
  });

  test('rejects descriptor identity and count mismatches', () {
    final descriptor = fixtures.descriptor(expectedFeatureCount: 2);
    final base = fixtures.dataset(
      descriptor: descriptor,
      chunks: [fixtures.chunk(id: 1), fixtures.chunk(id: 2)],
    );
    expect(
      () => validator.validate(
        dataset: base.copyWith(schemaVersion: 2),
        acceptedDescriptor: descriptor,
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );
    expect(
      () => validator.validate(
        dataset: base.copyWith(dataZoom: 3),
        acceptedDescriptor: descriptor,
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );
    expect(
      () => validator.validate(
        dataset: base.copyWith(archiveRevision: 'other'),
        acceptedDescriptor: descriptor,
      ),
      throwsA(isA<SeismicityPmTilesDecoderWorkerFailedException>()),
    );
    expect(
      () => validator.validate(
        dataset: base.copyWith(featureCount: 3),
        acceptedDescriptor: descriptor,
      ),
      throwsA(isA<SeismicityPmTilesFeatureCountMismatchException>()),
    );
    expect(
      () => validator.validate(
        dataset: base,
        acceptedDescriptor: fixtures.descriptor(expectedFeatureCount: 3),
      ),
      throwsA(isA<SeismicityPmTilesFeatureCountMismatchException>()),
    );
  });

  test('rejects matching metadata when a chunk is corrupt', () {
    final descriptor = fixtures.descriptor(expectedFeatureCount: 1);
    final cases = [
      fixtures.corruptOffsetChunk(),
      fixtures.corruptValidityTailChunk(),
      fixtures.corruptNanAgreementChunk(),
      fixtures.corruptFixedColumnLengthChunk(),
    ];
    for (final chunk in cases) {
      expect(
        () => validator.validate(
          dataset: fixtures.dataset(descriptor: descriptor, chunks: [chunk]),
          acceptedDescriptor: descriptor,
        ),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );
    }
  });
}

final class _Task49Fixtures {
  SeismicityPmTilesArchiveDescriptor descriptor({
    required int expectedFeatureCount,
  }) => SeismicityPmTilesArchiveDescriptor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
    ),
    schemaVersion: 1,
    dataZoom: 0,
    expectedSizeBytes: 64,
    expectedFeatureCount: expectedFeatureCount,
    archiveRevision: 'rev-task-49',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  SeismicityPmTilesDataset dataset({
    required SeismicityPmTilesArchiveDescriptor descriptor,
    required List<SeismicityPmTilesChunk> chunks,
  }) => SeismicityPmTilesDataset(
    archiveRevision: descriptor.archiveRevision,
    schemaVersion: descriptor.schemaVersion,
    dataZoom: descriptor.dataZoom,
    featureCount: descriptor.expectedFeatureCount,
    chunks: chunks,
  );

  SeismicityPmTilesChunk chunk({required int id}) => SeismicityPmTilesChunk(
    hypocenterIds: Uint8List.fromList(List.filled(16, id)),
    latitudes: Float64List.fromList([(35 + id).toDouble()]),
    longitudes: Float64List.fromList([(139 + id).toDouble()]),
    depthsKm: Float32List.fromList([double.nan]),
    depthValidity: Uint8List(1),
    magnitudes: Float32List.fromList([double.nan]),
    magnitudeValidity: Uint8List(1),
    originTimeUnixMilliseconds: Int64List.fromList([id]),
    maxIntensityDictionaryIndexes: Uint32List(1),
    maxIntensityValidity: Uint8List(1),
    maxIntensityDictionaryUtf8: Uint8List(0),
    maxIntensityDictionaryOffsets: Uint32List.fromList([0]),
  );

  SeismicityPmTilesChunk corruptOffsetChunk() => chunk(id: 1).copyWith(
    maxIntensityDictionaryOffsets: Uint32List.fromList([1]),
  );

  SeismicityPmTilesChunk corruptValidityTailChunk() => chunk(id: 1).copyWith(
    depthValidity: Uint8List.fromList([0x80]),
  );

  SeismicityPmTilesChunk corruptNanAgreementChunk() => chunk(id: 1).copyWith(
    depthsKm: Float32List.fromList([1]),
    depthValidity: Uint8List(1),
  );

  SeismicityPmTilesChunk corruptFixedColumnLengthChunk() =>
      chunk(id: 1).copyWith(longitudes: Float64List.fromList([139, 140]));
}
