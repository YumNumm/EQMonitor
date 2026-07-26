import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EewWarningOverlayEnabled', () {
    test('未設定ならtrueを返す', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        await container.read(eewWarningOverlayEnabledProvider.future),
        isTrue,
      );
    });

    test('保存済みfalseを復元する', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.eewWarningOverlayEnabled.key: false,
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        await container.read(eewWarningOverlayEnabledProvider.future),
        isFalse,
      );
    });

    test('setは状態とSharedPreferencesを更新する', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(eewWarningOverlayEnabledProvider.future);

      await container
          .read(eewWarningOverlayEnabledProvider.notifier)
          .set(value: false);

      expect(container.read(eewWarningOverlayEnabledProvider).value, isFalse);
      final preferences = await SharedPreferences.getInstance();
      expect(
        preferences.getBool(SharedPreferencesKey.eewWarningOverlayEnabled.key),
        isFalse,
      );
    });
  });
}
