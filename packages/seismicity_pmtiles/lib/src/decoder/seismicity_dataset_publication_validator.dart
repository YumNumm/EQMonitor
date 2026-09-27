import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_accumulator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

/// Fail-closed publication gate for every real or injected worker factory.
final class const SeismicityDatasetPublicationValidator({
  final SeismicityPmTilesChunkValidator chunkValidator =
      const SeismicityPmTilesChunkValidator(),
  final SeismicityDatasetChunkSumGate chunkSumGate =
      const SeismicityDatasetChunkSumGate(),
}) {
  void validate({
    required SeismicityPmTilesDataset dataset,
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
  }) {
    for (final chunk in dataset.chunks) {
      chunkValidator.validate(chunk: chunk);
    }
    chunkSumGate.ensureMatches(
      chunks: dataset.chunks,
      expectedFeatureCount: acceptedDescriptor.expectedFeatureCount,
    );
    if (dataset.schemaVersion != acceptedDescriptor.schemaVersion ||
        dataset.dataZoom != acceptedDescriptor.dataZoom ||
        dataset.archiveRevision != acceptedDescriptor.archiveRevision) {
      throw const SeismicityPmTilesException.decoderWorkerFailed(
        reason: 'descriptor_identity_mismatch',
      );
    }
    if (dataset.featureCount != acceptedDescriptor.expectedFeatureCount) {
      throw SeismicityPmTilesException.featureCountMismatch(
        expected: acceptedDescriptor.expectedFeatureCount,
        actual: dataset.featureCount,
      );
    }
  }
}
