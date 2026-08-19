import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_pmtiles_decode_progress.freezed.dart';

@freezed
abstract class SeismicityPmTilesDecodeProgress
    with _$SeismicityPmTilesDecodeProgress {
  const factory({
    required int decodedTileCount,
    required int rawFeatureCount,
    required int uniqueFeatureCount,
  }) = _SeismicityPmTilesDecodeProgress;
}
