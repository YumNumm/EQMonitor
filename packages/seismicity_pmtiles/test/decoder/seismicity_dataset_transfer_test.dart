import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:test/test.dart';

void main() {
  test('transfers exact dataset metadata and ordered chunks once', () async {
    final transfer = SeismicityDatasetTransfer(
      archiveRevision: 'revision-30',
      schemaVersion: 1,
      dataZoom: 12,
      featureCount: 2,
      chunks: [
        SeismicityChunkTransfer.fromChunk(chunk: chunk(id: 1)),
        SeismicityChunkTransfer.fromChunk(chunk: chunk(id: 2)),
      ],
    );

    final received = await Isolate.run(() => transfer);
    expect(received.archiveRevision, 'revision-30');
    expect(received.schemaVersion, 1);
    expect(received.dataZoom, 12);
    expect(received.featureCount, 2);
    expect(received.chunks, hasLength(2));
    expect(
      received.chunks.map((chunk) => chunk.materialize().hypocenterIds.first),
      [1, 2],
    );
    for (final chunk in received.chunks) {
      expect(chunk.materialize, throwsArgumentError);
    }
  });

  test('transfers an empty chunk collection without event models', () async {
    final received = await Isolate.run(
      () => SeismicityDatasetTransfer(
        archiveRevision: 'empty',
        schemaVersion: 1,
        dataZoom: 0,
        featureCount: 0,
        chunks: const [],
      ),
    );

    expect(received.chunks, isEmpty);
    expect(received.featureCount, 0);
  });
}

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
