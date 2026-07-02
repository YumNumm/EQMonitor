// 同梱アセットとモデルの契約ズレを CI で検出するための回帰テスト。
// flutter test の cwd は app/ なので assets/parameters/... の相対パスで読める。
import 'dart:io';

import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const parser = ParameterJsonParser();

  test('同梱パラメータアセット全体が例外なくパースできる', () {
    final manifestJson =
        File('assets/parameters/manifest.json').readAsStringSync();
    final parameterJsonByType = {
      for (final type in ParameterType.values)
        type: File('assets/parameters/${type.pathSegment}.json')
            .readAsStringSync(),
    };

    final result = parser.parseSet(
      manifestJson: manifestJson,
      parameterJsonByType: parameterJsonByType,
    );

    // 地震観測点データが空でないこと
    expect(result.earthquake.prefectures, isNotEmpty);

    // 全 station の status が enum 値として解決されていること(パース成功が主目的)
    final allStations = result.earthquake.prefectures
        .expand((pref) => pref.regions)
        .expand((region) => region.cities)
        .expand((city) => city.stations);
    for (final station in allStations) {
      expect(EarthquakeStationStatus.values, contains(station.status));
    }
  });
}
