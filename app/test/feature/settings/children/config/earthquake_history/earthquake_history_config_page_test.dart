import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _StubEarthquakeHistoryConfig extends EarthquakeHistoryConfigNotifier {
  EarthquakeHistoryConfig? savedValue;

  @override
  Future<EarthquakeHistoryConfig> build() async =>
      const EarthquakeHistoryConfig(list: EarthquakeHistoryListConfig());

  @override
  Future<void> save(EarthquakeHistoryConfig value) async {
    savedValue = value;
    state = AsyncValue.data(value);
  }
}

class _StubHomeConfiguration extends HomeConfigurationNotifier {
  @override
  Future<HomeConfigurationModel> build() async =>
      const HomeConfigurationModel();
}

void main() {
  testWidgets('日付区切りタイルをタップすると常時非表示設定を保存する', (tester) async {
    final historyConfig = _StubEarthquakeHistoryConfig();
    final container = ProviderContainer(
      overrides: [
        earthquakeHistoryConfigProvider.overrideWith(() => historyConfig),
        homeConfigurationProvider.overrideWith(_StubHomeConfiguration.new),
      ],
    );
    addTearDown(container.dispose);
    await container.read(earthquakeHistoryConfigProvider.future);
    await container.read(homeConfigurationProvider.future);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const EarthquakeHistoryConfigPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final tile = find.text('発生時刻ソート時の日付区切り');
    expect(tile, findsOneWidget);

    await tester.tap(tile);
    await tester.pump();

    expect(historyConfig.savedValue?.list.showDateSeparator, isFalse);
  });
}
