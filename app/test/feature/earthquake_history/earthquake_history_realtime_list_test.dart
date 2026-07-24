import 'dart:async';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart' as app;
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';

void main() {
  test('初回REST中の新規upsertを保持してREST結果とeventId順に統合する', () async {
    final initialResult = Completer<PaginatedResponse<EarthquakePartial>>();
    final repository = _CompletingListRepository([initialResult.future]);
    final dataSource = EarthquakeHistoryDataSource(
      repository: repository,
      parameter: const EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      ),
    );
    addTearDown(dataSource.dispose);

    final loading = dataSource.load(const Refresh());
    await Future<void>.delayed(Duration.zero);
    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724020000',
        earthquakeType: api.EarthquakeType.normal,
      ),
    );
    initialResult.complete(
      PaginatedResponse(
        items: [
          const api.EarthquakePartial(
            eventId: '20260724010000',
            status: api.TelegramStatus.normal,
            earthquakeType: api.EarthquakeType.distant,
            originTimePrecision: api.OriginTimePrecision.second,
            datasources: [api.EarthquakeDatasource.jmaDisasterInformationXml],
            telegramTypes: [],
          ).toEarthquakePartial(parameter: _earthquakeParameter),
        ],
        nextToken: null,
      ),
    );
    final result = await loading;
    final items = switch (result) {
      Success(:final page) => page.data,
      _ => fail('initial load must succeed'),
    };

    expect(items.map((item) => item.earthquake.eventId).toList(), [
      '20260724020000',
      '20260724010000',
    ]);
    expect(items.first.earthquake.earthquakeType.name, 'normal');
  });

  test('existing itemのearthquakeTypeをfull recordの値で更新する', () {
    final repository = _CompletingListRepository([]);
    final dataSource = _dataSource(repository: repository);
    addTearDown(dataSource.dispose);
    dataSource.upsertItems([
      _partial(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.distant,
      ),
    ]);

    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.normal,
      ),
    );

    expect(
      dataSource.notifier.values.single.earthquake.earthquakeType.name,
      'normal',
    );
  });

  test('all filterのmembershipをfull recordで追加・削除する', () {
    final repository = _CompletingListRepository([]);
    final dataSource = _dataSource(
      repository: repository,
      parameter: const EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        earthquakeType: EarthquakeType.distant,
      ),
    );
    addTearDown(dataSource.dispose);

    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.distant,
      ),
    );
    expect(dataSource.notifier.values, hasLength(1));

    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.normal,
      ),
    );
    expect(dataSource.notifier.values, isEmpty);
  });

  test('region filterのcodeとintensityでmembershipを更新する', () {
    final repository = _CompletingListRepository([]);
    final dataSource = _dataSource(
      repository: repository,
      parameter: const EarthquakeHistoryParameter.region(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        regionCode: '010100',
        intensityGte: JmaIntensity.three,
      ),
    );
    addTearDown(dataSource.dispose);

    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.normal,
        intensity: const api.Intensity(
          maxIntensity: api.JmaIntensity.value4,
          intensityTree: [
            api.IntensityTree(
              intensity: api.JmaIntensity.value4,
              regions: ['010100'],
            ),
          ],
        ),
      ),
    );
    expect(dataSource.notifier.values.single, isA<EarthquakePartialRegion>());

    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.normal,
        intensity: const api.Intensity(
          maxIntensity: api.JmaIntensity.value2,
          intensityTree: [
            api.IntensityTree(
              intensity: api.JmaIntensity.value2,
              regions: ['010100'],
            ),
          ],
        ),
      ),
    );
    expect(dataSource.notifier.values, isEmpty);
  });

  test('region filterはtype・epicenter・maxLpgmの共通条件でも出入りする', () {
    final repository = _CompletingListRepository([]);
    final dataSource = _dataSource(
      repository: repository,
      parameter: const EarthquakeHistoryParameter.region(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        regionCode: '010100',
        earthquakeType: EarthquakeType.distant,
        epicenterCodes: [100],
        maxLpgmIntensityGte: JmaLpgmIntensity.two,
      ),
    );
    addTearDown(dataSource.dispose);

    void apply({
      api.EarthquakeType type = api.EarthquakeType.distant,
      String epicenterCode = '100',
      api.JmaLpgmIntensity lpgm = api.JmaLpgmIntensity.value2,
    }) => dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: type,
        epicenterCode: epicenterCode,
        intensity: api.Intensity(
          maxIntensity: api.JmaIntensity.value4,
          maxLpgmIntensity: lpgm,
          intensityTree: const [
            api.IntensityTree(
              intensity: api.JmaIntensity.value4,
              regions: ['010100'],
            ),
          ],
        ),
      ),
    );

    apply();
    expect(dataSource.notifier.values, hasLength(1));
    apply(type: api.EarthquakeType.normal);
    expect(dataSource.notifier.values, isEmpty);
    apply();
    apply(epicenterCode: '200');
    expect(dataSource.notifier.values, isEmpty);
    apply();
    apply(lpgm: api.JmaLpgmIntensity.value1);
    expect(dataSource.notifier.values, isEmpty);
  });

  test('station filterはtype・epicenter・maxLpgmの共通条件でも出入りする', () {
    final repository = _CompletingListRepository([]);
    final dataSource = _dataSource(
      repository: repository,
      parameter: const EarthquakeHistoryParameter.station(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        stationCode: '0123456',
        earthquakeType: EarthquakeType.distant,
        epicenterCodes: [100],
        maxLpgmIntensityGte: JmaLpgmIntensity.two,
      ),
    );
    addTearDown(dataSource.dispose);

    void apply({
      api.EarthquakeType type = api.EarthquakeType.distant,
      String epicenterCode = '100',
      api.JmaLpgmIntensity lpgm = api.JmaLpgmIntensity.value2,
    }) => dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: type,
        epicenterCode: epicenterCode,
        intensity: api.Intensity(
          maxIntensity: api.JmaIntensity.value4,
          maxLpgmIntensity: lpgm,
          intensityTree: const [
            api.IntensityTree(
              intensity: api.JmaIntensity.value4,
              regions: [],
              stations: ['0123456'],
            ),
          ],
        ),
      ),
    );

    apply();
    expect(dataSource.notifier.values, hasLength(1));
    apply(type: api.EarthquakeType.normal);
    expect(dataSource.notifier.values, isEmpty);
    apply();
    apply(epicenterCode: '200');
    expect(dataSource.notifier.values, isEmpty);
    apply();
    apply(lpgm: api.JmaLpgmIntensity.value1);
    expect(dataSource.notifier.values, isEmpty);
  });

  test('prefecture filterは既存membershipだけを更新し新規を推測しない', () {
    final repository = _CompletingListRepository([]);
    final dataSource = _dataSource(
      repository: repository,
      parameter: const EarthquakeHistoryParameter.prefecture(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        prefectureCode: '01',
      ),
    );
    addTearDown(dataSource.dispose);
    dataSource.upsertItems([
      EarthquakePartial.prefecture(
        prefectureIntensity: JmaIntensity.four,
        earthquake: _partial(
          eventId: '20260724010000',
          earthquakeType: api.EarthquakeType.distant,
        ),
      ),
    ]);

    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.normal,
      ),
    );
    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724020000',
        earthquakeType: api.EarthquakeType.normal,
      ),
    );

    final item = dataSource.notifier.values.single;
    expect(item, isA<EarthquakePartialPrefecture>());
    expect(item.earthquake.earthquakeType, EarthquakeType.normal);
    expect(
      (item as EarthquakePartialPrefecture).prefectureIntensity,
      JmaIntensity.four,
    );
  });

  test('初回REST中のdelete tombstoneが古いREST itemを復活させない', () async {
    final initialResult = Completer<PaginatedResponse<EarthquakePartial>>();
    final repository = _CompletingListRepository([initialResult.future]);
    final dataSource = _dataSource(repository: repository);
    addTearDown(dataSource.dispose);

    final loading = dataSource.load(const Refresh());
    await Future<void>.delayed(Duration.zero);
    dataSource.applyRealtimeDelete('20260724010000');
    initialResult.complete(
      PaginatedResponse(
        items: [
          _partial(
            eventId: '20260724010000',
            earthquakeType: api.EarthquakeType.normal,
          ),
        ],
        nextToken: null,
      ),
    );

    final result = await loading;
    expect((result as Success<String?, EarthquakePartial>).page.data, isEmpty);
  });

  test('初回REST中のdelete後upsertはfull stateを復帰する', () async {
    final initialResult = Completer<PaginatedResponse<EarthquakePartial>>();
    final repository = _CompletingListRepository([initialResult.future]);
    final dataSource = _dataSource(repository: repository);
    addTearDown(dataSource.dispose);

    final loading = dataSource.load(const Refresh());
    await Future<void>.delayed(Duration.zero);
    dataSource.applyRealtimeDelete('20260724010000');
    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.distant,
      ),
    );
    initialResult.complete(
      PaginatedResponse(
        items: [
          _partial(
            eventId: '20260724010000',
            earthquakeType: api.EarthquakeType.normal,
          ),
        ],
        nextToken: null,
      ),
    );

    final result = await loading;
    final item =
        (result as Success<String?, EarthquakePartial>).page.data.single;
    expect(item.earthquake.earthquakeType, EarthquakeType.distant);
  });

  test('refresh REST中のupsertを古いREST結果で上書きしない', () async {
    final refreshResult = Completer<PaginatedResponse<EarthquakePartial>>();
    final repository = _CompletingListRepository([
      Future.value(
        PaginatedResponse(
          items: [
            _partial(
              eventId: '20260724010000',
              earthquakeType: api.EarthquakeType.normal,
            ),
          ],
          nextToken: null,
        ),
      ),
      refreshResult.future,
    ]);
    final dataSource = _dataSource(repository: repository);
    addTearDown(dataSource.dispose);
    await dataSource.load(const Refresh());

    final refreshing = dataSource.load(const Refresh());
    await Future<void>.delayed(Duration.zero);
    dataSource.applyRealtimeRecord(
      _earthquake(
        eventId: '20260724010000',
        earthquakeType: api.EarthquakeType.distant,
      ),
    );
    refreshResult.complete(
      PaginatedResponse(
        items: [
          _partial(
            eventId: '20260724010000',
            earthquakeType: api.EarthquakeType.normal,
          ),
        ],
        nextToken: null,
      ),
    );

    final result = await refreshing;
    final item =
        (result as Success<String?, EarthquakePartial>).page.data.single;
    expect(item.earthquake.earthquakeType, EarthquakeType.distant);
  });

  test('legacy notifierも初回REST中の新規upsertを保持する', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final initialResult = Completer<PaginatedResponse<EarthquakePartial>>();
    final repository = _CompletingListRepository([initialResult.future]);
    const parameter = EarthquakeHistoryParameter.all(
      sortBy: EarthquakeSortBy.eventId,
      sortOrder: SortOrder.desc,
    );
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      earthquakeHistoryProvider(parameter),
      (_, _) {},
    );
    addTearDown(subscription.close);
    await Future<void>.delayed(Duration.zero);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(
          eventId: '20260724020000',
          earthquakeType: api.EarthquakeType.normal,
        ),
        source: RealtimeSource.eqmonitor,
      ),
    );
    initialResult.complete(
      PaginatedResponse(
        items: [
          _partial(
            eventId: '20260724010000',
            earthquakeType: api.EarthquakeType.normal,
          ),
        ],
        nextToken: null,
      ),
    );
    final result = await container.read(
      earthquakeHistoryProvider(parameter).future,
    );

    expect(result.items.map((item) => item.earthquake.eventId), [
      '20260724020000',
      '20260724010000',
    ]);
  });
}

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

