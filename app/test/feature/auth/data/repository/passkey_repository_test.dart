import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/passkey_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passkeys/authenticator.dart';
import 'package:passkeys/exceptions.dart' as passkey;
import 'package:passkeys/types.dart' hide Result;

void main() {
  group('PasskeyRepository.register', () {
    test(
      '標準register endpointと同じchallenge CookieでNative responseを検証する',
      () async {
        final fixture = await _PasskeyFixture.create(
          responses: [
            _jsonResponse(
              _registerOptions(challenge: 'cmVnaXN0ZXItMQ'),
              setCookie: 'passkey_challenge=register-1; Path=/; Secure',
            ),
            _jsonResponse(<String, dynamic>{'verified': true}),
          ],
          acceptedSession: true,
          sessionToken: 'existing-session',
        );

        final result = await fixture.repository.register();

        expect(result, isA<Success<void, AuthFailure>>());
        expect(fixture.adapter.paths, [
          '/api/auth/passkey/generate-register-options',
          '/api/auth/passkey/verify-registration',
        ]);
        expect(fixture.adapter.cookieHeaders, [null, contains('register-1')]);
        expect(
          fixture.authenticator.registerRequests.single.challenge,
          'cmVnaXN0ZXItMQ',
        );
        expect(fixture.adapter.requestBodies.last, {
          'response': fixture.authenticator.registerResponse.toJson(),
        });
      },
    );

    test('accepted sessionがなければHTTPもNative UIも開始しない', () async {
      final fixture = await _PasskeyFixture.create(
        responses: const [],
        acceptedSession: false,
        sessionToken: 'persisted-but-not-accepted',
      );

      final result = await fixture.repository.register();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.sessionRequired,
      );
      expect(fixture.adapter.paths, isEmpty);
      expect(fixture.authenticator.registerRequests, isEmpty);
    });

    test('persisted sessionがなければHTTPもNative UIも開始しない', () async {
      final fixture = await _PasskeyFixture.create(
        responses: const [],
        acceptedSession: true,
      );

      final result = await fixture.repository.register();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.sessionRequired,
      );
      expect(fixture.adapter.paths, isEmpty);
      expect(fixture.authenticator.registerRequests, isEmpty);
    });

    test('stale sessionの401はTask 5のinvalidation boundaryへ渡す', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_registerOptions(challenge: 'c3RhbGU')),
          _jsonResponse(<String, dynamic>{}, statusCode: 401),
        ],
        acceptedSession: true,
        sessionToken: 'stale-session',
      );

      final result = await fixture.repository.register();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.unauthorized,
      );
      expect(fixture.invalidationCalls, 1);
    });
  });

  group('PasskeyRepository.signIn', () {
    test('標準authenticate endpointと同じchallenge Cookieでsessionを確立する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            _authenticateOptions(challenge: 'YXV0aC0x'),
            setCookie: 'passkey_challenge=auth-1; Path=/; Secure',
          ),
          _jsonResponse(
            <String, dynamic>{'verified': true},
            setAuthToken: 'passkey-session',
          ),
        ],
      );

      final result = await fixture.repository.signIn();

      expect(result.unwrap().isAuthenticated, isTrue);
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-authenticate-options',
        '/api/auth/passkey/verify-authentication',
      ]);
      expect(fixture.adapter.cookieHeaders, [null, contains('auth-1')]);
      expect(
        fixture.authenticator.authenticateRequests.single.challenge,
        'YXV0aC0x',
      );
      expect(fixture.adapter.requestBodies.last, {
        'response': fixture.authenticator.authenticateResponse.toJson(),
      });
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        'passkey-session',
      );
      expect(fixture.acceptSignInCalls, 1);
    });

    test('環境不一致はHTTPもNative UIも開始しない', () async {
      final fixture = await _PasskeyFixture.create(
        responses: const [],
        telegramUrl: _telegramUrl('https://v2.api.eqmonitor.app'),
      );

      final result = await fixture.repository.signIn();

      expect(
        (result as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.environmentMismatch,
      );
      expect(fixture.adapter.paths, isEmpty);
      expect(fixture.authenticator.authenticateRequests, isEmpty);
    });

    test('期待環境と異なるRP IDはNative UIを開始しない', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            _authenticateOptions(
              challenge: 'cnAtbWlzbWF0Y2g',
              rpId: 'eqmonitor.app',
            ),
          ),
        ],
      );

      final result = await fixture.repository.signIn();

      expect(
        (result as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(fixture.authenticator.authenticateRequests, isEmpty);
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-authenticate-options',
      ]);
    });

    test('challenge欠落のoptionsはNative UIを開始しない', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_authenticateOptions(challenge: '')),
        ],
      );

      final result = await fixture.repository.signIn();

      expect(
        (result as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(fixture.authenticator.authenticateRequests, isEmpty);
    });

    test('不正なBase64URL challengeはNative UIを開始しない', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_authenticateOptions(challenge: 'a')),
        ],
      );

      final result = await fixture.repository.signIn();

      expect(
        (result as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(fixture.authenticator.authenticateRequests, isEmpty);
    });

    test('Nativeキャンセル後のretryは新しいgenerate requestを発行する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_authenticateOptions(challenge: 'Y2hhbGxlbmdlLTE')),
          _jsonResponse(_authenticateOptions(challenge: 'Y2hhbGxlbmdlLTI')),
          _jsonResponse(
            <String, dynamic>{'verified': true},
            setAuthToken: 'retry-session',
          ),
        ],
      );
      fixture.authenticator.authenticateFailures.add(
        passkey.PasskeyAuthCancelledException(),
      );

      final cancelled = await fixture.repository.signIn();
      final retried = await fixture.repository.signIn();

      expect(
        (cancelled as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.cancelled,
      );
      expect(retried, isA<Success<AuthSession, AuthFailure>>());
      expect(
        fixture.adapter.paths.where(
          (path) => path.endsWith('generate-authenticate-options'),
        ),
        hasLength(2),
      );
      expect(
        fixture.authenticator.authenticateRequests.map((e) => e.challenge),
        ['Y2hhbGxlbmdlLTE', 'Y2hhbGxlbmdlLTI'],
      );
    });

    test('verify error後のretryは新しいchallengeを生成する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_authenticateOptions(challenge: 'ZXJyb3ItMQ')),
          _jsonResponse(<String, dynamic>{}, statusCode: 400),
          _jsonResponse(_authenticateOptions(challenge: 'ZXJyb3ItMg')),
          _jsonResponse(
            <String, dynamic>{'session': <String, dynamic>{}},
            setAuthToken: 'retry-after-error-session',
          ),
        ],
      );

      final failed = await fixture.repository.signIn();
      final retried = await fixture.repository.signIn();

      expect(
        (failed as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(retried, isA<Success<AuthSession, AuthFailure>>());
      expect(
        fixture.authenticator.authenticateRequests.map((e) => e.challenge),
        ['ZXJyb3ItMQ', 'ZXJyb3ItMg'],
      );
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-authenticate-options',
        '/api/auth/passkey/verify-authentication',
        '/api/auth/passkey/generate-authenticate-options',
        '/api/auth/passkey/verify-authentication',
      ]);
    });

    test('register進行中のsign-inはbusyでHTTPとNativeの二重起動を防ぐ', () async {
      final nativeGate = Completer<RegisterResponseType>();
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_registerOptions(challenge: 'Y29uY3VycmVudA')),
          _jsonResponse(<String, dynamic>{'verified': true}),
        ],
        acceptedSession: true,
        sessionToken: 'existing-session',
      );
      fixture.authenticator.pendingRegister = nativeGate;

      final registration = fixture.repository.register();
      await fixture.authenticator.registerStarted.future;
      final signIn = await fixture.repository.signIn();
      nativeGate.complete(fixture.authenticator.registerResponse);

      expect(
        (signIn as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(await registration, isA<Success<void, AuthFailure>>());
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-register-options',
        '/api/auth/passkey/verify-registration',
      ]);
      expect(fixture.authenticator.authenticateRequests, isEmpty);
    });

    test('Passkey ceremony中のsocial session transactionをbusyで拒否する', () async {
      final nativeGate = Completer<RegisterResponseType>();
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_registerOptions(challenge: 'c2hhcmVkLWdhdGU')),
          _jsonResponse(<String, dynamic>{'passkey': <String, dynamic>{}}),
        ],
        acceptedSession: true,
        sessionToken: 'existing-session',
      );
      fixture.authenticator.pendingRegister = nativeGate;

      final registration = fixture.repository.register();
      await fixture.authenticator.registerStarted.future;
      final social = await fixture.apiClient.signInSocial(
        provider: 'google',
        idToken: 'provider-id-token',
      );

      expect(
        (social as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      nativeGate.complete(fixture.authenticator.registerResponse);
      expect(await registration, isA<Success<void, AuthFailure>>());
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-register-options',
        '/api/auth/passkey/verify-registration',
      ]);
    });

    test('verify失敗ではsession acceptanceを開始しない', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_authenticateOptions(challenge: 'dmVyaWZ5LWZhaWw')),
          _jsonResponse(<String, dynamic>{}, statusCode: 500),
        ],
      );

      final result = await fixture.repository.signIn();

      expect(
        (result as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.server,
      );
      expect(fixture.acceptSignInCalls, 0);
    });

    test('不正なset-auth-tokenは既存sessionとCookieへrollbackする', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            _authenticateOptions(challenge: 'cm9sbGJhY2s'),
            setCookie: 'passkey_challenge=new-challenge; Path=/; Secure',
          ),
          _jsonResponse(<String, dynamic>{'verified': true}),
          _jsonResponse(<String, dynamic>{'session': null}),
        ],
        sessionToken: 'old-session',
        initialCookie: 'session=old-cookie',
      );

      final result = await fixture.repository.signIn();
      await fixture.apiClient.getSession();

      expect(
        (result as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        'old-session',
      );
      expect(fixture.adapter.cookieHeaders.last, contains('old-cookie'));
      expect(
        fixture.adapter.cookieHeaders.last,
        isNot(contains('new-challenge')),
      );
      expect(fixture.acceptSignInCalls, 0);
    });

    test('JWT acceptance完了まではauthenticatedを返さない', () async {
      final acceptance = Completer<Result<AuthSession, AuthFailure>>();
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_authenticateOptions(challenge: 'and0LWFjY2VwdA')),
          _jsonResponse(
            <String, dynamic>{'verified': true},
            setAuthToken: 'accepted-session',
          ),
        ],
        acceptance: acceptance,
      );
      var completed = false;

      final pending = fixture.repository.signIn()
        ..then((_) => completed = true);
      await fixture.acceptSignInStarted.future;

      expect(completed, isFalse);
      expect(fixture.acceptSignInCalls, 1);
      acceptance.complete(const Success(AuthSession.authenticated()));
      final result = await pending;

      expect(result.unwrap().isAuthenticated, isTrue);
      expect(fixture.acceptSignInCalls, 1);
    });

    for (final testCase in <({Exception exception, AuthFailureKind kind})>[
      (
        exception: passkey.PasskeyAuthCancelledException(),
        kind: AuthFailureKind.cancelled,
      ),
      (
        exception: passkey.TimeoutException('timeout'),
        kind: AuthFailureKind.timeout,
      ),
      (
        exception: passkey.DeviceNotSupportedException(),
        kind: AuthFailureKind.passkeyUnsupported,
      ),
      (
        exception: passkey.DomainNotAssociatedException('association'),
        kind: AuthFailureKind.passkeyDomainAssociation,
      ),
      (
        exception: passkey.NoCredentialsAvailableException(),
        kind: AuthFailureKind.passkeyCredentialUnavailable,
      ),
    ]) {
      test('${testCase.exception.runtimeType}をtyped failureへ変換する', () async {
        final fixture = await _PasskeyFixture.create(
          responses: [
            _jsonResponse(_authenticateOptions(challenge: 'ZXhjZXB0aW9u')),
          ],
        );
        fixture.authenticator.authenticateFailures.add(testCase.exception);

        final result = await fixture.repository.signIn();

        expect(
          (result as Failure<AuthSession, AuthFailure>).exception.kind,
          testCase.kind,
        );
      });
    }
  });
}

