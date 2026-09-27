import 'package:freezed_annotation/freezed_annotation.dart';

part 'pmtiles_v3_exception.freezed.dart';

/// PMTilesのどのresource budgetを超えたかを、payloadを保持せずに分類する。
enum PmTilesV3Resource {
  directoryEncoded,
  directoryDecoded,
  directoryEntries,
  tileEncoded,
  tileDecoded,
}

@freezed
sealed class PmTilesV3Exception with _$PmTilesV3Exception implements Exception {
  const factory invalidRange({
    required int offset,
    required int length,
    required int sizeBytes,
  }) = PmTilesV3InvalidRangeException;

  const factory corruptArchive({
    required String reason,
  }) = PmTilesV3CorruptArchiveException;

  const factory unsupportedCompression({
    required int compression,
  }) = PmTilesV3UnsupportedCompressionException;

  const factory sourceReadFailed({
    required String reason,
  }) = PmTilesV3SourceReadFailedException;

  const factory resourceLimitExceeded({
    required PmTilesV3Resource resource,
    required int limit,
    required int actual,
  }) = PmTilesV3ResourceLimitExceededException;

  const factory invalidTileId({
    required int tileId,
    required int minTileId,
    required int maxTileId,
  }) = PmTilesV3InvalidTileIdException;

  const factory invalidTileCoordinate({
    required int z,
    required int x,
    required int y,
  }) = PmTilesV3InvalidTileCoordinateException;
}
