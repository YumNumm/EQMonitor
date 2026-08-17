import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeviceRepository.getDeviceRole', () {
    test('admin ロールを返す', () async {
      final repository = _repository(role: 'admin');

      final result = await repository.getDeviceRole();

      expect(result, isA<Success<DeviceRole?, Exception>>());
      expect(
        (result as Success<DeviceRole?, Exception>).value,
        DeviceRole.admin,
      );
    });

    test('user ロールを返す', () async {
      final repository = _repository(role: 'user');

      final result = await repository.getDeviceRole();

      expect(
        (result as Success<DeviceRole?, Exception>).value,
        DeviceRole.user,
      );
    });

    test('role が未提供の場合は null を返す', () async {
      final repository = _repository();

      final result = await repository.getDeviceRole();

      expect((result as Success<DeviceRole?, Exception>).value, isNull);
    });

    test('未知の role は権限を推測せず null を返す', () async {
      final repository = _repository(role: 'moderator');

      final result = await repository.getDeviceRole();

      expect((result as Success<DeviceRole?, Exception>).value, isNull);
    });

    test('API が失敗した場合は Failure を返す', () async {
      final repository = _repository(statusCode: 401);

      final result = await repository.getDeviceRole();

      expect(result, isA<Failure<DeviceRole?, Exception>>());
    });
  });
}

DeviceRepository _repository({String? role, int statusCode = 200}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = _DeviceMeAdapter(role: role, statusCode: statusCode);
  return DeviceRepository(
    api: api.ApiClient(dio),
    authRepository: DeviceAuthRepository(_MemorySecurePreferencesDataSource()),
    apnsEnvironment: api.ApnsEnvironment.development,
  );
}

final class _DeviceMeAdapter implements HttpClientAdapter {
  _DeviceMeAdapter({required this.role, required this.statusCode});

  final String? role;
  final int statusCode;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path != '/v2/device/me' || statusCode != 200) {
      return ResponseBody.fromString('', statusCode);
    }
    return ResponseBody.fromString(
      jsonEncode({
        'id': 'server-device-id',
        'type': 'IOS',
        'locale': 'ja',
        'registrationType': 'APP_CHECK',
        'userId': null,
        'is_pro': false,
        if (role != null) 'role': role,
        'createdAt': '2026-08-14T00:00:00.000Z',
        'updatedAt': '2026-08-14T00:00:00.000Z',
      }),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
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
