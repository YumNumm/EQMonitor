import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_region_search.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

class EarthquakeSearchFixture {
  static const parameter = EarthquakeParameter(
    metadata: ParameterMetadata(
      type: ParameterType.earthquakeStations,
      schemaVersion: 1,
      sourceVersion: 'test',
      sourceUpdatedAt: null,
      sourceUrls: [],
      sha256: 'test',
    ),
    prefectures: [
      EarthquakeParameterPrefectureItem(
        code: '13',
        name: LocalizedName(ja: '東京都', en: 'Tokyo'),
        regions: [
          EarthquakeParameterRegionItem(
            code: '350',
            name: LocalizedName(ja: '東京都多摩東部'),
            kana: 'とうきょうとたまとうぶ',
            cities: [
              EarthquakeParameterCityItem(
                code: '1320600',
                name: LocalizedName(ja: '府中市'),
                kana: 'ふちゅうし',
                stations: [],
              ),
            ],
          ),
        ],
      ),
      EarthquakeParameterPrefectureItem(
        code: '34',
        name: LocalizedName(ja: '広島県'),
        regions: [
          EarthquakeParameterRegionItem(
            code: '671',
            name: LocalizedName(ja: '広島県南東部'),
            kana: null,
            cities: [
              EarthquakeParameterCityItem(
                code: '3420800',
                name: LocalizedName(ja: '府中市'),
                kana: 'ふちゅうし',
                stations: [],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

void main() {
  const search = EarthquakeRegionSearch();
  test('空白や未対応の自由文を全国検索に置き換えない', () {
    for (final query in ['', '  ', '昨日の東京の震度3以上', '存在しない地域']) {
      expect(
        search.search(
          parameter: EarthquakeSearchFixture.parameter,
          query: query,
        ),
        isEmpty,
      );
    }
  });
  test('都道府県の英語名は大文字小文字と前後の空白を無視する', () {
    final result = search.search(
      parameter: EarthquakeSearchFixture.parameter,
      query: ' TOKYO ',
    );
    expect(result.single.name, '東京都');
    expect(
      result.single.parameter,
      const EarthquakeHistoryParameter.prefecture(
        sortBy: .eventId,
        sortOrder: .desc,
        prefectureCode: '13',
      ),
    );
  });
  test('地域名と読み仮名から正しい地域コードを返す', () {
    for (final query in ['多摩東部', 'とうきょうとたまとうぶ']) {
      final result = search.search(
        parameter: EarthquakeSearchFixture.parameter,
        query: query,
      );
      expect(
        result.single.parameter,
        const EarthquakeHistoryParameter.region(
          sortBy: .eventId,
          sortOrder: .desc,
          regionCode: '350',
        ),
      );
    }
  });
  test('同名の市を自動選択せず、所属地域を表示した候補にする', () {
    final results = search.search(
      parameter: EarthquakeSearchFixture.parameter,
      query: '府中市',
    );
    expect(results, hasLength(2));
    expect(results.first.areaDescription, '東京都・東京都多摩東部');
    expect(results.last.areaDescription, '広島県・広島県南東部');
    expect(
      results.first.parameter,
      const EarthquakeHistoryParameter.city(
        sortBy: .eventId,
        sortOrder: .desc,
        cityCode: '1320600',
      ),
    );
    expect(
      results.last.parameter,
      const EarthquakeHistoryParameter.city(
        sortBy: .eventId,
        sortOrder: .desc,
        cityCode: '3420800',
      ),
    );
  });
}
