import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_intensity_page.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_intensity_list_data_source.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

IntensityCitySearchItem _item({DateTime? originTime}) =>
    IntensityCitySearchItem(
      intensity: JmaIntensity.value1,
      earthquake: EarthquakePartial(
        eventId: 'e1',
        status: TelegramStatus.normal,
        originTimePrecision: OriginTimePrecision.second,
        datasource: EarthquakeDatasource.jmaIntensityDatabase,
        telegramTypes: [],
        earthquakeType: EarthquakeType.normal,
        originTime: originTime,
      ),
    );

class _FakeCityIntensityRepository extends IntensityHighestRepository {
  _FakeCityIntensityRepository()
    : super(earthquake: api.ApiClient(Dio()).earthquake);

  final cursors = <String?>[];
  String? nextToken;
  List<IntensityCitySearchItem> items = const [];

  @override
  Future<CityIntensityPage> fetchCityIntensityList({
    required String cityCode,
    required int limit,
    String? cursor,
  }) async {
    cursors.add(cursor);
    return CityIntensityPage(items: items, nextToken: nextToken);
  }
}

void main() {
  group('CityIntensityListDataSource.groupBy', () {
    test('originTime をローカル日付 yyyy/MM/dd でグループ化', () {
      final ds = CityIntensityListDataSource(
        repository: _FakeCityIntensityRepository(),
        cityCode: 'city-1',
      );
      final key = ds.groupBy(_item(originTime: DateTime.utc(2026, 6, 27)));
      // ローカルタイムに依存するため、形式(8文字 + 区切り)のみ検証
      expect(key, matches(r'^\d{4}/\d{2}/\d{2}$'));
    });

    test('originTime が null のとき "不明" を返す', () {
      final ds = CityIntensityListDataSource(
        repository: _FakeCityIntensityRepository(),
        cityCode: 'city-1',
      );
      final key = ds.groupBy(_item());
      expect(key, '不明');
    });
  });

  group('CityIntensityListDataSource.load', () {
    test('Refresh は cursor=null、Append は受け取った key を渡す', () async {
      final repo = _FakeCityIntensityRepository()
        ..items = [_item(originTime: DateTime.utc(2026, 6, 27))]
        ..nextToken = 'next-1';
      final ds = CityIntensityListDataSource(
        repository: repo,
        cityCode: 'city-1',
      );

      final refresh = await ds.load(const Refresh());
      expect(refresh, isA<Success<String?, IntensityCitySearchItem>>());
      await ds.load(const Append(key: 'next-1'));

      expect(repo.cursors, [null, 'next-1']);
    });

    test('Success の appendKey に nextToken が入る', () async {
      final repo = _FakeCityIntensityRepository()
        ..items = [_item(originTime: DateTime.utc(2026, 6, 27))]
        ..nextToken = 'tok';
      final ds = CityIntensityListDataSource(
        repository: repo,
        cityCode: 'city-1',
      );
      final result = await ds.load(const Refresh());
      final success = result as Success<String?, IntensityCitySearchItem>;
      expect(success.page.appendKey, 'tok');
      expect(success.page.data.single.earthquake.eventId, 'e1');
    });
  });
}
