import 'package:freezed_annotation/freezed_annotation.dart';

part 'pmtiles_v3_exception.freezed.dart';

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
