import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthEnvironment.resolve', () {
    test('dev buildとdevelop APIをdevelop環境として受け入れる', () {
      final result = AuthEnvironment.resolve(
        buildConfig: buildConfig(flavor: Flavor.dev, appIdSuffix: '.dev'),
        telegramUrl: telegramUrl('https://dev.v2.api.eqmonitor.app'),
      );

      expect(result.unwrap(), AuthEnvironment.develop);
      expect(
        result.unwrap().appleAndroidCallbackUri,
        Uri.parse(
          'https://dev.v2.api.eqmonitor.app/api/auth/apple/android/callback',
        ),
      );
    });

    test('prod buildとproduction APIをproduction環境として受け入れる', () {
      final result = AuthEnvironment.resolve(
        buildConfig: buildConfig(flavor: Flavor.prod, appIdSuffix: ''),
        telegramUrl: telegramUrl('https://v2.api.eqmonitor.app/'),
      );

      expect(result.unwrap(), AuthEnvironment.production);
      expect(
        result.unwrap().appleAndroidCallbackUri,
        Uri.parse(
          'https://v2.api.eqmonitor.app/api/auth/apple/android/callback',
        ),
      );
    });

    for (final testCase in [
      (
        name: 'dev buildとproduction URL',
        flavor: Flavor.dev,
        suffix: '.dev',
        url: 'https://v2.api.eqmonitor.app',
      ),
      (
        name: 'prod buildとdevelop URL',
        flavor: Flavor.prod,
        suffix: '',
        url: 'https://dev.v2.api.eqmonitor.app',
      ),
      (
        name: 'custom URL',
        flavor: Flavor.dev,
        suffix: '.dev',
        url: 'https://custom.example.com',
      ),
      (
        name: 'dev flavorとproduction app ID suffix',
        flavor: Flavor.dev,
        suffix: '',
        url: 'https://dev.v2.api.eqmonitor.app',
      ),
      (
        name: 'query付きの見かけ上develop URL',
        flavor: Flavor.dev,
        suffix: '.dev',
        url: 'https://dev.v2.api.eqmonitor.app?target=production',
      ),
    ]) {
      test('${testCase.name}をenvironmentMismatchとして拒否する', () {
        final result = AuthEnvironment.resolve(
          buildConfig: buildConfig(
            flavor: testCase.flavor,
            appIdSuffix: testCase.suffix,
          ),
          telegramUrl: telegramUrl(testCase.url),
        );

        expect(
          (result as Failure<AuthEnvironment, AuthFailure>).exception.kind,
          AuthFailureKind.environmentMismatch,
        );
      });
    }
  });
}

BuildConfig buildConfig({
  required Flavor flavor,
  required String appIdSuffix,
}) => BuildConfig(
  restApiUrl: flavor == Flavor.dev
      ? 'https://dev.v2.api.eqmonitor.app'
      : 'https://v2.api.eqmonitor.app',
  appIdSuffix: appIdSuffix,
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: flavor,
  wsApiUrl: 'wss://example.com',
  googleIosClientId: 'ios.apps.googleusercontent.com',
  googleIosReversedClientId: 'com.googleusercontent.apps.ios',
  googleAndroidClientId: 'android.apps.googleusercontent.com',
  googleServerClientId: 'server.apps.googleusercontent.com',
  appleServiceId: 'net.yumnumm.eqmonitor.service',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
);

TelegramUrlModel telegramUrl(String restApiUrl) => TelegramUrlModel(
  restApiUrl: restApiUrl,
  wsApiUrl: 'wss://example.com',
);
