import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_initializer.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

const _oldId = '11111111-2222-4333-8444-555555555555';
const _newId = '01976d8e-7d12-7000-8000-1234567890ab';

String _legacyToken() =>
    JWT({'id': _oldId, 'role': 'USER', 'exp': 0})
        .sign(SecretKey('test-only-secret'), noIssueAt: true);
String _newToken() =>
    JWT({'sub': 'device:$_newId'})
        .sign(SecretKey('test-only-secret'), noIssueAt: true);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    talker_lib.talker = Talker();
  });
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  Future<ProviderContainer> container(_MigrationAdapter adapter) async {
    final prefs = await SharedPreferences.getInstance();
    final result = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => DeviceAuthRepository(
            await ref.watch(securePreferencesDataSourceProvider.future),
          ),
        ),
        deviceRepositoryProvider.overrideWith((ref) async {
          final auth = await ref.watch(deviceAuthRepositoryProvider.future);
          final dio = Dio(BaseOptions(baseUrl: 'https://example.invalid'))
            ..httpClientAdapter = adapter;
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) async {
                final token = await auth.readToken();
                if (token != null) {
                  options.headers['Authorization'] = 'Bearer $token';
                }
                handler.next(options);
              },
            ),
          );
          return DeviceRepository(
            api: api.ApiClient(dio),
            authRepository: auth,
            apnsEnvironment: api.ApnsEnvironment.development,
          );
        }),
        pushTokenSyncProvider.overrideWith(_NoopSync.new),
      ],
    );
    addTearDown(result.dispose);
    return result;
  }

  test('実v2状態: marker・Prefs IDなしでも期限切れ旧JWTのidを保全し移行する', () async {
    final token = _legacyToken();
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.legacyApiToken.key: token,
    });
    final adapter = _MigrationAdapter();
    final app = await container(adapter);
    expect(
      await app.read(deviceProvisioningProvider.future),
      DeviceProvisioningStatus.required,
    );
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(SharedPreferencesKey.legacyDeviceId.key), _oldId);
    expect(
      prefs.getBool(SharedPreferencesKey.secureStorageInitialized.key),
      isTrue,
    );
    final secure = await app.read(securePreferencesDataSourceProvider.future);
    expect(await secure.getString(key: SecureStorageKey.legacyApiToken), token);
    await app.read(deviceProvisioningProvider.notifier).provision();
    expect(adapter.registerCalls, 1);
    expect(adapter.oldIds, [_oldId]);
    expect(
      prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
      isTrue,
    );
    expect(
      await app.read(deviceProvisioningProvider.future),
      DeviceProvisioningStatus.notRequired,
    );
  });

  test('旧成功flag・既存新IDがあっても残る旧JWTから移行を再確認する', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
      SharedPreferencesKey.secureStorageInitialized.key: true,
      SharedPreferencesKey.deviceMigratedFromLegacy.key: true,
    });
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.legacyApiToken.key: _legacyToken(),
      SecureStorageKey.deviceToken.key: _newToken(),
    });
    final adapter = _MigrationAdapter();
    final app = await container(adapter);
    expect(
      await app.read(deviceProvisioningProvider.future),
      DeviceProvisioningStatus.required,
    );
    await app.read(deviceProvisioningProvider.notifier).provision();
    expect(adapter.registerCalls, 0);
    expect(adapter.oldIds, [_oldId]);
    final auth = await app.read(deviceAuthRepositoryProvider.future);
    expect(await auth.readToken(), _newToken());
  });

  for (final token in <String?>[
    null,
    '',
    'malformed',
    JWT({'id': 123}).sign(SecretKey('test-only-secret')),
    JWT({'sub': 'device:$_newId'}).sign(SecretKey('test-only-secret')),
  ]) {
    test(
      '旧JWTなし・破損・不正claimからIDを推測しない (case ${token == null ? 0 : token.length})',
      () async {
        FlutterSecureStorage.setMockInitialValues({
          if (token != null) SecureStorageKey.legacyApiToken.key: token,
        });
        final adapter = _MigrationAdapter();
        final app = await container(adapter);
        await app.read(deviceProvisioningProvider.future);
        await app.read(deviceProvisioningProvider.notifier).provision();
        final prefs = await SharedPreferences.getInstance();
        expect(adapter.oldIds, isEmpty);
        expect(
          prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
          isNot(isTrue),
        );
        expect(
          prefs.getBool(SharedPreferencesKey.deviceProvisioned.key),
          isTrue,
        );
        final secure = await app.read(
          securePreferencesDataSourceProvider.future,
        );
        expect(
          await secure.getString(key: SecureStorageKey.legacyApiToken),
          token,
        );
      },
    );
  }

  for (final status in [400, 401, 403, 404, 409, 422]) {
    test('$statusで移行を成功扱いせず、再起動後も同じ新IDで再試行できる', () async {
      FlutterSecureStorage.setMockInitialValues({
        SecureStorageKey.legacyApiToken.key: _legacyToken(),
      });
      final adapter = _MigrationAdapter()..migrateStatus = status;
      final first = await container(adapter);
      await first.read(deviceProvisioningProvider.future);
      await expectLater(
        first.read(deviceProvisioningProvider.notifier).provision(),
        throwsA(isA<DeviceProvisioningException>()),
      );
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(SharedPreferencesKey.deviceProvisioned.key), isTrue);
      expect(
        prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
        isNot(isTrue),
      );
      first.dispose();
      adapter.migrateStatus = 200;
      final restarted = await container(adapter);
      expect(
        await restarted.read(deviceProvisioningProvider.future),
        DeviceProvisioningStatus.required,
      );
      await restarted.read(deviceProvisioningProvider.notifier).provision();
      expect(adapter.registerCalls, 1);
      expect(adapter.oldIds, [_oldId, _oldId]);
      expect(
        prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
        isTrue,
      );
    });
  }

  for (final failure in ['network', '500']) {
    test('$failureの一時失敗は旧IDを保持して自動再試行する', () async {
      FlutterSecureStorage.setMockInitialValues({
        SecureStorageKey.legacyApiToken.key: _legacyToken(),
      });
      final adapter = _MigrationAdapter()..transientFailure = failure;
      final app = await container(adapter);
      await app.read(deviceProvisioningProvider.future);
      await app.read(deviceProvisioningProvider.notifier).provision();
      expect(adapter.registerCalls, 1);
      expect(adapter.oldIds, [_oldId, _oldId]);
      expect(
        await app.read(deviceProvisioningProvider.future),
        DeviceProvisioningStatus.notRequired,
      );
    });
  }

  test('成功後の再実行・再起動は移行を再送せず旧JWTのみを掃除する', () async {
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.legacyApiToken.key: _legacyToken(),
    });
    final adapter = _MigrationAdapter();
    final first = await container(adapter);
    await first.read(deviceProvisioningProvider.future);
    await first.read(deviceProvisioningProvider.notifier).provision();
    await first.read(deviceProvisioningProvider.notifier).provision();
    first.dispose();
    final restarted = await container(adapter);
    expect(
      await restarted.read(deviceProvisioningProvider.future),
      DeviceProvisioningStatus.notRequired,
    );
    final secure = await restarted.read(
      securePreferencesDataSourceProvider.future,
    );
    expect(
      await secure.getString(key: SecureStorageKey.legacyApiToken),
      isNull,
    );
    expect(
      await secure.getString(key: SecureStorageKey.deviceToken),
      _newToken(),
    );
    expect(adapter.registerCalls, 1);
    expect(adapter.oldIds, [_oldId]);
  });

  test('旧IDの保存失敗時はmarkerを立てず、旧JWTを消さない', () async {
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.legacyApiToken.key: _legacyToken(),
    });
    final prefs = await SharedPreferences.getInstance();
    final secure = SecurePreferencesDataSource(
      secureStorage: const FlutterSecureStorage(),
    );
    await expectLater(
      SecureStorageInitializer(
        sharedPreferences: _RejectIdWrite(sharedPreferences: prefs),
        securePreferences: secure,
      ).initialize(),
      throwsStateError,
    );
    expect(
      prefs.getBool(SharedPreferencesKey.secureStorageInitialized.key),
      isNull,
    );
    expect(
      await secure.getString(key: SecureStorageKey.legacyApiToken),
      _legacyToken(),
    );
  });

  test('保存済み旧IDがあれば旧JWT消失後も移行元を再利用する', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.legacyDeviceId.key: _oldId,
      SharedPreferencesKey.deviceProvisioned.key: true,
      SharedPreferencesKey.secureStorageInitialized.key: true,
    });
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.deviceToken.key: _newToken(),
    });
    final adapter = _MigrationAdapter();
    final app = await container(adapter);
    expect(
      await app.read(deviceProvisioningProvider.future),
      DeviceProvisioningStatus.required,
    );
    await app.read(deviceProvisioningProvider.notifier).provision();
    expect(adapter.registerCalls, 0);
    expect(adapter.oldIds, [_oldId]);
  });

  test('壊れた新JWTは旧IDを保ったまま新端末を登録する', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.deviceProvisioned.key: true,
      SharedPreferencesKey.secureStorageInitialized.key: true,
    });
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.legacyApiToken.key: _legacyToken(),
      SecureStorageKey.deviceToken.key: 'malformed-new-token',
    });
    final adapter = _MigrationAdapter();
    final app = await container(adapter);
    await app.read(deviceProvisioningProvider.future);
    await app.read(deviceProvisioningProvider.notifier).provision();
    expect(adapter.registerCalls, 1);
    expect(adapter.oldIds, [_oldId]);
  });

  test('不正な保存済み旧IDと失われたJWTから移行を推測しない', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.legacyDeviceId.key: 'invalid-id',
    });
    final adapter = _MigrationAdapter();
    final app = await container(adapter);
    await app.read(deviceProvisioningProvider.future);
    await app.read(deviceProvisioningProvider.notifier).provision();
    expect(
      await app.read(deviceProvisioningProvider.future),
      DeviceProvisioningStatus.notRequired,
    );
    expect(adapter.oldIds, isEmpty);
  });

  test('tokenと保存済み旧IDの不一致は上書き・推測移行しない', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.legacyDeviceId.key:
          'aaaaaaaa-bbbb-4ccc-8ddd-eeeeeeeeeeee',
    });
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.legacyApiToken.key: _legacyToken(),
    });
    final app = await container(_MigrationAdapter());
    await expectLater(
      app.read(deviceProvisioningProvider.future),
      throwsA(isA<StateError>()),
    );
    final prefs = await SharedPreferences.getInstance();
    expect(
      prefs.getBool(SharedPreferencesKey.secureStorageInitialized.key),
      isNull,
    );
  });

  test('markerなし・旧JWTなしでは従来の再インストール用credentials消去を維持する', () async {
    FlutterSecureStorage.setMockInitialValues({
      SecureStorageKey.deviceToken.key: _newToken(),
    });
    final app = await container(_MigrationAdapter());
    final secure = await app.read(securePreferencesDataSourceProvider.future);
    expect(await secure.getString(key: SecureStorageKey.deviceToken), isNull);
  });
}