final class _PasskeyFixture {
  const _PasskeyFixture({
    required this.repository,
    required this.apiClient,
    required this.sessionRepository,
    required this.adapter,
    required this.authenticator,
    required this.acceptSignInStarted,
    required this.acceptSignInCallsReader,
    required this.invalidationCallsReader,
  });

  final PasskeyRepository repository;
  final BetterAuthApiClient apiClient;
  final BetterAuthSessionRepository sessionRepository;
  final _PasskeyHttpAdapter adapter;
  final _FakePasskeyAuthenticator authenticator;
  final Completer<void> acceptSignInStarted;
  final int Function() acceptSignInCallsReader;
  final int Function() invalidationCallsReader;

  int get acceptSignInCalls => acceptSignInCallsReader();
  int get invalidationCalls => invalidationCallsReader();

  static Future<_PasskeyFixture> create({
    required List<ResponseBody> responses,
    bool acceptedSession = false,
    String? sessionToken,
    String? initialCookie,
    TelegramUrlModel? telegramUrl,
    Completer<Result<AuthSession, AuthFailure>>? acceptance,
  }) async {
    final preferences = _MemorySecurePreferencesDataSource();
    if (sessionToken != null) {
      preferences.values[SecureStorageKey.betterAuthSessionToken] =
          sessionToken;
    }
    final sessionRepository = BetterAuthSessionRepository(
      preferences: preferences,
    );
    final adapter = _PasskeyHttpAdapter(responses: responses);
    final cookieJar = CookieJar();
    if (initialCookie != null) {
      final separator = initialCookie.indexOf('=');
      await cookieJar.saveFromResponse(
        Uri.parse('https://dev.v2.api.eqmonitor.app'),
        [
          Cookie(
            initialCookie.substring(0, separator),
            initialCookie.substring(separator + 1),
          ),
        ],
      );
    }
    final dio = Dio(BaseOptions(baseUrl: 'https://dev.v2.api.eqmonitor.app'))
      ..httpClientAdapter = adapter;
    final apiClient = BetterAuthApiClient(
      dio: dio,
      sessionRepository: sessionRepository,
      cookieJar: cookieJar,
    );
    final authenticator = _FakePasskeyAuthenticator();
    final acceptSignInStarted = Completer<void>();
    var acceptSignInCalls = 0;
    var invalidationCalls = 0;
    final repository = PasskeyRepository(
      apiClient: apiClient,
      sessionRepository: sessionRepository,
      authenticator: authenticator,
      buildConfig: _buildConfig,
      telegramUrl:
          telegramUrl ?? _telegramUrl('https://dev.v2.api.eqmonitor.app'),
      hasAcceptedSession: () => acceptedSession,
      acceptSignIn: () async {
        acceptSignInCalls++;
        if (!acceptSignInStarted.isCompleted) {
          acceptSignInStarted.complete();
        }
        return acceptance?.future ??
            const Success<AuthSession, AuthFailure>(
              AuthSession.authenticated(),
            );
      },
      invalidateSession: () async {
        invalidationCalls++;
        return const Success<AuthSession, AuthFailure>(AuthSession.signedOut());
      },
    );
    return _PasskeyFixture(
      repository: repository,
      apiClient: apiClient,
      sessionRepository: sessionRepository,
      adapter: adapter,
      authenticator: authenticator,
      acceptSignInStarted: acceptSignInStarted,
      acceptSignInCallsReader: () => acceptSignInCalls,
      invalidationCallsReader: () => invalidationCalls,
    );
  }
}

