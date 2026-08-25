import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';
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
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() {
  group('NativeAuthCredential', () {
    test('Google credentialをprovider、ID Token、nonceへ変換する', () {
      const credential = NativeAuthCredential(
        provider: NativeAuthProvider.google,
        idToken: 'google-id-token',
        nonce: 'google-nonce',
      );

      expect(credential.toBetterAuthPayload(), {
        'provider': 'google',
        'idToken': {
          'token': 'google-id-token',
          'nonce': 'google-nonce',
        },
      });
    });

    test('Apple初回userだけをidToken userへ含める', () {
      const credential = NativeAuthCredential(
        provider: NativeAuthProvider.apple,
        idToken: 'apple-id-token',
        nonce: 'apple-raw-nonce',
        appleUser: AppleInitialUser(
          email: 'masked@example.com',
          firstName: 'Taro',
          lastName: 'Example',
        ),
      );

      expect(credential.toBetterAuthPayload(), {
        'provider': 'apple',
        'idToken': {
          'token': 'apple-id-token',
          'nonce': 'apple-raw-nonce',
          'user': {
            'name': {'firstName': 'Taro', 'lastName': 'Example'},
            'email': 'masked@example.com',
          },
        },
      });
    });

    test('Apple再認証でuserがなければpayloadから省略する', () {
      const credential = NativeAuthCredential(
        provider: NativeAuthProvider.apple,
        idToken: 'apple-id-token',
        nonce: 'apple-raw-nonce',
      );

      expect(credential.toBetterAuthPayload(), {
        'provider': 'apple',
        'idToken': {
          'token': 'apple-id-token',
          'nonce': 'apple-raw-nonce',
        },
      });
    });
  });

  group('CryptographicNonceGenerator', () {
    test('32 bytesのraw nonceとそのSHA-256 hexを生成する', () {
      final nonce = CryptographicNonceGenerator().generate();
      final rawBytes = base64Url.decode(base64Url.normalize(nonce.raw));

      expect(rawBytes, hasLength(32));
      expect(nonce.sha256, sha256.convert(utf8.encode(nonce.raw)).toString());
    });
  });

  group('GoogleAuthRepository', () {
    test('initializeを一度だけ待ち同じinstance nonceで認証する', () async {
      final plugin = RecordingGoogleSignInPlugin()
        ..idTokens.addAll(['google-token-1', 'google-token-2']);
      final repository = GoogleAuthRepository(
        plugin: plugin,
        nonceGenerator: QueueNonceGenerator([
          const NativeAuthNonce(raw: 'instance-raw', sha256: 'unused-hash'),
        ]),
      );

      final first = await repository.signIn(
        clientId: 'ios.apps.googleusercontent.com',
        serverClientId: 'server.apps.googleusercontent.com',
      );
      final second = await repository.signIn(
        clientId: 'ios.apps.googleusercontent.com',
        serverClientId: 'server.apps.googleusercontent.com',
      );

      expect(plugin.initializations, [
        const GoogleSignInInitialization(
          clientId: 'ios.apps.googleusercontent.com',
          serverClientId: 'server.apps.googleusercontent.com',
          nonce: 'instance-raw',
        ),
      ]);
      expect(first.unwrap().nonce, 'instance-raw');
      expect(second.unwrap().nonce, 'instance-raw');
    });

    test('Googleキャンセルをcancelledへ変換する', () async {
      final repository = GoogleAuthRepository(
        plugin: RecordingGoogleSignInPlugin()
          ..exception = const GoogleSignInException(
            code: GoogleSignInExceptionCode.canceled,
          ),
        nonceGenerator: QueueNonceGenerator([
          const NativeAuthNonce(raw: 'raw', sha256: 'hash'),
        ]),
      );

      final result = await repository.signIn(
        clientId: 'ios.apps.googleusercontent.com',
        serverClientId: 'server.apps.googleusercontent.com',
      );

      expect(
        (result as Failure<NativeAuthCredential, AuthFailure>).exception.kind,
        AuthFailureKind.cancelled,
      );
    });

    for (final idToken in <String?>[null, '']) {
      test(
        'Googleの${idToken == null ? 'missing' : 'empty'} ID Tokenを拒否する',
        () async {
          final repository = GoogleAuthRepository(
            plugin: RecordingGoogleSignInPlugin()..idTokens.add(idToken),
            nonceGenerator: QueueNonceGenerator([
              const NativeAuthNonce(raw: 'raw', sha256: 'hash'),
            ]),
          );

          final result = await repository.signIn(
            clientId: 'ios.apps.googleusercontent.com',
            serverClientId: 'server.apps.googleusercontent.com',
          );

          expect(
            (result as Failure<NativeAuthCredential, AuthFailure>)
                .exception
                .kind,
            AuthFailureKind.invalidResponse,
          );
        },
      );
    }
  });

  group('AppleAuthRepository', () {
    test('試行ごとのhashed nonceをAppleへ渡しraw nonceをBetter Auth用に返す', () async {
      final plugin = RecordingAppleSignInPlugin()
        ..credentials.addAll([
          const AppleNativeCredential(identityToken: 'apple-token-1'),
          const AppleNativeCredential(identityToken: 'apple-token-2'),
        ]);
      final repository = AppleAuthRepository(
        plugin: plugin,
        nonceGenerator: QueueNonceGenerator([
          const NativeAuthNonce(raw: 'raw-1', sha256: 'hash-1'),
          const NativeAuthNonce(raw: 'raw-2', sha256: 'hash-2'),
        ]),
      );

      final first = await repository.signIn(
        webAuthenticationOptions: null,
      );
      final second = await repository.signIn(
        webAuthenticationOptions: null,
      );

      expect(plugin.requests.map((request) => request.nonce), [
        'hash-1',
        'hash-2',
      ]);
      expect(first.unwrap().nonce, 'raw-1');
      expect(second.unwrap().nonce, 'raw-2');
    });

    test('初回Apple userをcredentialへ転送する', () async {
      final repository = AppleAuthRepository(
        plugin: RecordingAppleSignInPlugin()
          ..credentials.add(
            const AppleNativeCredential(
              identityToken: 'apple-token',
              email: 'masked@example.com',
              firstName: 'Taro',
              lastName: 'Example',
            ),
          ),
        nonceGenerator: QueueNonceGenerator([
          const NativeAuthNonce(raw: 'raw', sha256: 'hash'),
        ]),
      );

      final credential = (await repository.signIn(
        webAuthenticationOptions: null,
      )).unwrap();

      expect(
        credential.appleUser,
        const AppleInitialUser(
          email: 'masked@example.com',
          firstName: 'Taro',
          lastName: 'Example',
        ),
      );
    });

    test('Appleキャンセルをcancelledへ変換する', () async {
      final repository = AppleAuthRepository(
        plugin: RecordingAppleSignInPlugin()
          ..exception = const SignInWithAppleAuthorizationException(
            code: AuthorizationErrorCode.canceled,
            message: 'cancelled',
          ),
        nonceGenerator: QueueNonceGenerator([
          const NativeAuthNonce(raw: 'raw', sha256: 'hash'),
        ]),
      );

      final result = await repository.signIn(
        webAuthenticationOptions: null,
      );

      expect(
        (result as Failure<NativeAuthCredential, AuthFailure>).exception.kind,
        AuthFailureKind.cancelled,
      );
    });

    for (final idToken in <String?>[null, '']) {
      test(
        'Appleの${idToken == null ? 'missing' : 'empty'} ID Tokenを拒否する',
        () async {
          final repository = AppleAuthRepository(
            plugin: RecordingAppleSignInPlugin()
              ..credentials.add(AppleNativeCredential(identityToken: idToken)),
            nonceGenerator: QueueNonceGenerator([
              const NativeAuthNonce(raw: 'raw', sha256: 'hash'),
            ]),
          );

          final result = await repository.signIn(
            webAuthenticationOptions: null,
          );

          expect(
            (result as Failure<NativeAuthCredential, AuthFailure>)
                .exception
                .kind,
            AuthFailureKind.invalidResponse,
          );
        },
      );
    }
  });

  group('NativeSocialAuthRepository', () {
    test('環境一致時だけGoogle credentialをBetter Authへ送る', () async {
      final fixture = NativeSocialFixture();
      fixture.google.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: 'google-token',
          nonce: 'google-nonce',
        ),
      );

      final result = await fixture.repository.signInWithGoogle();

      expect(result, isA<Success<void, AuthFailure>>());
      expect(fixture.adapter.requestBodies, [
        {
          'provider': 'google',
          'idToken': {
            'token': 'google-token',
            'nonce': 'google-nonce',
          },
        },
      ]);
      expect(
        fixture.preferences.values[SecureStorageKey.betterAuthSessionToken],
        'social-session',
      );
    });

    test('Google API successだけでは完了せずJWT acceptanceまでattemptを保持する', () async {
      final acceptance = Completer<Result<AuthSession, AuthFailure>>();
      final fixture = NativeSocialFixture(acceptance: acceptance);
      fixture.google.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: 'google-token',
          nonce: 'google-nonce',
        ),
      );
      var completed = false;

      final pending = fixture.repository.signInWithGoogle()
        ..then((_) => completed = true);
      await fixture.acceptSignInStarted.future;
      final second = await fixture.repository.signInWithApple();

      expect(completed, isFalse);
      expect(fixture.acceptSignInCalls, 1);
      expect(
        (second as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(fixture.apple.webAuthenticationOptions, isEmpty);
      expect(fixture.adapter.requestBodies, hasLength(1));
      acceptance.complete(const Success(AuthSession.authenticated()));
      expect(await pending, isA<Success<void, AuthFailure>>());
    });

    test('Better Auth session header欠落はinvalidResponseでsessionを残さない', () async {
      final fixture = NativeSocialFixture();
      fixture.adapter.sessionTokenHeaders = null;
      fixture.google.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: 'google-token',
          nonce: 'google-nonce',
        ),
      );

      final result = await fixture.repository.signInWithGoogle();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.invalidResponse,
      );
      expect(
        fixture.preferences.values[SecureStorageKey.betterAuthSessionToken],
        isNull,
      );
      expect(fixture.google.signInCount, 1);
      expect(fixture.adapter.requestBodies, hasLength(1));
    });

    test('Apple AndroidへService IDと固定develop callbackだけを渡す', () async {
      final fixture = NativeSocialFixture(platform: NativeAuthPlatform.android);
      fixture.apple.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.apple,
          idToken: 'apple-token',
          nonce: 'apple-nonce',
          appleUser: AppleInitialUser(
            email: 'masked@example.com',
            firstName: 'Taro',
          ),
        ),
      );

      final result = await fixture.repository.signInWithApple();

      expect(result, isA<Success<void, AuthFailure>>());
      expect(fixture.apple.webAuthenticationOptions, hasLength(1));
      expect(
        fixture.apple.webAuthenticationOptions.single?.clientId,
        'net.yumnumm.eqmonitor.service',
      );
      expect(
        fixture.apple.webAuthenticationOptions.single?.redirectUri,
        Uri.parse(
          'https://dev.v2.api.eqmonitor.app/api/auth/apple/android/callback',
        ),
      );
      expect(fixture.adapter.requestBodies, [
        {
          'provider': 'apple',
          'idToken': {
            'token': 'apple-token',
            'nonce': 'apple-nonce',
            'user': {
              'name': {'firstName': 'Taro'},
              'email': 'masked@example.com',
            },
          },
        },
      ]);
      expect(
        fixture.preferences.values[SecureStorageKey.betterAuthSessionToken],
        'social-session',
      );
    });

    test('環境不一致はNative UIとHTTPを開く前に拒否する', () async {
      final fixture = NativeSocialFixture(
        telegramUrl: const TelegramUrlModel(
          restApiUrl: 'https://v2.api.eqmonitor.app',
          wsApiUrl: 'wss://example.com',
        ),
      );

      final result = await fixture.repository.signInWithGoogle();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.environmentMismatch,
      );
      expect(fixture.google.signInCount, 0);
      expect(fixture.adapter.requestBodies, isEmpty);
    });

    test('Appleも環境不一致ならNative UIとHTTPを開く前に拒否する', () async {
      final fixture = NativeSocialFixture(
        telegramUrl: const TelegramUrlModel(
          restApiUrl: 'https://v2.api.eqmonitor.app',
          wsApiUrl: 'wss://example.com',
        ),
      );

      final result = await fixture.repository.signInWithApple();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.environmentMismatch,
      );
      expect(fixture.apple.webAuthenticationOptions, isEmpty);
      expect(fixture.adapter.requestBodies, isEmpty);
    });

    test('AppleもNative Social Auth未有効ならNative UIとHTTP前に拒否する', () async {
      final fixture = NativeSocialFixture(
        buildConfig: devBuildConfig.copyWith(
          isNativeSocialAuthEnabled: false,
        ),
      );

      final result = await fixture.repository.signInWithApple();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.configuration,
      );
      expect(fixture.apple.webAuthenticationOptions, isEmpty);
      expect(fixture.adapter.requestBodies, isEmpty);
    });

    test('空のGoogle server client IDはNative UIの前に拒否する', () async {
      final fixture = NativeSocialFixture(
        buildConfig: devBuildConfig.copyWith(googleServerClientId: ''),
      );

      final result = await fixture.repository.signInWithGoogle();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.configuration,
      );
      expect(fixture.google.signInCount, 0);
      expect(fixture.adapter.requestBodies, isEmpty);
    });

    test('空のApple Service IDはAndroid Native UIの前に拒否する', () async {
      final fixture = NativeSocialFixture(
        platform: NativeAuthPlatform.android,
        buildConfig: devBuildConfig.copyWith(appleServiceId: ''),
      );

      final result = await fixture.repository.signInWithApple();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.configuration,
      );
      expect(fixture.apple.webAuthenticationOptions, isEmpty);
      expect(fixture.adapter.requestBodies, isEmpty);
    });

    test('Native Social Authが未有効化ならNative UIの前に拒否する', () async {
      final fixture = NativeSocialFixture(
        buildConfig: devBuildConfig.copyWith(isNativeSocialAuthEnabled: false),
      );

      final result = await fixture.repository.signInWithGoogle();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.configuration,
      );
      expect(fixture.google.signInCount, 0);
      expect(fixture.adapter.requestBodies, isEmpty);
    });

    test('iOS reverse client ID不一致はNative UIの前に拒否する', () async {
      final fixture = NativeSocialFixture(
        buildConfig: devBuildConfig.copyWith(
          googleIosReversedClientId: 'com.googleusercontent.apps.other',
        ),
      );

      final result = await fixture.repository.signInWithGoogle();

      expect(
        (result as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.configuration,
      );
      expect(fixture.google.signInCount, 0);
      expect(fixture.adapter.requestBodies, isEmpty);
    });

    for (final testCase in [
      (
        name: 'OAuth ID本体が空のGoogle iOS client ID',
        buildConfig: devBuildConfig.copyWith(
          googleIosClientId: '.apps.googleusercontent.com',
          googleIosReversedClientId: 'com.googleusercontent.apps.',
        ),
      ),
      (
        name: 'OAuth ID本体が空のGoogle server client ID',
        buildConfig: devBuildConfig.copyWith(
          googleServerClientId: '.apps.googleusercontent.com',
        ),
      ),
      (
        name: '空白を含むGoogle iOS client ID',
        buildConfig: devBuildConfig.copyWith(
          googleIosClientId: 'not a client.apps.googleusercontent.com',
          googleIosReversedClientId: 'com.googleusercontent.apps.not a client',
        ),
      ),
      (
        name: 'scheme文字列を含むGoogle iOS client ID',
        buildConfig: devBuildConfig.copyWith(
          googleIosClientId: 'https://bad.apps.googleusercontent.com',
          googleIosReversedClientId: 'com.googleusercontent.apps.https://bad',
        ),
      ),
      (
        name: '空白を含むGoogle server client ID',
        buildConfig: devBuildConfig.copyWith(
          googleServerClientId: 'not a client.apps.googleusercontent.com',
        ),
      ),
      (
        name: 'slashを含むGoogle server client ID',
        buildConfig: devBuildConfig.copyWith(
          googleServerClientId: 'server/id.apps.googleusercontent.com',
        ),
      ),
      (
        name: 'colonを含むGoogle server client ID',
        buildConfig: devBuildConfig.copyWith(
          googleServerClientId: 'server:id.apps.googleusercontent.com',
        ),
      ),
    ]) {
      test('${testCase.name}をNative UIとHTTP前に拒否する', () async {
        final fixture = NativeSocialFixture(buildConfig: testCase.buildConfig);
        fixture.google.credentials.add(
          const NativeAuthCredential(
            provider: NativeAuthProvider.google,
            idToken: 'google-token',
            nonce: 'google-nonce',
          ),
        );

        final result = await fixture.repository.signInWithGoogle();

        expect(
          (result as Failure<void, AuthFailure>).exception.kind,
          AuthFailureKind.configuration,
        );
        expect(fixture.google.signInCount, 0);
        expect(fixture.adapter.requestBodies, isEmpty);
      });
    }

    for (final serviceId in [
      '.',
      'a..b',
      '.service',
      'service.',
      'https://bad.example',
      'service id.example',
      'service/id.example',
      'service:bad.example',
      'サービス.example',
    ]) {
      test(
        '不正なApple Service ID $serviceIdをNative UIとHTTP前に拒否する',
        () async {
          final fixture = NativeSocialFixture(
            platform: NativeAuthPlatform.android,
            buildConfig: devBuildConfig.copyWith(appleServiceId: serviceId),
          );
          fixture.apple.credentials.add(
            const NativeAuthCredential(
              provider: NativeAuthProvider.apple,
              idToken: 'apple-token',
              nonce: 'apple-nonce',
            ),
          );

          final result = await fixture.repository.signInWithApple();

          expect(
            (result as Failure<void, AuthFailure>).exception.kind,
            AuthFailureKind.configuration,
          );
          expect(fixture.apple.webAuthenticationOptions, isEmpty);
          expect(fixture.adapter.requestBodies, isEmpty);
        },
      );
    }

    test('安全なASCIIのGoogle client IDを拒否しない', () async {
      final fixture = NativeSocialFixture(
        buildConfig: devBuildConfig.copyWith(
          googleIosClientId: 'client.id_123.apps.googleusercontent.com',
          googleIosReversedClientId: 'com.googleusercontent.apps.client.id_123',
          googleServerClientId: 'server.id-456.apps.googleusercontent.com',
        ),
      );
      fixture.google.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: 'google-token',
          nonce: 'google-nonce',
        ),
      );

      final result = await fixture.repository.signInWithGoogle();

      expect(result, isA<Success<void, AuthFailure>>());
      expect(fixture.google.signInCount, 1);
      expect(fixture.adapter.requestBodies, hasLength(1));
    });

    test('英数字とhyphenからなるApple Service IDを拒否しない', () async {
      final fixture = NativeSocialFixture(
        platform: NativeAuthPlatform.android,
        buildConfig: devBuildConfig.copyWith(
          appleServiceId: 'com.example.service-123',
        ),
      );
      fixture.apple.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.apple,
          idToken: 'apple-token',
          nonce: 'apple-nonce',
        ),
      );

      final result = await fixture.repository.signInWithApple();

      expect(result, isA<Success<void, AuthFailure>>());
      expect(fixture.apple.webAuthenticationOptions, hasLength(1));
      expect(fixture.adapter.requestBodies, hasLength(1));
    });

    test('Google double tapは二つ目をbusyで拒否しNativeとHTTPを一回にする', () async {
      final fixture = NativeSocialFixture();
      final nativeResult =
          Completer<Result<NativeAuthCredential, AuthFailure>>();
      fixture.google.pendingResult = nativeResult;

      final first = fixture.repository.signInWithGoogle();
      final second = fixture.repository.signInWithGoogle();
      nativeResult.complete(
        const Success(
          NativeAuthCredential(
            provider: NativeAuthProvider.google,
            idToken: 'google-token',
            nonce: 'google-nonce',
          ),
        ),
      );

      final results = await Future.wait([first, second]);

      expect(results.first, isA<Success<void, AuthFailure>>());
      expect(
        (results.last as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(fixture.google.signInCount, 1);
      expect(fixture.adapter.requestBodies, hasLength(1));
    });

    test('Apple中のGoogle sign-inをbusyで拒否しNativeとHTTPを一回にする', () async {
      final fixture = NativeSocialFixture();
      final nativeResult =
          Completer<Result<NativeAuthCredential, AuthFailure>>();
      fixture.apple.pendingResult = nativeResult;
      fixture.google.credentials.add(
        const NativeAuthCredential(
          provider: NativeAuthProvider.google,
          idToken: 'google-token',
          nonce: 'google-nonce',
        ),
      );

      final first = fixture.repository.signInWithApple();
      final second = fixture.repository.signInWithGoogle();
      nativeResult.complete(
        const Success(
          NativeAuthCredential(
            provider: NativeAuthProvider.apple,
            idToken: 'apple-token',
            nonce: 'apple-nonce',
          ),
        ),
      );

      final results = await Future.wait([first, second]);

      expect(results.first, isA<Success<void, AuthFailure>>());
      expect(
        (results.last as Failure<void, AuthFailure>).exception.kind,
        AuthFailureKind.busy,
      );
      expect(fixture.apple.webAuthenticationOptions, hasLength(1));
      expect(fixture.google.signInCount, 0);
      expect(fixture.adapter.requestBodies, hasLength(1));
    });
  });
}

