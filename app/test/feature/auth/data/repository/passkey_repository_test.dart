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
import 'package:eqmonitor/feature/auth/data/model/native_auth_credential.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/provider/native_auth_attempt_coordinator.dart';
import 'package:eqmonitor/feature/auth/data/repository/apple_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/google_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/native_social_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/passkey_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passkeys/authenticator.dart';
import 'package:passkeys/exceptions.dart' as passkey;
import 'package:passkeys/types.dart' hide Result;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
            _jsonResponse(_registrationResponse()),
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
        expect(fixture.adapter.methods, ['GET', 'POST']);
        expect(fixture.adapter.requests.first.body, isNull);
        expect(fixture.adapter.requests.last.body, {
          'response': fixture.authenticator.registerResponse.toJson(),
        });
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

    test('generateの401もTask 5 boundaryでstate、token、Cookieを清掃する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(<String, dynamic>{}, statusCode: 401),
          _jsonResponse(<String, dynamic>{'session': null}),
        ],
        acceptedSession: true,
        sessionToken: 'stale-session',
        initialCookie: 'session=stale-cookie',
      );

      final result = await fixture.repository.register();
      await fixture.apiClient.getSession();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.unauthorized,
      );
      expect(fixture.invalidationCalls, 1);
      expect(fixture.hasAcceptedSession, isFalse);
      expect(
        (await fixture.sessionRepository.readSessionToken()).unwrap(),
        isNull,
      );
      expect(fixture.authenticator.registerRequests, isEmpty);
      expect(fixture.adapter.cookieHeaders.last, isNull);
    });

    for (final testCase
        in <({String name, void Function(Map<String, dynamic>) mutate})>[
          (
            name: 'excludeCredentialsの非Map要素',
            mutate: (options) => options['excludeCredentials'] = [
              {
                'type': 'public-key',
                'id': 'Y3JlZGVudGlhbC0x',
                'transports': ['internal'],
              },
              'malformed',
            ],
          ),
          (
            name: 'user IDの不正Base64URL',
            mutate: (options) =>
                (options['user'] as Map<String, dynamic>)['id'] = 'a',
          ),
          (
            name: 'pubKeyCredParamsの非public-key type',
            mutate: (options) => options['pubKeyCredParams'] = [
              {'type': 'password', 'alg': -7},
            ],
          ),
        ]) {
      test('${testCase.name}はNative前にfail-closedでtransactionを破棄する', () async {
        final malformed = _registerOptions(challenge: 'bWFsZm9ybWVkLTE');
        testCase.mutate(malformed);
        final fixture = await _PasskeyFixture.create(
          responses: [
            _jsonResponse(malformed),
            _jsonResponse(_registerOptions(challenge: 'ZnJlc2gtcmV0cnk')),
            _jsonResponse(_registrationResponse()),
          ],
          acceptedSession: true,
          sessionToken: 'existing-session',
        );

        final malformedResult = await fixture.repository.register();
        final retried = await fixture.repository.register();

        expect(
          (malformedResult as Failure<void, AuthFailure>).exception.kind,
          AuthFailureKind.invalidResponse,
        );
        expect(retried, isA<Success<void, AuthFailure>>());
        expect(fixture.authenticator.registerRequests, hasLength(1));
        expect(
          fixture.authenticator.registerRequests.single.challenge,
          'ZnJlc2gtcmV0cnk',
        );
      });
    }

    for (final malformedBody in <Object?>[
      null,
      <String, dynamic>{},
      <String, dynamic>{'id': 'passkey-id', 'credentialID': 'credential-id'},
      <dynamic>[],
    ]) {
      test(
        'registration 200 body $malformedBody を拒否してsessionをrollbackする',
        () async {
          final fixture = await _PasskeyFixture.create(
            responses: [
              _jsonResponse(
                _registerOptions(challenge: 'YmFkLXJlZ2lzdHJhdGlvbg'),
              ),
              _jsonResponse(
                malformedBody,
                setAuthToken: 'must-not-commit',
                setCookie: 'session=must-not-commit; Path=/; Secure',
              ),
            ],
            acceptedSession: true,
            sessionToken: 'existing-session',
            initialCookie: 'session=existing-cookie',
          );

          final result = await fixture.repository.register();

          expect(
            (result as Failure<void, AuthFailure>).exception.kind,
            AuthFailureKind.invalidResponse,
          );
          expect(
            (await fixture.sessionRepository.readSessionToken()).unwrap(),
            'existing-session',
          );
        },
      );
    }

    test('同一registration operationの並行verifyは二つ目をHTTP前に拒否する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_registerOptions(challenge: 'b25lLXNob3Q')),
        ],
        acceptedSession: true,
        sessionToken: 'existing-session',
      );
      final operation =
          (await fixture.apiClient.generatePasskeyRegistrationOptions())
              .unwrap();
      final response = fixture.authenticator.registerResponse.toJson();
      final pendingResponse = Completer<ResponseBody>();
      final verifyStarted = fixture.adapter.expectNextFetch();
      fixture.adapter.enqueue(pendingResponse.future);

      final first = fixture.apiClient.verifyPasskeyRegistration(
        operation: operation,
        response: response,
      );
      await verifyStarted.future;
      final second = await fixture.apiClient.verifyPasskeyRegistration(
        operation: operation,
        response: response,
      );
      pendingResponse.complete(_jsonResponse(_registrationResponse()));

      expect(await first, isA<Success<void, AuthFailure>>());
      expect(
        (second as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-register-options',
        '/api/auth/passkey/verify-registration',
      ]);
    });

    test('Nativeキャンセル後のretryはregistration challengeを再生成する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            _registerOptions(challenge: 'cmVnaXN0ZXItY2FuY2Vs'),
          ),
          _jsonResponse(
            _registerOptions(challenge: 'cmVnaXN0ZXItZnJlc2g'),
          ),
          _jsonResponse(_registrationResponse()),
        ],
        acceptedSession: true,
        sessionToken: 'existing-session',
      );
      fixture.authenticator.registerFailures.add(
        passkey.PasskeyAuthCancelledException(),
      );

      final cancelled = await fixture.repository.register();
      final retried = await fixture.repository.register();

      expect(
        (cancelled as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.cancelled,
      );
      expect(retried, isA<Success<void, AuthFailure>>());
      expect(
        fixture.authenticator.registerRequests.map(
          (request) => request.challenge,
        ),
        ['cmVnaXN0ZXItY2FuY2Vs', 'cmVnaXN0ZXItZnJlc2g'],
      );
    });

    test('registrationのRP ID不一致はNative UI前に拒否する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            _registerOptions(
              challenge: 'cmVnaXN0ZXItcnAtbWlzbWF0Y2g',
              rpId: 'eqmonitor.app',
            ),
          ),
        ],
        acceptedSession: true,
        sessionToken: 'existing-session',
      );

      final result = await fixture.repository.register();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(fixture.authenticator.registerRequests, isEmpty);
    });

    test('production環境ではeqmonitor.appのregistrationだけをNativeへ渡す', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            _registerOptions(
              challenge: 'cHJvZHVjdGlvbi1yZWdpc3Rlcg',
              rpId: 'eqmonitor.app',
            ),
          ),
          _jsonResponse(_registrationResponse()),
        ],
        acceptedSession: true,
        sessionToken: 'production-session',
        buildConfig: _productionBuildConfig,
        telegramUrl: _telegramUrl('https://v2.api.eqmonitor.app'),
      );

      final result = await fixture.repository.register();

      expect(result, isA<Success<void, AuthFailure>>());
      expect(
        fixture.authenticator.registerRequests.single.relyingParty.id,
        'eqmonitor.app',
      );
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
        exception: passkey.ExcludeCredentialsCanNotBeRegisteredException(),
        kind: AuthFailureKind.passkeyCredentialUnavailable,
      ),
    ]) {
      test(
        'registration ${testCase.exception.runtimeType}をtyped failureへ変換する',
        () async {
          final fixture = await _PasskeyFixture.create(
            responses: [
              _jsonResponse(
                _registerOptions(challenge: 'cmVnaXN0ZXItZXhjZXB0aW9u'),
              ),
            ],
            acceptedSession: true,
            sessionToken: 'existing-session',
          );
          fixture.authenticator.registerFailures.add(testCase.exception);

          final result = await fixture.repository.register();

          expect(
            (result as Failure<void, AuthFailure>).exception.kind,
            testCase.kind,
          );
        },
      );
    }
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
      expect(fixture.adapter.methods, ['GET', 'POST']);
      expect(fixture.adapter.requests.first.body, isNull);
      expect(fixture.adapter.requests.last.body, {
        'response': fixture.authenticator.authenticateResponse.toJson(),
      });
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

    for (final testCase
        in <({String name, void Function(Map<String, dynamic>) mutate})>[
          (
            name: 'allowCredentialsの非Map要素',
            mutate: (options) => options['allowCredentials'] = [
              {
                'type': 'public-key',
                'id': 'Y3JlZGVudGlhbC0x',
                'transports': ['internal'],
              },
              42,
            ],
          ),
          (
            name: 'credential IDの不正Base64URL',
            mutate: (options) => options['allowCredentials'] = [
              {
                'type': 'public-key',
                'id': 'a',
                'transports': ['internal'],
              },
            ],
          ),
          (
            name: 'credentialの非public-key type',
            mutate: (options) => options['allowCredentials'] = [
              {
                'type': 'password',
                'id': 'Y3JlZGVudGlhbC0x',
                'transports': ['internal'],
              },
            ],
          ),
        ]) {
      test('${testCase.name}はNative前にfail-closedでtransactionを破棄する', () async {
        final malformed = _authenticateOptions(
          challenge: 'YXV0aC1tYWxmb3JtZWQ',
        );
        testCase.mutate(malformed);
        final fixture = await _PasskeyFixture.create(
          responses: [
            _jsonResponse(malformed),
            _jsonResponse(
              _authenticateOptions(challenge: 'YXV0aC1mcmVzaA'),
            ),
            _jsonResponse(
              <String, dynamic>{'verified': true},
              setAuthToken: 'fresh-session',
            ),
          ],
        );

        final malformedResult = await fixture.repository.signIn();
        final retried = await fixture.repository.signIn();

        expect(
          (malformedResult as Failure<AuthSession, AuthFailure>).exception.kind,
          AuthFailureKind.invalidResponse,
        );
        expect(retried, isA<Success<AuthSession, AuthFailure>>());
        expect(fixture.authenticator.authenticateRequests, hasLength(1));
        expect(
          fixture.authenticator.authenticateRequests.single.challenge,
          'YXV0aC1mcmVzaA',
        );
      });
    }

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

    test('同一authentication operationの再verifyはHTTP前に拒否する', () async {
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_authenticateOptions(challenge: 'YXV0aC1vbmUtc2hvdA')),
          _jsonResponse(
            <String, dynamic>{'verified': true},
            setAuthToken: 'one-shot-session',
          ),
        ],
      );
      final operation =
          (await fixture.apiClient.generatePasskeyAuthenticationOptions())
              .unwrap();
      final response = fixture.authenticator.authenticateResponse.toJson();

      final first = await fixture.apiClient.verifyPasskeyAuthentication(
        operation: operation,
        response: response,
      );
      first.unwrap().release();
      final second = await fixture.apiClient.verifyPasskeyAuthentication(
        operation: operation,
        response: response,
      );

      expect(
        (second as Failure<BetterAuthSessionAcceptance, AuthFailure>)
            .exception
            .kind,
        AuthFailureKind.invalidResponse,
      );
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-authenticate-options',
        '/api/auth/passkey/verify-authentication',
      ]);
    });

    test('register進行中のsign-inはbusyでHTTPとNativeの二重起動を防ぐ', () async {
      final nativeGate = Completer<RegisterResponseType>();
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_registerOptions(challenge: 'Y29uY3VycmVudA')),
          _jsonResponse(_registrationResponse()),
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
          _jsonResponse(_registrationResponse()),
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
        (social as Failure<BetterAuthSessionAcceptance, AuthFailure>)
            .exception
            .kind,
        AuthFailureKind.busy,
      );
      nativeGate.complete(fixture.authenticator.registerResponse);
      expect(await registration, isA<Success<void, AuthFailure>>());
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-register-options',
        '/api/auth/passkey/verify-registration',
      ]);
    });

    test('Passkey Native中はGoogle Nativeとsocial HTTPを開始しない', () async {
      final nativeGate = Completer<RegisterResponseType>();
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(_registerOptions(challenge: 'cGFzc2tleS1uYXRpdmU')),
          _jsonResponse(_registrationResponse()),
        ],
        acceptedSession: true,
        sessionToken: 'existing-session',
      );
      fixture.authenticator.pendingRegister = nativeGate;
      final social = _createCrossSocialFixture(passkeyFixture: fixture);
      social.google.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: 'google-id-token',
          nonce: 'google-nonce',
        ),
      );

      final registration = fixture.repository.register();
      await fixture.authenticator.registerStarted.future;
      final socialResult = await social.repository.signInWithGoogle();
      final appleResult = await social.repository.signInWithApple();

      expect(
        (socialResult as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(social.google.signInCount, 0);
      expect(
        (appleResult as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(social.apple.signInCount, 0);
      expect(fixture.adapter.paths, [
        '/api/auth/passkey/generate-register-options',
      ]);
      nativeGate.complete(fixture.authenticator.registerResponse);
      expect(await registration, isA<Success<void, AuthFailure>>());
    });

    test('Google Native中はPasskey HTTPとNativeを開始しない', () async {
      final fixture = await _PasskeyFixture.create(responses: const []);
      final social = _createCrossSocialFixture(passkeyFixture: fixture);
      final pendingGoogle =
          Completer<Result<NativeAuthCredential, AuthFailure>>();
      social.google.pendingResult = pendingGoogle;

      final socialSignIn = social.repository.signInWithGoogle();
      await social.google.signInStarted.future;
      final passkeyResult = await fixture.repository.signIn();

      expect(
        (passkeyResult as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(fixture.adapter.paths, isEmpty);
      expect(fixture.authenticator.authenticateRequests, isEmpty);
      pendingGoogle.complete(
        const Failure(AuthFailure(kind: AuthFailureKind.cancelled)),
      );
      expect(
        (await socialSignIn as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.cancelled,
      );
    });

    test('Google JWT acceptance中もPasskey HTTPとNativeを開始しない', () async {
      final acceptance = Completer<Result<AuthSession, AuthFailure>>();
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            <String, dynamic>{},
            setAuthToken: 'google-subject-session',
          ),
        ],
      );
      final social = _createCrossSocialFixture(
        passkeyFixture: fixture,
        acceptance: acceptance,
      );
      social.google.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: 'google-id-token',
          nonce: 'google-nonce',
        ),
      );

      final socialSignIn = social.repository.signInWithGoogle();
      await social.acceptSignInStarted.future;
      final passkeyResult = await fixture.repository.signIn();

      expect(
        (passkeyResult as Failure<AuthSession, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(fixture.adapter.paths, ['/api/auth/sign-in/social']);
      expect(fixture.authenticator.authenticateRequests, isEmpty);
      acceptance.complete(const Success(AuthSession.authenticated()));
      expect(await socialSignIn, isA<Success<void, AuthFailure>>());
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

    test(
      'JWT acceptance中はsession gateを保持し別主体のsocial/passkey HTTPを拒否する',
      () async {
        final acceptance = Completer<Result<AuthSession, AuthFailure>>();
        final fixture = await _PasskeyFixture.create(
          responses: [
            _jsonResponse(
              _authenticateOptions(challenge: 'c3ViamVjdC1wYXNza2V5'),
            ),
            _jsonResponse(
              <String, dynamic>{'verified': true},
              setAuthToken: 'passkey-subject-session',
            ),
          ],
          acceptance: acceptance,
        );

        final pending = fixture.repository.signIn();
        await fixture.acceptSignInStarted.future;
        final social = await fixture.apiClient.signInSocial(
          provider: 'google',
          idToken: 'other-subject-id-token',
        );
        final secondPasskey = await fixture.apiClient
            .generatePasskeyAuthenticationOptions();

        expect(
          (social as Failure<BetterAuthSessionAcceptance, AuthFailure>)
              .exception
              .kind,
          AuthFailureKind.busy,
        );
        expect(
          (secondPasskey
                  as Failure<
                    BetterAuthPasskeyAuthenticationOperation,
                    AuthFailure
                  >)
              .exception
              .kind,
          AuthFailureKind.busy,
        );
        expect(fixture.adapter.paths, [
          '/api/auth/passkey/generate-authenticate-options',
          '/api/auth/passkey/verify-authentication',
        ]);
        expect(
          (await fixture.sessionRepository.readSessionToken()).unwrap(),
          'passkey-subject-session',
        );
        acceptance.complete(const Success(AuthSession.authenticated()));
        expect((await pending).unwrap().isAuthenticated, isTrue);
      },
    );

    for (final failureKind in [
      AuthFailureKind.server,
      AuthFailureKind.unauthorized,
    ]) {
      test('JWT acceptanceの$failureKind後はown attemptだけを解放する', () async {
        final acceptance = Completer<Result<AuthSession, AuthFailure>>();
        final fixture = await _PasskeyFixture.create(
          responses: [
            _jsonResponse(
              _authenticateOptions(challenge: 'YWNjZXB0YW5jZS1mYWls'),
            ),
            _jsonResponse(
              <String, dynamic>{'verified': true},
              setAuthToken: 'failed-acceptance-session',
            ),
            _jsonResponse(
              _authenticateOptions(challenge: 'YWZ0ZXItZmFpbHVyZQ'),
            ),
          ],
          acceptance: acceptance,
        );

        final pending = fixture.repository.signIn();
        await fixture.acceptSignInStarted.future;
        acceptance.complete(Failure(AuthFailure(kind: failureKind)));
        final failed = await pending;
        final nextOperation = await fixture.apiClient
            .generatePasskeyAuthenticationOptions();

        expect(
          (failed as Failure<AuthSession, AuthFailure>).exception.kind,
          failureKind,
        );
        expect(
          nextOperation,
          isA<Success<BetterAuthPasskeyAuthenticationOperation, AuthFailure>>(),
        );
        await nextOperation.unwrap().abandonWithFailure<void>(
          failure: const Failure(
            AuthFailure(kind: AuthFailureKind.cancelled),
          ),
        );
      });
    }

    test('JWT acceptance throw後もsession/native attemptを解放する', () async {
      final acceptance = Completer<Result<AuthSession, AuthFailure>>();
      final fixture = await _PasskeyFixture.create(
        responses: [
          _jsonResponse(
            _authenticateOptions(challenge: 'YWNjZXB0YW5jZS10aHJvdw'),
          ),
          _jsonResponse(
            <String, dynamic>{'verified': true},
            setAuthToken: 'throwing-acceptance-session',
          ),
          _jsonResponse(
            _authenticateOptions(challenge: 'YWZ0ZXItdGhyb3c'),
          ),
        ],
        acceptance: acceptance,
      );

      final pending = fixture.repository.signIn();
      await fixture.acceptSignInStarted.future;
      final thrown = expectLater(pending, throwsStateError);
      acceptance.completeError(StateError('acceptance failed'));
      await thrown;
      final nextOperation = await fixture.apiClient
          .generatePasskeyAuthenticationOptions();

      expect(
        nextOperation,
        isA<Success<BetterAuthPasskeyAuthenticationOperation, AuthFailure>>(),
      );
      await nextOperation.unwrap().abandonWithFailure<void>(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.cancelled),
        ),
      );
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

  test('stale Native attemptのreleaseは後続attemptを解放しない', () {
    final coordinator = NativeAuthAttemptCoordinator();
    final first = coordinator.tryBegin();
    expect(first, isNotNull);
    first?.release();
    final second = coordinator.tryBegin();
    expect(second, isNotNull);

    first?.release();

    expect(coordinator.tryBegin(), isNull);
    second?.release();
    expect(coordinator.tryBegin(), isNotNull);
  });
}

({
  NativeSocialAuthRepository repository,
  _CrossGoogleAuthGateway google,
  _CrossAppleAuthGateway apple,
  Completer<void> acceptSignInStarted,
})
_createCrossSocialFixture({
  required _PasskeyFixture passkeyFixture,
  Completer<Result<AuthSession, AuthFailure>>? acceptance,
}) {
  final google = _CrossGoogleAuthGateway();
  final apple = _CrossAppleAuthGateway();
  final acceptSignInStarted = Completer<void>();
  final repository = NativeSocialAuthRepository(
    apiClient: passkeyFixture.apiClient,
    googleAuthRepository: google,
    appleAuthRepository: apple,
    buildConfig: _socialBuildConfig,
    telegramUrl: _telegramUrl('https://dev.v2.api.eqmonitor.app'),
    platform: NativeAuthPlatform.ios,
    attemptCoordinator: passkeyFixture.attemptCoordinator,
    acceptSignIn: () async {
      if (!acceptSignInStarted.isCompleted) {
        acceptSignInStarted.complete();
      }
      return acceptance?.future ??
          const Success<AuthSession, AuthFailure>(
            AuthSession.authenticated(),
          );
    },
  );
  return (
    repository: repository,
    google: google,
    apple: apple,
    acceptSignInStarted: acceptSignInStarted,
  );
}

final class _CrossGoogleAuthGateway implements GoogleAuthGateway {
  final credentials = <NativeAuthCredential>[];
  Completer<Result<NativeAuthCredential, AuthFailure>>? pendingResult;
  final signInStarted = Completer<void>();
  var signInCount = 0;

  @override
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required String clientId,
    required String serverClientId,
  }) {
    signInCount++;
    if (!signInStarted.isCompleted) {
      signInStarted.complete();
    }
    return pendingResult?.future ??
        Future.value(Success(credentials.removeAt(0)));
  }
}

final class _CrossAppleAuthGateway implements AppleAuthGateway {
  var signInCount = 0;

  @override
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required WebAuthenticationOptions? webAuthenticationOptions,
  }) {
    signInCount++;
    throw StateError('Apple gateway must not be called');
  }
}

