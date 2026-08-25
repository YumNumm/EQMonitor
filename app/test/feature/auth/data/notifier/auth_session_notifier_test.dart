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
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_session_lifecycle.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  test('session tokenが無いrestoreはHTTPせずsigned outにする', () async {
    final fixture = _NotifierFixture();
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);

    final result = await container.read(authSessionProvider.notifier).restore();

    expect(result.unwrap().status, AuthSessionStatus.signedOut);
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
    expect(container.read(authSessionRevisionProvider), 1);
    expect(fixture.adapter.requestCount, 0);
  });

  test('保存sessionを検証してJWTをmemoryへ復元する', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    final jwt = _jwt(exp: 1893459660, marker: 'restored');
    fixture.adapter
      ..enqueue(
        _jsonResponse({
          'session': {'id': 'session-id'},
          'user': {'id': 'user-id'},
        }),
      )
      ..enqueue(_jsonResponse({'token': jwt}));
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);

    final result = await container.read(authSessionProvider.notifier).restore();

    expect(result.unwrap().status, AuthSessionStatus.authenticated);
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.authenticated,
    );
    expect(fixture.adapter.paths, [
      '/api/auth/get-session',
      '/api/auth/token',
    ]);
  });

  test('acceptSignInとrefreshJwtでJWTだけをmemory更新する', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    final firstJwt = _jwt(exp: 1893459660, marker: 'first');
    final refreshedJwt = _jwt(exp: 1893463260, marker: 'refreshed');
    fixture.adapter
      ..enqueue(_jsonResponse({'token': firstJwt}))
      ..enqueue(_jsonResponse({'token': refreshedJwt}));
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);

    final accepted = await container
        .read(authSessionProvider.notifier)
        .acceptSignIn();
    final refreshed = await container
        .read(authSessionProvider.notifier)
        .refreshJwt();

    expect(accepted.unwrap().status, AuthSessionStatus.authenticated);
    expect(refreshed.unwrap().status, AuthSessionStatus.authenticated);
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.authenticated,
    );
    expect(container.read(authSessionRevisionProvider), 2);
    expect(fixture.preferences.values, {
      SecureStorageKey.betterAuthSessionToken: 'session-token',
    });
  });

  test('signOut成功時にsessionとmemory JWTを削除する', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    fixture.adapter
      ..enqueue(
        _jsonResponse({
          'token': _jwt(exp: 1893459660, marker: 'signed-in'),
        }),
      )
      ..enqueue(_jsonResponse({}));
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);
    await container.read(authSessionProvider.notifier).acceptSignIn();

    final result = await container.read(authSessionProvider.notifier).signOut();

    expect(result.unwrap().status, AuthSessionStatus.signedOut);
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
    expect(container.read(authSessionRevisionProvider), 2);
    expect(
      (await fixture.sessionRepository.readSessionToken()).unwrap(),
      isNull,
    );
  });

  test('restoreの5xxはsessionを保持してFailureを返す', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    fixture.adapter.enqueue(_jsonResponse({}, statusCode: 503));
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);

    final result = await container.read(authSessionProvider.notifier).restore();

    expect(result, isA<Failure<AuthSession, AuthFailure>>());
    expect(
      (result as Failure<AuthSession, AuthFailure>).exception.kind,
      AuthFailureKind.server,
    );
    expect(
      (await fixture.sessionRepository.readSessionToken()).unwrap(),
      'session-token',
    );
  });

  test('acceptSignInの401は無効なsessionを削除する', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    fixture.adapter.enqueue(_jsonResponse({}, statusCode: 401));
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);

    final result = await container
        .read(authSessionProvider.notifier)
        .acceptSignIn();

    expect(
      (result as Failure<AuthSession, AuthFailure>).exception.kind,
      AuthFailureKind.unauthorized,
    );
    expect(
      (await fixture.sessionRepository.readSessionToken()).unwrap(),
      isNull,
    );
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
    expect(container.read(authSessionRevisionProvider), 1);
  });

  test('acceptSignIn中のlocal invalidation後に認証状態が復活しない', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    final pending = Completer<ResponseBody>();
    fixture.adapter.enqueue(pending.future);
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);

    final acceptStarted = fixture.adapter.nextRequestStarted();
    final accept = container.read(authSessionProvider.notifier).acceptSignIn();
    await acceptStarted;
    await container.read(authSessionProvider.notifier).invalidate();
    pending.complete(
      _jsonResponse({
        'token': _jwt(exp: 1893459660, marker: 'stale-accept'),
      }),
    );

    expect(
      (await accept as Failure<AuthSession, AuthFailure>).exception.kind,
      AuthFailureKind.unauthorized,
    );
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
  });

  test('refreshJwt中のsignOut後に認証状態が復活しない', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    fixture.adapter.enqueue(
      _jsonResponse({
        'token': _jwt(exp: 1893459660, marker: 'accepted'),
      }),
    );
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);
    await container.read(authSessionProvider.notifier).acceptSignIn();
    final pending = Completer<ResponseBody>();
    fixture.adapter
      ..enqueue(pending.future)
      ..enqueue(_jsonResponse({}));

    final refreshStarted = fixture.adapter.nextRequestStarted();
    final refresh = container.read(authSessionProvider.notifier).refreshJwt();
    await refreshStarted;
    await container.read(authSessionProvider.notifier).signOut();
    pending.complete(
      _jsonResponse({
        'token': _jwt(exp: 1893463260, marker: 'stale-refresh'),
      }),
    );

    expect(
      (await refresh as Failure<AuthSession, AuthFailure>).exception.kind,
      AuthFailureKind.unauthorized,
    );
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
  });

  test('restore中のsignOut後にsession tokenと認証状態が復活しない', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    final pending = Completer<ResponseBody>();
    fixture.adapter
      ..enqueue(pending.future)
      ..enqueue(_jsonResponse({}));
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);

    final restoreStarted = fixture.adapter.nextRequestStarted();
    final restore = container.read(authSessionProvider.notifier).restore();
    await restoreStarted;
    await container.read(authSessionProvider.notifier).signOut();
    pending.complete(
      _jsonResponse(
        {
          'session': {'id': 'late-session'},
        },
        headers: {
          'set-auth-token': ['late-session-token'],
          'set-cookie': ['session=late-cookie; Path=/'],
        },
      ),
    );

    expect(
      (await restore as Failure<AuthSession, AuthFailure>).exception.kind,
      AuthFailureKind.unauthorized,
    );
    expect(
      (await fixture.sessionRepository.readSessionToken()).unwrap(),
      isNull,
    );
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
    expect(fixture.adapter.paths, [
      '/api/auth/get-session',
      '/api/auth/sign-out',
    ]);
    fixture.adapter.enqueue(
      _jsonResponse({
        'session': {'id': 'after-sign-out'},
      }),
    );

    await fixture.apiClient.getSession();

    expect(fixture.adapter.cookieHeaders, [null, null, null]);
  });

  test('invalidation cleanup中の新規JWT refreshを拒否する', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    fixture.adapter.enqueue(
      _jsonResponse({
        'token': _jwt(exp: 1893459660, marker: 'cached'),
      }),
    );
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);
    await container.read(authSessionProvider.notifier).acceptSignIn();
    final removeGate = Completer<void>();
    fixture.preferences.removeGate = removeGate;

    final invalidation = container
        .read(authSessionProvider.notifier)
        .invalidate();
    await fixture.preferences.removeStarted.future;
    fixture.adapter.enqueue(
      _jsonResponse({
        'token': _jwt(exp: 1893463260, marker: 'during-invalidation'),
      }),
    );

    final refresh = await fixture.jwtProvider.getValidJwt();

    expect(
      (refresh as Failure<String, AuthFailure>).exception.kind,
      AuthFailureKind.unauthorized,
    );
    expect(fixture.adapter.requestCount, 1);
    removeGate.complete();
    await invalidation;
  });

  test('Secure Storage remove例外でもstateとJWTとCookieを消去する', () async {
    final fixture = _NotifierFixture();
    fixture.preferences.values[SecureStorageKey.betterAuthSessionToken] =
        'session-token';
    fixture.adapter.enqueue(
      _jsonResponse({
        'token': _jwt(exp: 1893459660, marker: 'cached'),
      }),
    );
    final container = fixture.createContainer();
    addTearDown(container.dispose);
    await container.read(authSessionProvider.future);
    await container.read(authSessionProvider.notifier).acceptSignIn();
    await fixture.cookieJar.saveFromResponse(
      Uri.parse('https://example.com'),
      [Cookie('session', 'cookie-session')],
    );
    fixture.preferences.throwOnRemove = true;

    final result = await container
        .read(authSessionProvider.notifier)
        .invalidate();

    expect(
      (result as Failure<AuthSession, AuthFailure>).exception.kind,
      AuthFailureKind.storage,
    );
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
    expect(
      await fixture.cookieJar.loadForRequest(
        Uri.parse('https://example.com'),
      ),
      isEmpty,
    );
    expect(container.read(authSessionRevisionProvider), 2);
    fixture.adapter.enqueue(
      _jsonResponse({
        'token': _jwt(exp: 1893463260, marker: 'fresh'),
      }),
    );
    expect(
      (await container.read(authSessionProvider.notifier).acceptSignIn())
          .unwrap()
          .status,
      AuthSessionStatus.authenticated,
    );
    expect(fixture.adapter.requestCount, 2);
  });
}

