import 'dart:convert';
import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/feature/location/data/headless/headless_device_location_dependencies.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/headless_api_identity.dart';
import 'package:eqmonitor/feature/location/data/model/pending_device_location.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  group('HeadlessDeviceLocationDependencies.run', () {
    test('active taskがなければ同期依存を構築しない', () async {
      var runCount = 0;
      final dependencies = HeadlessDeviceLocationDependencies(
        getActiveHeadlessTaskId: () async => null,
        runHeadlessTask: ({required taskUpdateId}) async {
          runCount++;
          return HeadlessTaskResult.success;
        },
      );

      await dependencies.run();

      expect(runCount, 0);
    });

    test('nativeのactive task IDをrunnerへ一度だけ渡す', () async {
      final updateIds = <String>[];
      final dependencies = HeadlessDeviceLocationDependencies(
        getActiveHeadlessTaskId: () async => 'active-1',
        runHeadlessTask: ({required taskUpdateId}) async {
          updateIds.add(taskUpdateId);
          return HeadlessTaskResult.retry;
        },
      );

      await dependencies.run();

      expect(updateIds, ['active-1']);
    });
  });

  group('HeadlessRestApiUrlResolver', () {
    test('保存済みTelegram URLのREST URLを優先する', () {
      const resolver = HeadlessRestApiUrlResolver();

      final result = resolver.resolve(
        buildConfig: buildConfig(restApiUrl: 'https://default.example.com'),
        savedTelegramUrlJson: jsonEncode({
          'rest_api_url': 'https://saved.example.com',
          'ws_api_url': 'wss://saved.example.com',
        }),
      );

      expect(result, 'https://saved.example.com');
    });

    test('保存値が不正ならBuildConfigのREST URLへ戻す', () {
      const resolver = HeadlessRestApiUrlResolver();

      final result = resolver.resolve(
        buildConfig: buildConfig(restApiUrl: 'https://default.example.com'),
        savedTelegramUrlJson: '{invalid',
      );

      expect(result, 'https://default.example.com');
    });
  });

  test('headless Dioは通常APIと同じ必須headerだけを設定する', () {
    const factory = HeadlessApiDioFactory();

    final dio = factory.build(
      baseUrl: 'https://api.example.com',
      identity: const HeadlessApiIdentity(
        userAgent: 'net.yumnumm.eqmonitor/3.0.0+100 (device)',
        version: '3.0.0+100',
        platform: 'ios',
        deviceId: 'hashed-device-id',
      ),
      deviceToken: 'secret-device-token',
    );

    expect(dio.options.baseUrl, 'https://api.example.com');
    expect(
      dio.options.headers[HttpHeaders.userAgentHeader],
      'net.yumnumm.eqmonitor/3.0.0+100 (device)',
    );
    expect(dio.options.headers['x-eqmonitor-version'], '3.0.0+100');
    expect(dio.options.headers['x-eqmonitor-platform'], 'ios');
    expect(dio.options.headers['x-eqmonitor-device-id'], 'hashed-device-id');
    expect(
      dio.options.headers[HttpHeaders.authorizationHeader],
      'Bearer secret-device-token',
    );
    expect(dio.options.headers, isNot(contains('X-Firebase-AppCheck')));
    expect(dio.interceptors, hasLength(1));
  });

  test('terminal診断は位置やtokenを含めず専用Preferences keyへ保存する', () async {
    final preferences = SharedPreferencesAsync();
    final recorder = HeadlessDeviceLocationDiagnosticRecorder(preferences);

    await recorder.recordTerminalFailure(
      updateId: 'update-1',
      statusCode: 422,
    );

    final source = await preferences.getString(
      SharedPreferencesKey.backgroundLocationHeadlessDiagnostic.key,
    );
    expect(jsonDecode(source ?? '') as Map<String, dynamic>, {
      'updateId': 'update-1',
      'result': 'terminalFailure',
      'statusCode': 422,
    });
    expect(source, isNot(contains('latitude')));
    expect(source, isNot(contains('longitude')));
    expect(source, isNot(contains('token')));
  });

  test('bundled Asset PackはmanifestとearthquakeStationsだけを読む', () async {
    const parameterSource = '{"fixture":true}';
    final parameterBytes = utf8.encode(parameterSource);
    final manifest = jsonEncode({
      'pack_version': '1.0.0',
      'schema_version': 1,
      'generated_at': '2026-08-24T00:00:00Z',
      'assets': [
        {
          'id': 'EARTHQUAKE_STATIONS',
          'kind': 'json',
          'path': 'parameters/earthquake_stations.json',
          'schema_version': 1,
          'source_version': 'fixture',
          'source_updated_at': null,
          'source_urls': <String>[],
          'sha256': sha256.convert(parameterBytes).toString(),
          'size_bytes': parameterBytes.length,
        },
      ],
    });
    final bundle = RecordingAssetBundle({
      'assets/platform/manifest.json': utf8.encode(manifest),
      'assets/platform/parameters/earthquake_stations.json': parameterBytes,
    });

    final result = await const HeadlessEarthquakeParameterAssetLoader()
        .loadBundled(bundle: bundle);

    expect(result, parameterSource);
    expect(bundle.loadedKeys, [
      'assets/platform/manifest.json',
      'assets/platform/parameters/earthquake_stations.json',
    ]);
  });

  test('ローカルAsset Packで地域解決しAPIへ地域コードだけを送る', () async {
    final preferences = SharedPreferencesAsync();
    final resolver = await HeadlessJmaRegionResolverLoader(preferences).load();
    final adapter = RecordingDeviceLocationApiAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'))
      ..httpClientAdapter = adapter;
    final service = HeadlessDeviceLocationSyncServiceBuilder.build(
      scope: testScope,
      leaseManager: const AlwaysCurrentDeviceLocationSyncLeaseManager(),
      stateRepository: InMemoryDeviceLocationSyncStateRepository(),
      resolver: resolver,
      repository: NotificationSlotRepository(api: api.ApiClient(dio)),
    );

    final result = await service.syncPending(
      location: const PendingDeviceLocation(
        updateId: 'asset-integration',
        latitude: 35.681236,
        longitude: 139.767125,
        accuracy: 10,
        timestampMillis: 1000,
      ),
    );

    expect(result, DeviceLocationSyncResult.sent);
    expect(adapter.requestPath, '/v2/device/me/location');
    expect(adapter.requestBody.keys, {
      'region',
      'city',
      'tsunamiForecastRegion',
    });
    expect(adapter.requestBody, isNot(contains('latitude')));
    expect(adapter.requestBody, isNot(contains('longitude')));
  });
}

