import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_distribution_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late _QueueAdapter adapter;
  late AssetPackDistributionRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = SharedPreferencesDataSource(
      sharedPreferences: await SharedPreferences.getInstance(),
    );
    adapter = _QueueAdapter();
    repository = AssetPackDistributionRepository(
      dio: Dio()..httpClientAdapter = adapter,
      preferences: preferences,
      verifySignature: ({required content, required sidecar}) async => true,
    );
  });

  test(
    'fetches and verifies manifest bytes before reporting an update',
    () async {
      adapter
        ..enqueueJson(_manifest(revision: 1, latestVersion: '1.1.0'))
        ..enqueueJson(_signature());

      final result = await repository.checkForUpdate(
        activeVersion: '1.0.0',
        appVersion: '3.0.0',
      );

      expect(result, isA<AssetPackUpdateAvailable>());
      expect(result.manifest.latestVersion, '1.1.0');
      expect(adapter.requests[0].path, endsWith('/manifest.json'));
      expect(adapter.requests[1].path, endsWith('/manifest.sig'));
    },
  );

  test('uses If-None-Match and verified cached bytes for 304', () async {
    adapter
      ..enqueueJson(
        _manifest(revision: 1, latestVersion: '1.1.0'),
        headers: {
          'etag': ['"revision-1"'],
        },
      )
      ..enqueueJson(_signature());
    await repository.checkForUpdate(
      activeVersion: '1.0.0',
      appVersion: '3.0.0',
    );
    adapter.enqueue(ResponseBody.fromString('', 304));

    final result = await repository.checkForUpdate(
      activeVersion: '1.1.0',
      appVersion: '3.0.0',
    );

    expect(result, isA<AssetPackNoUpdate>());
    expect(adapter.requests[2].headers['If-None-Match'], '"revision-1"');
    expect(adapter.requests, hasLength(3));
  });

  test('rejects invalid signatures without accepting rollback state', () async {
    repository = AssetPackDistributionRepository(
      dio: Dio()..httpClientAdapter = adapter,
      preferences: SharedPreferencesDataSource(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      verifySignature: ({required content, required sidecar}) async => false,
    );
    adapter
      ..enqueueJson(_manifest(revision: 10, latestVersion: '2.0.0'))
      ..enqueueJson(_signature());

    await expectLater(
      repository.checkForUpdate(activeVersion: '1.0.0', appVersion: '3.0.0'),
      throwsA(isA<AssetPackDistributionException>()),
    );
  });

  test('rejects a manifest older than the last accepted revision', () async {
    adapter
      ..enqueueJson(_manifest(revision: 2, latestVersion: '1.2.0'))
      ..enqueueJson(_signature());
    await repository.checkForUpdate(
      activeVersion: '1.0.0',
      appVersion: '3.0.0',
    );
    adapter
      ..enqueueJson(_manifest(revision: 1, latestVersion: '1.1.0'))
      ..enqueueJson(_signature());

    await expectLater(
      repository.checkForUpdate(activeVersion: '1.0.0', appVersion: '3.0.0'),
      throwsA(
        isA<AssetPackDistributionException>().having(
          (error) => error.code,
          'code',
          AssetPackDistributionErrorCode.rollback,
        ),
      ),
    );
  });

  test(
    'reports that an app update is required without allowing download',
    () async {
      adapter
        ..enqueueJson(
          _manifest(
            revision: 1,
            latestVersion: '1.1.0',
            minimumAppVersion: '4.0.0',
          ),
        )
        ..enqueueJson(_signature());

      final result = await repository.checkForUpdate(
        activeVersion: '1.0.0',
        appVersion: '3.0.0',
      );

      expect(result, isA<AssetPackAppUpdateRequired>());
    },
  );
}

Map<String, dynamic> _manifest({
  required int revision,
  required String latestVersion,
  String minimumAppVersion = '3.0.0',
}) => {
  'schema_version': 1,
  'revision': revision,
  'latest_version': latestVersion,
  'generated_at': '2026-08-16T00:00:00Z',
  'packs': [
    {
      'version': latestVersion,
      'published_at': '2026-08-16',
      'minimum_app_version': minimumAppVersion,
      'archive_path': 'packs/$latestVersion/asset-pack-v$latestVersion.zip',
      'archive_size_bytes': 10,
      'archive_sha256': 'a' * 64,
      'localizations': {
        'ja': {
          'sections': [
            {
              'title': '更新',
              'items': ['データ更新'],
            },
          ],
        },
        'en': {
          'sections': [
            {
              'title': 'Changes',
              'items': ['Data update'],
            },
          ],
        },
      },
    },
  ],
};

Map<String, dynamic> _signature() => {
  'schema_version': 1,
  'algorithm': 'Ed25519',
  'key_id': 'test-key',
  'content_sha256': 'a' * 64,
  'signature_base64': base64Encode(Uint8List(64)),
};

final class _QueueAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  final _responses = <ResponseBody>[];

  void enqueueJson(
    Map<String, dynamic> value, {
    Map<String, List<String>> headers = const {},
  }) {
    enqueue(ResponseBody.fromString(jsonEncode(value), 200, headers: headers));
  }

  void enqueue(ResponseBody response) => _responses.add(response);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (_responses.isEmpty) {
      throw StateError('No queued response for ${options.uri}');
    }
    return _responses.removeAt(0);
  }

  @override
  void close({bool force = false}) {}
}
