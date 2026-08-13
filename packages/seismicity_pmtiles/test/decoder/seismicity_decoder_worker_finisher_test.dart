import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_finisher.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

void main() {
  final fixtures = _Task42Fixtures();
  const finisher = SeismicityDecoderWorkerFinisher();

  test(
    'finisher materializes a valid transfer against accepted descriptor',
    () {
      final descriptor = fixtures.descriptor(expectedFeatureCount: 2);
      final transfer = fixtures.transfer(
        archiveRevision: descriptor.archiveRevision,
        schemaVersion: descriptor.schemaVersion,
        dataZoom: descriptor.dataZoom,
        featureCount: 2,
        chunks: [
          SeismicityChunkTransfer.fromChunk(chunk: fixtures.chunk(id: 1)),
          SeismicityChunkTransfer.fromChunk(chunk: fixtures.chunk(id: 2)),
        ],
      );

      final dataset = finisher.materialize(
        transfer: transfer,
        acceptedDescriptor: descriptor,
      );
      expect(dataset.archiveRevision, descriptor.archiveRevision);
      expect(dataset.schemaVersion, 1);
      expect(dataset.dataZoom, 14);
      expect(dataset.featureCount, 2);
      expect(dataset.chunks.map((chunk) => chunk.hypocenterIds.first), [1, 2]);
    },
  );

  test(
    'finisher rejects identity count sum and chunk invariant mismatches',
    () {
      final descriptor = fixtures.descriptor(expectedFeatureCount: 2);

      List<SeismicityChunkTransfer> twoChunks() => [
        SeismicityChunkTransfer.fromChunk(chunk: fixtures.chunk(id: 1)),
        SeismicityChunkTransfer.fromChunk(chunk: fixtures.chunk(id: 2)),
      ];

      final cases =
          <
            ({
              String name,
              SeismicityDatasetTransfer transfer,
              SeismicityPmTilesArchiveDescriptor accepted,
              Matcher error,
            })
          >[
            (
              name: 'schema',
              transfer: fixtures.transfer(
                archiveRevision: descriptor.archiveRevision,
                schemaVersion: 2,
                dataZoom: descriptor.dataZoom,
                featureCount: 2,
                chunks: twoChunks(),
              ),
              accepted: descriptor,
              error: isA<SeismicityPmTilesDecoderWorkerFailedException>()
                  .having(
                    (error) => error.reason,
                    'reason',
                    'descriptor_identity_mismatch',
                  ),
            ),
            (
              name: 'dataZoom',
              transfer: fixtures.transfer(
                archiveRevision: descriptor.archiveRevision,
                schemaVersion: descriptor.schemaVersion,
                dataZoom: 13,
                featureCount: 2,
                chunks: twoChunks(),
              ),
              accepted: descriptor,
              error: isA<SeismicityPmTilesDecoderWorkerFailedException>()
                  .having(
                    (error) => error.reason,
                    'reason',
                    'descriptor_identity_mismatch',
                  ),
            ),
            (
              name: 'archiveRevision',
              transfer: fixtures.transfer(
                archiveRevision: 'other-rev',
                schemaVersion: descriptor.schemaVersion,
                dataZoom: descriptor.dataZoom,
                featureCount: 2,
                chunks: twoChunks(),
              ),
              accepted: descriptor,
              error: isA<SeismicityPmTilesDecoderWorkerFailedException>()
                  .having(
                    (error) => error.reason,
                    'reason',
                    'descriptor_identity_mismatch',
                  ),
            ),
            (
              name: 'featureCount',
              transfer: fixtures.transfer(
                archiveRevision: descriptor.archiveRevision,
                schemaVersion: descriptor.schemaVersion,
                dataZoom: descriptor.dataZoom,
                featureCount: 3,
                chunks: twoChunks(),
              ),
              accepted: descriptor,
              error: isA<SeismicityPmTilesFeatureCountMismatchException>(),
            ),
            (
              name: 'chunkSum',
              transfer: fixtures.transfer(
                archiveRevision: descriptor.archiveRevision,
                schemaVersion: descriptor.schemaVersion,
                dataZoom: descriptor.dataZoom,
                featureCount: 2,
                chunks: [
                  SeismicityChunkTransfer.fromChunk(
                    chunk: fixtures.chunk(id: 1),
                  ),
                ],
              ),
              accepted: descriptor,
              error: isA<SeismicityPmTilesFeatureCountMismatchException>(),
            ),
            (
              name: 'chunkInvariant',
              transfer: fixtures.transfer(
                archiveRevision: descriptor.archiveRevision,
                schemaVersion: descriptor.schemaVersion,
                dataZoom: descriptor.dataZoom,
                featureCount: 1,
                chunks: [
                  SeismicityChunkTransfer.fromChunk(
                    chunk: fixtures.corruptOffsetChunk(),
                  ),
                ],
              ),
              accepted: fixtures.descriptor(expectedFeatureCount: 1),
              error: isA<SeismicityPmTilesCorruptArchiveException>(),
            ),
          ];

      for (final testCase in cases) {
        expect(
          () => finisher.materialize(
            transfer: testCase.transfer,
            acceptedDescriptor: testCase.accepted,
          ),
          throwsA(testCase.error),
          reason: testCase.name,
        );
      }

      final otherArchive = fixtures.descriptor(
        expectedFeatureCount: 2,
        archiveRevision: 'relabel-rev',
      );
      expect(
        () => finisher.materialize(
          transfer: fixtures.transfer(
            archiveRevision: descriptor.archiveRevision,
            schemaVersion: descriptor.schemaVersion,
            dataZoom: descriptor.dataZoom,
            featureCount: 2,
            chunks: twoChunks(),
          ),
          acceptedDescriptor: otherArchive,
        ),
        throwsA(
          isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
            (error) => error.reason,
            'reason',
            'descriptor_identity_mismatch',
          ),
        ),
      );
    },
  );
}

final class _Task42Fixtures {
  SeismicityPmTilesArchiveDescriptor descriptor({
    required int expectedFeatureCount,
    String archiveRevision = 'rev-task-42',
  }) => SeismicityPmTilesArchiveDescriptor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
    ),
    schemaVersion: 1,
    dataZoom: 14,
    expectedSizeBytes: 128,
    expectedFeatureCount: expectedFeatureCount,
    archiveRevision: archiveRevision,
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  SeismicityDatasetTransfer transfer({
    required String archiveRevision,
    required int schemaVersion,
    required int dataZoom,
    required int featureCount,
    required List<SeismicityChunkTransfer> chunks,
  }) => SeismicityDatasetTransfer(
    archiveRevision: archiveRevision,
    schemaVersion: schemaVersion,
    dataZoom: dataZoom,
    featureCount: featureCount,
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

  SeismicityPmTilesChunk corruptOffsetChunk() => SeismicityPmTilesChunk(
    hypocenterIds: Uint8List(16),
    latitudes: Float64List.fromList([35]),
    longitudes: Float64List.fromList([139]),
    depthsKm: Float32List.fromList([double.nan]),
    depthValidity: Uint8List(1),
    magnitudes: Float32List.fromList([double.nan]),
    magnitudeValidity: Uint8List(1),
    originTimeUnixMilliseconds: Int64List.fromList([1]),
    maxIntensityDictionaryIndexes: Uint32List(1),
    maxIntensityValidity: Uint8List(1),
    maxIntensityDictionaryUtf8: Uint8List(0),
    maxIntensityDictionaryOffsets: Uint32List.fromList([1]),
  );
}
