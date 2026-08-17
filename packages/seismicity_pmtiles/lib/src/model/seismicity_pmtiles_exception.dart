import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';

part 'seismicity_pmtiles_exception.freezed.dart';

@freezed
sealed class SeismicityPmTilesException
    with _$SeismicityPmTilesException
    implements Exception {
  const factory invalidDescriptor({
    required String reason,
  }) = SeismicityPmTilesInvalidDescriptorException;

  const factory invalidRange({
    required int offset,
    required int length,
    required int sizeBytes,
  }) = SeismicityPmTilesInvalidRangeException;

  const factory corruptArchive({
    required String reason,
  }) = SeismicityPmTilesCorruptArchiveException;

  const factory unsupportedCompression({
    required int compression,
  }) = SeismicityPmTilesUnsupportedCompressionException;

  const factory unsupportedSource({
    required SeismicityPmTilesSource source,
  }) = SeismicityPmTilesUnsupportedSourceException;

  const factory sourceReadFailed({
    required SeismicityPmTilesSource source,
    required String reason,
  }) = SeismicityPmTilesSourceReadFailedException;

  const factory networkRequestFailed({
    required SeismicityPmTilesSource source,
    required int? statusCode,
  }) = SeismicityPmTilesNetworkRequestFailedException;

  const factory invalidNetworkResponse({
    required SeismicityPmTilesSource source,
    required int statusCode,
    required String reason,
  }) = SeismicityPmTilesInvalidNetworkResponseException;

  const factory archiveChanged({
    required SeismicityPmTilesSource source,
    required String? expectedEtag,
    required String? receivedEtag,
    required int statusCode,
  }) = SeismicityPmTilesArchiveChangedException;

  const factory cancelled({
    required SeismicityPmTilesSource source,
  }) = SeismicityPmTilesCancelledException;

  const factory closed({
    required SeismicityPmTilesSource source,
  }) = SeismicityPmTilesClosedException;

  const factory unsupportedSchema({
    required int expected,
    required int actual,
  }) = SeismicityPmTilesUnsupportedSchemaException;

  const factory invalidVectorTile({
    required int tileId,
    required String reason,
  }) = SeismicityPmTilesInvalidVectorTileException;

  const factory invalidHypocenterFeature({
    required int tileId,
    required int featureIndex,
    required String field,
    required String reason,
  }) = SeismicityPmTilesInvalidHypocenterFeatureException;

  const factory duplicateConflict({
    required String hypocenterId,
  }) = SeismicityPmTilesDuplicateConflictException;

  const factory featureCountMismatch({
    required int expected,
    required int actual,
  }) = SeismicityPmTilesFeatureCountMismatchException;

  const factory decoderWorkerFailed({
    required String reason,
  }) = SeismicityPmTilesDecoderWorkerFailedException;

  const factory tileNotFound({
    required int tileId,
  }) = SeismicityPmTilesTileNotFoundException;

  const factory invalidTileId({
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
