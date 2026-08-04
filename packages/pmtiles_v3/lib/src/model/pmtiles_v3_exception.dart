import 'package:freezed_annotation/freezed_annotation.dart';

part 'pmtiles_v3_exception.freezed.dart';

@freezed
sealed class PmTilesV3Exception with _$PmTilesV3Exception implements Exception {
  const factory PmTilesV3Exception.invalidRange({
    required int offset,
    required int length,
    required int sizeBytes,
  }) = PmTilesV3InvalidRangeException;

  const factory PmTilesV3Exception.corruptArchive({
    required String reason,
  }) = PmTilesV3CorruptArchiveException;

  const factory PmTilesV3Exception.unsupportedCompression({
    required int compression,
  }) = PmTilesV3UnsupportedCompressionException;

  const factory PmTilesV3Exception.sourceReadFailed({
    required String reason,
  }) = PmTilesV3SourceReadFailedException;

  const factory PmTilesV3Exception.invalidTileId({
    required int tileId,
    required int minTileId,
    required int maxTileId,
  }) = PmTilesV3InvalidTileIdException;

  const factory PmTilesV3Exception.invalidTileCoordinate({
    required int z,
    required int x,
    required int y,
  }) = PmTilesV3InvalidTileCoordinateException;
}
