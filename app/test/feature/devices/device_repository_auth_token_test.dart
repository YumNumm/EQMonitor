import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/interceptor/device_auth_token_interceptor.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'registerDevice persists returned device token before reading me',
    () async {
      final adapter = _DeviceRegisterAdapter();
      final authRepository = _MemoryDeviceAuthRepository();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(
          DeviceAuthTokenInterceptor(readToken: authRepository.readToken),
        )
        ..httpClientAdapter = adapter;
      final repository = DeviceRepository(
        api.ApiClient(dio),
        authRepository,
        apnsEnvironment: api.ApnsEnvironment.development,
      );

      final result = await repository.registerDevice(
        deviceId: 'local-device-id',
        devicePlatform: DevicePlatform.ios,
        deviceLocale: DeviceLocale.ja,
      );

      expect(result, isA<Success<RegisteredDevice, Exception>>());
      expect(authRepository.savedToken, 'device-jwt');
      expect(adapter.paths, ['/v2/device', '/v2/device/me']);
      expect(adapter.authorizationHeaders, [null, 'Bearer device-jwt']);
    },
  );

  test(
    'registerDevice reuses saved token when confirmation retry recovers',
    () async {
      final adapter = _DeviceRegisterAdapter(failFirstMeRequest: true);
      final authRepository = _MemoryDeviceAuthRepository();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(
          DeviceAuthTokenInterceptor(readToken: authRepository.readToken),
        )
        ..httpClientAdapter = adapter;
      final repository = DeviceRepository(
        api.ApiClient(dio),
        authRepository,
        apnsEnvironment: api.ApnsEnvironment.development,
      );

      final first = await repository.registerDevice(
        deviceId: 'local-device-id',
        devicePlatform: DevicePlatform.ios,
        deviceLocale: DeviceLocale.ja,
      );
      final second = await repository.registerDevice(
        deviceId: 'local-device-id',
        devicePlatform: DevicePlatform.ios,
        deviceLocale: DeviceLocale.ja,
      );

      expect(first, isA<Failure<RegisteredDevice, Exception>>());
      expect(second, isA<Success<RegisteredDevice, Exception>>());
      expect(authRepository.savedToken, 'device-jwt');
      expect(adapter.paths, ['/v2/device', '/v2/device/me', '/v2/device/me']);
      expect(adapter.authorizationHeaders, [
        null,
        'Bearer device-jwt',
        'Bearer device-jwt',
      ]);
    },
  );

  test(
    'registerDevice replaces saved token when it is unauthenticated',
    () async {
      final adapter = _DeviceRegisterAdapter(rejectStaleAuthorization: true);
      final authRepository = _MemoryDeviceAuthRepository()
        ..savedToken = 'stale-jwt';
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(
          DeviceAuthTokenInterceptor(readToken: authRepository.readToken),
        )
        ..httpClientAdapter = adapter;
      final repository = DeviceRepository(
        api.ApiClient(dio),
        authRepository,
        apnsEnvironment: api.ApnsEnvironment.development,
      );

      final result = await repository.registerDevice(
        deviceId: 'local-device-id',
        devicePlatform: DevicePlatform.ios,
        deviceLocale: DeviceLocale.ja,
      );

      expect(result, isA<Success<RegisteredDevice, Exception>>());
      expect(authRepository.savedToken, 'device-jwt');
      expect(adapter.paths, ['/v2/device/me', '/v2/device', '/v2/device/me']);
      expect(adapter.authorizationHeaders, [
        'Bearer stale-jwt',
        null,
        'Bearer device-jwt',
      ]);
    },
  );

  test(
    'fetchOrRegister registers when saved token is unauthenticated',
    () async {
      final adapter = _DeviceRegisterAdapter(rejectStaleAuthorization: true);
      final authRepository = _MemoryDeviceAuthRepository()
        ..savedToken = 'stale-jwt';
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..interceptors.add(
          DeviceAuthTokenInterceptor(readToken: authRepository.readToken),
        )
        ..httpClientAdapter = adapter;
      final repository = DeviceRepository(
        api.ApiClient(dio),
        authRepository,
        apnsEnvironment: api.ApnsEnvironment.development,
      );

      final result = await repository.fetchOrRegister(
        deviceId: 'local-device-id',
        devicePlatform: DevicePlatform.ios,
        deviceLocale: DeviceLocale.ja,
      );

      expect(result, isA<Success<RegisteredDevice, Exception>>());
      expect(authRepository.savedToken, 'device-jwt');
      expect(adapter.paths, [
        '/v2/device/me',
        '/v2/device/me',
        '/v2/device',
        '/v2/device/me',
      ]);
    },
  );

  test(
    'deleteDevice clears saved device token after successful delete',
    () async {
      final adapter = _DeleteDeviceAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final authRepository = _MemoryDeviceAuthRepository()
        ..savedToken = 'jwt-1';
      final repository = DeviceRepository(
        api.ApiClient(dio),
        authRepository,
        apnsEnvironment: api.ApnsEnvironment.development,
      );

      final result = await repository.deleteDevice('local-device-id');

      expect(result, isA<Success<void, Exception>>());
      expect(authRepository.savedToken, isNull);
      expect(adapter.paths, ['/v2/device/me']);
    },
  );
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  String? savedToken;

  @override
  Future<void> saveToken({
    required String token,
  }) async {
    savedToken = token;
  }

  @override
  Future<String?> readToken() async => savedToken;

  @override
  Future<void> clearToken() async {
    savedToken = null;
  }
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

final class _DeviceRegisterAdapter implements HttpClientAdapter {
  _DeviceRegisterAdapter({
    this.failFirstMeRequest = false,
    this.rejectStaleAuthorization = false,
  });

  final bool failFirstMeRequest;
  final bool rejectStaleAuthorization;
  final paths = <String>[];
  final authorizationHeaders = <String?>[];
  var _meRequests = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    authorizationHeaders.add(options.headers['Authorization'] as String?);
    if (options.path == '/v2/device') {
      return ResponseBody.fromString(
        jsonEncode({
          'deviceId': 'server-device-id',
          'deviceToken': 'device-jwt',
          'expiresAt': null,
        }),
        201,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }
    if (options.path == '/v2/device/me') {
      _meRequests++;
      if (rejectStaleAuthorization &&
          options.headers['Authorization'] == 'Bearer stale-jwt') {
        throw DioException.badResponse(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          statusCode: 401,
        );
      }
      if (failFirstMeRequest && _meRequests == 1) {
        throw DioException.connectionError(
          requestOptions: options,
          reason: 'temporary network failure',
        );
      }
      return ResponseBody.fromString(
        jsonEncode({
          'id': 'server-device-id',
          'type': 'IOS',
          'locale': 'ja',
          'registrationType': 'APP_CHECK',
          'userId': null,
          'createdAt': '2026-06-05T00:00:00.000Z',
          'updatedAt': '2026-06-05T00:00:00.000Z',
        }),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }
    return ResponseBody.fromString('', 404);
  }

  @override
  void close({bool force = false}) {}
}

final class _DeleteDeviceAdapter implements HttpClientAdapter {
  final paths = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}
