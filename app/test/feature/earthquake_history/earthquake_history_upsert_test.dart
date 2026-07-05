import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart' as app;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

void main() {
  // 1. eventId 降順 (desc) のデータソースに既存より新しい eventId を upsert
  //    → index 0 に挿入される
  test(
    'upsertItems: desc order — newer eventId is inserted at index 0',
    () async {
      final repository = _FakeEarthquakeHistoryRepository(
        items: [_makeEarthquake('20240102'), _makeEarthquake('20240101')],
      );
      const parameter = EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.refresh();

      dataSource.upsertItems([_makeEarthquake('20240103')]);

      final values = dataSource.notifier.values;
      expect(values.length, 3);
      expect(values[0].earthquake.eventId, '20240103');
      expect(values[1].earthquake.eventId, '20240102');
      expect(values[2].earthquake.eventId, '20240101');
    },
  );

  // 2. eventId 降順 (desc) のデータソースに同じ eventId を upsert
  //    → その位置で置換される
  test(
    'upsertItems: desc order — same eventId replaces item in place',
    () async {
      final repository = _FakeEarthquakeHistoryRepository(
        items: [_makeEarthquake('20240102'), _makeEarthquake('20240101')],
      );
      const parameter = EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.refresh();

      dataSource.upsertItems([_makeEarthquake('20240102')]);

      final values = dataSource.notifier.values;
      expect(values.length, 2);
      expect(values[0].earthquake.eventId, '20240102');
      expect(values[1].earthquake.eventId, '20240101');
    },
  );

  // 3. eventId 昇順 (asc) のデータソースに既存より新しい eventId を upsert
  //    → 末尾に挿入される
  test(
    'upsertItems: asc order — newer eventId is inserted at the end',
    () async {
      final repository = _FakeEarthquakeHistoryRepository(
        items: [_makeEarthquake('20240101'), _makeEarthquake('20240102')],
      );
      const parameter = EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.asc,
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.refresh();

      dataSource.upsertItems([_makeEarthquake('20240103')]);

      final values = dataSource.notifier.values;
      expect(values.length, 3);
      expect(values[0].earthquake.eventId, '20240101');
      expect(values[1].earthquake.eventId, '20240102');
      expect(values[2].earthquake.eventId, '20240103');
    },
  );

  // 4. sortBy: magnitude の場合 upsert しても items が変化しない (no-op)
  test('upsertItems: non-eventId sortBy — upsert is a no-op', () async {
    final repository = _FakeEarthquakeHistoryRepository(
      items: [_makeEarthquake('20240101')],
    );
    const parameter = EarthquakeHistoryParameter.all(
      sortBy: EarthquakeSortBy.magnitude,
      sortOrder: SortOrder.desc,
    );
    final dataSource = EarthquakeHistoryDataSource(
      repository: repository,
      parameter: parameter,
    );
    addTearDown(dataSource.dispose);

    await dataSource.refresh();

    dataSource.upsertItems([_makeEarthquake('20240102')]);

    final values = dataSource.notifier.values;
    expect(values.length, 1);
    expect(values[0].earthquake.eventId, '20240101');
  });
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

const _parameterMetadata = ParameterMetadata(
  type: ParameterType.jmaCodeTable,
  schemaVersion: 1,
  sourceVersion: 'test',
  sourceUpdatedAt: null,
  sourceUrls: [],
  sha256: 'test',
);

const _earthquakeParameter = EarthquakeParameter(
  metadata: _parameterMetadata,
  prefectures: [],
);

const _shindoDbStations = ShindoDbStationsParameter(
  metadata: ParameterMetadata(
    type: ParameterType.shindoDbStations,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  stations: [],
);

EarthquakePartialNormal _makeEarthquake(String eventId) =>
    EarthquakePartialNormal(
      eventId: eventId,
      status: app.TelegramStatus.normal,
      originTime: null,
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSources: [EarthquakeDataSource.jmaDisasterInformationXml],
      hypocenter: null,
      intensity: null,
      earthquakeType: EarthquakeType.normal,
      telegramTypes: const [],
      estimatedIntensityTileUrl: null,
    );

/// [EarthquakeHistoryRepository] の Fake 実装。
/// コンストラクタで渡した [items] を fetchEarthquakeList で返す。
final class _FakeEarthquakeHistoryRepository
    extends EarthquakeHistoryRepository {
  _FakeEarthquakeHistoryRepository({required this.items})
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      );

  final List<EarthquakePartialNormal> items;

  @override
  Future<PaginatedResponse<EarthquakePartial>> fetchEarthquakeList({
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    List<app.TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    EarthquakeType? earthquakeType,
    EarthquakeDataSource? datasource,
    List<EarthquakeTelegramType>? telegramTypes,
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    double? latitudeGte,
    double? latitudeLte,
    double? longitudeGte,
    double? longitudeLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async => PaginatedResponse(items: items, nextToken: null);
}