const devBuildConfig = BuildConfig(
  restApiUrl: 'https://dev.v2.api.eqmonitor.app',
  appIdSuffix: '.dev',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: Flavor.dev,
  wsApiUrl: 'wss://example.com',
  googleIosClientId: 'ios.apps.googleusercontent.com',
  googleIosReversedClientId: 'com.googleusercontent.apps.ios',
  googleAndroidClientId: 'android.apps.googleusercontent.com',
  googleServerClientId: 'server.apps.googleusercontent.com',
  appleServiceId: 'net.yumnumm.eqmonitor.service',
  isNativeSocialAuthEnabled: true,
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
);

final class NativeSocialFixture {
  new({
    this.platform = NativeAuthPlatform.ios,
    this.buildConfig = devBuildConfig,
    this.telegramUrl = const TelegramUrlModel(
      restApiUrl: 'https://dev.v2.api.eqmonitor.app',
      wsApiUrl: 'wss://example.com',
    ),
    this.acceptance,
  }) {
    final dio = Dio(BaseOptions(baseUrl: telegramUrl.restApiUrl))
      ..httpClientAdapter = adapter;
    apiClient = BetterAuthApiClient(
      dio: dio,
      sessionRepository: BetterAuthSessionRepository(
        preferences: preferences,
      ),
      cookieJar: CookieJar(),
    );
    repository = NativeSocialAuthRepository(
      apiClient: apiClient,
      googleAuthRepository: google,
      appleAuthRepository: apple,
      buildConfig: buildConfig,
      telegramUrl: telegramUrl,
      platform: platform,
      attemptCoordinator: attemptCoordinator,
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
    );
  }

