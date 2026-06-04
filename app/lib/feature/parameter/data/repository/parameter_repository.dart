import 'dart:convert';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_local_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ParameterRepository> parameterRepository(Ref ref) async {
  return ParameterRepository(
    assetDataSource: ref.watch(parameterAssetDataSourceProvider),
    localDataSource: await ref.watch(parameterLocalDataSourceProvider.future),
    parser: ref.watch(parameterJsonParserProvider),
    apiClient: await ref.watch(apiClientProvider.future),
  );
}

final class ParameterRepository {
  const ParameterRepository({
    required ParameterAssetDataSource assetDataSource,
    required ParameterLocalDataSource localDataSource,
    required ParameterJsonParser parser,
    required api.ApiClient apiClient,
  }) : _assetDataSource = assetDataSource,
       _localDataSource = localDataSource,
       _parser = parser,
       _apiClient = apiClient;

  final ParameterAssetDataSource _assetDataSource;
  final ParameterLocalDataSource _localDataSource;
  final ParameterJsonParser _parser;
  final api.ApiClient _apiClient;

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

  Future<bool> refresh() async {
    final manifestResponse = await _apiClient.parameters
        .getV2ParametersManifest();
    final manifestJson = jsonEncode(manifestResponse.data.toJson());
    final parameterJsonByType = <ParameterType, String>{};

    for (final type in ParameterType.values) {
      final response = await _apiClient.parameters.getV2ParametersType(
        type: type.toApiParameterType,
      );
      parameterJsonByType[type] = jsonEncode(response.data);
    }

    _parser.parseSet(
      manifestJson: manifestJson,
      parameterJsonByType: parameterJsonByType,
    );

    await _localDataSource.writeManifestJson(manifestJson);
    for (final entry in parameterJsonByType.entries) {
      await _localDataSource.writeParameterJson(
        type: entry.key,
        json: entry.value,
      );
    }
    return true;
  }
}
