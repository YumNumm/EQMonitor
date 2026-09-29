import 'package:eqmonitor/core/model/environment.dart';
import 'package:flutter_test/flutter_test.dart';

BuildConfig _buildConfig({
  required Flavor flavor,
  required bool isProduction,
  bool isShakeDetectionEnabled = true,
}) => BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: flavor,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
  isProduction: isProduction,
  isShakeDetectionEnabled: isShakeDetectionEnabled,
);

void main() {
  group('BuildConfig.isDeveloperUiEnabled', () {
    test('production のときは false', () {
      expect(
        _buildConfig(
          flavor: Flavor.prod,
          isProduction: true,
        ).isDeveloperUiEnabled,
        isFalse,
      );
    });

    test('production なら dev flavor でも false', () {
      expect(
        _buildConfig(
          flavor: Flavor.dev,
          isProduction: true,
        ).isDeveloperUiEnabled,
        isFalse,
      );
    });

    test('非 production なら prod flavor でも true', () {
      expect(
        _buildConfig(
          flavor: Flavor.prod,
          isProduction: false,
        ).isDeveloperUiEnabled,
        isTrue,
      );
    });

    test('非 production の dev flavor なら true', () {
      expect(
        _buildConfig(
          flavor: Flavor.dev,
          isProduction: false,
        ).isDeveloperUiEnabled,
        isTrue,
      );
    });
  });

  group('BuildConfig defaults', () {
    test('isProduction は既定で false', () {
      const config = BuildConfig(
        restApiUrl: '',
        appIdSuffix: '',
        appName: 'EQMonitor',
        commitInformation: 'test',
        flavor: Flavor.dev,
        wsApiUrl: '',
        googleIosClientId: '',
        googleAndroidClientId: '',
        buildTimestamp: '',
        buildCommitMessage: '',
        revenueCatApiKeyIos: '',
        revenueCatApiKeyAndroid: '',
      );
      expect(config.isProduction, isFalse);
    });

    test('isShakeDetectionEnabled は既定で true', () {
      const config = BuildConfig(
        restApiUrl: '',
        appIdSuffix: '',
        appName: 'EQMonitor',
        commitInformation: 'test',
        flavor: Flavor.dev,
        wsApiUrl: '',
        googleIosClientId: '',
        googleAndroidClientId: '',
        buildTimestamp: '',
        buildCommitMessage: '',
        revenueCatApiKeyIos: '',
        revenueCatApiKeyAndroid: '',
      );
      expect(config.isShakeDetectionEnabled, isTrue);
    });

    test('production では揺れ検知フラグが true でも無効', () {
      expect(
        _buildConfig(
          flavor: Flavor.prod,
          isProduction: true,
          isShakeDetectionEnabled: true,
        ).isShakeDetectionAvailable,
        isFalse,
      );
    });
  });
}
