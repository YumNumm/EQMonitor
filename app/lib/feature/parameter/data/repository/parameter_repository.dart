import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_local_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Riverpod(keepAlive: true)
Future<ParameterRepository> parameterRepository(Ref ref) async {
  final dio = await ref.watch(dioProvider.future);
  return ParameterRepository(
    apiClient: api.ParametersApiClient(dio),
    assetDataSource: ParameterAssetDataSource(bundle: rootBundle),
    localDataSource: ParameterLocalDataSource(
      documentsDirectory: ref.watch(applicationDocumentsDirectoryProvider),
    ),
    parser: const ParameterJsonParser(),
  );
}

final class ParameterRepository {
  const ParameterRepository({
    required api.ParametersApiClient apiClient,
    required ParameterAssetDataSource assetDataSource,
    required ParameterLocalDataSource localDataSource,
    required ParameterJsonParser parser,
  }) : _apiClient = apiClient,
       _assetDataSource = assetDataSource,
       _localDataSource = localDataSource,
       _parser = parser;

  final api.ParametersApiClient _apiClient;
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
      parameterJsonByType[type] = await _assetDataSource.readParameterJson(type);
    }
    return _parser.parseSet(
      manifestJson: manifestJson,
      parameterJsonByType: parameterJsonByType,
    );
  }

  /// Manifest に If-None-Match リクエストを送り、更新があれば差分のみ取得して保存する。
  ///
  /// 戻り値: パラメーターが更新された場合は true、更新なし・エラーの場合は false。
  Future<bool> refresh() async {
    try {
      final etag = await _localDataSource.readEtag();

      late api.ParametersManifestResponse remoteManifest;
      late String? responseEtag;
      try {
        final manifestResponse = await _apiClient.getV2ParametersManifest(
          ifNoneMatch: etag,
        );
        remoteManifest = manifestResponse.data;
        responseEtag = manifestResponse.response.headers.value(
          HttpHeaders.etagHeader,
        );
      } on DioException catch (e) {
        if (e.response?.statusCode == HttpStatus.notModified) {
          return false;
        }
        return false;
      }

      final manifestJson = jsonEncode(remoteManifest.toJson());
      final currentManifest = await _readCurrentManifestOrNull();
      final fetchedParameterJsonByType = <ParameterType, String>{};

      for (final item in remoteManifest.parameters) {
        final appType = item.type.toParameterType();
        final currentItem = currentManifest?.parameters.firstWhereOrNull(
          (p) => p.type == appType,
        );
        final hasLocalParameter = await _localDataSource.hasParameterJson(
          appType,
        );
        if (currentItem?.sha256 == item.sha256 && hasLocalParameter) {
          continue;
        }
        final parameterJson = await _fetchParameterJson(appType);
        _parser.parseParameter(type: appType, source: parameterJson);
        fetchedParameterJsonByType[appType] = parameterJson;
      }

      for (final entry in fetchedParameterJsonByType.entries) {
        await _localDataSource.writeParameterJson(
          type: entry.key,
          json: entry.value,
        );
      }
      await _localDataSource.writeManifestJson(manifestJson);
      await _localDataSource.writeEtag(responseEtag);
      return fetchedParameterJsonByType.isNotEmpty;
    } on DioException {
      return false;
    } on FormatException {
      return false;
    } on FileSystemException {
      return false;
    }
  }

  Future<String> _fetchParameterJson(ParameterType type) async {
    final response = await _apiClient.getV2ParametersType(
      type: type.toApi,
    );
    return jsonEncode(response.data);
  }

  Future<ParameterManifest?> _readCurrentManifestOrNull() async {
    final localManifestJson = await _localDataSource.readManifestJson();
    if (localManifestJson != null) {
      try {
        return _parser.parseManifest(localManifestJson);
      } on FormatException {
        return null;
      }
    }
    final assetManifestJson = await _assetDataSource.readManifestJson();
    return _parser.parseManifest(assetManifestJson);
  }
}
