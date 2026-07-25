import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('details キーの無い保存済み JSON からデフォルト値で復元できる', () {
    final config = EarthquakeHistoryConfig.fromJson({
      'list': <String, dynamic>{},
    });

    expect(config.details.stationDisplayMode, StationDisplayMode.auto);
  });

  test('stationDisplayMode を JSON ラウンドトリップできる', () {
    const config = EarthquakeHistoryConfig(
      list: EarthquakeHistoryListConfig(),
      details: EarthquakeHistoryDetailsConfig(
        stationDisplayMode: StationDisplayMode.allMinimized,
      ),
    );

    final restored = EarthquakeHistoryConfig.fromJson(config.toJson());

    expect(
      restored.details.stationDisplayMode,
      StationDisplayMode.allMinimized,
    );
  });
}
