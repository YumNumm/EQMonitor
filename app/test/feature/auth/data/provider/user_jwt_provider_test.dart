import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/user_api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('UserJwtProvider', () {
    test('同時3要求のJWT更新を1回のHTTP要求へsingle-flightする', () async {
      final fixture = _AuthFixture();
      final pending = Completer<ResponseBody>();
      fixture.authAdapter.enqueue(pending.future);
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );

      final requests = [
        jwtProvider.getValidJwt(),
        jwtProvider.getValidJwt(),
        jwtProvider.getValidJwt(),
      ];
      pending.complete(
        _jsonResponse({'token': _jwt(exp: 1893456061, marker: 'single')}),
      );
      final results = await Future.wait(requests);
      expect(
        results.map((result) => result.unwrap()).toList(),
        List.filled(3, _jwt(exp: 1893456061, marker: 'single')),
      );
      expect(fixture.authAdapter.requestCount, 1);
    });

    test('expの60秒前まではmemory JWTを再利用し、到達後に更新する', () async {
      final fixture = _AuthFixture();
      var now = DateTime.utc(2030);
      final firstJwt = _jwt(exp: 1893456061, marker: 'first');
      final secondJwt = _jwt(exp: 1893459660, marker: 'second');
      fixture.authAdapter
        ..enqueue(Future.value(_jsonResponse({'token': firstJwt})))
        ..enqueue(Future.value(_jsonResponse({'token': secondJwt})));
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => now,
      );

      expect((await jwtProvider.getValidJwt()).unwrap(), firstJwt);
      expect((await jwtProvider.getValidJwt()).unwrap(), firstJwt);
      expect(fixture.authAdapter.requestCount, 1);

      now = now.add(const Duration(seconds: 2));
      expect((await jwtProvider.getValidJwt()).unwrap(), secondJwt);
      expect(fixture.authAdapter.requestCount, 2);
    });

    test('JWTはSecure Storageへ永続化しない', () async {
      final fixture = _AuthFixture();
      fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
          'session-token';
      fixture.authAdapter.enqueue(
        Future.value(
          _jsonResponse({
            'token': _jwt(exp: 1893459660, marker: 'memory-only'),
          }),
        ),
      );
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );

      expect(
        await jwtProvider.getValidJwt(),
        isA<Success<String, AuthFailure>>(),
      );
      expect(fixture.preferences.values, {
        SecureStorageKey.betterAuthSessionToken: 'session-token',
      });
    });

    test('取得済みJWTのtokenを公開せず有効期限だけを参照できる', () async {
      final fixture = _AuthFixture();
      fixture.authAdapter.enqueue(
        Future.value(
          _jsonResponse({
            'token': _jwt(exp: 1893459660, marker: 'metadata'),
          }),
        ),
      );
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );

      expect(jwtProvider.expiresAt, isNull);
      await jwtProvider.getValidJwt();

      expect(
        jwtProvider.expiresAt,
        DateTime.fromMillisecondsSinceEpoch(
          1893459660 * Duration.millisecondsPerSecond,
          isUtc: true,
        ),
      );
    });

    test('JWT payloadがJSON objectでなければinvalidResponseを返す', () async {
      final fixture = _AuthFixture();
      final header = base64Url.encode(
        utf8.encode(jsonEncode({'alg': 'RS256'})),
      );
      final payload = base64Url.encode(utf8.encode(jsonEncode(['invalid'])));
      fixture.authAdapter.enqueue(
        Future.value(_jsonResponse({'token': '$header.$payload.signature'})),
      );
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );

      final result = await jwtProvider.getValidJwt();

      expect(
        (result as Failure<String, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
    });

    test('refresh中のclearJwt後に遅延JWTがcacheへ復活しない', () async {
      final fixture = _AuthFixture();
      final pending = Completer<ResponseBody>();
      fixture.authAdapter.enqueue(pending.future);
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );

      final refresh = jwtProvider.getValidJwt();
      await fixture.authAdapter.firstRequestStarted.future;
      jwtProvider.clearJwt();
      pending.complete(
        _jsonResponse({
          'token': _jwt(exp: 1893459660, marker: 'stale'),
        }),
      );

      expect(
        (await refresh as Failure<String, AuthFailure>).exception.kind,
        AuthFailureKind.unauthorized,
      );
      fixture.authAdapter.enqueue(
        Future.value(
          _jsonResponse({
            'token': _jwt(exp: 1893463260, marker: 'fresh'),
          }),
        ),
      );
      expect(
        (await jwtProvider.getValidJwt()).unwrap(),
        _jwt(exp: 1893463260, marker: 'fresh'),
      );
      expect(fixture.authAdapter.requestCount, 2);
    });

    test('provider dispose後に遅延JWTがcacheへ復活しない', () async {
      final fixture = _AuthFixture();
      final pending = Completer<ResponseBody>();
      fixture.authAdapter.enqueue(pending.future);
      final container = ProviderContainer(
        overrides: [
          betterAuthApiClientProvider.overrideWith(
            (ref) async => fixture.authClient,
          ),
        ],
      );
      final jwtProvider = await container.read(userJwtServiceProvider.future);

      final refresh = jwtProvider.getValidJwt();
      await fixture.authAdapter.firstRequestStarted.future;
      container.dispose();
      pending.complete(
        _jsonResponse({
          'token': _jwt(
            exp:
                DateTime.now()
                    .add(const Duration(hours: 1))
                    .toUtc()
                    .millisecondsSinceEpoch ~/
                Duration.millisecondsPerSecond,
            marker: 'disposed',
          ),
        }),
      );

      expect(
        (await refresh as Failure<String, AuthFailure>).exception.kind,
        AuthFailureKind.unauthorized,
      );
    });

    for (final testCase in const [
      (secondsFromNow: -1, isValid: false),
      (secondsFromNow: 59, isValid: false),
      (secondsFromNow: 60, isValid: false),
      (secondsFromNow: 61, isValid: true),
    ]) {
      test('fetch直後のexp境界 ${testCase.secondsFromNow}秒を検証する', () async {
        final fixture = _AuthFixture();
        final token = _jwt(
          exp: 1893456000 + testCase.secondsFromNow,
          marker: 'boundary',
        );
        fixture.authAdapter.enqueue(
          Future.value(_jsonResponse({'token': token})),
        );
        final jwtProvider = UserJwtProvider(
          apiClient: fixture.authClient,
          now: () => DateTime.utc(2030),
        );

        final result = await jwtProvider.getValidJwt();

        if (testCase.isValid) {
          expect(result.unwrap(), token);
        } else {
          expect(
            (result as Failure<String, AuthFailure>).exception.kind,
            AuthFailureKind.invalidResponse,
          );
        }
      });
    }

    for (final testCase in [
      (name: 'segment不足', token: 'header.payload'),
      (name: '空header', token: '.${_encodedJson({'exp': 1893459660})}.c2ln'),
      (name: '空payload', token: '${_encodedJson({'alg': 'RS256'})}..c2ln'),
      (
        name: '空signature',
        token:
            '${_encodedJson({'alg': 'RS256'})}.${_encodedJson({'exp': 1893459660})}.',
      ),
      (
        name: '不正header base64url',
        token: '*.${_encodedJson({'exp': 1893459660})}.c2ln',
      ),
      (
        name: 'header非object',
        token:
            '${_encodedJson(['RS256'])}.${_encodedJson({'exp': 1893459660})}.c2ln',
      ),
      (
        name: '不正payload base64url',
        token: '${_encodedJson({'alg': 'RS256'})}.*.c2ln',
      ),
      (
        name: 'payload非object',
        token:
            '${_encodedJson({'alg': 'RS256'})}.${_encodedJson(['invalid'])}.c2ln',
      ),
      (
        name: 'exp欠落',
        token:
            '${_encodedJson({'alg': 'RS256'})}.${_encodedJson({'sub': 'user'})}.c2ln',
      ),
      (
        name: 'exp文字列',
        token:
            '${_encodedJson({'alg': 'RS256'})}.${_encodedJson({'exp': '1893459660'})}.c2ln',
      ),
      (
        name: 'exp範囲外',
        token:
            '${_encodedJson({'alg': 'RS256'})}.${_encodedJson({'exp': 9223372036854775807})}.c2ln',
      ),
      (
        name: '不正signature base64url',
        token:
            '${_encodedJson({'alg': 'RS256'})}.${_encodedJson({'exp': 1893459660})}.*',
      ),
    ]) {
      test('不正JWT ${testCase.name}をinvalidResponseへ分類する', () async {
        final fixture = _AuthFixture();
        fixture.authAdapter.enqueue(
          Future.value(_jsonResponse({'token': testCase.token})),
        );
        final jwtProvider = UserJwtProvider(
          apiClient: fixture.authClient,
          now: () => DateTime.utc(2030),
        );

        final result = await jwtProvider.getValidJwt();

        expect(
          (result as Failure<String, AuthFailure>).exception.kind,
          AuthFailureKind.invalidResponse,
        );
      });
    }
  });

  group('UserApiClient', () {
    test('401時だけJWTを更新して1回再送し、成功時はsessionを保持する', () async {
      final fixture = _AuthFixture();
      fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
          'session-token';
      final firstJwt = _jwt(exp: 1893459660, marker: 'first');
      final refreshedJwt = _jwt(exp: 1893463260, marker: 'refreshed');
      fixture.authAdapter
        ..enqueue(Future.value(_jsonResponse({'token': firstJwt})))
        ..enqueue(Future.value(_jsonResponse({'token': refreshedJwt})));
      final userAdapter = _UserApiAdapter([
        _UserReply.unauthorized,
        _UserReply.success,
      ]);
      final client = _userApiClient(
        fixture: fixture,
        adapter: userAdapter,
      );

      final result = await client.getJson(path: '/v2/user/me');

      expect(result.unwrap(), {'ok': true});
      expect(userAdapter.authorizationHeaders, [
        'Bearer $firstJwt',
        'Bearer $refreshedJwt',
      ]);
      expect(fixture.authAdapter.requestCount, 2);
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        'session-token',
      );
    });

    test('再送後も401ならsessionを削除し、3回目を送らない', () async {
      final fixture = _AuthFixture();
      fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
          'session-token';
      fixture.authAdapter
        ..enqueue(
          Future.value(
            _jsonResponse({
              'token': _jwt(exp: 1893459660, marker: 'first'),
            }),
          ),
        )
        ..enqueue(
          Future.value(
            _jsonResponse({
              'token': _jwt(exp: 1893463260, marker: 'refreshed'),
            }),
          ),
        );
      final userAdapter = _UserApiAdapter([
        _UserReply.unauthorized,
        _UserReply.unauthorized,
      ]);
      final client = _userApiClient(
        fixture: fixture,
        adapter: userAdapter,
      );

      final result = await client.getJson(path: '/v2/user/me');

      expect(
        result,
        isA<Failure<Map<String, dynamic>, AuthFailure>>(),
      );
      expect(
        (result as Failure<Map<String, dynamic>, AuthFailure>).exception.kind,
        AuthFailureKind.unauthorized,
      );
      expect(userAdapter.requestCount, 2);
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        isNull,
      );
    });

    for (final testCase in const [
      (reply: _UserReply.rateLimited, failure: AuthFailureKind.rateLimited),
      (reply: _UserReply.serverError, failure: AuthFailureKind.server),
      (reply: _UserReply.timeout, failure: AuthFailureKind.timeout),
      (reply: _UserReply.network, failure: AuthFailureKind.network),
    ]) {
      test('${testCase.reply.name}ではsessionを保持する', () async {
        final fixture = _AuthFixture();
        fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
            'session-token';
        fixture.authAdapter.enqueue(
          Future.value(
            _jsonResponse({
              'token': _jwt(exp: 1893459660, marker: 'initial'),
            }),
          ),
        );
        final userAdapter = _UserApiAdapter([testCase.reply]);
        final client = _userApiClient(
          fixture: fixture,
          adapter: userAdapter,
        );

        final result = await client.getJson(path: '/v2/user/me');

        expect(
          (result as Failure<Map<String, dynamic>, AuthFailure>).exception.kind,
          testCase.failure,
        );
        expect(
          (await fixture.sessionRepository.readSessionToken()).unwrap(),
          'session-token',
        );
        expect(userAdapter.requestCount, 1);
      });
    }

    test('401後のJWT更新が5xxでもsessionを保持する', () async {
      final fixture = _AuthFixture();
      fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
          'session-token';
      fixture.authAdapter
        ..enqueue(
          Future.value(
            _jsonResponse({
              'token': _jwt(exp: 1893459660, marker: 'initial'),
            }),
          ),
        )
        ..enqueue(Future.value(_jsonResponse({}, statusCode: 503)));
      final userAdapter = _UserApiAdapter([_UserReply.unauthorized]);
      final client = _userApiClient(
        fixture: fixture,
        adapter: userAdapter,
      );

      final result = await client.getJson(path: '/v2/user/me');

      expect(
        (result as Failure<Map<String, dynamic>, AuthFailure>).exception.kind,
        AuthFailureKind.server,
      );
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        'session-token',
      );
      expect(userAdapter.requestCount, 1);
    });

    test('再送後も401ならauthSessionをsigned outにしてJWTを破棄する', () async {
      final fixture = _AuthFixture();
      fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
          'session-token';
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );
      fixture.authAdapter.enqueue(
        Future.value(
          _jsonResponse({
            'token': _jwt(exp: 1893459660, marker: 'accepted'),
          }),
        ),
      );
      final container = fixture.createContainer(jwtProvider: jwtProvider);
      addTearDown(container.dispose);
      await container.read(authSessionProvider.future);
      await container.read(authSessionProvider.notifier).acceptSignIn();
      fixture.authAdapter.enqueue(
        Future.value(
          _jsonResponse({
            'token': _jwt(exp: 1893463260, marker: 'retry'),
          }),
        ),
      );
      final client = _userApiClient(
        fixture: fixture,
        adapter: _UserApiAdapter([
          _UserReply.unauthorized,
          _UserReply.unauthorized,
        ]),
        jwtProvider: jwtProvider,
        invalidateSession: () =>
            container.read(authSessionProvider.notifier).invalidate(),
      );

      await client.getJson(path: '/v2/user/me');

      expect(
        container.read(authSessionProvider).value?.status,
        AuthSessionStatus.signedOut,
      );
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        isNull,
      );
      fixture.authAdapter.enqueue(
        Future.value(
          _jsonResponse({
            'token': _jwt(exp: 1893466860, marker: 'after-invalidation'),
          }),
        ),
      );
      expect(
        (await jwtProvider.getValidJwt()).unwrap(),
        _jwt(exp: 1893466860, marker: 'after-invalidation'),
      );
      expect(fixture.authAdapter.requestCount, 3);
    });

    test('401後のJWT更新も401ならauthSessionをsigned outにする', () async {
      final fixture = _AuthFixture();
      fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
          'session-token';
      final jwtProvider = UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );
      fixture.authAdapter
        ..enqueue(
          Future.value(
            _jsonResponse({
              'token': _jwt(exp: 1893459660, marker: 'accepted'),
            }),
          ),
        )
        ..enqueue(Future.value(_jsonResponse({}, statusCode: 401)));
      final container = fixture.createContainer(jwtProvider: jwtProvider);
      addTearDown(container.dispose);
      await container.read(authSessionProvider.future);
      await container.read(authSessionProvider.notifier).acceptSignIn();
      final client = _userApiClient(
        fixture: fixture,
        adapter: _UserApiAdapter([_UserReply.unauthorized]),
        jwtProvider: jwtProvider,
        invalidateSession: () =>
            container.read(authSessionProvider.notifier).invalidate(),
      );

      final result = await client.getJson(path: '/v2/user/me');

      expect(
        (result as Failure<Map<String, dynamic>, AuthFailure>).exception.kind,
        AuthFailureKind.unauthorized,
      );
      expect(
        container.read(authSessionProvider).value?.status,
        AuthSessionStatus.signedOut,
      );
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        isNull,
      );
    });
  });
}