  final NativeAuthPlatform platform;
  final BuildConfig buildConfig;
  final TelegramUrlModel telegramUrl;
  final Completer<Result<AuthSession, AuthFailure>>? acceptance;
  final google = QueueGoogleAuthGateway();
  final apple = QueueAppleAuthGateway();
  final adapter = RecordingSocialAuthAdapter();
  final preferences = MemoryPreferencesDataSource();
  final attemptCoordinator = NativeAuthAttemptCoordinator();
  final acceptSignInStarted = Completer<void>();
  var acceptSignInCalls = 0;
  late final BetterAuthApiClient apiClient;
  late final NativeSocialAuthRepository repository;
}

final class QueueGoogleAuthGateway implements GoogleAuthGateway {
  final credentials = <NativeAuthCredential>[];
  Completer<Result<NativeAuthCredential, AuthFailure>>? pendingResult;
  var signInCount = 0;

  @override
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required String clientId,
    required String serverClientId,
  }) {
    signInCount++;
    return pendingResult?.future ??
        Future.value(Success(credentials.removeAt(0)));
  }
}

final class QueueAppleAuthGateway implements AppleAuthGateway {
  final credentials = <NativeAuthCredential>[];
  final webAuthenticationOptions = <WebAuthenticationOptions?>[];
  Completer<Result<NativeAuthCredential, AuthFailure>>? pendingResult;

