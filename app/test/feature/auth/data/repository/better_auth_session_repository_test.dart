import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
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

      expect(
        await repository.saveSessionToken(token: 'session-token'),
        isA<Success<void, AuthFailure>>(),
      );

      expect(
        preferences.values,
        {SecureStorageKey.betterAuthSessionToken: 'session-token'},
      );
      expect(
        (await repository.readSessionToken()).unwrap(),
        'session-token',
      );
    });

    test('session削除時にDevice JWTなど他のSecure Storage値を消さない', () async {
      final preferences = _MemorySecurePreferencesDataSource()
        ..values[SecureStorageKey.betterAuthSessionToken] = 'session-token'
        ..values[SecureStorageKey.deviceToken] = 'device-jwt';
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );

      expect(
        await repository.clearSession(),
        isA<Success<void, AuthFailure>>(),
      );

      expect(
        preferences.values,
        {SecureStorageKey.deviceToken: 'device-jwt'},
      );
    });

    test('Secure Storage read例外をstorage Failureへ閉じる', () async {
      final repository = BetterAuthSessionRepository(
        preferences: _MemorySecurePreferencesDataSource()
          ..throwingOperation = 'read',
      );

      final result = await repository.readSessionToken();

      expect(
        (result as Failure<String?, AuthFailure>).exception.kind,
        AuthFailureKind.storage,
      );
    });

    test('Secure Storage set例外をstorage Failureへ閉じる', () async {
      final repository = BetterAuthSessionRepository(
        preferences: _MemorySecurePreferencesDataSource()
          ..throwingOperation = 'set',
      );

      final result = await repository.saveSessionToken(
        token: 'session-token',
      );

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.storage,
      );
    });

    test('Secure Storage remove例外をstorage Failureへ閉じる', () async {
      final repository = BetterAuthSessionRepository(
        preferences: _MemorySecurePreferencesDataSource()
          ..throwingOperation = 'remove',
      );

      final result = await repository.clearSession();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.storage,
      );
    });

    test('clearSessionを跨ぐpending setString完了後にtokenを残さない', () async {
      final preferences = _MemorySecurePreferencesDataSource();
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );
      final setGate = Completer<void>();
      preferences.setStringGate = setGate;

      final save = repository.saveSessionToken(token: 'stale-session');
      await preferences.setStringStarted.future;
      final clear = repository.clearSession();
      setGate.complete();
      await save;
      await clear;

      expect(
        (await repository.readSessionToken()).unwrap(),
        isNull,
      );
      expect(preferences.mutationOrder, ['set', 'remove']);
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
        cookieJar: CookieJar(),
      );

      final result = await client.getSession();

      expect(result, isA<Success<bool, AuthFailure>>());
      expect(result.unwrap(), isTrue);
      expect(adapter.authorizationHeaders, ['Bearer old-session']);
      expect((await repository.readSessionToken()).unwrap(), 'new-session');
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
        cookieJar: CookieJar(),
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
      expect((await repository.readSessionToken()).unwrap(), 'new-session');
    });

    test('social sign-in成功時だけ新session tokenとCookieをcommitする', () async {
      final preferences = _MemorySecurePreferencesDataSource()
        ..values[SecureStorageKey.betterAuthSessionToken] = 'old-session';
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );
      final adapter = _SocialSignInResponseAdapter(
        tokenHeaders: const ['new-session'],
      );
      final cookieJar = CookieJar();
      await cookieJar.saveFromResponse(
        Uri.parse('https://example.com'),
        [Cookie('session', 'old-cookie')],
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final client = BetterAuthApiClient(
        dio: dio,
        sessionRepository: repository,
        cookieJar: cookieJar,
      );

      final result = await client.signInSocial(
        provider: 'google',
        idToken: 'provider-id-token',
      );
      await client.getSession();

      expect(result, isA<Success<void, AuthFailure>>());
      expect((await repository.readSessionToken()).unwrap(), 'new-session');
      expect(adapter.cookieHeaders, [
        'session=old-cookie',
        'session=new-cookie',
      ]);
    });

    for (final testCase in <({String name, List<String>? tokenHeaders})>[
      (name: '欠落', tokenHeaders: null),
      (name: '複数', tokenHeaders: ['session-a', 'session-b']),
      (name: '不正値', tokenHeaders: [' unsafe-session']),
    ]) {
      test(
        'social sign-inのset-auth-token ${testCase.name}をinvalidResponseにして既存sessionを保持する',
        () async {
          final preferences = _MemorySecurePreferencesDataSource()
            ..values[SecureStorageKey.betterAuthSessionToken] = 'old-session';
          final repository = BetterAuthSessionRepository(
            preferences: preferences,
          );
          final adapter = _SocialSignInResponseAdapter(
            tokenHeaders: testCase.tokenHeaders,
          );
          final cookieJar = CookieJar();
          await cookieJar.saveFromResponse(
            Uri.parse('https://example.com'),
            [Cookie('session', 'old-cookie')],
          );
          final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
            ..httpClientAdapter = adapter;
          final client = BetterAuthApiClient(
            dio: dio,
            sessionRepository: repository,
            cookieJar: cookieJar,
          );

          final result = await client.signInSocial(
            provider: 'google',
            idToken: 'provider-id-token',
          );
          await client.getSession();

          expect(
            (result as Failure<void, AuthFailure>).exception.kind,
            AuthFailureKind.invalidResponse,
          );
          expect(
            (await repository.readSessionToken()).unwrap(),
            'old-session',
          );
          expect(adapter.cookieHeaders, [
            'session=old-cookie',
            'session=old-cookie',
          ]);
        },
      );
    }

    test(
      'social sign-inのsession token保存例外をstorageにして既存sessionを保持する',
      () async {
        final preferences = _MemorySecurePreferencesDataSource()
          ..values[SecureStorageKey.betterAuthSessionToken] = 'old-session'
          ..throwingOperation = 'set';
        final repository = BetterAuthSessionRepository(
          preferences: preferences,
        );
        final adapter = _SocialSignInResponseAdapter(
          tokenHeaders: const ['new-session'],
        );
        final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
          ..httpClientAdapter = adapter;
        final cookieJar = CookieJar();
        await cookieJar.saveFromResponse(
          Uri.parse('https://example.com'),
          [Cookie('session', 'old-cookie')],
        );
        final client = BetterAuthApiClient(
          dio: dio,
          sessionRepository: repository,
          cookieJar: cookieJar,
        );

        final result = await client.signInSocial(
          provider: 'google',
          idToken: 'provider-id-token',
        );
        preferences.throwingOperation = null;
        await client.getSession();

        expect(
          (result as Failure<void, AuthFailure>).exception.kind,
          AuthFailureKind.storage,
        );
        expect((await repository.readSessionToken()).unwrap(), 'old-session');
        expect(adapter.cookieHeaders, [
          'session=old-cookie',
          'session=old-cookie',
        ]);
      },
    );

    test('social sign-in応答待ちのinvalidation後にsessionとCookieを復活させない', () async {
      final preferences = _MemorySecurePreferencesDataSource()
        ..values[SecureStorageKey.betterAuthSessionToken] = 'old-session';
      final repository = BetterAuthSessionRepository(
        preferences: preferences,
      );
      final responseGate = Completer<void>();
      final adapter = _SocialSignInResponseAdapter(
        tokenHeaders: const ['new-session'],
        responseGate: responseGate,
      );
      final cookieJar = CookieJar();
      await cookieJar.saveFromResponse(
        Uri.parse('https://example.com'),
        [Cookie('session', 'old-cookie')],
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final client = BetterAuthApiClient(
        dio: dio,
        sessionRepository: repository,
        cookieJar: cookieJar,
      );

      final pendingSignIn = client.signInSocial(
        provider: 'google',
        idToken: 'provider-id-token',
      );
      await adapter.fetchStarted.future;
      await repository.clearSession();
      await client.clearCookies();
      responseGate.complete();
      final result = await pendingSignIn;
      await client.getSession();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect((await repository.readSessionToken()).unwrap(), isNull);
      expect(adapter.cookieHeaders, ['session=old-cookie', null]);
    });

    test('remote sign-out失敗時も専用CookieJarを削除する', () async {
      final repository = BetterAuthSessionRepository(
        preferences: _MemorySecurePreferencesDataSource(),
      );
      final adapter = _CookieLifecycleAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final client = BetterAuthApiClient(
        dio: dio,
        sessionRepository: repository,
        cookieJar: CookieJar(),
      );
      await client.getSession();

      final signOut = await client.signOut();
      await client.getSession();

      expect(
        (signOut as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.network,
      );
      expect(adapter.cookieHeaders, [null, 'session=cookie-session', null]);
    });

    test('Secure Storage read例外はHTTP前にstorage Failureへ閉じる', () async {
      final preferences = _MemorySecurePreferencesDataSource()
        ..throwingOperation = 'read';
      final adapter = _RecordingAuthAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final client = BetterAuthApiClient(
        dio: dio,
        sessionRepository: BetterAuthSessionRepository(
          preferences: preferences,
        ),
        cookieJar: CookieJar(),
      );

      final result = await client.getSession();

      expect(
        (result as Failure<bool, AuthFailure>).exception.kind,
        AuthFailureKind.storage,
      );
      expect(adapter.paths, isEmpty);
    });

    test('set-auth-token保存例外をstorage Failureへ閉じる', () async {
      final preferences = _MemorySecurePreferencesDataSource()
        ..throwingOperation = 'set';
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = _RecordingAuthAdapter();
      final client = BetterAuthApiClient(
        dio: dio,
        sessionRepository: BetterAuthSessionRepository(
          preferences: preferences,
        ),
        cookieJar: CookieJar(),
      );

      final result = await client.getSession();

      expect(
        (result as Failure<bool, AuthFailure>).exception.kind,
        AuthFailureKind.storage,
      );
    });
  });
}