final class _RejectIdWrite extends SharedPreferencesDataSource {
  new({required super.sharedPreferences});
  @override
  Future<void> setString({
    required SharedPreferencesKey key,
    required String value,
  }) async {
    throw StateError('mock write failure');
  }
}

final class _NoopSync extends PushTokenSyncNotifier {
  @override
  Future<PushTokenSyncSnapshot> build() async => const PushTokenSyncSnapshot(
    fcm: NotApplicableTokenState(),
    apnsNotification: NotApplicableTokenState(),
    apnsPushToStart: NotApplicableTokenState(),
  );
}

final class _MigrationAdapter implements HttpClientAdapter {
  var registerCalls = 0;
  var migrateStatus = 200;
  String? transientFailure;
  final oldIds = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final authorized =
        options.headers['Authorization'] == 'Bearer ${_newToken()}';
    if (options.path == '/v2/device') {
      registerCalls++;
      return jsonResponse({
        'deviceId': _newId,
        'deviceToken': _newToken(),
        'expiresAt': null,
      }, 201);
    }
    if (!authorized) {
      return jsonResponse({
        'code': 'UNAUTHORIZED',
        'message': 'Unauthorized',
      }, 401);
    }
    if (options.path == '/v2/device/me') {
      return jsonResponse({
        'id': _newId,
        'type': 'IOS',
        'locale': 'ja',
        'registrationType': 'APP_CHECK',
        'userId': null,
        'is_pro': false,
        'role': 'USER',
        'createdAt': '2026-06-05T00:00:00.000Z',
        'updatedAt': '2026-06-05T00:00:00.000Z',
      }, 200);
    }
    if (options.path == '/v2/device/me/migrate') {
      final body = options.data as Map<String, dynamic>;
      oldIds.add(body['old_device_id'] as String);
      final failure = transientFailure;
      transientFailure = null;
      if (failure == 'network') {
        throw DioException.connectionError(
          requestOptions: options,
          reason: 'mock offline',
        );
      }
      if (failure == '500' || migrateStatus != 200) {
        return jsonResponse({
          'code': 'MOCK_FAILURE',
          'message': 'Mock failure',
        }, failure == '500' ? 500 : migrateStatus);
      }
      return jsonResponse({
        'migrated': {
          'earthquake_regions': 1,
          'eew_regions': 2,
          'notification_settings': true,
        },
      }, 200);
    }
    throw StateError('Unexpected mock request');
  }

  ResponseBody jsonResponse(Map<String, dynamic> body, int status) =>
      ResponseBody.fromString(
        jsonEncode(body),
        status,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

  @override
  void close({bool force = false}) {}
}