  @override
  Future<Result<NativeAuthCredential, AuthFailure>> signIn({
    required WebAuthenticationOptions? webAuthenticationOptions,
  }) {
    this.webAuthenticationOptions.add(webAuthenticationOptions);
    return pendingResult?.future ??
        Future.value(Success(credentials.removeAt(0)));
  }
}

final class RecordingGoogleSignInPlugin implements GoogleSignInPlugin {
  final idTokens = <String?>[];
  final initializations = <GoogleSignInInitialization>[];
  Exception? exception;

  @override
  Future<String?> authenticateIdToken() async {
    final currentException = exception;
    if (currentException != null) {
      throw currentException;
    }
    return idTokens.removeAt(0);
  }

  @override
  Future<void> initialize({
    required String clientId,
    required String serverClientId,
    required String nonce,
  }) async {
    initializations.add(
      GoogleSignInInitialization(
        clientId: clientId,
        serverClientId: serverClientId,
        nonce: nonce,
      ),
    );
  }
}

final class RecordingAppleSignInPlugin implements AppleSignInPlugin {
  final credentials = <AppleNativeCredential>[];
  final requests = <AppleSignInRequest>[];
  Exception? exception;

  @override
  Future<AppleNativeCredential> signIn({
    required String nonce,
    required WebAuthenticationOptions? webAuthenticationOptions,
  }) async {
    requests.add(
      AppleSignInRequest(
        nonce: nonce,
        webAuthenticationOptions: webAuthenticationOptions,
      ),
    );
    final currentException = exception;
    if (currentException != null) {
      throw currentException;
    }
    return credentials.removeAt(0);
  }
}

