import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProviderContainer _container(Map<String, Object> initialPrefs) {
  SharedPreferences.setMockInitialValues(initialPrefs);
  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWith(
        (ref) => SharedPreferences.getInstance(),
      ),
    ],
  );
}

void main() {
  group('NotificationPresetNotifier', () {
    test('loads all and none from preferences', () async {
      final allContainer = _container({
        SharedPreferencesKey.notificationPreset.key: 'all',
      });
      addTearDown(allContainer.dispose);

      final allPreset = await allContainer.read(
        notificationPresetProvider.future,
      );
      expect(allPreset, NotificationPreset.all);

      final noneContainer = _container({
        SharedPreferencesKey.notificationPreset.key: 'none',
      });
      addTearDown(noneContainer.dispose);

      final nonePreset = await noneContainer.read(
        notificationPresetProvider.future,
      );
      expect(nonePreset, NotificationPreset.none);
    });

    test('defaults unknown values to recommended', () async {
      final unknownContainer = _container({
        SharedPreferencesKey.notificationPreset.key: 'legacy_value',
      });
      addTearDown(unknownContainer.dispose);

      final unknownPreset = await unknownContainer.read(
        notificationPresetProvider.future,
      );
      expect(unknownPreset, NotificationPreset.recommended);

      final emptyContainer = _container({});
      addTearDown(emptyContainer.dispose);

      final defaultPreset = await emptyContainer.read(
        notificationPresetProvider.future,
      );
      expect(defaultPreset, NotificationPreset.recommended);
    });
  });
}
