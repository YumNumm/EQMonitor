import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _StubSubscriptionNotifier extends SubscriptionNotifier {
  _StubSubscriptionNotifier(this._status);

  final SubscriptionStatus _status;

  @override
  Future<SubscriptionStatus> build() async => _status;
}

BuildConfig _buildConfig({required bool isProFeaturesEnabled}) => BuildConfig(
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
  isProFeaturesEnabled: isProFeaturesEnabled,
);

ProviderContainer _container({
  required bool isProFeaturesEnabled,
  required SubscriptionStatus status,
}) => ProviderContainer(
  overrides: [
    buildConfigProvider.overrideWithValue(
      _buildConfig(isProFeaturesEnabled: isProFeaturesEnabled),
    ),
    subscriptionProvider.overrideWith(() => _StubSubscriptionNotifier(status)),
  ],
);

void main() {
  group('isProProvider', () {
    test('フラグ有効かつ active なら true', () async {
      final container = _container(
        isProFeaturesEnabled: true,
        status: const SubscriptionStatus.active(productId: 'pro_monthly'),
      );
      addTearDown(container.dispose);

      await container.read(subscriptionProvider.future);
      expect(container.read(isProProvider), isTrue);
    });

    test('フラグ無効なら active でも false', () async {
      final container = _container(
        isProFeaturesEnabled: false,
        status: const SubscriptionStatus.active(productId: 'pro_monthly'),
      );
      addTearDown(container.dispose);

      await container.read(subscriptionProvider.future);
      expect(container.read(isProProvider), isFalse);
    });

    test('フラグ有効でも inactive なら false', () async {
      final container = _container(
        isProFeaturesEnabled: true,
        status: const SubscriptionStatus.inactive(),
      );
      addTearDown(container.dispose);

      await container.read(subscriptionProvider.future);
      expect(container.read(isProProvider), isFalse);
    });
  });
}
