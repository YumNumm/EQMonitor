import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/prefecture_intensity_page.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_intensity_list_data_source.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

const _parameter = EarthquakeParameter(
  metadata: ParameterMetadata(
    type: ParameterType.earthquakeStations,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  prefectures: [],
);

EarthquakePartial _earthquake(String eventId) => EarthquakePartial(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: null,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSource: EarthquakeDataSource.jmaIntensityDatabase,
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);

IntensityAreaSearchItem _item({
  JmaIntensity? intensity = JmaIntensity.one,
}) => IntensityAreaSearchItem(
  eventId: 'e1',
  area: IntensityAreaInfo(
    code: '0400',
    name: '宮城県',
    intensity: intensity,
    lpgmIntensity: null,
  ),
  earthquake: _earthquake('e1'),
);

class _FakePrefectureIntensityRepository extends IntensityHighestRepository {
  _FakePrefectureIntensityRepository()
    : super(earthquake: api.ApiClient(Dio()).earthquake);

  final cursors = <String?>[];
  String? nextToken;
  List<IntensityAreaSearchItem> items = const [];

  @override
  Future<PrefectureIntensityPage> fetchPrefectureIntensityList({
    required String prefectureCode,
    required String prefectureName,
    required EarthquakeParameter parameter,
    required int limit,
    String? cursor,
  }) async {
    cursors.add(cursor);
    return PrefectureIntensityPage(items: items, nextToken: nextToken);
  }
}

PrefectureIntensityListDataSource _dataSource(
  _FakePrefectureIntensityRepository repository,
) => PrefectureIntensityListDataSource(
  repository: repository,
  prefectureCode: '0400',
  prefectureName: '宮城県',
  parameter: _parameter,
);

void main() {
  group('PrefectureIntensityListDataSource.groupBy', () {
    test('震度ラベルでグループ化', () {
      final ds = _dataSource(_FakePrefectureIntensityRepository());
      final key = ds.groupBy(_item(intensity: JmaIntensity.fiveUpper));
      expect(key, '震度5+');
    });

    test('震度がない場合は不明でグループ化', () {
      final ds = _dataSource(_FakePrefectureIntensityRepository());
      expect(ds.groupBy(_item(intensity: null)), '震度不明');
    });
  });

  group('PrefectureIntensityListDataSource.load', () {
    test('Refresh は cursor=null で10件取得し、Append は追加取得しない', () async {
      final repo = _FakePrefectureIntensityRepository()
        ..items = [_item()]
        ..nextToken = 'next-1';
      final ds = _dataSource(repo);

      final refresh = await ds.load(const Refresh());
      expect(refresh, isA<Success<String?, IntensityAreaSearchItem>>());

      await ds.load(const Append(key: 'next-1'));

      expect(repo.cursors, [null]);
    });

    test('Success の appendKey は null になる', () async {
      final repo = _FakePrefectureIntensityRepository()
        ..items = [_item()]
        ..nextToken = 'tok';
      final ds = _dataSource(repo);
      final result = await ds.load(const Refresh());
      final success = result as Success<String?, IntensityAreaSearchItem>;
      expect(success.page.appendKey, isNull);
      expect(success.page.data.single.earthquake.eventId, 'e1');
    });
  });
}