final class _PasskeyFixture {
  const _PasskeyFixture({
    required this.repository,
    required this.apiClient,
    required this.sessionRepository,
    required this.adapter,
    required this.authenticator,
    required this.attemptCoordinator,
    required this.acceptSignInStarted,
    required this.acceptSignInCallsReader,
    required this.invalidationCallsReader,
    required this.hasAcceptedSessionReader,
  });

  final PasskeyRepository repository;
  final BetterAuthApiClient apiClient;
  final BetterAuthSessionRepository sessionRepository;
  final _PasskeyHttpAdapter adapter;
  final _FakePasskeyAuthenticator authenticator;
  final NativeAuthAttemptCoordinator attemptCoordinator;
  final Completer<void> acceptSignInStarted;
  final int Function() acceptSignInCallsReader;
  final int Function() invalidationCallsReader;
  final bool Function() hasAcceptedSessionReader;

  int get acceptSignInCalls => acceptSignInCallsReader();
  int get invalidationCalls => invalidationCallsReader();
  bool get hasAcceptedSession => hasAcceptedSessionReader();

  static Future<_PasskeyFixture> create({
    required List<ResponseBody> responses,
    bool acceptedSession = false,
    String? sessionToken,
    String? initialCookie,
    TelegramUrlModel? telegramUrl,
    Completer<Result<AuthSession, AuthFailure>>? acceptance,
    NativeAuthAttemptCoordinator? attemptCoordinator,
    BuildConfig buildConfig = _buildConfig,
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
    final sharedAttemptCoordinator =
        attemptCoordinator ?? NativeAuthAttemptCoordinator();
    final acceptSignInStarted = Completer<void>();
    var acceptedSessionState = acceptedSession;
    var acceptSignInCalls = 0;
    var invalidationCalls = 0;
    final repository = PasskeyRepository(
      apiClient: apiClient,
      sessionRepository: sessionRepository,
      authenticator: authenticator,
      buildConfig: buildConfig,
      telegramUrl:
          telegramUrl ?? _telegramUrl('https://dev.v2.api.eqmonitor.app'),
      hasAcceptedSession: () => acceptedSessionState,
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
        acceptedSessionState = false;
        await apiClient.clearCookies();
        await sessionRepository.clearSession();
        return const Success<AuthSession, AuthFailure>(AuthSession.signedOut());
      },
      attemptCoordinator: sharedAttemptCoordinator,
    );
    return _PasskeyFixture(
      repository: repository,
      apiClient: apiClient,
      sessionRepository: sessionRepository,
      adapter: adapter,
      authenticator: authenticator,
      attemptCoordinator: sharedAttemptCoordinator,
      acceptSignInStarted: acceptSignInStarted,
      acceptSignInCallsReader: () => acceptSignInCalls,
      invalidationCallsReader: () => invalidationCalls,
      hasAcceptedSessionReader: () => acceptedSessionState,
    );
  }
}

