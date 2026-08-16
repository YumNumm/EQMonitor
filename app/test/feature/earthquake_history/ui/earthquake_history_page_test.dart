import 'dart:async';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _LoadingEarthquakeHistoryConfig extends EarthquakeHistoryConfigNotifier {
  @override
  Future<EarthquakeHistoryConfig> build() =>
      Completer<EarthquakeHistoryConfig>().future;
}

void main() {
  testWidgets('一覧設定の読み込み中はスケルトンを表示する', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryConfigProvider.overrideWith(
            _LoadingEarthquakeHistoryConfig.new,
          ),
          earthquakeHistoryDataSourceProvider.overrideWith(
            (ref, parameter) => Completer<EarthquakeHistoryDataSource>().future,
          ),
        ],
        child: const MaterialApp(home: EarthquakeHistoryPage()),
      ),
    );
    await tester.pump();

    expect(find.text('震源地 0'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
