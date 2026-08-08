import 'package:dio/dio.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_asset_loader.dart';

final class SeismicityRandomAccessReaderFactory {
  const SeismicityRandomAccessReaderFactory({
    required this.assetLoader,
    required this.dio,
    required this.networkMaxCacheBytes,
  });

  final SeismicityPmTilesAssetLoader assetLoader;
  final Dio dio;
  final int networkMaxCacheBytes;

  Future<SeismicityPmTilesResult<PmTilesRandomAccessReader>> create({
    required SeismicityPmTilesArchiveDescriptor descriptor,
    required CancelToken cancelToken,
  }) async {
    final source = descriptor.source;
    switch (source) {
      case SeismicityPmTilesNetworkSource():
        return SeismicityPmTilesResult<PmTilesRandomAccessReader>.failure(
          exception: SeismicityPmTilesException.unsupportedSource(
            source: source,
          ),
        );
      case SeismicityPmTilesFileSource():
        try {
          final reader = await PmTilesV3FileRandomAccessReader.open(
            path: source.path,
          );
          return SeismicityPmTilesResult<PmTilesRandomAccessReader>.success(
            value: reader,
          );
        } on PmTilesV3Exception catch (exception) {
          return SeismicityPmTilesResult<PmTilesRandomAccessReader>.failure(
            exception: exception.toSeismicityException(source: source),
          );
        }
      case SeismicityPmTilesAssetSource():
        try {
          final reader = await PmTilesV3AssetRandomAccessReader.open(
            assetKey: source.assetKey,
            assetLoader: assetLoader,
          );
          return SeismicityPmTilesResult<PmTilesRandomAccessReader>.success(
            value: reader,
          );
        } on PmTilesV3Exception catch (exception) {
          return SeismicityPmTilesResult<PmTilesRandomAccessReader>.failure(
            exception: exception.toSeismicityException(source: source),
          );
        }
    }
  }
}
