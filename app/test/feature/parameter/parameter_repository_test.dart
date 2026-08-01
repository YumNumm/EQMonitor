import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/parameter/data/data_source/parameter_asset_data_source.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'loadAsset reads manifest.json + per-type parameter JSON from the '
    'Asset Pack (no HTTP, no bundled-asset fallback)',
    () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'parameter_repository_test',
      );
      addTearDown(() => tempDir.delete(recursive: true));

      // Encode each per-type JSON once so the manifest's size_bytes/sha256 and
      // the file written to disk are derived from the identical bytes, and the
      // Asset Pack integrity checks pass.
      final contents = <ParameterType, String>{
        for (final type in ParameterType.values)
          type: jsonEncode(_parameterJson(type.serializedValue)),
      };

      await File(
        '${tempDir.path}/manifest.json',
      ).writeAsString(jsonEncode(_manifestJson(contents)));
      final paramsDir = Directory('${tempDir.path}/parameters')
        ..createSync(recursive: true);
      for (final type in ParameterType.values) {
        await File(
          '${paramsDir.path}/${type.pathSegment}.json',
        ).writeAsString(contents[type]!);
      }

      final assetPackRepository = AssetPackRepository(
        resolvePackRoot: () async => tempDir.path,
      );
      final repository = ParameterRepository(
        assetDataSource: ParameterAssetDataSource(
          assetPackRepository: assetPackRepository,
        ),
        parser: const ParameterJsonParser(),
      );

      final result = await repository.loadAsset();

      expect(result.manifest.packVersion, '1.0.0');
      expect(result.jmaCodeTable.metadata.sourceVersion, 'test');
      expect(result.kyoshinObservationPoints.metadata.sourceVersion, 'test');
      expect(result.earthquake.metadata.sourceVersion, 'test');
      expect(result.tsunami.metadata.sourceVersion, 'test');
      expect(result.shindoDbStations.metadata.sourceVersion, 'test');
      expect(result.shindoDbStations.stations, isEmpty);
    },
  );

  test(
    'loadAsset propagates AssetPackNotReadyException unchanged when the '
    'pack is not ready (no fallback to fake data)',
    () async {
      final assetPackRepository = AssetPackRepository(
        resolvePackRoot: () async =>
            throw const AssetPackNotReadyException('pack not downloaded'),
      );
      final repository = ParameterRepository(
        assetDataSource: ParameterAssetDataSource(
          assetPackRepository: assetPackRepository,
        ),
        parser: const ParameterJsonParser(),
      );

      await expectLater(
        repository.loadAsset(),
        throwsA(isA<AssetPackNotReadyException>()),
      );
    },
  );

  test('earthquake_stations を API 生成型に依存せずデコードする', () {
    final source = jsonEncode({
      'metadata': _metadataJson('EARTHQUAKE_STATIONS'),
      'prefectures': [
        {
          'code': '13',
          'name': {'ja': '東京都'},
          'regions': [
            {
              'code': '130000',
              'name': {'ja': '東京都'},
              'kana': 'とうきょうと',
              'cities': [
                {
                  'code': '1310100',
                  'name': {'ja': '千代田区'},
                  'kana': 'ちよだく',
                  'stations': [
                    {
                      'code': '1310100',
                      'no_code': '001',
                      'name': {'ja': '東京千代田区'},
                      'kana': 'とうきょうちよだく',
                      'status': 'OPERATING',
                      'source_status': '現用',
                      'owner': '気象庁',
                      'location': {'latitude': 35.68, 'longitude': 139.76},
                      'arv_400': 123.4,
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
    });

    final parameter = const ParameterJsonParser().parseEarthquake(source);
    final station = parameter.prefectures.single.regions.single.cities.single
        .stations.single;

    expect(station.name.ja, '東京千代田区');
    expect(station.status.name, 'operating');
    expect(station.location.lat, 35.68);
    expect(station.location.lon, 139.76);
    expect(station.arv400, 123.4);
  });
}

Map<String, Object?> _manifestJson(Map<ParameterType, String> contents) => {
  'pack_version': '1.0.0',
  'schema_version': 1,
  'generated_at': '2026-06-04T00:00:00Z',
  'assets': [
    {
      // Not resolved by ParameterRepository.loadAsset, so its integrity
      // fields are unchecked.
      'id': 'BASE_MAP_PMTILES',
      'kind': 'pmtiles',
      'path': 'map/all.pmtiles',
      'schema_version': 1,
      'source_version': 'test',
      'source_updated_at': null,
      'source_urls': <String>[],
      'sha256': 'a' * 64,
      'size_bytes': 1,
    },
    for (final type in ParameterType.values)
      {
        'id': type.serializedValue,
        'kind': 'json',
        'path': 'parameters/${type.pathSegment}.json',
        'schema_version': 1,
        'source_version': 'test',
        'source_updated_at': null,
        'source_urls': <String>[],
        'sha256': sha256.convert(utf8.encode(contents[type]!)).toString(),
        'size_bytes': utf8.encode(contents[type]!).length,
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
