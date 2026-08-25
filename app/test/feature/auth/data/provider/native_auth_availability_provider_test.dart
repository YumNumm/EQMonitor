import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/feature/auth/data/provider/native_auth_availability_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/native_social_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NativeAuthAvailabilityEvaluator', () {
    for (final testCase
        in <
          ({
            String name,
            BuildConfig config,
            bool environmentCompatible,
            NativeAuthPlatform platform,
            bool google,
            bool apple,
            bool passkey,
          })
        >[
          (
            name: 'iOSの有効な設定',
            config: validConfig,
            environmentCompatible: true,
            platform: NativeAuthPlatform.ios,
            google: true,
            apple: true,
            passkey: true,
          ),
          (
            name: 'Androidの有効な設定',
            config: validConfig,
            environmentCompatible: true,
            platform: NativeAuthPlatform.android,
            google: true,
            apple: true,
            passkey: true,
          ),
          (
            name: '環境不一致',
            config: validConfig,
            environmentCompatible: false,
            platform: NativeAuthPlatform.ios,
            google: false,
            apple: false,
            passkey: false,
          ),
          (
            name: 'social feature flag無効',
            config: validConfig.copyWith(isNativeSocialAuthEnabled: false),
            environmentCompatible: true,
            platform: NativeAuthPlatform.ios,
            google: false,
            apple: false,
            passkey: true,
          ),
          (
            name: '非対応platform',
            config: validConfig,
            environmentCompatible: true,
            platform: NativeAuthPlatform.unsupported,
            google: false,
            apple: false,
            passkey: false,
          ),
          (
            name: 'Google client設定不正',
            config: validConfig.copyWith(googleServerClientId: ''),
            environmentCompatible: true,
            platform: NativeAuthPlatform.ios,
            google: false,
            apple: true,
            passkey: true,
          ),
          (
            name: 'Android Apple Service ID不正',
            config: validConfig.copyWith(appleServiceId: ''),
            environmentCompatible: true,
            platform: NativeAuthPlatform.android,
            google: true,
            apple: false,
            passkey: true,
          ),
        ]) {
      test(testCase.name, () {
        final availability = const NativeAuthAvailabilityEvaluator().evaluate(
          buildConfig: testCase.config,
          environmentCompatible: testCase.environmentCompatible,
          platform: testCase.platform,
        );

        expect(availability.googleAvailable, testCase.google);
        expect(availability.appleAvailable, testCase.apple);
        expect(availability.passkeyAvailable, testCase.passkey);
      });
    }
  });

  test('環境不一致なら認証状態やbusy状態にかかわらず全actionを無効化する', () {
    const availability = NativeAuthAvailability(
      environmentCompatible: false,
      googleAvailable: true,
      appleAvailable: true,
      passkeyAvailable: true,
    );

    final actions = availability.actions(
      isSessionReady: true,
      isAuthenticated: true,
      isBusy: false,
    );

    expect(actions.googleSignIn, isFalse);
    expect(actions.appleSignIn, isFalse);
    expect(actions.passkeySignIn, isFalse);
    expect(actions.passkeyRegistration, isFalse);
    expect(actions.jwtRefresh, isFalse);
    expect(actions.userMeVerification, isFalse);
    expect(actions.signOut, isFalse);
  });

  test('busy中は利用可能な環境でも全actionを無効化する', () {
    const availability = NativeAuthAvailability(
      environmentCompatible: true,
      googleAvailable: true,
      appleAvailable: true,
      passkeyAvailable: true,
    );

    final actions = availability.actions(
      isSessionReady: true,
      isAuthenticated: true,
      isBusy: true,
    );

    expect(actions.allDisabled, isTrue);
  });

  for (final sessionState in ['loading', 'error']) {
    test('session $sessionState 中は全actionを無効化する', () {
      const availability = NativeAuthAvailability(
        environmentCompatible: true,
        googleAvailable: true,
        appleAvailable: true,
        passkeyAvailable: true,
      );

      final actions = availability.actions(
        isSessionReady: false,
        isAuthenticated: false,
        isBusy: false,
      );

      expect(actions.allDisabled, isTrue);
    });
  }
}

const validConfig = BuildConfig(
  restApiUrl: 'https://dev.v2.api.eqmonitor.app',
  appIdSuffix: '.dev',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: Flavor.dev,
  wsApiUrl: 'wss://example.com',
  googleIosClientId: 'ios.apps.googleusercontent.com',
  googleAndroidClientId: 'android.apps.googleusercontent.com',
  googleServerClientId: 'server.apps.googleusercontent.com',
  googleIosReversedClientId: 'com.googleusercontent.apps.ios',
  appleServiceId: 'net.yumnumm.eqmonitor.service',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
  isNativeSocialAuthEnabled: true,
);
