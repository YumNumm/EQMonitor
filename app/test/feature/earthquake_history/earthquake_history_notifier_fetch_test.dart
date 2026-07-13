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
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [EarthquakeHistoryNotifier] の地域種別ごとのルーティングを検証する。
///
/// DataSource 側 (`earthquake_history_data_source_fetch_test.dart`) には
/// 同等のテストが存在していたが、Notifier 側には無かったため
/// `City` が `searchByRegion` に誤ルーティングされる不具合
/// (Exception: Region not found) を長期間見逃していた。
/// 本テストはその回帰防止を目的とする。
void main() {
  Future<_SpyEarthquakeHistoryRepository> readWith(
    EarthquakeHistoryParameter parameter,
  ) async {
    final repository = _SpyEarthquakeHistoryRepository();
    final container = ProviderContainer(
      overrides: [
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);
    await container.read(earthquakeHistoryProvider(parameter).future);
    return repository;
  }

  // 回帰テスト本命: City は searchByCity に流れ、searchByRegion は呼ばれない。
  test(
    'EarthquakeHistoryParameterCity calls searchByCity, not searchByRegion',
    () async {
      final repository = await readWith(
        const EarthquakeHistoryParameter.city(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          cityCode: '4720100',
        ),
      );

      expect(
        repository.searchByCityCodes,
        equals(['4720100']),
        reason: 'searchByCity should be called with the city code',
      );
      expect(
        repository.searchByRegionCodes,
        isEmpty,
        reason: 'searchByRegion must NOT be called for City parameter',
      );
    },
  );

  test('EarthquakeHistoryParameterPrefecture calls searchByPrefecture', () async {
    final repository = await readWith(
      const EarthquakeHistoryParameter.prefecture(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        prefectureCode: '14',
      ),
    );

    expect(repository.searchByPrefectureCodes, equals(['14']));
    expect(repository.searchByRegionCodes, isEmpty);
    expect(repository.searchByCityCodes, isEmpty);
  });

  test('EarthquakeHistoryParameterRegion calls searchByRegion', () async {
    final repository = await readWith(
      const EarthquakeHistoryParameter.region(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        regionCode: '250',
      ),
    );

    expect(repository.searchByRegionCodes, equals(['250']));
    expect(repository.searchByCityCodes, isEmpty);
  });

  test('EarthquakeHistoryParameterStation calls searchByStation', () async {
    final repository = await readWith(
      const EarthquakeHistoryParameter.station(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        stationCode: '4720100',
      ),
    );

    expect(repository.searchByStationCodes, equals(['4720100']));
    expect(repository.searchByRegionCodes, isEmpty);
    expect(repository.searchByCityCodes, isEmpty);
  });
}

// ---------------------------------------------------------------------------
// Spy – EarthquakeHistoryRepository の search メソッド呼び出しを記録する。
// ---------------------------------------------------------------------------

final class _SpyEarthquakeHistoryRepository
    extends EarthquakeHistoryRepository {
  _SpyEarthquakeHistoryRepository()
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      );

  final searchByRegionCodes = <String>[];
  final searchByPrefectureCodes = <String>[];
  final searchByCityCodes = <String>[];
  final searchByStationCodes = <String>[];

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
    searchByRegionCodes.add(code);
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
    searchByPrefectureCodes.add(code);
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
    searchByCityCodes.add(code);
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
    searchByStationCodes.add(code);
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
