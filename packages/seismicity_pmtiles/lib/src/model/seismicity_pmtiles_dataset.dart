import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';

part 'seismicity_pmtiles_dataset.freezed.dart';

@Freezed(equal: false)
abstract class SeismicityPmTilesDataset with _$SeismicityPmTilesDataset {
  const factory({
    required String archiveRevision,
    required int schemaVersion,
    required int dataZoom,
    required int featureCount,
    required List<SeismicityPmTilesChunk> chunks,
  }) = _SeismicityPmTilesDataset;
}
