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
    required this.networkResult,
  }) : super(
         earthquake: api.ApiClient(Dio()).earthquake,
         earthquakeParameter: _earthquakeParameter,
         shindoDbStations: _shindoDbStations,
       );

  final api.ApiClient cacheClient;
  final Future<Earthquake> Function() cacheResult;
  final Completer<Earthquake> networkResult;
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
    return networkResult.future;
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

  test('初回REST完了前のrealtimeを古い初回結果で上書きしないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final networkClient = api.ApiClient(Dio());
    final networkResult = Completer<Earthquake>();
    final repository = _CompletingRepository(
      cacheClient: cacheClient,
      cacheResult: () async => throw const CacheMissException(),
      networkResult: networkResult,
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
      networkResult: networkResult,
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
}

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
