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
  // 1. City パラメータで searchByCity が呼ばれ searchByRegion は呼ばれない
  test(
    'EarthquakeHistoryParameterCity calls searchByCity, not searchByRegion',
    () async {
      final repository = _SpyEarthquakeHistoryRepository();
      const parameter = EarthquakeHistoryParameter.city(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        cityCode: '4720100',
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.load(const Refresh());

      expect(
        repository.searchByCityCalls,
        isNotEmpty,
        reason: 'searchByCity should be called',
      );
      expect(repository.searchByCityCalls.first['code'], equals('4720100'));
      expect(
        repository.searchByRegionCalls,
        isEmpty,
        reason: 'searchByRegion must NOT be called for City parameter',
      );
    },
  );

  // 2. All パラメータで statuses/datasource/telegramTypes/latitude*/longitude* が転送される
  test(
    'EarthquakeHistoryParameterAll forwards statuses, datasource, telegramTypes, '
    'latitudeGte, latitudeLte, longitudeGte, longitudeLte',
    () async {
      final repository = _SpyEarthquakeHistoryRepository();
      const parameter = EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        statuses: [app.TelegramStatus.training],
        datasource: EarthquakeDataSource.jmaIntensityDatabase,
        telegramTypes: [EarthquakeTelegramType.vxse53],
        latitudeGte: 30,
        latitudeLte: 45,
        longitudeGte: 130,
        longitudeLte: 145,
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.load(const Refresh());

      expect(repository.fetchEarthquakeListCalls, isNotEmpty);
      final call = repository.fetchEarthquakeListCalls.first;
      expect(call['statuses'], equals([app.TelegramStatus.training]));
      expect(
        call['datasource'],
        equals(EarthquakeDataSource.jmaIntensityDatabase),
      );
      expect(call['telegramTypes'], equals([EarthquakeTelegramType.vxse53]));
      expect(call['latitudeGte'], equals(30.0));
      expect(call['latitudeLte'], equals(45.0));
      expect(call['longitudeGte'], equals(130.0));
      expect(call['longitudeLte'], equals(145.0));
    },
  );

  // 3. Prefecture パラメータで statuses が転送される
  test(
    'EarthquakeHistoryParameterPrefecture forwards statuses to searchByPrefecture',
    () async {
      final repository = _SpyEarthquakeHistoryRepository();
      const parameter = EarthquakeHistoryParameter.prefecture(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        prefectureCode: '010006',
        statuses: [app.TelegramStatus.training],
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.load(const Refresh());

      expect(repository.searchByPrefectureCalls, isNotEmpty);
      expect(
        repository.searchByPrefectureCalls.first['statuses'],
        equals([app.TelegramStatus.training]),
      );
    },
  );

  // 4. Region パラメータで statuses が転送される
  test(
    'EarthquakeHistoryParameterRegion forwards statuses to searchByRegion',
    () async {
      final repository = _SpyEarthquakeHistoryRepository();
      const parameter = EarthquakeHistoryParameter.region(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        regionCode: '010100',
        statuses: [app.TelegramStatus.training],
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.load(const Refresh());

      expect(repository.searchByRegionCalls, isNotEmpty);
      expect(
        repository.searchByRegionCalls.first['statuses'],
        equals([app.TelegramStatus.training]),
      );
    },
  );

  // 5. Station パラメータで statuses が転送される
  test(
    'EarthquakeHistoryParameterStation forwards statuses to searchByStation',
    () async {
      final repository = _SpyEarthquakeHistoryRepository();
      const parameter = EarthquakeHistoryParameter.station(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        stationCode: '4720100',
        statuses: [app.TelegramStatus.training],
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      await dataSource.load(const Refresh());

      expect(repository.searchByStationCalls, isNotEmpty);
      expect(
        repository.searchByStationCalls.first['statuses'],
        equals([app.TelegramStatus.training]),
      );
    },
  );

  test(
    'default All refresh returns Failure when network fetch fails',
    () async {
      final repository = _SpyEarthquakeHistoryRepository(throwOnFetch: true);
      const parameter = EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      );
      final dataSource = EarthquakeHistoryDataSource(
        repository: repository,
        parameter: parameter,
      );
      addTearDown(dataSource.dispose);

      final result = await dataSource.load(const Refresh());

      expect(result, isA<Failure<String?, EarthquakePartial>>());
      expect(repository.fetchEarthquakeListCalls, hasLength(1));
    },
  );
}

// ---------------------------------------------------------------------------
// Spy (手書き Fake) – EarthquakeHistoryRepository のすべての search/fetch メソッドを
// 記録する。実際の API 呼び出しは行わない。
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

final class _SpyEarthquakeHistoryRepository
    extends EarthquakeHistoryRepository {
  _SpyEarthquakeHistoryRepository({this.throwOnFetch = false})
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      );

  final bool throwOnFetch;

  final fetchEarthquakeListCalls = <Map<String, Object?>>[];
  final searchByRegionCalls = <Map<String, Object?>>[];
  final searchByPrefectureCalls = <Map<String, Object?>>[];
  final searchByCityCalls = <Map<String, Object?>>[];
  final searchByStationCalls = <Map<String, Object?>>[];

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
    api.ApiClient? client,
  }) async {
    fetchEarthquakeListCalls.add({
      'limit': limit,
      'cursor': cursor,
      'statuses': statuses,
      'datasource': datasource,
      'telegramTypes': telegramTypes,
      'latitudeGte': latitudeGte,
      'latitudeLte': latitudeLte,
      'longitudeGte': longitudeGte,
      'longitudeLte': longitudeLte,
    });
    if (throwOnFetch) {
      throw Exception('network failure');
    }
    return PaginatedResponse(
      items: [_makeEarthquake('event-1')],
      nextToken: null,
    );
  }

  @override
  Future<PaginatedResponse<EarthquakePartialRegion>> searchByRegion({
    required String code,
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
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    searchByRegionCalls.add({'code': code, 'statuses': statuses});
    return PaginatedResponse(
      items: [
        EarthquakePartialRegion(
          regionIntensity: JmaIntensity.three,
          earthquake: _makeEarthquake('event-region'),
        ),
      ],
      nextToken: null,
    );
  }

  @override
  Future<PaginatedResponse<EarthquakePartialPrefecture>> searchByPrefecture({
    required String code,
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
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    searchByPrefectureCalls.add({'code': code, 'statuses': statuses});
    return PaginatedResponse(
      items: [
        EarthquakePartialPrefecture(
          prefectureIntensity: JmaIntensity.three,
          earthquake: _makeEarthquake('event-prefecture'),
        ),
      ],
      nextToken: null,
    );
  }

  @override
  Future<PaginatedResponse<EarthquakePartialRegion>> searchByCity({
    required String code,
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
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    searchByCityCalls.add({'code': code, 'statuses': statuses});
    return PaginatedResponse(
      items: [
        EarthquakePartialRegion(
          regionIntensity: JmaIntensity.three,
          earthquake: _makeEarthquake('event-city'),
        ),
      ],
      nextToken: null,
    );
  }

  @override
  Future<PaginatedResponse<EarthquakePartialStation>> searchByStation({
    required String code,
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
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    searchByStationCalls.add({'code': code, 'statuses': statuses});
    return PaginatedResponse(
      items: [
        EarthquakePartialStation(
          stationIntensity: JmaIntensity.three,
          earthquake: _makeEarthquake('event-station'),
        ),
      ],
      nextToken: null,
    );
  }
}