UserApiClient _userApiClient({
  required _AuthFixture fixture,
  required _UserApiAdapter adapter,
  UserJwtProvider? jwtProvider,
  AuthSessionInvalidator? invalidateSession,
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = adapter;
  final resolvedJwtProvider =
      jwtProvider ??
      UserJwtProvider(
        apiClient: fixture.authClient,
        now: () => DateTime.utc(2030),
      );
  return UserApiClient(
    dio: dio,
    jwtProvider: resolvedJwtProvider,
    invalidateSession:
        invalidateSession ??
        () async {
          await fixture.sessionRepository.clearSession();
          resolvedJwtProvider.clearJwt();
          return const Success(AuthSession.signedOut());
        },
  );
}

String _jwt({required int exp, required String marker}) {
  final header = _encodedJson({'alg': 'RS256'});
  final payload = _encodedJson({'exp': exp, 'marker': marker});
  return '$header.$payload.c2lnbmF0dXJl';
}

String _encodedJson<T>(T value) =>
    base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');

ResponseBody _jsonResponse(
  Map<String, dynamic> body, {
  int statusCode = 200,
}) => ResponseBody.fromString(
  jsonEncode(body),
  statusCode,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

final class _AuthFixture {
  _AuthFixture() {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = authAdapter;
    sessionRepository = BetterAuthSessionRepository(
      preferences: preferences,
    );
    authClient = BetterAuthApiClient(
      dio: dio,
      sessionRepository: sessionRepository,
      cookieJar: CookieJar(),
    );
  }

  final preferences = _MemorySecurePreferencesDataSource();
  final authAdapter = _QueueAuthAdapter();
  late final BetterAuthSessionRepository sessionRepository;
  late final BetterAuthApiClient authClient;

  ProviderContainer createContainer({required UserJwtProvider jwtProvider}) =>
      ProviderContainer(
        overrides: [
          betterAuthSessionRepositoryProvider.overrideWith(
            (ref) async => sessionRepository,
          ),
          betterAuthApiClientProvider.overrideWith((ref) async => authClient),
          userJwtServiceProvider.overrideWith((ref) async => jwtProvider),
        ],
      );
}

final class _QueueAuthAdapter implements HttpClientAdapter {
  final responses = <Future<ResponseBody>>[];
  final firstRequestStarted = Completer<void>();
  var requestCount = 0;

  void enqueue(Future<ResponseBody> response) {
    responses.add(response);
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    if (!firstRequestStarted.isCompleted) {
      firstRequestStarted.complete();
    }
    if (responses.isEmpty) {
      throw StateError('No queued auth response');
    }
    return responses.removeAt(0);
  }

  @override
  void close({bool force = false}) {}
}

enum _UserReply {
  success,
  unauthorized,
  rateLimited,
  serverError,
  timeout,
  network,
}

final class _UserApiAdapter implements HttpClientAdapter {
  _UserApiAdapter(this.replies);

  final List<_UserReply> replies;
  final authorizationHeaders = <String?>[];
  var requestCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    authorizationHeaders.add(options.headers['Authorization'] as String?);
    final reply = replies.removeAt(0);
    return switch (reply) {
      .success => _jsonResponse({'ok': true}),
      .unauthorized => _jsonResponse({}, statusCode: 401),
      .rateLimited => _jsonResponse({}, statusCode: 429),
      .serverError => _jsonResponse({}, statusCode: 503),
      .timeout => throw DioException(
        requestOptions: options,
        type: DioExceptionType.receiveTimeout,
      ),
      .network => throw DioException.connectionError(
        requestOptions: options,
        reason: 'network unavailable',
      ),
    };
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
