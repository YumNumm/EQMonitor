import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

part 'seismicity_pmtiles_load_state.freezed.dart';

@freezed
sealed class SeismicityPmTilesLoadState with _$SeismicityPmTilesLoadState {
  const factory SeismicityPmTilesLoadState.idle() = SeismicityPmTilesLoadIdle;

  const factory SeismicityPmTilesLoadState.openingSource() =
      SeismicityPmTilesLoadOpeningSource;

  const factory SeismicityPmTilesLoadState.readingDirectory() =
      SeismicityPmTilesLoadReadingDirectory;

  const factory SeismicityPmTilesLoadState.decoding({
    required SeismicityPmTilesDecodeProgress progress,
  }) = SeismicityPmTilesLoadDecoding;

  const factory SeismicityPmTilesLoadState.completed() =
      SeismicityPmTilesLoadCompleted;

  const factory SeismicityPmTilesLoadState.failed({
    required SeismicityPmTilesException exception,
  }) = SeismicityPmTilesLoadFailed;

  const factory SeismicityPmTilesLoadState.cancelled() =
      SeismicityPmTilesLoadCancelled;
}
