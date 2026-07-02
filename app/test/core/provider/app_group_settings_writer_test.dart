import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesAsync prefs;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    prefs = SharedPreferencesAsync();
  });

  group('writeCurrentLocationRegionToAppGroup', () {
    test('地域を書き込むと code/name が保存され changed=true', () async {
      final changed = await writeCurrentLocationRegionToAppGroup(
        prefs,
        regionCode: 130010,
        regionName: '東京都２３区',
      );

      expect(changed, isTrue);
      expect(
        await prefs.getString(AppGroupKeys.currentLocationRegionCode),
        '130010',
      );
      expect(
        await prefs.getString(AppGroupKeys.currentLocationRegionName),
        '東京都２３区',
      );
    });

    test('同じ値の再書き込みは changed=false', () async {
      await writeCurrentLocationRegionToAppGroup(
        prefs,
        regionCode: 130010,
        regionName: '東京都２３区',
      );
      final changed = await writeCurrentLocationRegionToAppGroup(
        prefs,
        regionCode: 130010,
        regionName: '東京都２３区',
      );

      expect(changed, isFalse);
    });

    test('null を渡すとキーが削除される', () async {
      await writeCurrentLocationRegionToAppGroup(
        prefs,
        regionCode: 130010,
        regionName: '東京都２３区',
      );
      final changed = await writeCurrentLocationRegionToAppGroup(
        prefs,
        regionCode: null,
        regionName: null,
      );

      expect(changed, isTrue);
      expect(
        await prefs.getString(AppGroupKeys.currentLocationRegionCode),
        isNull,
      );
      expect(
        await prefs.getString(AppGroupKeys.currentLocationRegionName),
        isNull,
      );
    });

    test('既にキーが無い状態で null 書き込みは changed=false', () async {
      final changed = await writeCurrentLocationRegionToAppGroup(
        prefs,
        regionCode: null,
        regionName: null,
      );

      expect(changed, isFalse);
    });
  });
}