EarthquakeHistoryDataSource _dataSource({
  required EarthquakeHistoryRepository repository,
  EarthquakeHistoryParameter parameter = const EarthquakeHistoryParameter.all(
    sortBy: EarthquakeSortBy.eventId,
    sortOrder: SortOrder.desc,
  ),
}) => EarthquakeHistoryDataSource(repository: repository, parameter: parameter);

EarthquakePartialNormal _partial({
  required String eventId,
  required api.EarthquakeType earthquakeType,
}) => api.EarthquakePartial(
  eventId: eventId,
  status: api.TelegramStatus.normal,
  earthquakeType: earthquakeType,
  originTimePrecision: api.OriginTimePrecision.second,
  datasources: const [api.EarthquakeDatasource.jmaDisasterInformationXml],
  telegramTypes: const [],
).toEarthquakePartial(parameter: _earthquakeParameter);

final class _CompletingListRepository extends EarthquakeHistoryRepository {
  _CompletingListRepository(this.results)
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      );

  final List<Future<PaginatedResponse<EarthquakePartial>>> results;
  var fetchCount = 0;

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
  }) => results[fetchCount++];
}

api.Earthquake _earthquake({
  required String eventId,
  required api.EarthquakeType earthquakeType,
  api.Intensity? intensity,
  String? epicenterCode,
}) => api.Earthquake(
  eventId: eventId,
  status: api.TelegramStatus.normal,
  earthquakeType: earthquakeType,
  originTimePrecision: api.OriginTimePrecision.second,
  datasources: const [api.EarthquakeDatasource.jmaDisasterInformationXml],
  telegrams: const [],
  intensity: intensity,
  hypocenter: epicenterCode == null
      ? null
      : api.Hypocenter(
          magnitude: const api.Magnitude(
            type: api.MagnitudeType.normal,
            value: 5,
          ),
          depth: const api.Depth(type: api.DepthType.normal, value: 10),
          code: epicenterCode,
        ),
);

const _metadata = ParameterMetadata(
  type: ParameterType.jmaCodeTable,
  schemaVersion: 1,
  sourceVersion: 'test',
  sourceUpdatedAt: null,
  sourceUrls: [],
  sha256: 'test',
);

const _earthquakeParameter = EarthquakeParameter(
  metadata: _metadata,
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
