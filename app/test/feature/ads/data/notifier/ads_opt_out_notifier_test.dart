import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/ads/data/notifier/ads_opt_out_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container({
  Map<String, Object> initial = const {},
}) async {
  SharedPreferences.setMockInitialValues(initial);
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdsOptOutNotifier', () {
    test('初期値は false（SharedPreferences 未設定時）', () async {
      final container = await _container();
      addTearDown(container.dispose);

      expect(container.read(adsOptOutProvider), isFalse);
    });

    test('SharedPreferences に true が入っていれば true を返す', () async {
      final container = await _container(initial: {'ads_opt_out': true});
      addTearDown(container.dispose);

      expect(container.read(adsOptOutProvider), isTrue);
    });

    test('toggle で値が反転する', () async {
      final container = await _container();
      addTearDown(container.dispose);

      expect(container.read(adsOptOutProvider), isFalse);

      await container.read(adsOptOutProvider.notifier).toggle();
      expect(container.read(adsOptOutProvider), isTrue);

      await container.read(adsOptOutProvider.notifier).toggle();
      expect(container.read(adsOptOutProvider), isFalse);
    });

    test('setOptOut(value: true) で true 固定にできる', () async {
      final container = await _container();
      addTearDown(container.dispose);

      await container.read(adsOptOutProvider.notifier).setOptOut(value: true);
      expect(container.read(adsOptOutProvider), isTrue);

      // 冪等性: 再度 true でもクラッシュしない
      await container.read(adsOptOutProvider.notifier).setOptOut(value: true);
      expect(container.read(adsOptOutProvider), isTrue);
    });

    test('setOptOut(value: false) で false に戻せる', () async {
      final container = await _container(initial: {'ads_opt_out': true});
      addTearDown(container.dispose);

      await container.read(adsOptOutProvider.notifier).setOptOut(value: false);
      expect(container.read(adsOptOutProvider), isFalse);
    });

    test('変更後の値が SharedPreferences に永続化される', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(adsOptOutProvider.notifier).setOptOut(value: true);

      expect(prefs.getBool('ads_opt_out'), isTrue);
    });
  });
}
