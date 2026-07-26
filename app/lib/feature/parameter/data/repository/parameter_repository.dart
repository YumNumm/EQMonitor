import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ParameterRepository> parameterRepository(Ref ref) async {
  return ParameterRepository(
    assetDataSource: ref.watch(parameterAssetDataSourceProvider),
    parser: ref.watch(parameterJsonParserProvider),
  );
}

/// Loads [ParameterSet] from the platform Asset Pack. This is the sole
/// source of parameter data (no HTTP fetch, no bundled-asset fallback):
/// if the pack isn't ready, `AssetPackNotReadyException` propagates from
/// [assetDataSource] unchanged.
final class ParameterRepository {
  const ParameterRepository({
    required ParameterAssetDataSource assetDataSource,
    required ParameterJsonParser parser,
  }) : _assetDataSource = assetDataSource,
       _parser = parser;

  final ParameterAssetDataSource _assetDataSource;
  final ParameterJsonParser _parser;

  Future<ParameterSet> loadAsset() async {
    final manifest = await _assetDataSource.readManifest();
    final parameterJsonByType = <ParameterType, String>{};
    for (final type in ParameterType.values) {
      parameterJsonByType[type] = await _assetDataSource.readParameterJson(
        type,
      );
    }
    return _parser.parseSet(
      manifest: manifest,
      parameterJsonByType: parameterJsonByType,
    );
  }
}
