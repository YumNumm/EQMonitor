import 'dart:async';

import 'package:cache/cache.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

final class _SpyRepository extends EarthquakeHistoryRepository {
  _SpyRepository({required this.initial, required this.cacheClient})
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      );

  final Earthquake initial;
  final api.ApiClient cacheClient;
  int detailFetchCount = 0;

  @override
  Future<Earthquake> fetchEarthquakeDetail({
    required String eventId,
    api.ApiClient? client,
  }) async {
    if (identical(client, cacheClient)) {
      throw const CacheMissException();
    }
    detailFetchCount += 1;
    return initial;
  }
}

final class _CompletingRepository extends EarthquakeHistoryRepository {
  _CompletingRepository({
    required this.cacheClient,
    required this.cacheResult,
    required this.networkResults,
  }) : super(
         earthquake: api.ApiClient(Dio()).earthquake,
         earthquakeParameter: _earthquakeParameter,
         shindoDbStations: _shindoDbStations,
       );

  final api.ApiClient cacheClient;
  final Future<Earthquake> Function() cacheResult;
  final List<Completer<Earthquake>> networkResults;
  int networkFetchCount = 0;

  @override
  Future<Earthquake> fetchEarthquakeDetail({
    required String eventId,
    api.ApiClient? client,
  }) async {
    if (identical(client, cacheClient)) {
      return cacheResult();
    }
    networkFetchCount += 1;
    return networkResults[networkFetchCount - 1].future;
  }
}

