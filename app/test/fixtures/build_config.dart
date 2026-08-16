import 'package:eqmonitor/core/model/environment.dart';

/// テスト用の [BuildConfig] を組み立てる。
///
/// `buildConfigProvider` は `BuildConfig.fromEnvironment()` を返すため、
/// dart-define のないテストでは `Flavor.values.byName('')` で例外になる。
/// `buildConfigProvider` を読む provider / Widget のテストでは必ず
/// `buildConfigProvider.overrideWithValue(...)` で差し替えること。
class BuildConfigFixture {
  const BuildConfigFixture();

  BuildConfig build({
    Flavor flavor = Flavor.dev,
    bool isBetaTesting = false,
    bool isProFeaturesEnabled = false,
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
    isBetaTesting: isBetaTesting,
    isProFeaturesEnabled: isProFeaturesEnabled,
    isShakeDetectionEnabled: isShakeDetectionEnabled,
  );
}
