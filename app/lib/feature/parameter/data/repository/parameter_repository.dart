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

/// Loads [ParameterSet] from the active Asset Pack. This is the sole source of
/// parameter data (no HTTP fetch). If a downloaded pack cannot be parsed, it is
/// deactivated and the pack bundled with the app is parsed instead.
final class const ParameterRepository({
  required ParameterAssetDataSource assetDataSource,
  required ParameterJsonParser parser,
}) {
  final ParameterAssetDataSource _assetDataSource = assetDataSource;
  final ParameterJsonParser _parser = parser;

  Future<ParameterSet> loadAsset() => _assetDataSource.readParameters(
    (manifest, parameterJsonByType) => _parser.parseSet(
      manifest: manifest,
      parameterJsonByType: parameterJsonByType,
    ),
  );
}
