import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';

part 'seismicity_pmtiles_exception.freezed.dart';

@freezed
sealed class SeismicityPmTilesException
    with _$SeismicityPmTilesException
    implements Exception {
  const factory SeismicityPmTilesException.invalidDescriptor({
    required String reason,
  }) = SeismicityPmTilesInvalidDescriptorException;

  const factory SeismicityPmTilesException.invalidRange({
    required int offset,
    required int length,
    required int sizeBytes,
  }) = SeismicityPmTilesInvalidRangeException;

  const factory SeismicityPmTilesException.corruptArchive({
    required String reason,
  }) = SeismicityPmTilesCorruptArchiveException;

  const factory SeismicityPmTilesException.unsupportedCompression({
    required int compression,
  }) = SeismicityPmTilesUnsupportedCompressionException;

  const factory SeismicityPmTilesException.unsupportedSource({
    required SeismicityPmTilesSource source,
  }) = SeismicityPmTilesUnsupportedSourceException;

  const factory SeismicityPmTilesException.sourceReadFailed({
    required SeismicityPmTilesSource source,
    required String reason,
  }) = SeismicityPmTilesSourceReadFailedException;
}