void main() {
  test('matching full earthquakeで詳細stateをRESTなしに置換すること', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final networkClient = api.ApiClient(Dio());
    final initialRecord = _earthquake(eventId: 'event-1', comment: 'old');
    final updatedRecord = _earthquake(eventId: 'event-1', comment: 'new');
    final repository = _SpyRepository(
      initial: initialRecord.toEarthquake(
        parameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      ),
      cacheClient: cacheClient,
    );
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
        apiClientProvider.overrideWith((ref) async => networkClient),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(
      earthquakeHistoryDetailsProvider('event-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);
    await container.read(earthquakeHistoryDetailsProvider('event-1').future);
    expect(repository.detailFetchCount, 1);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: updatedRecord,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();

    expect(
      container
          .read(earthquakeHistoryDetailsProvider('event-1'))
          .value
          ?.telegramComments
          .single
          .additional,
      'new',
    );
    expect(repository.detailFetchCount, 1);
  });

  test('別eventIdのfull earthquakeは詳細stateを変更しないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final initialRecord = _earthquake(eventId: 'event-1', comment: 'old');
    final repository = _SpyRepository(
      initial: initialRecord.toEarthquake(
        parameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      ),
      cacheClient: cacheClient,
    );
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
        apiClientProvider.overrideWith((ref) async => api.ApiClient(Dio())),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(
      earthquakeHistoryDetailsProvider('event-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);
    await container.read(earthquakeHistoryDetailsProvider('event-1').future);
    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-2', comment: 'other'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();

    expect(
      container
          .read(earthquakeHistoryDetailsProvider('event-1'))
          .value
          ?.telegramComments
          .single
          .additional,
      'old',
    );
    expect(repository.detailFetchCount, 1);
  });

  test('matching full earthquakeでlist memoryを同じrecordから置換すること', () {
    final cacheClient = api.ApiClient(Dio());
    final repository = _SpyRepository(
      initial: _earthquake(eventId: 'event-1', comment: 'old').toEarthquake(
        parameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      ),
      cacheClient: cacheClient,
    );
    final dataSource = EarthquakeHistoryDataSource(
      repository: repository,
      parameter: const EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      ),
    );
    addTearDown(dataSource.dispose);
    dataSource.upsertItems([
      const api.EarthquakePartial(
        eventId: 'event-1',
        status: api.TelegramStatus.normal,
        originTimePrecision: api.OriginTimePrecision.second,
        datasources: [api.EarthquakeDatasource.jmaDisasterInformationXml],
        telegramTypes: [api.EarthquakeTelegramType.vxse51],
        earthquakeType: api.EarthquakeType.distant,
      ).toEarthquakePartial(parameter: _earthquakeParameter),
    ]);

    dataSource.applyRealtimeRecord(
      _earthquake(eventId: 'event-1', comment: 'new'),
    );

    final updated = dataSource.notifier.values.single.earthquake;
    expect(updated.telegramTypes.single.name, 'vxse53');
    expect(updated.earthquakeType.name, 'distant');
    expect(repository.detailFetchCount, 0);
  });

  test('repository初期化中のrealtimeを初回RESTで上書きしないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final networkResult = Completer<Earthquake>();
    final repository = _CompletingRepository(
      cacheClient: cacheClient,
      cacheResult: () async => throw const CacheMissException(),
      networkResults: [networkResult],
    );
    final repositoryResult = Completer<EarthquakeHistoryRepository>();
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) => repositoryResult.future,
        ),
        cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
        apiClientProvider.overrideWith((ref) async => api.ApiClient(Dio())),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      earthquakeHistoryDetailsProvider('event-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-1', comment: 'realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    expect(repository.networkFetchCount, 0);

    repositoryResult.complete(repository);
    await _waitFor(() => repository.networkFetchCount == 1);
    networkResult.complete(
      _earthquake(eventId: 'event-1', comment: 'old-rest').toEarthquake(
        parameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      ),
    );
    await container.pump();

    expect(
      container
          .read(earthquakeHistoryDetailsProvider('event-1'))
          .value
          ?.telegramComments
          .single
          .additional,
      'realtime',
    );
    expect(repository.networkFetchCount, 1);
  });

  test('初回REST完了前のrealtimeを古い初回結果で上書きしないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final networkClient = api.ApiClient(Dio());
    final networkResult = Completer<Earthquake>();
    final repository = _CompletingRepository(
      cacheClient: cacheClient,
      cacheResult: () async => throw const CacheMissException(),
      networkResults: [networkResult],
    );
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
        apiClientProvider.overrideWith((ref) async => networkClient),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      earthquakeHistoryDetailsProvider('event-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);
    await _waitFor(() => repository.networkFetchCount == 1);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-1', comment: 'realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    networkResult.complete(
      _earthquake(eventId: 'event-1', comment: 'old-rest').toEarthquake(
        parameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      ),
    );
    await container.pump();

    expect(
      container
          .read(earthquakeHistoryDetailsProvider('event-1'))
          .value
          ?.telegramComments
          .single
          .additional,
      'realtime',
    );
    expect(repository.networkFetchCount, 1);
  });

  test('background再検証完了前のrealtimeを古いfresh結果で上書きしないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final networkClient = api.ApiClient(Dio());
    final networkResult = Completer<Earthquake>();
    final repository = _CompletingRepository(
      cacheClient: cacheClient,
      cacheResult: () async =>
          _earthquake(eventId: 'event-1', comment: 'cached').toEarthquake(
            parameter: _earthquakeParameter,
            shindoDbStations: _shindoDbStations,
          ),
      networkResults: [networkResult],
    );
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
        apiClientProvider.overrideWith((ref) async => networkClient),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      earthquakeHistoryDetailsProvider('event-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);
    await container.read(earthquakeHistoryDetailsProvider('event-1').future);
    await _waitFor(() => repository.networkFetchCount == 1);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-1', comment: 'realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    networkResult.complete(
      _earthquake(eventId: 'event-1', comment: 'old-fresh').toEarthquake(
        parameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      ),
    );
    await container.pump();

    expect(
      container
          .read(earthquakeHistoryDetailsProvider('event-1'))
          .value
          ?.telegramComments
          .single
          .additional,
      'realtime',
    );
    expect(repository.networkFetchCount, 1);
  });

  test('realtime後に開始したrefreshのREST結果を採用すること', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final initialResult = Completer<Earthquake>();
    final refreshResult = Completer<Earthquake>();
    final repository = _CompletingRepository(
      cacheClient: cacheClient,
      cacheResult: () async => throw const CacheMissException(),
      networkResults: [initialResult, refreshResult],
    );
    final container = _detailsContainer(
      controller: controller,
      repository: repository,
      cacheClient: cacheClient,
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      earthquakeHistoryDetailsProvider('event-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);
    await _waitFor(() => repository.networkFetchCount == 1);
    initialResult.complete(
      _domainEarthquake(eventId: 'event-1', comment: 'initial-rest'),
    );
    await container.pump();

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-1', comment: 'old-realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    container.invalidate(earthquakeHistoryDetailsProvider('event-1'));
    await _waitFor(() => repository.networkFetchCount == 2);
    refreshResult.complete(
      _domainEarthquake(eventId: 'event-1', comment: 'new-rest'),
    );
    await container.pump();

    expect(
      container
          .read(earthquakeHistoryDetailsProvider('event-1'))
          .value
          ?.telegramComments
          .single
          .additional,
      'new-rest',
    );
  });

  test('refresh REST中の新しいrealtimeをREST完了で上書きしないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final initialResult = Completer<Earthquake>();
    final refreshResult = Completer<Earthquake>();
    final repository = _CompletingRepository(
      cacheClient: cacheClient,
      cacheResult: () async => throw const CacheMissException(),
      networkResults: [initialResult, refreshResult],
    );
    final container = _detailsContainer(
      controller: controller,
      repository: repository,
      cacheClient: cacheClient,
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      earthquakeHistoryDetailsProvider('event-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);
    await _waitFor(() => repository.networkFetchCount == 1);
    initialResult.complete(
      _domainEarthquake(eventId: 'event-1', comment: 'initial-rest'),
    );
    await container.pump();

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-1', comment: 'old-realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    container.invalidate(earthquakeHistoryDetailsProvider('event-1'));
    await _waitFor(() => repository.networkFetchCount == 2);
    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-1', comment: 'new-realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    refreshResult.complete(
      _domainEarthquake(eventId: 'event-1', comment: 'new-rest'),
    );
    await container.pump();

    expect(
      container
          .read(earthquakeHistoryDetailsProvider('event-1'))
          .value
          ?.telegramComments
          .single
          .additional,
      'new-realtime',
    );
  });

  test('realtime後のrefreshでstale cacheを表示せずfresh成功を採用すること', () async {
    final fixture = await _startCacheHitRefresh();

    expect(_detailsComment(fixture.container), 'old-realtime');
    fixture.refreshResult.complete(
      _domainEarthquake(eventId: 'event-1', comment: 'new-fresh'),
    );
    await fixture.container.pump();

    expect(_detailsComment(fixture.container), 'new-fresh');
  });

  test('realtime後のrefreshでfresh失敗時もrealtimeを維持すること', () async {
    final fixture = await _startCacheHitRefresh();

    expect(_detailsComment(fixture.container), 'old-realtime');
    fixture.refreshResult.completeError(StateError('fresh failed'));
    await fixture.container.pump();

    final state = fixture.container.read(
      earthquakeHistoryDetailsProvider('event-1'),
    );
    expect(_detailsComment(fixture.container), 'old-realtime');
    expect(state.hasError, isFalse);
  });

  test('cache-hit refreshのfresh取得中に来たrealtimeを維持すること', () async {
    final fixture = await _startCacheHitRefresh();

    fixture.controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _earthquake(eventId: 'event-1', comment: 'new-realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.container.pump();
    fixture.refreshResult.complete(
      _domainEarthquake(eventId: 'event-1', comment: 'new-fresh'),
    );
    await fixture.container.pump();

    expect(_detailsComment(fixture.container), 'new-realtime');
  });
}

final class _CacheHitRefreshFixture {
  const _CacheHitRefreshFixture({
    required this.controller,
    required this.container,
    required this.refreshResult,
  });

  final StreamController<RealtimeEvent> controller;
  final ProviderContainer container;
  final Completer<Earthquake> refreshResult;
}

Future<_CacheHitRefreshFixture> _startCacheHitRefresh() async {
  final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
  addTearDown(controller.close);
  final cacheClient = api.ApiClient(Dio());
  final initialFreshResult = Completer<Earthquake>();
  final refreshResult = Completer<Earthquake>();
  final repository = _CompletingRepository(
    cacheClient: cacheClient,
    cacheResult: () async =>
        _domainEarthquake(eventId: 'event-1', comment: 'stale-cache'),
    networkResults: [initialFreshResult, refreshResult],
  );
  final container = _detailsContainer(
    controller: controller,
    repository: repository,
    cacheClient: cacheClient,
  );
  addTearDown(container.dispose);
  final subscription = container.listen(
    earthquakeHistoryDetailsProvider('event-1'),
    (_, _) {},
  );
  addTearDown(subscription.close);
  await _waitFor(() => repository.networkFetchCount == 1);
  initialFreshResult.complete(
    _domainEarthquake(eventId: 'event-1', comment: 'initial-fresh'),
  );
  await container.pump();

  controller.add(
    RealtimeEvent.earthquakeUpsert(
      record: _earthquake(eventId: 'event-1', comment: 'old-realtime'),
      source: RealtimeSource.eqmonitor,
    ),
  );
  await container.pump();
  container.invalidate(earthquakeHistoryDetailsProvider('event-1'));
  await _waitFor(() => repository.networkFetchCount == 2);

  return _CacheHitRefreshFixture(
    controller: controller,
    container: container,
    refreshResult: refreshResult,
  );
}

String? _detailsComment(ProviderContainer container) => container
    .read(earthquakeHistoryDetailsProvider('event-1'))
    .value
    ?.telegramComments
    .single
    .additional;

ProviderContainer _detailsContainer({
  required StreamController<RealtimeEvent> controller,
  required EarthquakeHistoryRepository repository,
  required api.ApiClient cacheClient,
}) => ProviderContainer(
  overrides: [
    realtimeEventsProvider.overrideWith(
      () => _StubRealtimeEvents(controller.stream),
    ),
    earthquakeHistoryRepositoryProvider.overrideWith((ref) async => repository),
    cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
    apiClientProvider.overrideWith((ref) async => api.ApiClient(Dio())),
  ],
);

Earthquake _domainEarthquake({
  required String eventId,
  required String comment,
}) => _earthquake(eventId: eventId, comment: comment).toEarthquake(
  parameter: _earthquakeParameter,
  shindoDbStations: _shindoDbStations,
);

Future<void> _waitFor(bool Function() condition) async {
  for (var i = 0; i < 20 && !condition(); i += 1) {
    await Future<void>.delayed(Duration.zero);
  }
  expect(condition(), isTrue);
}

api.Earthquake _earthquake({
  required String eventId,
  required String comment,
}) => api.Earthquake(
  eventId: eventId,
  status: api.TelegramStatus.normal,
  originTimePrecision: api.OriginTimePrecision.second,
  datasources: const [api.EarthquakeDatasource.jmaDisasterInformationXml],
  telegrams: [
    api.EarthquakeTelegram(
      telegram: api.Telegram(
        id: 'telegram-$comment',
        eventId: eventId,
        type: api.TelegramType.vxse53,
        title: '震源・震度情報',
        status: api.TelegramStatus.normal,
        infoType: api.InfoType.publication,
        editorialOffice: '気象庁本庁',
        publishingOffice: const ['気象庁'],
        pressedAt: DateTime.utc(2026, 5, 1, 9),
        reportedAt: DateTime.utc(2026, 5, 1, 9),
        infoKind: '地震情報',
        infoKindVersion: '1.0_0',
        hash: 'hash-$comment',
        createdAt: DateTime.utc(2026, 5, 1, 9),
      ),
      comments: api.TelegramComments(additional: comment),
    ),
  ],
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
