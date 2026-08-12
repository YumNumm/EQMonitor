import 'package:eqmonitor/core/model/environment.dart';
import 'package:flutter_test/flutter_test.dart';

BuildConfig _buildConfig({
  required Flavor flavor,
  required bool isBetaTesting,
  bool isProFeaturesEnabled = false,
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
  isBetaTesting: isBetaTesting,
  isProFeaturesEnabled: isProFeaturesEnabled,
);

void main() {
  group('BuildConfig.isDeveloperUiEnabled', () {
    test('BETA かつ prod のときのみ false', () {
      expect(
        _buildConfig(flavor: Flavor.prod, isBetaTesting: true)
            .isDeveloperUiEnabled,
        isFalse,
      );
    });

    test('BETA でも dev flavor なら true', () {
      expect(
        _buildConfig(flavor: Flavor.dev, isBetaTesting: true)
            .isDeveloperUiEnabled,
        isTrue,
      );
    });

    test('prod でも BETA でなければ true', () {
      expect(
        _buildConfig(flavor: Flavor.prod, isBetaTesting: false)
            .isDeveloperUiEnabled,
        isTrue,
      );
    });

    test('dev かつ非 BETA なら true', () {
      expect(
        _buildConfig(flavor: Flavor.dev, isBetaTesting: false)
            .isDeveloperUiEnabled,
        isTrue,
      );
    });
  });

  group('BuildConfig defaults', () {
    test('isProFeaturesEnabled は既定で false', () {
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
      expect(config.isProFeaturesEnabled, isFalse);
      expect(config.isBetaTesting, isFalse);
    });
  });
}
