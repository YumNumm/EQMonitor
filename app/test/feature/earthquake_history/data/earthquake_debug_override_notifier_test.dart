import 'dart:async';
import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/api/http_cached_api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_debug_override_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  const factory = EarthquakeVxseDebugDraftFactory();

  test('draft適用とresetはRESTを増やさず初期baseへ戻す', () async {
    final fixture = await _startFixture();
    final initial = _details(fixture.container);
    final draft = factory.create(
      current: initial,
      type: EarthquakeTelegramType.vxse52,
    );

    fixture.container
        .read(earthquakeDebugOverrideProvider(_eventId).notifier)
        .applyDraft(
          current: initial,
          draft: draft,
          mode: EarthquakeVxseApplyMode.merge,
        );

    expect(_details(fixture.container).hypocenter, isNotNull);
    expect(fixture.repository.detailFetchCount, 1);

    fixture.container
        .read(earthquakeDebugOverrideProvider(_eventId).notifier)
        .reset();

    expect(_details(fixture.container).hypocenter, isNull);
    expect(fixture.repository.detailFetchCount, 1);
  });

  test('override中のfull realtimeはbaseだけを更新しresetで最新baseへ戻す', () async {
    final fixture = await _startFixture();
    final draft = factory.create(
      current: _details(fixture.container),
      type: EarthquakeTelegramType.vxse52,
    );
    final notifier = fixture.container.read(
      earthquakeDebugOverrideProvider(_eventId).notifier,
    );
    notifier.applyDraft(
      current: _details(fixture.container),
      draft: draft,
      mode: EarthquakeVxseApplyMode.merge,
    );

    fixture.controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _apiEarthquake(comment: 'new-realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.container.pump();

    expect(_details(fixture.container).hypocenter, isNotNull);
    expect(_comment(fixture.container), 'old-rest');
    expect(fixture.repository.detailFetchCount, 1);

    notifier.reset();

    expect(_details(fixture.container).hypocenter, isNull);
    expect(_comment(fixture.container), 'new-realtime');
    expect(fixture.repository.detailFetchCount, 1);
  });

  test('applyJsonは現在表示中のoverrideから派生する', () async {
    final fixture = await _startFixture();
    final vxse51 = factory.create(
      current: _details(fixture.container),
      type: EarthquakeTelegramType.vxse51,
    );
    final notifier = fixture.container.read(
      earthquakeDebugOverrideProvider(_eventId).notifier,
    );
    final base = _details(fixture.container);
    notifier.applyDraft(
      current: base,
      draft: vxse51,
      mode: EarthquakeVxseApplyMode.merge,
    );
    final vxse52 = factory.create(
      current: _details(fixture.container),
      type: EarthquakeTelegramType.vxse52,
    );

    notifier.applyJson(
      current: base,
      json: jsonEncode(vxse52.toJson()),
      mode: EarthquakeVxseApplyMode.merge,
    );

    expect(
      _details(fixture.container).intensity?.maxIntensity,
      JmaIntensity.four,
    );
    expect(_details(fixture.container).hypocenter, isNotNull);
    expect(fixture.repository.detailFetchCount, 1);
  });

  test('別eventIdのdraftは適用しない', () async {
    final fixture = await _startFixture();
    final base = _details(fixture.container);
    final draft = factory
        .create(current: base, type: EarthquakeTelegramType.vxse52)
        .copyWith(eventId: 'other-event');
    final notifier = fixture.container.read(
      earthquakeDebugOverrideProvider(_eventId).notifier,
    );

    expect(
      () => notifier.applyDraft(
        current: base,
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      ),
      throwsArgumentError,
    );
    expect(_details(fixture.container), base);
    expect(fixture.repository.detailFetchCount, 1);
  });

  test('別eventIdのcurrentは適用元にしない', () async {
    final fixture = await _startFixture();
    final base = _details(fixture.container);
    final draft = factory.create(
      current: base,
      type: EarthquakeTelegramType.vxse52,
    );
    final notifier = fixture.container.read(
      earthquakeDebugOverrideProvider(_eventId).notifier,
    );

    expect(
      () => notifier.applyDraft(
        current: base.copyWith(eventId: 'other-event'),
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      ),
      throwsArgumentError,
    );
    expect(_details(fixture.container), base);
    expect(fixture.repository.detailFetchCount, 1);
  });

  test('details refresh中もoverrideを保持する', () async {
    final fixture = await _startFixture();
    final base = _details(fixture.container);
    final draft = factory.create(
      current: base,
      type: EarthquakeTelegramType.vxse52,
    );
    final notifier = fixture.container.read(
      earthquakeDebugOverrideProvider(_eventId).notifier,
    );
    notifier.applyDraft(
      current: base,
      draft: draft,
      mode: EarthquakeVxseApplyMode.merge,
    );
    fixture.repository.initial = _apiEarthquake(comment: 'new-rest')
        .toEarthquake(
          parameter: _earthquakeParameter,
          shindoDbStations: _shindoDbStations,
        );

    fixture.container.invalidate(earthquakeHistoryDetailsProvider(_eventId));
    await fixture.container.read(
      earthquakeHistoryDetailsProvider(_eventId).future,
    );

    expect(_details(fixture.container).hypocenter, isNotNull);
    expect(_comment(fixture.container), 'old-rest');
    notifier.reset();
    expect(_details(fixture.container).hypocenter, isNull);
    expect(_comment(fixture.container), 'new-rest');
    expect(fixture.repository.detailFetchCount, 2);
  });

  test('override中のstale cacheでbaseを巻き戻さずfresh完了時に更新する', () async {
    final fixture = await _startFixture();
    final base = _details(fixture.container);
    final draft = factory.create(
      current: base,
      type: EarthquakeTelegramType.vxse52,
    );
    final notifier = fixture.container.read(
      earthquakeDebugOverrideProvider(_eventId).notifier,
    );
    notifier.applyDraft(
      current: base,
      draft: draft,
      mode: EarthquakeVxseApplyMode.merge,
    );
    fixture.repository.cacheResult = _domainEarthquake(comment: 'stale-cache');
    final freshResult = Completer<Earthquake>();
    fixture.repository.freshResult = freshResult;

    fixture.container.invalidate(earthquakeHistoryDetailsProvider(_eventId));
    await fixture.container.read(
      earthquakeHistoryDetailsProvider(_eventId).future,
    );
    await _waitFor(() => fixture.repository.detailFetchCount == 2);
    notifier.reset();

    expect(_comment(fixture.container), 'old-rest');

    freshResult.complete(_domainEarthquake(comment: 'fresh-rest'));
    await fixture.container.pump();

    expect(_comment(fixture.container), 'fresh-rest');
  });
}

