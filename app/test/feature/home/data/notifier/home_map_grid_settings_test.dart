import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('map_gridがない旧設定はグリッド無効として読み込み保存時にmap_gridを出力する', () {
    final configuration = HomeConfigurationModel.fromJson(<String, dynamic>{});

    expect(configuration.mapGrid, const HomeMapGridSettings());
    expect(
      configuration.toJson(),
      containsPair('map_grid', <String, dynamic>{'enabled': false}),
    );
  });

  test('updateMapGridで有効化した設定を保存し新しいcontainerで復元する', () async {
    SharedPreferences.setMockInitialValues({});
    final firstContainer = ProviderContainer();

    try {
      await firstContainer
          .read(homeConfigurationProvider.notifier)
          .updateMapGrid(const HomeMapGridSettings(enabled: true));

      final preferences = await SharedPreferences.getInstance();
      final savedJson = preferences.getString(
        SharedPreferencesKey.homeConfiguration.key,
      );
      if (savedJson == null) {
        fail('home_configuration was not saved');
      }
      final savedConfiguration = jsonDecode(savedJson) as Map<String, dynamic>;
      expect(savedConfiguration['map_grid'], <String, dynamic>{
        'enabled': true,
      });
    } finally {
      firstContainer.dispose();
    }

    final secondContainer = ProviderContainer();
    addTearDown(secondContainer.dispose);

    final reloaded = await secondContainer.read(
      homeConfigurationProvider.future,
    );
    expect(reloaded.mapGrid.enabled, isTrue);
  });
}