String _jwt({required int exp, required String marker}) {
  final header = base64Url
      .encode(utf8.encode(jsonEncode({'alg': 'RS256'})))
      .replaceAll('=', '');
  final payload = base64Url
      .encode(utf8.encode(jsonEncode({'exp': exp, 'marker': marker})))
      .replaceAll('=', '');
  return '$header.$payload.c2lnbmF0dXJl';
}

ResponseBody _jsonResponse(
  Map<String, dynamic> body, {
  int statusCode = 200,
  Map<String, List<String>>? headers,
}) => ResponseBody.fromString(
  jsonEncode(body),
  statusCode,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
    ...?headers,
  },
);

final class _NotifierFixture {
  _NotifierFixture() {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    sessionRepository = BetterAuthSessionRepository(
      preferences: preferences,
    );
    apiClient = BetterAuthApiClient(
      dio: dio,
      sessionRepository: sessionRepository,
      cookieJar: cookieJar,
    );
    jwtProvider = UserJwtProvider(
      apiClient: apiClient,
      now: () => DateTime.utc(2030),
      lifecycle: lifecycle,
    );
  }

  final preferences = _MemorySecurePreferencesDataSource();
  final adapter = _QueueAdapter();
  final cookieJar = CookieJar();
  final lifecycle = AuthSessionLifecycle();
  late final BetterAuthSessionRepository sessionRepository;
  late final BetterAuthApiClient apiClient;
  late final UserJwtProvider jwtProvider;

