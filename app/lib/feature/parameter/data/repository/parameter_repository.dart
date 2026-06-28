import 'dart:convert';

import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ParameterRepository> parameterRepository(Ref ref) async {
  return ParameterRepository(
    assetDataSource: ref.watch(parameterAssetDataSourceProvider),
    parser: ref.watch(parameterJsonParserProvider),
  );
}

final class ParameterRepository {
  const ParameterRepository({
    required ParameterAssetDataSource assetDataSource,
    required ParameterJsonParser parser,
  }) : _assetDataSource = assetDataSource,
       _parser = parser;

  final ParameterAssetDataSource _assetDataSource;
  final ParameterJsonParser _parser;

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

  Future<ParameterSet> fetch(api.ApiClient client) async {
    final manifestResponse = await client.parameters.getV2ParametersManifest();
    final manifestJson = jsonEncode(manifestResponse.data.toJson());
    final parameterJsonByType = <ParameterType, String>{};

    for (final type in ParameterType.values) {
      final response = await client.parameters.getV2ParametersType(
        type: type.toApiParameterType,
      );
      parameterJsonByType[type] = jsonEncode(response.data);
    }

    return _parser.parseSet(
      manifestJson: manifestJson,
      parameterJsonByType: parameterJsonByType,
    );
  }
}
