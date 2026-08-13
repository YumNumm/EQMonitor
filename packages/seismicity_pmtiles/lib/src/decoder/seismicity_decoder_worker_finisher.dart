import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_accumulator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityDecoderWorkerFinisher {
  const SeismicityDecoderWorkerFinisher();

  SeismicityPmTilesDataset materialize({
    required SeismicityDatasetTransfer transfer,
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
  }) {
    if (transfer.archiveRevision != acceptedDescriptor.archiveRevision ||
        transfer.schemaVersion != acceptedDescriptor.schemaVersion ||
        transfer.dataZoom != acceptedDescriptor.dataZoom) {
      throw const SeismicityPmTilesException.decoderWorkerFailed(
        reason: 'descriptor_identity_mismatch',
      );
    }
    if (transfer.featureCount != acceptedDescriptor.expectedFeatureCount) {
      throw SeismicityPmTilesException.featureCountMismatch(
        expected: acceptedDescriptor.expectedFeatureCount,
        actual: transfer.featureCount,
      );
    }
    final chunks = <SeismicityPmTilesChunk>[
      for (final chunkTransfer in transfer.chunks) chunkTransfer.materialize(),
    ];
    const SeismicityDatasetChunkSumGate().ensureMatches(
      chunks: chunks,
      expectedFeatureCount: acceptedDescriptor.expectedFeatureCount,
    );
    return SeismicityPmTilesDataset(
      archiveRevision: acceptedDescriptor.archiveRevision,
      schemaVersion: acceptedDescriptor.schemaVersion,
      dataZoom: acceptedDescriptor.dataZoom,
      featureCount: acceptedDescriptor.expectedFeatureCount,
      chunks: chunks,
    );
  }
}