final class QueueNonceGenerator implements NativeAuthNonceGenerator {
  new(this.nonces);

  final List<NativeAuthNonce> nonces;

  @override
  NativeAuthNonce generate() => nonces.removeAt(0);
}

final class RecordingSocialAuthAdapter implements HttpClientAdapter {
  final requestBodies = <Map<String, dynamic>>[];
  List<String>? sessionTokenHeaders = const ['social-session'];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.data case final Map<String, dynamic> data) {
      requestBodies.add(data);
    }
    final currentSessionTokenHeaders = sessionTokenHeaders;
    return ResponseBody.fromString(
      '{}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        if (currentSessionTokenHeaders != null)
          'set-auth-token': currentSessionTokenHeaders,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final class MemoryPreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<void> clear() async => values.clear();

  @override
  Future<String?> getString({required SecureStorageKey key}) async =>
      values[key];

  @override
  Future<int?> getInt({required SecureStorageKey key}) async => null;

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async => null;

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async => null;

  @override
  Future<void> remove({required SecureStorageKey key}) async =>
      values.remove(key);

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) async {}

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {}

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {}

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async => values[key] = value;
}

final class GoogleSignInInitialization {
  const new({
    required this.clientId,
    required this.serverClientId,
    required this.nonce,
  });

  final String clientId;
  final String serverClientId;
  final String nonce;

  @override
  bool operator ==(Object other) =>
      other is GoogleSignInInitialization &&
      other.clientId == clientId &&
      other.serverClientId == serverClientId &&
      other.nonce == nonce;

  @override
  int get hashCode => Object.hash(clientId, serverClientId, nonce);
}

final class AppleSignInRequest {
  const new({
    required this.nonce,
    required this.webAuthenticationOptions,
  });

  final String nonce;
  final WebAuthenticationOptions? webAuthenticationOptions;
}