final class _Fixture {
  const _Fixture({
    required this.controller,
    required this.container,
    required this.repository,
  });

  final StreamController<RealtimeEvent> controller;
  final ProviderContainer container;
  final _SpyRepository repository;
}

Future<_Fixture> _startFixture() async {
  final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
  addTearDown(controller.close);
  final cacheClient = api.ApiClient(Dio());
  final repository = _SpyRepository(
    initial: _apiEarthquake(comment: 'old-rest').toEarthquake(
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
      httpCachedApiClientProvider.overrideWith(
        (ref) async => api.ApiClient(Dio()),
      ),
    ],
  );
  addTearDown(container.dispose);
  final subscription = container.listen(
    earthquakeHistoryDetailsProvider(_eventId),
    (_, _) {},
  );
  addTearDown(subscription.close);
  await container.read(earthquakeHistoryDetailsProvider(_eventId).future);
  return _Fixture(
    controller: controller,
    container: container,
    repository: repository,
  );
}

Earthquake _details(ProviderContainer container) =>
    container.read(earthquakeHistoryDetailsProvider(_eventId)).requireValue;

String? _comment(ProviderContainer container) =>
    _details(container).telegramComments.single.additional;

Earthquake _domainEarthquake({required String comment}) =>
    _apiEarthquake(comment: comment).toEarthquake(
      parameter: _earthquakeParameter,
      shindoDbStations: _shindoDbStations,
    );

Future<void> _waitFor(bool Function() condition) async {
  for (var i = 0; i < 20 && !condition(); i += 1) {
    await Future<void>.delayed(Duration.zero);
  }
  expect(condition(), isTrue);
}

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

  Earthquake initial;
  final api.ApiClient cacheClient;
  int detailFetchCount = 0;
  Earthquake? cacheResult;
  Completer<Earthquake>? freshResult;

  @override
  Future<Earthquake> fetchEarthquakeDetail({
    required String eventId,
    api.ApiClient? client,
  }) async {
    if (identical(client, cacheClient)) {
      final cached = cacheResult;
      if (cached != null) {
        return cached;
      }
      throw const CacheMissException();
    }
    detailFetchCount += 1;
    final pendingFresh = freshResult;
    if (pendingFresh != null) {
      return pendingFresh.future;
    }
    return initial;
  }
}

api.Earthquake _apiEarthquake({required String comment}) => api.Earthquake(
  eventId: _eventId,
  status: api.TelegramStatus.normal,
  earthquakeType: api.EarthquakeType.distant,
  originTimePrecision: api.OriginTimePrecision.second,
  datasources: const [api.EarthquakeDatasource.jmaDisasterInformationXml],
  telegrams: [
    api.EarthquakeTelegram(
      telegram: api.Telegram(
        id: 'telegram-$comment',
        eventId: _eventId,
        type: api.TelegramType.vxse53,
        title: '震源・震度情報',
        status: api.TelegramStatus.normal,
        infoType: api.InfoType.publication,
        editorialOffice: '気象庁本庁',
        publishingOffice: const ['気象庁'],
        pressedAt: DateTime.utc(2026, 7, 24),
        reportedAt: DateTime.utc(2026, 7, 24),
        infoKind: '地震情報',
        infoKindVersion: '1.0_0',
        hash: 'hash-$comment',
        createdAt: DateTime.utc(2026, 7, 24),
      ),
      comments: api.TelegramComments(additional: comment),
    ),
  ],
);

const _eventId = 'event-1';
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