final class _CookieLifecycleAdapter implements HttpClientAdapter {
  final cookieHeaders = <String?>[];
  var requestCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    cookieHeaders.add(options.headers['cookie'] as String?);
    if (requestCount == 2) {
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'network unavailable',
      );
    }
    return ResponseBody.fromString(
      jsonEncode({
        'session': {'id': 'session-id'},
      }),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        if (requestCount == 1) 'set-cookie': ['session=cookie-session; Path=/'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
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

final class _SocialSignInResponseAdapter implements HttpClientAdapter {
  _SocialSignInResponseAdapter({
    required this.tokenHeaders,
    this.responseGate,
  });

  final List<String>? tokenHeaders;
  final Completer<void>? responseGate;
  final cookieHeaders = <String?>[];
  final fetchStarted = Completer<void>();

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    cookieHeaders.add(options.headers['cookie'] as String?);
    final isSignIn = options.path == '/api/auth/sign-in/social';
    final currentTokenHeaders = tokenHeaders;
    if (!fetchStarted.isCompleted) {
      fetchStarted.complete();
    }
    if (isSignIn) {
      await responseGate?.future;
    }
    return ResponseBody.fromString(
      jsonEncode(
        isSignIn
            ? <String, dynamic>{}
            : {
                'session': {'id': 'session-id'},
                'user': {'id': 'user-id'},
              },
      ),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        if (isSignIn) 'set-cookie': ['session=new-cookie; Path=/'],
        if (isSignIn && currentTokenHeaders != null)
          'set-auth-token': currentTokenHeaders,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};
  final mutationOrder = <String>[];
  String? throwingOperation;
  Completer<void>? setStringGate;
  final setStringStarted = Completer<void>();

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {
    if (!setStringStarted.isCompleted) {
      setStringStarted.complete();
    }
    final gate = setStringGate;
    if (gate != null) {
      await gate.future;
    }
    if (throwingOperation == 'set') {
      throw Exception('secure storage set failed');
    }
    values[key] = value;
    mutationOrder.add('set');
  }

  @override
  Future<String?> getString({required SecureStorageKey key}) async {
    if (throwingOperation == 'read') {
      throw Exception('secure storage read failed');
    }
    return values[key];
  }

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
    if (throwingOperation == 'remove') {
      throw Exception('secure storage remove failed');
    }
    values.remove(key);
    mutationOrder.add('remove');
  }

  @override
  Future<void> clear() async {
    values.clear();
  }
}
