import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BetterAuthSessionRepository', () {
    test('Better Auth session tokenを専用Secure Storageキーへ保存・復元する', () async {
      final preferences = _MemorySecurePreferencesDataSource();
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );

      await repository.saveSessionToken(token: 'session-token');

      expect(
        preferences.values,
        {SecureStorageKey.betterAuthSessionToken: 'session-token'},
      );
      expect(await repository.readSessionToken(), 'session-token');
    });

    test('session削除時にDevice JWTなど他のSecure Storage値を消さない', () async {
      final preferences = _MemorySecurePreferencesDataSource()
        ..values[SecureStorageKey.betterAuthSessionToken] = 'session-token'
        ..values[SecureStorageKey.deviceToken] = 'device-jwt';
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );

      await repository.clearSession();

      expect(
        preferences.values,
        {SecureStorageKey.deviceToken: 'device-jwt'},
      );
    });
  });

  group('BetterAuthApiClient', () {
    test('保存済みsession tokenを付与しset-auth-tokenで安全に置換する', () async {
      final preferences = _MemorySecurePreferencesDataSource()
        ..values[SecureStorageKey.betterAuthSessionToken] = 'old-session';
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );
      final adapter = _RecordingAuthAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final client = BetterAuthApiClient(
        dio: dio,
        sessionRepository: repository,
      );

      final result = await client.getSession();

      expect(result, isA<Success<bool, AuthFailure>>());
      expect(result.unwrap(), isTrue);
      expect(adapter.authorizationHeaders, ['Bearer old-session']);
      expect(await repository.readSessionToken(), 'new-session');
    });

    test('social sign-inをBetter Authのnative idToken形式で送る', () async {
      final preferences = _MemorySecurePreferencesDataSource();
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );
      final adapter = _RecordingAuthAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final client = BetterAuthApiClient(
        dio: dio,
        sessionRepository: repository,
      );

      final result = await client.signInSocial(
        provider: 'google',
        idToken: 'provider-id-token',
        nonce: 'provider-nonce',
      );

      expect(result, isA<Success<void, AuthFailure>>());
      expect(adapter.paths, ['/api/auth/sign-in/social']);
      expect(adapter.requestBodies.single, {
        'provider': 'google',
        'idToken': {
          'token': 'provider-id-token',
          'nonce': 'provider-nonce',
        },
      });
      expect(await repository.readSessionToken(), 'new-session');
    });
  });
}

final class _RecordingAuthAdapter implements HttpClientAdapter {
  final paths = <String>[];
  final authorizationHeaders = <String?>[];
  final requestBodies = <Map<String, dynamic>>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    authorizationHeaders.add(options.headers['Authorization'] as String?);
    final data = options.data;
    if (data is Map<String, dynamic>) {
      requestBodies.add(data);
    }
    final body = options.path == '/api/auth/get-session'
        ? {
            'session': {'id': 'session-id'},
            'user': {'id': 'user-id'},
          }
        : <String, dynamic>{};
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        'set-auth-token': ['new-session'],
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
