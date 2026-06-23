import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/provider/apns_environment.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('apnsEnvironmentProvider follows production iOS entitlements', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      container.read(apnsEnvironmentProvider),
      api.ApnsEnvironment.production,
    );
  });

  test('syncPushTokens sends APNs environment', () async {
    final adapter = _ApnsEnvironmentAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(
      api.ApiClient(dio),
      _MemoryDeviceAuthRepository(),
      apnsEnvironment: api.ApnsEnvironment.development,
      isApplePlatform: true,
    );

    await repository.syncPushTokens(
      deviceId: 'unused',
      token: const NotificationToken(
        apnsToken: 'apns-token',
        apnsPushToStartToken: 'push-to-start-token',
      ),
    );

    final payloads = adapter.requests.map(
      (request) => jsonDecode(jsonEncode(request.data)),
    );

    expect(payloads, [
      {'token': 'apns-token', 'environment': 'development'},
      {'token': 'push-to-start-token', 'environment': 'development'},
    ]);
  });
}

final class _ApnsEnvironmentAdapter implements HttpClientAdapter {
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
  Future<void> saveToken({
    required String token,
  }) async {}

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
