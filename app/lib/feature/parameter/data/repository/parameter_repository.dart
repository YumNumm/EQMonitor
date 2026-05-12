import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_local_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ParameterRepository> parameterRepository(Ref ref) async {
  return ParameterRepository(
    assetDataSource: ref.watch(parameterAssetDataSourceProvider),
    localDataSource: await ref.watch(parameterLocalDataSourceProvider.future),
    parser: ref.watch(parameterJsonParserProvider),
  );
}

final class ParameterRepository {
  const ParameterRepository({
    required ParameterAssetDataSource assetDataSource,
    required ParameterLocalDataSource localDataSource,
    required ParameterJsonParser parser,
  }) : _assetDataSource = assetDataSource,
       _localDataSource = localDataSource,
       _parser = parser;

  final ParameterAssetDataSource _assetDataSource;
  final ParameterLocalDataSource _localDataSource;
  final ParameterJsonParser _parser;

  /// ローカル保存済みデータを優先し、なければアセットから読み込む。
  Future<ParameterSet> load() async {
    final local = await loadLocalOrNull();
    if (local != null) {
      return local;
    }
    return loadAsset();
  }

  Future<ParameterSet?> loadLocalOrNull() async {
    final manifestJson = await _localDataSource.readManifestJson();
    if (manifestJson == null) {
      return null;
    }

    final parameterJsonByType = <ParameterType, String>{};
    for (final type in ParameterType.values) {
      final parameterJson = await _localDataSource.readParameterJson(type);
      if (parameterJson == null) {
        return null;
      }
      parameterJsonByType[type] = parameterJson;
    }

    try {
      return _parser.parseSet(
        manifestJson: manifestJson,
        parameterJsonByType: parameterJsonByType,
      );
    } on FormatException {
      return null;
    }
  }

  Future<ParameterSet> loadAsset() async {
    final manifestJson = await _assetDataSource.readManifestJson();
    final parameterJsonByType = <ParameterType, String>{};
    for (final type in ParameterType.values) {
      parameterJsonByType[type] = await _assetDataSource.readParameterJson(
        type,
      );
    }
    return _parser.parseSet(
      manifestJson: manifestJson,
      parameterJsonByType: parameterJsonByType,
    );
  }

  /// パラメーター更新 API は現バージョンでは未提供のため常に false を返す。
  Future<bool> refresh() async => false;
}