final class _FakePasskeyAuthenticator implements PasskeyAuthenticatorInterface {
  final registerRequests = <RegisterRequestType>[];
  final authenticateRequests = <AuthenticateRequestType>[];
  final authenticateFailures = <Exception>[];
  Completer<RegisterResponseType>? pendingRegister;
  final registerStarted = Completer<void>();

  final registerResponse = const RegisterResponseType(
    id: 'register-credential',
    rawId: 'register-credential',
    clientDataJSON: 'client-data',
    attestationObject: 'attestation',
    transports: ['internal'],
  );
  final authenticateResponse = const AuthenticateResponseType(
    id: 'authenticate-credential',
    rawId: 'authenticate-credential',
    clientDataJSON: 'client-data',
    authenticatorData: 'authenticator-data',
    signature: 'signature',
    userHandle: 'user-handle',
  );

  @override
  Future<RegisterResponseType> register(RegisterRequestType request) async {
    registerRequests.add(request);
    if (!registerStarted.isCompleted) {
      registerStarted.complete();
    }
    return pendingRegister?.future ?? registerResponse;
  }

  @override
  Future<AuthenticateResponseType> authenticate(
    AuthenticateRequestType request,
  ) async {
    authenticateRequests.add(request);
    if (authenticateFailures.isNotEmpty) {
      throw authenticateFailures.removeAt(0);
    }
    return authenticateResponse;
  }

