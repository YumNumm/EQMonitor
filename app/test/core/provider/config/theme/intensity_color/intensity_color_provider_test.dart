import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('IntensityColorProvider', () {
    test('エクスポートしたJSONをインポートすると状態が復元される', () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(preferences),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(intensityColorProvider.notifier);
      await notifier.update(IntensityColorModel.jma());
      final exported = notifier.exportAsJsonString();

      await notifier.update(IntensityColorModel.eqmonitor());
      final result = await notifier.importFromJsonString(exported);

      expect(result, isA<Success<void, IntensityColorImportException>>());
      expect(container.read(intensityColorProvider), IntensityColorModel.jma());
    });

    test('不正なJSONインポート時はFailureを返し状態を変更しない', () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(preferences),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(intensityColorProvider.notifier);
      final original = container.read(intensityColorProvider);

      final result = await notifier.importFromJsonString('{ invalid json');

      expect(result, isA<Failure<void, IntensityColorImportException>>());
      expect(container.read(intensityColorProvider), original);
    });
  });
}
