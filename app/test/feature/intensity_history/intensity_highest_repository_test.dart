import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_intensity_page.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

EarthquakePartial _partial(String eventId) => EarthquakePartial(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTimePrecision: OriginTimePrecision.second,
  datasource: EarthquakeDatasource.jmaDisasterInformationXml,
  telegramTypes: const [],
  earthquakeType: EarthquakeType.normal,
);

HighestIntensityItem _item({
  required String code,
  required String name,
  required JmaIntensity intensity,
}) => HighestIntensityItem(
  code: code,
  name: name,
  intensity: intensity,
  count: 3,
  earthquake: _partial('evt-$code'),
);

IntensityCitySearchItem _citySearchItem(JmaIntensity intensity) =>
    IntensityCitySearchItem(
      intensity: intensity,
      earthquake: _partial('evt-city'),
    );

// ---------------------------------------------------------------------------
// Fake repository
// ---------------------------------------------------------------------------

class _FakeIntensityHighestRepository extends IntensityHighestRepository {
  _FakeIntensityHighestRepository()
    : super(earthquake: ApiClient(Dio()).earthquake);

  List<HighestIntensityItem> prefectureItems = const [];
  List<HighestIntensityItem> cityItems = const [];
  List<IntensityCitySearchItem> cityIntensityItems = const [];
  String? nextToken;

  @override
  Future<List<HighestIntensityEntry>> fetchPrefectureHighest() async {
    return prefectureItems.map(HighestIntensityEntry.fromApi).toList();
  }

  @override
  Future<List<HighestIntensityEntry>> fetchCityHighest(
    String prefectureCode,
  ) async {
    return cityItems.map(HighestIntensityEntry.fromApi).toList();
  }

  @override
  Future<CityIntensityPage> fetchCityIntensityList({
    required String cityCode,
    required int limit,
    String? cursor,
  }) async {
    return CityIntensityPage(
      items: cityIntensityItems,
      nextToken: nextToken,
    );
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('HighestIntensityEntry.fromApi', () {
    test('HighestIntensityItem を HighestIntensityEntry に変換できる', () {
      final apiItem = _item(
        code: '010101',
        name: 'テスト地域',
        intensity: JmaIntensity.value4,
      );
      final entry = HighestIntensityEntry.fromApi(apiItem);
      expect(entry.code, '010101');
      expect(entry.name, 'テスト地域');
      expect(entry.intensity, JmaIntensity.value4);
      expect(entry.count, 3);
      expect(entry.earthquake.eventId, 'evt-010101');
    });
  });

  group('IntensityHighestRepository.fetchPrefectureHighest', () {
    test('items を HighestIntensityEntry のリストに変換して返す', () async {
      final repo = _FakeIntensityHighestRepository()
        ..prefectureItems = [
          _item(code: '0100', name: '北海道', intensity: JmaIntensity.value5plus),
          _item(code: '0200', name: '青森県', intensity: JmaIntensity.value3),
        ];

      final result = await repo.fetchPrefectureHighest();
      expect(result.length, 2);
      expect(result[0].code, '0100');
      expect(result[0].intensity, JmaIntensity.value5plus);
      expect(result[1].code, '0200');
      expect(result[1].intensity, JmaIntensity.value3);
    });
  });

  group('IntensityHighestRepository.fetchCityHighest', () {
    test('cityItems を HighestIntensityEntry のリストに変換して返す', () async {
      final repo = _FakeIntensityHighestRepository()
        ..cityItems = [
          _item(
            code: '0110100',
            name: '札幌市中央区',
            intensity: JmaIntensity.value4,
          ),
        ];

      final result = await repo.fetchCityHighest('0100');
      expect(result.length, 1);
      expect(result[0].code, '0110100');
      expect(result[0].intensity, JmaIntensity.value4);
    });
  });

  group('IntensityHighestRepository.fetchCityIntensityList', () {
    test('items と nextToken を CityIntensityPage に詰めて返す', () async {
      final repo = _FakeIntensityHighestRepository()
        ..cityIntensityItems = [
          _citySearchItem(JmaIntensity.value3),
          _citySearchItem(JmaIntensity.value4),
        ]
        ..nextToken = 'next-cursor';

      final page = await repo.fetchCityIntensityList(
        cityCode: '0110100',
        cursor: null,
        limit: 20,
      );
      expect(page.items.length, 2);
      expect(page.nextToken, 'next-cursor');
      expect(page.items[0].intensity, JmaIntensity.value3);
    });

    test('nextToken が null の場合は CityIntensityPage.nextToken が null', () async {
      final repo = _FakeIntensityHighestRepository()
        ..cityIntensityItems = []
        ..nextToken = null;

      final page = await repo.fetchCityIntensityList(
        cityCode: '0110100',
        cursor: null,
        limit: 20,
      );
      expect(page.nextToken, isNull);
    });
  });
}
