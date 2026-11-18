import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';

final class SeismicityDatasetTransfer({
  required final String archiveRevision,
  required final int schemaVersion,
  required final int dataZoom,
  required final int featureCount,
  required List<SeismicityChunkTransfer> chunks,
}) {
  final List<SeismicityChunkTransfer> chunks = List.unmodifiable(chunks);
}
