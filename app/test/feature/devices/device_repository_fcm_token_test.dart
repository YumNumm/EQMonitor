import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('upsertPushToken maps each kind to its own endpoint', () async {
    final adapter = _UpsertPushTokenAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(
      api: api.ApiClient(dio),
      authRepository: _MemoryDeviceAuthRepository(),
      apnsEnvironment: api.ApnsEnvironment.development,
      isApplePlatform: true,
    );

    await repository.upsertPushToken(kind: PushTokenKind.fcm, token: 'fcm');
    await repository.upsertPushToken(
      kind: PushTokenKind.apnsPushToStart,
      token: 'pts',
    );

    expect(adapter.requests.map((request) => request.path), [
      '/v2/device/me/fcm',
      '/v2/device/me/apns/LIVE_ACTIVITY_START',
    ]);
    final payloads = adapter.requests.map(
      (request) => jsonDecode(jsonEncode(request.data)),
    );
    expect(payloads, [
      {'token': 'fcm'},
      {'token': 'pts', 'environment': 'development'},
    ]);
  });

  test(
    'upsertPushToken maps apnsNotification kind to NOTIFICATION endpoint',
    () async {
      final adapter = _UpsertPushTokenAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final repository = DeviceRepository(
        api: api.ApiClient(dio),
        authRepository: _MemoryDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.production,
        isApplePlatform: true,
      );

      final result = await repository.upsertPushToken(
        kind: PushTokenKind.apnsNotification,
        token: 'apns-token',
      );

      expect(result, isA<Success<void, Exception>>());
      expect(adapter.requests.map((request) => request.path), [
        '/v2/device/me/apns/NOTIFICATION',
      ]);
      final payloads = adapter.requests.map(
        (request) => jsonDecode(jsonEncode(request.data)),
      );
      expect(payloads, [
        {'token': 'apns-token', 'environment': 'production'},
      ]);
    },
  );
}

final class _UpsertPushTokenAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  @override
  Future<void> saveToken({required String token}) async {}

  @override
  Future<String?> readToken() async => null;

  @override
  Future<void> clearToken() async {}
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {
    values[key] = value;
  }

  @override
  Future<String?> getString({required SecureStorageKey key}) async =>
      values[key];

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<int?> getInt({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : int.tryParse(value);
  }

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : double.tryParse(value);
  }

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : bool.tryParse(value);
  }

  @override
  Future<void> remove({required SecureStorageKey key}) async {
    values.remove(key);
  }

  @override
  Future<void> clear() async {
    values.clear();
  }
}
