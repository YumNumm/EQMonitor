import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_local_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('refresh downloads parameter json and stores it locally', () async {
    final tempDirectory = await Directory.systemTemp.createTemp(
      'parameter_repository_refresh_test_',
    );
    addTearDown(() async {
      if (tempDirectory.existsSync()) {
        await tempDirectory.delete(recursive: true);
      }
    });
    final adapter = _ParametersApiAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final localDataSource = ParameterLocalDataSource(
      documentsDirectory: tempDirectory,
    );
    final repository = ParameterRepository(
      assetDataSource: ParameterAssetDataSource(bundle: rootBundle),
      localDataSource: localDataSource,
      parser: const ParameterJsonParser(),
      apiClient: api.ApiClient(dio),
    );

    final refreshed = await repository.refresh();

    expect(refreshed, isTrue);
    expect(await localDataSource.readManifestJson(), isNotNull);
    for (final type in ParameterType.values) {
      expect(await localDataSource.readParameterJson(type), isNotNull);
    }
    expect(adapter.requestedTypes, [
      'jma_code_table',
      'kyoshin_observation_points',
      'earthquake_stations',
      'tsunami_stations',
    ]);
  });
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
        'type': type.pathSegment,
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
  'jma_code_table' => {
    'metadata': _metadataJson(type),
    'code_tables': {
      'area_forecast_local_eew': <Object?>[],
      'area_information_prefecture_earthquake': <Object?>[],
      'area_epicenter': <Object?>[],
      'area_epicenter_abbreviation': <Object?>[],
      'area_epicenter_detail': <Object?>[],
    },
  },
  'kyoshin_observation_points' => {
    'metadata': _metadataJson(type),
    'points': <Object?>[],
  },
  'earthquake_stations' => {
    'metadata': _metadataJson(type),
    'prefectures': <Object?>[],
  },
  'tsunami_stations' => {
    'metadata': _metadataJson(type),
    'prefectures': <Object?>[],
  },
  _ => throw StateError('Unexpected parameter type: $type'),
};

Map<String, Object?> _metadataJson(String type) => {
  'type': type,
  'schema_version': 1,
  'source_version': 'test',
  'source_updated_at': null,
  'generated_at': '2026-06-04T00:00:00Z',
  'source_urls': <String>[],
  'sha256': type,
};