  @override
  Future<void> signalAllAcceptedCredentials(
    SignalAllAcceptedCredentialsRequestType request,
  ) async {}

  @override
  Future<void> signalUnknownCredential(
    SignalUnknownCredentialRequestType request,
  ) async {}
}

final class _PasskeyHttpAdapter implements HttpClientAdapter {
  _PasskeyHttpAdapter({required List<ResponseBody> responses})
    : _responses = [...responses];

  final List<ResponseBody> _responses;
  final paths = <String>[];
  final requestBodies = <Map<String, dynamic>>[];
  final cookieHeaders = <String?>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    cookieHeaders.add(options.headers[HttpHeaders.cookieHeader] as String?);
    if (options.data case final Map<String, dynamic> body) {
      requestBodies.add(body);
    }
    return _responses.removeAt(0);
  }

  @override
  void close({bool force = false}) {}
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<void> clear() async {
    values.clear();
  }

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async => null;

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async => null;

  @override
  Future<int?> getInt({required SecureStorageKey key}) async => null;

  @override
  Future<String?> getString({required SecureStorageKey key}) async =>
      values[key];

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {
    values[key] = value;
  }

  @override
  Future<void> remove({required SecureStorageKey key}) async {
    values.remove(key);
  }

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

ResponseBody _jsonResponse(
  Map<String, dynamic> body, {
  int statusCode = 200,
  String? setCookie,
  String? setAuthToken,
}) => ResponseBody.fromString(
  jsonEncode(body),
  statusCode,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
    if (setCookie != null) HttpHeaders.setCookieHeader: [setCookie],
    if (setAuthToken != null) 'set-auth-token': [setAuthToken],
  },
);

