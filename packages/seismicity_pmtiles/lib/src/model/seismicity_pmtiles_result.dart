import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

part 'seismicity_pmtiles_result.freezed.dart';

@freezed
sealed class SeismicityPmTilesResult<T> with _$SeismicityPmTilesResult<T> {
  const factory SeismicityPmTilesResult.success({required T value}) =
      SeismicityPmTilesSuccess<T>;

  const factory SeismicityPmTilesResult.failure({
    required SeismicityPmTilesException exception,
  }) = SeismicityPmTilesFailure<T>;
}
