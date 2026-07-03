import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/model/widget_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/notifier/widget_region_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WidgetRegionSelection JSON 往復', () {
    test('全フィールドを保持する', () {
      const original = WidgetRegionSelection(
        searchType: RegionSearchType.city,
        code: '13101',
        name: '千代田区',
      );
      final roundTrip = WidgetRegionSelection.fromJson(
        jsonDecode(jsonEncode(original.toJson())) as Map<String, dynamic>,
      );
      expect(roundTrip, original);
    });
  });

  group('WidgetRegionNotifier', () {
    test('初期状態は null', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final value = await container.read(widgetRegionProvider.future);
      expect(value, isNull);
    });

    test('save で選択を保存し、再構築後も復元できる', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(widgetRegionProvider.future);

      const selection = WidgetRegionSelection(
        searchType: RegionSearchType.prefecture,
        code: '130000',
        name: '東京都',
      );
      await container
          .read(widgetRegionProvider.notifier)
          .save(selection);

      expect(container.read(widgetRegionProvider).value, selection);

      // 別コンテナ = アプリ再起動相当。永続化されていれば復元される。
      final container2 = ProviderContainer();
      addTearDown(container2.dispose);
      final restored = await container2.read(
        widgetRegionProvider.future,
      );
      expect(restored, selection);
    });

    test('clear で選択を解除する', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(widgetRegionProvider.future);

      await container.read(widgetRegionProvider.notifier).save(
        const WidgetRegionSelection(
          searchType: RegionSearchType.city,
          code: '13101',
          name: '千代田区',
        ),
      );
      await container.read(widgetRegionProvider.notifier).clear();

      expect(container.read(widgetRegionProvider).value, isNull);

      final container2 = ProviderContainer();
      addTearDown(container2.dispose);
      expect(
        await container2.read(widgetRegionProvider.future),
        isNull,
      );
    });

    test('壊れた JSON は null にフォールバックする', () async {
      SharedPreferences.setMockInitialValues({
        'widget_region_selection': 'not a json',
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        await container.read(widgetRegionProvider.future),
        isNull,
      );
    });
  });
}
