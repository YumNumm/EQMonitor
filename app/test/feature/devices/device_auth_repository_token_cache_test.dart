import 'dart:async';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/provider/interceptor/device_auth_token_interceptor.dart';
import 'package:eqmonitor/core/provider/interceptor/device_id_interceptor.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeviceAuthRepository のトークン保持', () {
    test('一度読んだトークンは secure storage を読み直さずに返す', () async {
      final storage = _CountingSecureStorage(token: 'token-1');
      final repository = DeviceAuthRepository(storage);

      expect(await repository.readToken(), 'token-1');
      expect(await repository.readToken(), 'token-1');
      expect(await repository.readToken(), 'token-1');

      expect(storage.readCount, 1);
    });

    test('保存なしの結果は保持せず、読めるようになった値を返す', () async {
      final storage = _CountingSecureStorage();
      final repository = DeviceAuthRepository(storage);

      expect(await repository.readToken(), isNull);
      storage.token = 'token-1';

      expect(await repository.readToken(), 'token-1');
      expect(storage.readCount, 2);
    });

    test('同時に読んでも secure storage の読み取りは 1 回にまとめる', () async {
      final storage = _CountingSecureStorage(token: 'token-1');
      final repository = DeviceAuthRepository(storage);

      final tokens = await Future.wait([
        repository.readToken(),
        repository.readToken(),
        repository.readToken(),
      ]);

      expect(tokens, ['token-1', 'token-1', 'token-1']);
      expect(storage.readCount, 1);
    });

    test('保存すると、保持した値を新しいトークンへ入れ替える', () async {
      final storage = _CountingSecureStorage(token: 'token-1');
      final repository = DeviceAuthRepository(storage);
      await repository.readToken();

      await repository.saveToken(token: 'token-2');

      expect(await repository.readToken(), 'token-2');
      expect(storage.token, 'token-2');
      expect(storage.readCount, 1);
    });

    test('削除すると、保持した値を返さない', () async {
      final storage = _CountingSecureStorage(token: 'token-1');
      final repository = DeviceAuthRepository(storage);
      await repository.readToken();

      await repository.clearToken();

      expect(await repository.readToken(), isNull);
      expect(storage.token, isNull);
    });

    test('読み取りの失敗は保持せず、次の読み取りでやり直す', () async {
      final storage = _CountingSecureStorage(token: 'token-1')
        ..readError = StateError('keychain locked');
      final repository = DeviceAuthRepository(storage);

      await expectLater(repository.readToken(), throwsStateError);
      storage.readError = null;

      expect(await repository.readToken(), 'token-1');
      expect(storage.readCount, 2);
    });

    test('保存に失敗したら、古い値を返し続けず secure storage を読み直す', () async {
      final storage = _CountingSecureStorage(token: 'token-1');
      final repository = DeviceAuthRepository(storage);
      await repository.readToken();
      storage.writeError = StateError('keychain locked');

      await expectLater(
        repository.saveToken(token: 'token-2'),
        throwsStateError,
      );
      storage.token = 'token-3';

      expect(await repository.readToken(), 'token-3');
      expect(storage.readCount, 2);
    });

    test('書き込み中に始まった読み取りの結果で、保存後の値を上書きしない', () async {
      final storage = _CountingSecureStorage(token: 'token-1');
      final repository = DeviceAuthRepository(storage);
      final write = Completer<void>();
      storage.pendingWrite = write;

      final saving = repository.saveToken(token: 'token-2');
      await Future<void>.delayed(Duration.zero);
      final readDuringWrite = repository.readToken();
      write.complete();
      await saving;

      expect(await readDuringWrite, 'token-1');
      expect(await repository.readToken(), 'token-2');
    });

    test('forgetCachedToken の後は secure storage を読み直す', () async {
      final storage = _CountingSecureStorage(token: 'token-1');
      final repository = DeviceAuthRepository(storage);
      await repository.readToken();
      storage.token = 'token-2';

      repository.forgetCachedToken();

      expect(await repository.readToken(), 'token-2');
      expect(storage.readCount, 2);
    });
  });

  test('再登録後のリクエストは新しい端末 ID と認証ヘッダーを送る', () async {
    final storage = _CountingSecureStorage(token: _jwt('device-1'));
    final repository = DeviceAuthRepository(storage);
    final idInterceptor = DeviceIdInterceptor(readToken: repository.readToken);
    final authInterceptor = DeviceAuthTokenInterceptor(
      readToken: repository.readToken,
    );

    Future<RequestOptions> send() async {
      final options = RequestOptions(path: '/v2/device/me', method: 'GET');
      await idInterceptor.onRequest(options, _Handler());
      await authInterceptor.onRequest(options, _Handler());
      return options;
    }

    for (var i = 0; i < 3; i++) {
      final options = await send();
      expect(options.headers['x-eqmonitor-device-id'], 'device-1');
      expect(
        options.headers[HttpHeaders.authorizationHeader],
        'Bearer ${_jwt('device-1')}',
      );
    }
    expect(storage.readCount, 1);

    await repository.clearToken();
    final unregistered = await send();
    expect(
      unregistered.headers.containsKey('x-eqmonitor-device-id'),
      isFalse,
    );
    expect(
      unregistered.headers.containsKey(HttpHeaders.authorizationHeader),
      isFalse,
    );

    final readsBeforeRegistration = storage.readCount;
    await repository.saveToken(token: _jwt('device-2'));
    for (var i = 0; i < 3; i++) {
      final reregistered = await send();
      expect(reregistered.headers['x-eqmonitor-device-id'], 'device-2');
      expect(
        reregistered.headers[HttpHeaders.authorizationHeader],
        'Bearer ${_jwt('device-2')}',
      );
    }
    expect(storage.readCount, readsBeforeRegistration);
  });
}

String _jwt(String deviceId) =>
    JWT({'sub': 'device:$deviceId'}).sign(SecretKey('test-secret'));

final class _Handler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions requestOptions) {}
}

final class _CountingSecureStorage
    implements PreferencesDataSource<SecureStorageKey> {
  new({this.token});

  String? token;
  Object? readError;
  Object? writeError;
  Completer<void>? pendingWrite;
  var readCount = 0;

  @override
  Future<String?> getString({required SecureStorageKey key}) async {
    readCount += 1;
    final error = readError;
    if (error != null) {
      throw error;
    }
    return token;
  }

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {
    await pendingWrite?.future;
    final error = writeError;
    if (error != null) {
      throw error;
    }
    token = value;
  }

  @override
  Future<void> remove({required SecureStorageKey key}) async {
    token = null;
  }

  @override
  Future<void> clear() async => token = null;

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async => null;

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async => null;

  @override
  Future<int?> getInt({required SecureStorageKey key}) async => null;

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {}

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {}

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) async {}
}
