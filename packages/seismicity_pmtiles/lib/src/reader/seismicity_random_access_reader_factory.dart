import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/asset_random_access_reader.dart';
import 'package:seismicity_pmtiles/src/reader/file_random_access_reader.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_asset_loader.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_random_access_reader.dart';

final class SeismicityRandomAccessReaderFactory {
  const SeismicityRandomAccessReaderFactory({required this.assetLoader});

  final SeismicityPmTilesAssetLoader assetLoader;

  Future<SeismicityPmTilesResult<SeismicityRandomAccessReader>> create({
    required SeismicityPmTilesSource source,
  }) async {
    switch (source) {
      case SeismicityPmTilesNetworkSource():
        return SeismicityPmTilesResult<SeismicityRandomAccessReader>.failure(
          exception: SeismicityPmTilesException.unsupportedSource(
            source: source,
          ),
        );
      case SeismicityPmTilesFileSource():
        try {
          final reader = await FileRandomAccessReader.open(source: source);
          return SeismicityPmTilesResult<SeismicityRandomAccessReader>.success(
            value: reader,
          );
        } on SeismicityPmTilesException catch (exception) {
          return SeismicityPmTilesResult<SeismicityRandomAccessReader>.failure(
            exception: exception,
          );
        }
      case SeismicityPmTilesAssetSource():
        try {
          final reader = await AssetRandomAccessReader.open(
            source: source,
            assetLoader: assetLoader,
          );
          return SeismicityPmTilesResult<SeismicityRandomAccessReader>.success(
            value: reader,
          );
        } on SeismicityPmTilesException catch (exception) {
          return SeismicityPmTilesResult<SeismicityRandomAccessReader>.failure(
            exception: exception,
          );
        }
    }
  }
}
