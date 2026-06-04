import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/provider/interceptor/device_auth_token_interceptor.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('adds bearer token to /v2/device/me requests', () async {
    final interceptor = DeviceAuthTokenInterceptor(
      readToken: () async => 'jwt-1',
    );
    final options = RequestOptions(path: '/v2/device/me/fcm', method: 'PATCH');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers['Authorization'], 'Bearer jwt-1');
    expect(handler.nextOptions, same(options));
  });

  test('does not add bearer token to device registration', () async {
    final interceptor = DeviceAuthTokenInterceptor(
      readToken: () async => 'jwt-1',
    );
    final options = RequestOptions(path: '/v2/device', method: 'POST');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test('does not add bearer token to realtime ticket', () async {
    final interceptor = DeviceAuthTokenInterceptor(
      readToken: () async => 'jwt-1',
    );
    final options = RequestOptions(path: '/v2/realtime/ticket', method: 'GET');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test('does not add bearer token to sibling device paths', () async {
    final interceptor = DeviceAuthTokenInterceptor(
      readToken: () async => 'jwt-1',
    );
    final options = RequestOptions(path: '/v2/device/metadata', method: 'GET');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test('does not add Authorization when token is missing', () async {
    final interceptor = DeviceAuthTokenInterceptor(readToken: () async => null);
    final options = RequestOptions(
      path: '/v2/device/me/settings/eew',
      method: 'GET',
    );
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test('does not add Authorization when token is empty', () async {
    final interceptor = DeviceAuthTokenInterceptor(readToken: () async => '');
    final options = RequestOptions(path: '/v2/device/me', method: 'GET');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test(
    'provider keeps interceptor instance and reads repository token',
    () async {
      final container = ProviderContainer(
        overrides: [
          deviceAuthRepositoryProvider.overrideWith(
            (ref) async => _MemoryDeviceAuthRepository(token: 'jwt-1'),
          ),
        ],
      );
      addTearDown(container.dispose);
      final first = await container.read(
        deviceAuthTokenInterceptorProvider.future,
      );
      final second = await container.read(
        deviceAuthTokenInterceptorProvider.future,
      );
      final options = RequestOptions(path: '/v2/device/me', method: 'GET');
      final handler = _CapturingRequestHandler();

      await first.onRequest(options, handler);

      expect(second, same(first));
      expect(options.headers['Authorization'], 'Bearer jwt-1');
      expect(handler.nextOptions, same(options));
    },
  );
}

final class _CapturingRequestHandler extends RequestInterceptorHandler {
  RequestOptions? nextOptions;

  @override
  void next(RequestOptions requestOptions) {
    nextOptions = requestOptions;
  }
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository({required String token})
    : _token = token,
      super(_MemorySecurePreferencesDataSource());

  final String _token;

  @override
  Future<String?> readToken() async => _token;
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {}

  @override
  Future<String?> getString({required SecureStorageKey key}) async => null;

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) async {}

  @override
  Future<int?> getInt({required SecureStorageKey key}) async => null;

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {}

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async => null;

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {}

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async => null;

  @override
  Future<void> remove({required SecureStorageKey key}) async {}

  @override
  Future<void> clear() async {}
}