const testScope = DeviceLocationSyncScope(
  apiEndpoint: 'https://api.example.com/v2/device/me/location',
  registrationGeneration: 'test-registration',
);

BuildConfig buildConfig({required String restApiUrl}) => BuildConfig(
  restApiUrl: restApiUrl,
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: '',
  flavor: Flavor.prod,
  wsApiUrl: 'wss://default.example.com',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
);

class RecordingAssetBundle extends CachingAssetBundle {
  new(this.assets);

  final Map<String, List<int>> assets;
  final loadedKeys = <String>[];

  @override
  Future<ByteData> load(String key) async {
    loadedKeys.add(key);
    final bytes = assets[key];
    if (bytes == null) {
      throw StateError('Missing test asset: $key');
    }
    return ByteData.sublistView(Uint8List.fromList(bytes));
  }
}

class RecordingDeviceLocationApiAdapter implements HttpClientAdapter {
  String? requestPath;
  Map<String, dynamic> requestBody = {};

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestPath = options.path;
    requestBody = Map<String, dynamic>.from(
      options.data as Map<String, dynamic>,
    );
    return ResponseBody.fromString(
      jsonEncode(requestBody),
      HttpStatus.ok,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class AlwaysCurrentDeviceLocationSyncLeaseManager
    implements DeviceLocationSyncLeaseManager {
  const new();

  @override
  Future<DeviceLocationSyncLease?> acquire({required String updateId}) async =>
      const AlwaysCurrentDeviceLocationSyncLease();
}

class AlwaysCurrentDeviceLocationSyncLease implements DeviceLocationSyncLease {
  const new();

  @override
  Future<bool> isCurrent() async => true;

  @override
  Future<void> release() async {}
}