final class _FakePasskeyAuthenticator implements PasskeyAuthenticatorInterface {
  final registerRequests = <RegisterRequestType>[];
  final authenticateRequests = <AuthenticateRequestType>[];
  final registerFailures = <Exception>[];
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
    if (registerFailures.isNotEmpty) {
      throw registerFailures.removeAt(0);
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
    : _responses = responses.map(Future<ResponseBody>.value).toList();

  final List<Future<ResponseBody>> _responses;
  final paths = <String>[];
  final methods = <String>[];
  final requests =
      <({String method, String path, Map<String, dynamic>? body})>[];
  final requestBodies = <Map<String, dynamic>>[];
  final cookieHeaders = <String?>[];
  Completer<void>? _nextFetchStarted;

  Completer<void> expectNextFetch() {
    final completer = Completer<void>();
    _nextFetchStarted = completer;
    return completer;
  }

  void enqueue(Future<ResponseBody> response) => _responses.add(response);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    methods.add(options.method);
    cookieHeaders.add(options.headers[HttpHeaders.cookieHeader] as String?);
    _nextFetchStarted?.complete();
    _nextFetchStarted = null;
    final body = switch (options.data) {
      final Map<String, dynamic> value => value,
      _ => null,
    };
    requests.add((method: options.method, path: options.path, body: body));
    if (body != null) {
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
  Object? body, {
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
  'allowCredentials': [
    {
      'type': 'public-key',
      'id': 'Y3JlZGVudGlhbC0x',
      'transports': ['internal'],
    },
  ],
};

Map<String, dynamic> _registrationResponse() => {
  'id': 'passkey-database-id',
  'credentialID': 'credential-id',
  'userId': 'user-id',
  'name': 'EQMonitor Passkey',
  'publicKey': 'public-key',
  'counter': 0,
  'deviceType': 'singleDevice',
  'backedUp': false,
  'transports': 'internal',
  'createdAt': '2026-08-25T00:00:00.000Z',
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

const _productionBuildConfig = BuildConfig(
  restApiUrl: 'https://v2.api.eqmonitor.app',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: Flavor.prod,
  wsApiUrl: 'wss://v2.api.eqmonitor.app',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '2026-08-25T00:00:00Z',
  buildCommitMessage: 'test',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
);

final _socialBuildConfig = _buildConfig.copyWith(
  googleIosClientId: 'ios.apps.googleusercontent.com',
  googleIosReversedClientId: 'com.googleusercontent.apps.ios',
  googleAndroidClientId: 'android.apps.googleusercontent.com',
  googleServerClientId: 'server.apps.googleusercontent.com',
  appleServiceId: 'net.yumnumm.eqmonitor.service',
  isNativeSocialAuthEnabled: true,
);

TelegramUrlModel _telegramUrl(String restApiUrl) => TelegramUrlModel(
  restApiUrl: restApiUrl,
  wsApiUrl: 'wss://dev.v2.api.eqmonitor.app',
);
