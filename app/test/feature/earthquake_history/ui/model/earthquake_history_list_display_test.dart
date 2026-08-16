import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/model/earthquake_history_list_display.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('背景塗りつぶし設定を一覧表示へ反映する', () {
    final display = EarthquakeHistoryListDisplay.resolve(
      config: const EarthquakeHistoryListConfig(isFillBackground: false),
      sortBy: EarthquakeSortBy.eventId,
    );

    expect(display.showBackgroundColor, isFalse);
  });

  test('設定が有効なら発生時刻ソートの昇順・降順で日付区切りを表示できる', () {
    final display = EarthquakeHistoryListDisplay.resolve(
      config: const EarthquakeHistoryListConfig(),
      sortBy: EarthquakeSortBy.eventId,
    );

    expect(display.showDateSeparator, isTrue);
  });

  test('設定が無効なら発生時刻ソートでも日付区切りを表示しない', () {
    final display = EarthquakeHistoryListDisplay.resolve(
      config: const EarthquakeHistoryListConfig(showDateSeparator: false),
      sortBy: EarthquakeSortBy.eventId,
    );

    expect(display.showDateSeparator, isFalse);
  });

  test('発生時刻以外のソートでは日付区切りを表示しない', () {
    for (final sortBy in EarthquakeSortBy.values.where(
      (value) => value != EarthquakeSortBy.eventId,
    )) {
      final display = EarthquakeHistoryListDisplay.resolve(
        config: const EarthquakeHistoryListConfig(),
        sortBy: sortBy,
      );

      expect(display.showDateSeparator, isFalse, reason: sortBy.name);
    }
  });
}
