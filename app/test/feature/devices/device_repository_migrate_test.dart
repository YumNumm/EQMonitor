import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

const _oldDeviceId = 'legacy-supabase-id';

void main() {
  setUpAll(() {
    talker_lib.talker = Talker();
  });

  DeviceRepository buildRepository(_MigrateAdapter adapter) {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    return DeviceRepository(
      api.ApiClient(dio),
      _MemoryDeviceAuthRepository(),
      dio,
      apnsEnvironment: api.ApnsEnvironment.development,
    );
  }

  test('既登録デバイスで migrate 成功なら Success を返し old_device_id を送信する', () async {
    final adapter = _MigrateAdapter();
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
    expect(adapter.paths, ['/v2/device/me', '/v2/device/me/migrate']);
    expect(adapter.migrateRequestBody, {'old_device_id': _oldDeviceId});
  });

  test('migrate が 409 なら冪等成功として Success を返す', () async {
    final adapter = _MigrateAdapter(migrateStatus: 409);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
  });

  test('migrate が 404 (旧デバイスなし) なら非致命として Success を返す', () async {
    final adapter = _MigrateAdapter(migrateStatus: 404);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
  });

  test('migrate が 500 なら Failure を返す', () async {
    final adapter = _MigrateAdapter(migrateStatus: 500);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Failure<void, Exception>>());
  });

  test('GET /v2/device/me が予期しないエラーなら migrate を呼ばず Failure', () async {
    final adapter = _MigrateAdapter(getMeStatus: 500);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Failure<void, Exception>>());
    expect(adapter.paths, ['/v2/device/me']);
  });

  test('デバイス未登録 (404) なら登録してから migrate する', () async {
    final adapter = _MigrateAdapter(firstGetMeStatus: 404);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
    expect(adapter.paths, [
      '/v2/device/me', // step 1: 404
      '/v2/device', // register
      '/v2/device/me', // register 内の確認 GET
      '/v2/device/me/migrate',
    ]);
  });

  test('migrate が 200 でも不正なボディなら Failure を返す (パース失敗は成功扱いしない)',
      () async {
    final adapter = _MigrateAdapter(malformedMigrateBody: true);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Failure<void, Exception>>());
  });
}

final class _MigrateAdapter implements HttpClientAdapter {
  _MigrateAdapter({
    this.migrateStatus = 200,
    this.getMeStatus = 200,
    this.firstGetMeStatus,
    this.malformedMigrateBody = false,
  });

  /// POST /v2/device/me/migrate が返すステータス。
  final int migrateStatus;

  /// GET /v2/device/me が常に返すステータス。
  final int getMeStatus;

  /// 最初の GET /v2/device/me のみ返すステータス（未登録→登録フロー用）。
  final int? firstGetMeStatus;

  /// true のとき migrate が 200 で `migrated` キー欠落の不正ボディを返す。
  final bool malformedMigrateBody;

  final paths = <String>[];
  Map<String, Object?>? migrateRequestBody;
  var _getMeCalls = 0;

  static const _jsonHeaders = {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  };

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    if (options.path == '/v2/device/me/migrate') {
      migrateRequestBody = (options.data as Map).cast<String, Object?>();
      if (migrateStatus != 200) {
        throw DioException.badResponse(
          statusCode: migrateStatus,
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: migrateStatus),
        );
      }
      final body = malformedMigrateBody
          ? jsonEncode(<String, Object?>{}) // `migrated` キー欠落: パース失敗を誘発
          : jsonEncode({
              'migrated': {
                'earthquake_regions': 2,
                'eew_regions': 1,
                'notification_settings': true,
              },
            });
      return ResponseBody.fromString(body, 200, headers: _jsonHeaders);
    }
    if (options.path == '/v2/device/me') {
      _getMeCalls++;
      final status = (_getMeCalls == 1 && firstGetMeStatus != null)
          ? firstGetMeStatus!
          : getMeStatus;
      if (status != 200) {
        throw DioException.badResponse(
          statusCode: status,
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: status),
        );
      }
      return ResponseBody.fromString(
        jsonEncode({
          'id': 'server-device-id',
          'type': 'IOS',
          'locale': 'ja',
          'registrationType': 'APP_CHECK',
          'userId': null,
          'is_pro': false,
          'createdAt': '2026-06-05T00:00:00.000Z',
          'updatedAt': '2026-06-05T00:00:00.000Z',
        }),
        200,
        headers: _jsonHeaders,
      );
    }
    if (options.path == '/v2/device') {
      return ResponseBody.fromString(
        jsonEncode({
          'deviceId': 'server-device-id',
          'deviceToken': 'device-jwt',
          'expiresAt': null,
        }),
        201,
        headers: _jsonHeaders,
      );
    }
    return ResponseBody.fromString('', 404);
  }

  @override
  void close({bool force = false}) {}
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  String? savedToken;

  @override
  Future<void> saveToken({required String token}) async => savedToken = token;

  @override
  Future<String?> readToken() async => savedToken;

  @override
  Future<void> clearToken() async => savedToken = null;
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async => values[key] = value;

  @override
  Future<String?> getString({required SecureStorageKey key}) async =>
      values[key];

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
