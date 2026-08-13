import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
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

  const factory SeismicityPmTilesException.networkRequestFailed({
    required SeismicityPmTilesSource source,
    required int? statusCode,
  }) = SeismicityPmTilesNetworkRequestFailedException;

  const factory SeismicityPmTilesException.invalidNetworkResponse({
    required SeismicityPmTilesSource source,
    required int statusCode,
    required String reason,
  }) = SeismicityPmTilesInvalidNetworkResponseException;

  const factory SeismicityPmTilesException.archiveChanged({
    required SeismicityPmTilesSource source,
    required String? expectedEtag,
    required String? receivedEtag,
    required int statusCode,
  }) = SeismicityPmTilesArchiveChangedException;

  const factory SeismicityPmTilesException.cancelled({
    required SeismicityPmTilesSource source,
  }) = SeismicityPmTilesCancelledException;

  const factory SeismicityPmTilesException.closed({
    required SeismicityPmTilesSource source,
  }) = SeismicityPmTilesClosedException;

  const factory SeismicityPmTilesException.tileNotFound({
    required int tileId,
  }) = SeismicityPmTilesTileNotFoundException;

  const factory SeismicityPmTilesException.invalidTileId({
    required int tileId,
    required int minTileId,
    required int maxTileId,
  }) = SeismicityPmTilesInvalidTileIdException;
}

/// pmtiles_v3が投げるPMTiles v3仕様レベルの例外を、この packageの公開例外型
/// へ翻訳する。`source`はarchiveを開いた際のdescriptorが持つsourceで、
/// pmtiles_v3自体はsourceを知らないためここで補う。
extension PmTilesV3ExceptionToSeismicityException on PmTilesV3Exception {
  SeismicityPmTilesException toSeismicityException({
    required SeismicityPmTilesSource source,
  }) {
    return switch (this) {
      PmTilesV3InvalidRangeException(
        :final offset,
        :final length,
        :final sizeBytes,
      ) =>
        SeismicityPmTilesException.invalidRange(
          offset: offset,
          length: length,
          sizeBytes: sizeBytes,
        ),
      PmTilesV3CorruptArchiveException(:final reason) =>
        SeismicityPmTilesException.corruptArchive(reason: reason),
      PmTilesV3UnsupportedCompressionException(:final compression) =>
        SeismicityPmTilesException.unsupportedCompression(
          compression: compression,
        ),
      PmTilesV3SourceReadFailedException(:final reason) =>
        SeismicityPmTilesException.sourceReadFailed(
          source: source,
          reason: reason,
        ),
      PmTilesV3InvalidTileIdException(
        :final tileId,
        :final minTileId,
        :final maxTileId,
      ) =>
        SeismicityPmTilesException.invalidTileId(
          tileId: tileId,
          minTileId: minTileId,
          maxTileId: maxTileId,
        ),
      // このpackageは常にtile IDでarchiveを読み、z/x/y座標変換を使わない
      // ため、実際には発生しない。
      PmTilesV3InvalidTileCoordinateException() =>
        const SeismicityPmTilesException.corruptArchive(
          reason: 'Unexpected tile coordinate lookup on a tile ID archive.',
        ),
    };
  }
}
