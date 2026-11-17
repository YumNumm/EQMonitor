import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/api_dio_factory.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/core/provider/interceptor/app_check_interceptor.dart';
import 'package:eqmonitor/core/provider/interceptor/device_auth_token_interceptor.dart';
import 'package:eqmonitor/core/provider/interceptor/device_id_interceptor.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_distribution_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _apiOnlyHeaders = {
  'x-eqmonitor-device-id',
  'x-eqmonitor-version',
  'x-eqmonitor-platform',
  'x-firebase-appcheck',
  'authorization',
  'cookie',
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> createContainer({
    Map<String, Object> preferences = const {},
  }) async {
    SharedPreferences.setMockInitialValues(preferences);
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        data_prefs.sharedPreferencesProvider.overrideWithValue(
          AsyncValue.data(await SharedPreferences.getInstance()),
        ),
        // 自前 API 用の Dio とその部品を参照したら失敗させる。
        dioProvider.overrideWith(
          (ref) async => throw StateError('API Dio must not be used'),
        ),
        apiDioFactoryProvider.overrideWith(
          (ref) async => throw StateError('API Dio must not be used'),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('配布元への Dio は自前 API 用の interceptor とヘッダーを持たない', () async {
    final container = await createContainer();

    final dio = container.read(assetPackDistributionDioProvider);

    expect(dio.interceptors.whereType<DeviceIdInterceptor>(), isEmpty);
    expect(dio.interceptors.whereType<DeviceAuthTokenInterceptor>(), isEmpty);
    expect(dio.interceptors.whereType<AppCheckInterceptor>(), isEmpty);
    expect(dio.options.baseUrl, isEmpty);
    expect(
      dio.options.headers.keys.map((key) => key.toLowerCase()),
      isNot(contains(isIn(_apiOnlyHeaders))),
    );
    expect(dio.options.connectTimeout, isNotNull);
    expect(dio.options.receiveTimeout, isNotNull);
  });

  test('更新情報と署名の要求に端末 ID・認証・App Check のヘッダーを付けない', () async {
    final container = await createContainer();
    final repository = await container.read(
      assetPackDistributionRepositoryProvider.future,
    );
    expect(
      repository.dio,
      same(container.read(assetPackDistributionDioProvider)),
    );
    final adapter = _RecordingAdapter();
    repository.dio.httpClientAdapter = adapter;

    // 応答は本物の鍵で署名していないため、署名の検証で失敗する。
    // 検証の前に、更新情報と署名の両方を取得し終えている。
    await expectLater(
      repository.checkForUpdate(activeVersion: '1.0.0', appVersion: '3.0.0'),
      throwsA(isA<AssetPackDistributionException>()),
    );

    expect(adapter.requests.map((request) => request.uri.toString()), [
      '$assetPackDistributionBaseUrl/manifest.json',
      '$assetPackDistributionBaseUrl/manifest.sig',
    ]);
    for (final request in adapter.requests) {
      expect(request.uri.host, 'assets.eqmonitor.app');
      expect(
        request.headers.keys.map((key) => key.toLowerCase()),
        isNot(contains(isIn(_apiOnlyHeaders))),
      );
    }
  });

  test('保存済みの ETag による再検証は維持する', () async {
    final container = await createContainer(
      preferences: {
        SharedPreferencesKey.assetPackDistributionEtag.key: '"revision-1"',
      },
    );
    final repository = await container.read(
      assetPackDistributionRepositoryProvider.future,
    );
    final adapter = _RecordingAdapter();
    repository.dio.httpClientAdapter = adapter;

    await expectLater(
      repository.checkForUpdate(activeVersion: '1.0.0', appVersion: '3.0.0'),
      throwsA(isA<AssetPackDistributionException>()),
    );

    expect(adapter.requests.first.headers['If-None-Match'], '"revision-1"');
  });
}

final class _RecordingAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode({
        'schema_version': 1,
        'algorithm': 'Ed25519',
        'key_id': 'untrusted-test-key',
        'content_sha256': 'a' * 64,
        'signature_base64': base64Encode(Uint8List(64)),
      }),
      200,
    );
  }

  @override
  void close({bool force = false}) {}
}
