import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'fetch stores parameter json in package cache and restores it',
    () async {
      final db = CacheDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final store = HttpCacheStore(
        db: db,
        schemaVersion: 1,
        appBuild: '3.0.0+100',
      );
      final adapter = _ParametersApiAdapter();
      final normalDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(HttpCacheInterceptor(store))
        ..httpClientAdapter = adapter;
      final cacheOnlyDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(CacheOnlyInterceptor(store));
      final repository = ParameterRepository(
        assetDataSource: ParameterAssetDataSource(bundle: rootBundle),
        parser: const ParameterJsonParser(),
      );

      final fresh = await repository.fetch(api.ApiClient(normalDio));
      final cached = await repository.fetch(api.ApiClient(cacheOnlyDio));

      expect(fresh.jmaCodeTable.metadata.sourceVersion, 'test');
      expect(cached.jmaCodeTable.metadata.sourceVersion, 'test');
      expect(adapter.requestedTypes, [
        'JMA_CODE_TABLE',
        'KYOSHIN_OBSERVATION_POINTS',
        'EARTHQUAKE_STATIONS',
        'TSUNAMI_STATIONS',
        'SHINDO_DB_STATIONS',
      ]);
    },
  );
}

final class _ParametersApiAdapter implements HttpClientAdapter {
  final requestedTypes = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final path = options.path;
    final Object body = switch (path) {
      '/v2/parameters/manifest' => _manifestJson(),
      _ when path.startsWith('/v2/parameters/') => () {
        final type = path.split('/').last;
        requestedTypes.add(type);
        return _parameterJson(type);
      }(),
      _ => throw StateError('Unexpected path: $path'),
    };
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        'etag': ['W/"$path"'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Map<String, Object?> _manifestJson() => {
  'parameters': [
    for (final type in ParameterType.values)
      {
        'type': type.toApiParameterType.toJson(),
        'schema_version': 1,
        'source_version': 'test',
        'source_updated_at': null,
        'generated_at': '2026-06-04T00:00:00Z',
        'source_urls': <String>[],
        'sha256': type.pathSegment,
        'size_bytes': 1,
        'url': 'https://example.com/${type.pathSegment}.json',
      },
  ],
};

Map<String, Object?> _parameterJson(String type) => switch (type) {
  'JMA_CODE_TABLE' => {
    'metadata': _metadataJson(type),
    'code_tables': {
      'area_forecast_local_eew': <Object?>[],
      'area_information_prefecture_earthquake': <Object?>[],
      'area_information_city': <Object?>[],
      'area_epicenter': <Object?>[],
      'area_epicenter_abbreviation': <Object?>[],
      'area_epicenter_detail': <Object?>[],
    },
  },
  'KYOSHIN_OBSERVATION_POINTS' => {
    'metadata': _metadataJson(type),
    'points': <Object?>[],
  },
  'EARTHQUAKE_STATIONS' => {
    'metadata': _metadataJson(type),
    'prefectures': <Object?>[],
  },
  'TSUNAMI_STATIONS' => {
    'metadata': _metadataJson(type),
    'prefectures': <Object?>[],
  },
  'SHINDO_DB_STATIONS' => {
    'metadata': _metadataJson(type),
    'stations': <Object?>[],
  },
  _ => throw StateError('Unexpected parameter type: $type'),
};

Map<String, Object?> _metadataJson(String apiType) => {
  'type': apiType,
  'schema_version': 1,
  'source_version': 'test',
  'source_updated_at': null,
  'generated_at': '2026-06-04T00:00:00Z',
  'source_urls': <String>[],
  'sha256': apiType,
};