  ProviderContainer createContainer() => ProviderContainer(
    overrides: [
      betterAuthSessionRepositoryProvider.overrideWith(
        (ref) async => sessionRepository,
      ),
      betterAuthApiClientProvider.overrideWith((ref) async => apiClient),
      userJwtServiceProvider.overrideWith((ref) async => jwtProvider),
      authSessionLifecycleProvider.overrideWith((ref) => lifecycle),
    ],
  );
}

final class _QueueAdapter implements HttpClientAdapter {
  final responses = <Future<ResponseBody>>[];
  final paths = <String>[];
  final cookieHeaders = <String?>[];
  Completer<void>? _requestStarted;
  var requestCount = 0;

  void enqueue(FutureOr<ResponseBody> response) {
    responses.add(Future.value(response));
  }

  Future<void> nextRequestStarted() {
    final started = Completer<void>();
    _requestStarted = started;
    return started.future;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    paths.add(options.path);
    cookieHeaders.add(options.headers['cookie'] as String?);
    _requestStarted?.complete();
    _requestStarted = null;
    if (responses.isEmpty) {
      throw StateError('No queued response');
    }
    return await responses.removeAt(0);
  }

  @override
  void close({bool force = false}) {}
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};
  var throwOnRemove = false;
  Completer<void>? removeGate;
  final removeStarted = Completer<void>();

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
    if (!removeStarted.isCompleted) {
      removeStarted.complete();
    }
    final gate = removeGate;
    if (gate != null) {
      await gate.future;
    }
    if (throwOnRemove) {
      throw Exception('secure storage remove failed');
    }
    values.remove(key);
  }

  @override
  Future<void> clear() async {
    values.clear();
  }
}
