import 'dart:convert';
import 'dart:typed_data';

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
    expect(result.unwrap().userJwt, jwt);
    expect(container.read(authSessionProvider).value?.userJwt, jwt);
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

    expect(accepted.unwrap().userJwt, firstJwt);
    expect(refreshed.unwrap().userJwt, refreshedJwt);
    expect(container.read(authSessionProvider).value?.userJwt, refreshedJwt);
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
    expect(await fixture.sessionRepository.readSessionToken(), isNull);
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
    expect(await fixture.sessionRepository.readSessionToken(), 'session-token');
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
    expect(await fixture.sessionRepository.readSessionToken(), isNull);
    expect(
      container.read(authSessionProvider).value?.status,
      AuthSessionStatus.signedOut,
    );
  });
}

String _jwt({required int exp, required String marker}) {
  final header = base64Url.encode(utf8.encode(jsonEncode({'alg': 'RS256'})));
  final payload = base64Url.encode(
    utf8.encode(jsonEncode({'exp': exp, 'marker': marker})),
  );
  return '$header.$payload.signature';
}

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
    );
    jwtProvider = UserJwtProvider(
      apiClient: apiClient,
      now: () => DateTime.utc(2030),
    );
  }

  final preferences = _MemorySecurePreferencesDataSource();
  final adapter = _QueueAdapter();
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
    ],
  );
}

final class _QueueAdapter implements HttpClientAdapter {
  final responses = <ResponseBody>[];
  final paths = <String>[];
  var requestCount = 0;

  void enqueue(ResponseBody response) {
    responses.add(response);
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    paths.add(options.path);
    if (responses.isEmpty) {
      throw StateError('No queued response');
    }
    return responses.removeAt(0);
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
