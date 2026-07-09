import 'package:eqmonitor/feature/permission/data/notifier/notification_permission_banner_dismissed_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('初期状態は false', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(
      await container.read(
        notificationPermissionBannerDismissedProvider.future,
      ),
      isFalse,
    );
  });

  test('dismiss で true を永続化する', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(notificationPermissionBannerDismissedProvider.future);

    await container
        .read(notificationPermissionBannerDismissedProvider.notifier)
        .dismiss();
    expect(
      container.read(notificationPermissionBannerDismissedProvider).value,
      isTrue,
    );

    final container2 = ProviderContainer();
    addTearDown(container2.dispose);
    expect(
      await container2.read(
        notificationPermissionBannerDismissedProvider.future,
      ),
      isTrue,
    );
  });
}
