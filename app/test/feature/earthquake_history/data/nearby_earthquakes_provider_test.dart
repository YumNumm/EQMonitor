import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart' as app;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/nearby_earthquakes_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('検索範囲と並び順を渡し、自身を除外して最大5件を返す', () async {
    final repository = _SpyEarthquakeHistoryRepository(
      items: [
        _earthquake('current'),
        _earthquake('event-1'),
        _earthquake('event-2'),
        _earthquake('event-3'),
        _earthquake('event-4'),
        _earthquake('event-5'),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(
      nearbyEarthquakesProvider(
        const NearbyEarthquakeQuery(
          excludeEventId: 'current',
          latitude: 35,
          longitude: 139,
          depth: 40,
          parameter: NearbyEarthquakeParameter(),
          sortBy: EarthquakeSortBy.maxIntensity,
          sortOrder: SortOrder.desc,
        ),
      ).future,
    );

    expect(repository.limit, 6);
    expect(repository.latitudeGte, 34.5);
    expect(repository.latitudeLte, 35.5);
    expect(repository.longitudeGte, 138.5);
    expect(repository.longitudeLte, 139.5);
    expect(repository.depthGte, 0);
    expect(repository.depthLte, 90);
    expect(repository.sortBy, EarthquakeSortBy.maxIntensity);
    expect(repository.sortOrder, SortOrder.desc);
    expect(result.map((item) => item.earthquake.eventId), [
      'event-1',
      'event-2',
      'event-3',
      'event-4',
      'event-5',
    ]);
  });

  test('深さ不明ならRepositoryへ深さ条件を渡さない', () async {
    final repository = _SpyEarthquakeHistoryRepository(items: const []);
    final container = ProviderContainer(
      overrides: [
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(
      nearbyEarthquakesProvider(
        const NearbyEarthquakeQuery(
          excludeEventId: 'current',
          latitude: 35,
          longitude: 139,
          depth: null,
          parameter: NearbyEarthquakeParameter(),
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.asc,
        ),
      ).future,
    );

    expect(repository.depthGte, isNull);
    expect(repository.depthLte, isNull);
  });
}

EarthquakePartialNormal _earthquake(String eventId) => EarthquakePartialNormal(
  eventId: eventId,
  status: app.TelegramStatus.normal,
  originTime: null,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);

final class _SpyEarthquakeHistoryRepository
    extends EarthquakeHistoryRepository {
  _SpyEarthquakeHistoryRepository({required this.items})
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      );

  final List<EarthquakePartialNormal> items;
  int? limit;
  int? depthGte;
  int? depthLte;
  double? latitudeGte;
  double? latitudeLte;
  double? longitudeGte;
  double? longitudeLte;
  EarthquakeSortBy? sortBy;
  SortOrder? sortOrder;

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
    this.limit = limit;
    this.depthGte = depthGte;
    this.depthLte = depthLte;
    this.latitudeGte = latitudeGte;
    this.latitudeLte = latitudeLte;
    this.longitudeGte = longitudeGte;
    this.longitudeLte = longitudeLte;
    this.sortBy = sortBy;
    this.sortOrder = sortOrder;
    return PaginatedResponse(items: items, nextToken: null);
  }
}

const _earthquakeParameter = EarthquakeParameter(
  metadata: ParameterMetadata(
    type: ParameterType.jmaCodeTable,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
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