Map<String, dynamic> _registerOptions({
  required String challenge,
  String rpId = 'dev.v2.api.eqmonitor.app',
}) => {
  'challenge': challenge,
  'rp': {'id': rpId, 'name': 'EQMonitor'},
  'user': {
    'id': 'dXNlci0x',
    'name': 'debug-user',
    'displayName': 'Debug User',
  },
  'pubKeyCredParams': [
    {'type': 'public-key', 'alg': -7},
  ],
  'excludeCredentials': <Map<String, dynamic>>[],
};

Map<String, dynamic> _authenticateOptions({
  required String challenge,
  String rpId = 'dev.v2.api.eqmonitor.app',
}) => {
  'challenge': challenge,
  'rpId': rpId,
  'userVerification': 'preferred',
};

const _buildConfig = BuildConfig(
  restApiUrl: 'https://dev.v2.api.eqmonitor.app',
  appIdSuffix: '.dev',
  appName: 'EQMonitor Dev',
  commitInformation: 'test',
  flavor: Flavor.dev,
  wsApiUrl: 'wss://dev.v2.api.eqmonitor.app',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '2026-08-25T00:00:00Z',
  buildCommitMessage: 'test',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
);

TelegramUrlModel _telegramUrl(String restApiUrl) => TelegramUrlModel(
  restApiUrl: restApiUrl,
  wsApiUrl: 'wss://dev.v2.api.eqmonitor.app',
);
