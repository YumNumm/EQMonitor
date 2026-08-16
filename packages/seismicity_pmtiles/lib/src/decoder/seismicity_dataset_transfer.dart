import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';

final class SeismicityDatasetTransfer {
  SeismicityDatasetTransfer({
    required this.archiveRevision,
    required this.schemaVersion,
    required this.dataZoom,
    required this.featureCount,
    required List<SeismicityChunkTransfer> chunks,
  }) : chunks = List.unmodifiable(chunks);

  final String archiveRevision;
  final int schemaVersion;
  final int dataZoom;
  final int featureCount;
  final List<SeismicityChunkTransfer> chunks;
}
