import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

part 'seismicity_pmtiles_load_state.freezed.dart';

@freezed
sealed class SeismicityPmTilesLoadState with _$SeismicityPmTilesLoadState {
  const factory idle() = SeismicityPmTilesLoadIdle;

  const factory openingSource() =
      SeismicityPmTilesLoadOpeningSource;

  const factory readingDirectory() =
      SeismicityPmTilesLoadReadingDirectory;

  const factory decoding({
    required SeismicityPmTilesDecodeProgress progress,
  }) = SeismicityPmTilesLoadDecoding;

  const factory completed() =
      SeismicityPmTilesLoadCompleted;

  const factory failed({
    required SeismicityPmTilesException exception,
  }) = SeismicityPmTilesLoadFailed;

  const factory cancelled() =
      SeismicityPmTilesLoadCancelled;
}
