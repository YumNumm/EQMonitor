import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/widget_current_location_loader.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/model/widget_region_selection.dart';
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

  group('write', () {
    const region = WidgetRegionSelection(
      searchType: RegionSearchType.prefecture,
      code: '13',
      name: '東京都',
    );

    Future<bool> write({required bool? isPro}) => AppGroupSettingsWriter.write(
      prefs: prefs,
      telegramRestApiUrl: 'https://example.com',
      isPro: isPro,
      widgetRegion: region,
      locationResult: (
        state: WidgetLocationState.temporarilyUnavailable,
        position: null,
      ),
      resolveEarthquakeRegion: (lat, lon) async => null,
    );

    test('購読状態が未確定の間は Pro 状態と任意地域を書かず、URL は書く', () async {
      final changed = await write(isPro: null);

      expect(changed, isTrue);
      expect(
        await prefs.getString(AppGroupKeys.apiServerUrl),
        'https://example.com',
      );
      expect(await prefs.getBool(AppGroupKeys.isPro), isNull);
      expect(await prefs.getString(AppGroupKeys.widgetRegionCode), isNull);
    });

    test('前回 Pro の値を、未確定の間に false で上書きしない', () async {
      await write(isPro: true);

      final changedWhileLoading = await write(isPro: null);

      expect(changedWhileLoading, isFalse);
      expect(await prefs.getBool(AppGroupKeys.isPro), isTrue);
      expect(await prefs.getString(AppGroupKeys.widgetRegionCode), '13');

      final changedAfterConfirmed = await write(isPro: true);

      expect(changedAfterConfirmed, isFalse);
    });

    test('Pro でないと確定したら false を書き、任意地域を隠す', () async {
      await write(isPro: true);

      final changed = await write(isPro: false);

      expect(changed, isTrue);
      expect(await prefs.getBool(AppGroupKeys.isPro), isFalse);
      expect(await prefs.getString(AppGroupKeys.widgetRegionCode), isNull);
      expect(await prefs.getString(AppGroupKeys.widgetRegionName), isNull);
    });
  });

  group('writeCurrentLocationRegionToAppGroup', () {
    test('地域を書き込むと code/name が保存され changed=true', () async {
      final changed = await AppGroupSettingsWriter.writeCurrentLocationRegion(
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
      await AppGroupSettingsWriter.writeCurrentLocationRegion(
        prefs,
        regionCode: 130010,
        regionName: '東京都２３区',
      );
      final changed = await AppGroupSettingsWriter.writeCurrentLocationRegion(
        prefs,
        regionCode: 130010,
        regionName: '東京都２３区',
      );

      expect(changed, isFalse);
    });

    test('null を渡すとキーが削除される', () async {
      await AppGroupSettingsWriter.writeCurrentLocationRegion(
        prefs,
        regionCode: 130010,
        regionName: '東京都２３区',
      );
      final changed = await AppGroupSettingsWriter.writeCurrentLocationRegion(
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
      final changed = await AppGroupSettingsWriter.writeCurrentLocationRegion(
        prefs,
        regionCode: null,
        regionName: null,
      );

      expect(changed, isFalse);
    });
  });
}
