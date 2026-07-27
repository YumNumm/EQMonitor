import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_coordinator.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_detected_event_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/provider/live_monitor_latest_earthquake_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

final _now = DateTime.utc(2026, 7, 27, 12);
final _reportedAt = DateTime.utc(2026, 7, 27, 11, 59);

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

final class _MutableEews extends EewAliveTelegram {
  _MutableEews(this.initial);

  final List<EewTelegramItem>? initial;

  @override
  List<EewTelegramItem>? build() => initial;

  void publish(List<EewTelegramItem>? value) => state = value;
}

final class _MutableShakeSnapshot extends ShakeDetectionAcceptedSnapshot {
  _MutableShakeSnapshot(this.initial);

  final ShakeDetectionSnapshot? initial;

  @override
  ShakeDetectionSnapshot? build() => initial;

  void publish(ShakeDetectionSnapshot? value) => state = value;
}

final class _MutableLifecycle extends AppLifecycle {
  @override
  AppLifecycleState build() => AppLifecycleState.resumed;

  void publish(AppLifecycleState value) => state = value;
}

final class _FixedAppClock extends AppClock {
  @override
  TimeMode build() => const TimeMode.realtime();

  @override
  DateTime now() => _now;
}

final class _PageStore {
  _PageStore(this.page);

  PaginatedResponse<EarthquakePartial> page;
  Completer<PaginatedResponse<EarthquakePartial>>? firstLoad;
  final delayedLoads = <int, Completer<PaginatedResponse<EarthquakePartial>>>{};
  var loadCount = 0;
  var failFirstLoad = false;
  var failAfterFirstLoad = false;

  Future<PaginatedResponse<EarthquakePartial>> load() async {
    loadCount += 1;
    if (loadCount == 1 && failFirstLoad) {
      throw StateError('initial page unavailable');
    }
    final pending = firstLoad;
    if (loadCount == 1 && pending != null) {
      return pending.future;
    }
    final delayed = delayedLoads[loadCount];
    if (delayed != null) {
      return delayed.future;
    }
    if (loadCount > 1 && failAfterFirstLoad) {
      throw StateError('page unavailable');
    }
    return page;
  }
}

final class _StaticSettings extends LiveMonitorSettingsNotifier {
  @override
  Future<LiveMonitorSettings> build() async => const LiveMonitorSettings();
}

final class _StubHistoryNotifier extends EarthquakeHistoryNotifier {
  _StubHistoryNotifier(this.store);

  final _PageStore store;

  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) => store.load();
}

final class _DetailStore {
  final values = <String, Earthquake>{};
  final failures = <String>{};
  final firstLoads = <String, Completer<Earthquake>>{};
  final fetchCounts = <String, int>{};

  Future<Earthquake> load(String eventId) async {
    fetchCounts.update(eventId, (count) => count + 1, ifAbsent: () => 1);
    final firstLoad = firstLoads[eventId];
    if (fetchCounts[eventId] == 1 && firstLoad != null) {
      return firstLoad.future;
    }
    if (failures.contains(eventId)) {
      throw StateError('detail unavailable: $eventId');
    }
    final value = values[eventId];
    if (value == null) {
      throw StateError('detail missing: $eventId');
    }
    return value;
  }
}

final class _StubDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  _StubDetailsNotifier(this.store);

  final _DetailStore store;

  @override
  Future<Earthquake> build(String eventId) => store.load(eventId);
}

final class _DetectedEventFixture {
  _DetectedEventFixture({
    required this.container,
    required this.realtime,
    required this.eews,
    required this.shake,
    required this.lifecycle,
    required this.pageStore,
    required this.detailStore,
    required this.events,
  });

  final ProviderContainer container;
  final StreamController<RealtimeEvent> realtime;
  final _MutableEews eews;
  final _MutableShakeSnapshot shake;
  final _MutableLifecycle lifecycle;
  final _PageStore pageStore;
  final _DetailStore detailStore;
  final List<LiveMonitorEventEnvelope> events;

  Future<void> start() async {
    await container.read(liveMonitorDetectedEventProvider.future);
    await settle();
  }

  Future<void> settle() async {
    for (var i = 0; i < 12; i += 1) {
      await container.pump();
      await Future<void>.delayed(Duration.zero);
    }
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  test('初期REST stateは基準値になりイベントを発行しない', () async {
    final fixture = createFixture(
      eews: [eew(eventId: 'E', serialNo: 1)],
      shakeSnapshot: snapshot(
        revision: 1,
        events: [shakeEvent(eventId: 'S', serialNo: 1)],
      ),
      details: {'Q': earthquake(eventId: 'Q', telegramType: .vxse53)},
    );
    addTearDown(fixture.container.dispose);

    await fixture.start();

    expect(fixture.events, isEmpty);
    expect(
      fixture.container.read(liveMonitorDetectedEventProvider).value,
      isNull,
    );
  });

  test('初期EEWがnullでもslow detail中の最初のEEWを一度発行してパネルを閉じる', () async {
    final initialDetail = Completer<Earthquake>();
    final fixture = createFixture(
      eews: null,
      shakeSnapshot: snapshot(revision: 0, events: const []),
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await fixture.container.read(liveMonitorSettingsProvider.future);
    fixture.container
      ..listen(liveMonitorCoordinatorProvider, (_, _) {}, fireImmediately: true)
      ..read(liveMonitorControlPanelProvider.notifier).open();
    await fixture.settle();

    final firstEew = [eew(eventId: 'NEW-EEW', serialNo: 1)];
    fixture.eews.publish(firstEew);
    await fixture.settle();
    fixture.eews.publish(firstEew);
    await fixture.settle();

    expect(fixture.events.map((envelope) => envelope.event), [
      const LiveMonitorDetectedEvent.eewStarted(
        eventId: 'NEW-EEW',
        serialNo: 1,
      ),
    ]);
    expect(fixture.container.read(liveMonitorControlPanelProvider), isFalse);

    initialDetail.complete(earthquake(eventId: 'Q'));
    await initialization;
  });

  test('初期揺れ検知がnullでもslow detail中のrevision 0を一度発行する', () async {
    final initialDetail = Completer<Earthquake>();
    final fixture = createFixture(
      shakeSnapshot: null,
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await fixture.settle();

    final firstSnapshot = snapshot(
      revision: 0,
      events: [shakeEvent(eventId: 'NEW-SHAKE', serialNo: 1)],
    );
    fixture.shake.publish(firstSnapshot);
    await fixture.settle();
    fixture.shake.publish(firstSnapshot);
    await fixture.settle();

    expect(fixture.events.map((envelope) => envelope.event), [
      const LiveMonitorDetectedEvent.shakeDetected(
        eventId: 'NEW-SHAKE',
        serialNo: 1,
      ),
    ]);

    initialDetail.complete(earthquake(eventId: 'Q'));
    await initialization;
  });

  test('初期detail待機中も新規EEWと揺れ検知を即時発行しEEWでパネルを閉じる', () async {
    final initialDetail = Completer<Earthquake>();
    final fixture = createFixture(
      eews: [eew(eventId: 'BASELINE-EEW', serialNo: 1)],
      shakeSnapshot: snapshot(
        revision: 1,
        events: [shakeEvent(eventId: 'BASELINE-SHAKE', serialNo: 1)],
      ),
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    fixture.container
      ..read(eewAliveTelegramProvider)
      ..read(shakeDetectionAcceptedSnapshotProvider);
    await fixture.container.read(liveMonitorSettingsProvider.future);
    fixture.container
      ..listen(liveMonitorCoordinatorProvider, (_, _) {}, fireImmediately: true)
      ..read(liveMonitorControlPanelProvider.notifier).open();
    await fixture.settle();

    fixture.eews.publish([
      eew(eventId: 'BASELINE-EEW', serialNo: 1),
      eew(eventId: 'NEW-EEW', serialNo: 1),
    ]);
    fixture.shake.publish(
      snapshot(
        revision: 2,
        events: [
          shakeEvent(eventId: 'BASELINE-SHAKE', serialNo: 1),
          shakeEvent(eventId: 'NEW-SHAKE', serialNo: 1),
        ],
      ),
    );
    await fixture.settle();

    expect(fixture.events.map((envelope) => envelope.event), [
      const LiveMonitorDetectedEvent.eewStarted(
        eventId: 'NEW-EEW',
        serialNo: 1,
      ),
      const LiveMonitorDetectedEvent.shakeDetected(
        eventId: 'NEW-SHAKE',
        serialNo: 1,
      ),
    ]);
    expect(fixture.container.read(liveMonitorControlPanelProvider), isFalse);

    initialDetail.complete(earthquake(eventId: 'Q'));
    await initialization;
    await fixture.settle();
    expect(fixture.events, hasLength(2));
  });

  test('初期一覧失敗を隔離しrawとcanonicalを継続してReadyとforegroundで再同期する', () async {
    final fixture = createFixture(
      failFirstPageLoad: true,
      details: {'Q': earthquake(eventId: 'Q')},
      shakeSnapshot: snapshot(revision: 0, events: const []),
    );
    addTearDown(fixture.container.dispose);

    await expectLater(fixture.start(), completes);
    fixture.realtime.add(
      const RealtimeEvent.earthquakeDelete(
        eventId: 'RAW-AFTER-INITIAL-ERROR',
        source: RealtimeSource.eqmonitor,
      ),
    );
    fixture.eews.publish([eew(eventId: 'NEW-EEW', serialNo: 1)]);
    fixture.shake.publish(
      snapshot(
        revision: 1,
        events: [shakeEvent(eventId: 'NEW-SHAKE', serialNo: 1)],
      ),
    );
    await fixture.settle();

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      metadata: [metadata(type: .vxse53, minute: 1)],
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();
    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      metadata: [
        metadata(type: .vxse53, minute: 1),
        metadata(type: .vxse62, minute: 2),
      ],
    );
    fixture.lifecycle
      ..publish(AppLifecycleState.paused)
      ..publish(AppLifecycleState.resumed);
    await fixture.settle();

    expect(fixture.events.map((envelope) => envelope.event.eventId), [
      'RAW-AFTER-INITIAL-ERROR',
      'NEW-EEW',
      'NEW-SHAKE',
      'Q',
    ]);
    expect(
      fixture.events
          .map((envelope) => envelope.event)
          .whereType<LiveMonitorEarthquakeUpsertEvent>()
          .map((event) => event.trigger.kind),
      [LiveMonitorEarthquakeTriggerKind.vxse62],
    );
    expect(fixture.pageStore.loadCount, 3);
  });

  test('初期一覧失敗後の初回resyncはcumulative detailをbaselineにして次の差分だけ発行する', () async {
    final fixture = createFixture(
      failFirstPageLoad: true,
      details: {'Q': earthquake(eventId: 'Q')},
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      metadata: [
        metadata(type: .vxse51, minute: 1),
        metadata(type: .vxse52, minute: 2),
        metadata(type: .vxse53, minute: 3),
        metadata(type: .vxse61, minute: 4),
        metadata(type: .vxse62, minute: 5),
      ],
      tileUrl: 'https://tiles.eqmonitor.app/estimated/existing.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    expect(
      fixture.events.where(
        (envelope) => envelope.event is LiveMonitorEarthquakeUpsertEvent,
      ),
      isEmpty,
    );

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      metadata: [
        metadata(type: .vxse51, minute: 1),
        metadata(type: .vxse52, minute: 2),
        metadata(type: .vxse53, minute: 3),
        metadata(type: .vxse61, minute: 4),
        metadata(type: .vxse62, minute: 5),
        metadata(type: .vxse53, minute: 6),
      ],
      tileUrl: 'https://tiles.eqmonitor.app/estimated/existing.pmtiles',
    );
    fixture.lifecycle
      ..publish(AppLifecycleState.paused)
      ..publish(AppLifecycleState.resumed);
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .toList(growable: false);
    expect(events, hasLength(1));
    expect(
      events.single.trigger,
      LiveMonitorEarthquakeTrigger.telegram(
        kind: .vxse53,
        reportedAt: _reportedAt.add(const Duration(minutes: 6)),
      ),
    );
    expect(fixture.pageStore.loadCount, 3);
  });

  test('初期一覧失敗後の初回cumulative rawは最新VXSEだけを発行しReadyで重複しない', () async {
    final cumulativeRecord = earthquakeRecord(
      eventId: 'Q',
      metadata: [
        metadata(type: .vxse51, minute: 1),
        metadata(type: .vxse52, minute: 2),
        metadata(type: .vxse53, minute: 3),
        metadata(type: .vxse61, minute: 4),
        metadata(type: .vxse62, minute: 5),
        metadata(type: .vxse53, minute: 6),
      ],
    );
    final cumulativeEarthquake = cumulativeRecord.toEarthquake(
      parameter: _earthquakeParameter,
      shindoDbStations: _shindoDbStations,
    );
    final fixture = createFixture(
      failFirstPageLoad: true,
      details: {'Q': earthquake(eventId: 'Q')},
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime.add(
      RealtimeEvent.earthquakeUpsert(
        record: cumulativeRecord,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    fixture.detailStore.values['Q'] = cumulativeEarthquake;
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .toList(growable: false);
    expect(events, hasLength(1));
    expect(
      events.single.trigger,
      LiveMonitorEarthquakeTrigger.telegram(
        kind: .vxse53,
        reportedAt: _reportedAt.add(const Duration(minutes: 6)),
      ),
    );
  });

  test('初期detail欠損後の初回cumulative rawも最新VXSEだけを発行する', () async {
    final cumulativeRecord = earthquakeRecord(
      eventId: 'Q',
      metadata: [
        metadata(type: .vxse51, minute: 1),
        metadata(type: .vxse52, minute: 2),
        metadata(type: .vxse53, minute: 3),
        metadata(type: .vxse62, minute: 4),
      ],
    );
    final cumulativeEarthquake = cumulativeRecord.toEarthquake(
      parameter: _earthquakeParameter,
      shindoDbStations: _shindoDbStations,
    );
    final fixture = createFixture(details: {'Q': earthquake(eventId: 'Q')});
    fixture.detailStore.failures.add('Q');
    addTearDown(fixture.container.dispose);
    await fixture.start();
    fixture.detailStore.failures.remove('Q');

    fixture.realtime.add(
      RealtimeEvent.earthquakeUpsert(
        record: cumulativeRecord,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    fixture.detailStore.values['Q'] = cumulativeEarthquake;
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .toList(growable: false);
    expect(events, hasLength(1));
    expect(
      events.single.trigger,
      LiveMonitorEarthquakeTrigger.telegram(
        kind: .vxse62,
        reportedAt: _reportedAt.add(const Duration(minutes: 4)),
      ),
    );
  });

  test('初回rawに新規候補がなければfullをbaselineにして推計震度を誤発行しない', () async {
    final cumulativeRecord = earthquakeRecord(
      eventId: 'Q',
      metadata: const [],
      tileUrl: 'https://tiles.eqmonitor.app/estimated/existing.pmtiles',
    );
    final cumulativeEarthquake = cumulativeRecord.toEarthquake(
      parameter: _earthquakeParameter,
      shindoDbStations: _shindoDbStations,
    );
    final fixture = createFixture(
      failFirstPageLoad: true,
      details: {'Q': earthquake(eventId: 'Q')},
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime.add(
      RealtimeEvent.earthquakeUpsert(
        record: cumulativeRecord,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    fixture.detailStore.values['Q'] = cumulativeEarthquake;
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    expect(fixture.events, isEmpty);
  });

  test('初期baseline中のraw eventを到着順に発行する', () async {
    final pageCompleter = Completer<PaginatedResponse<EarthquakePartial>>();
    final fixture = createFixture(pageCompleter: pageCompleter);
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await Future<void>.delayed(Duration.zero);

    fixture.realtime
      ..add(
        const RealtimeEvent.earthquakeDelete(
          eventId: 'A',
          source: RealtimeSource.eqmonitor,
        ),
      )
      ..add(
        const RealtimeEvent.earthquakeDelete(
          eventId: 'B',
          source: RealtimeSource.eqmonitor,
        ),
      );
    pageCompleter.complete(emptyPage());
    await initialization;
    await fixture.settle();

    expect(fixture.events.map((envelope) => envelope.sequence), [1, 2]);
    expect(fixture.events.map((envelope) => envelope.event.eventId), [
      'A',
      'B',
    ]);
  });

  test('初期detail待機中に届いた同一VXSE更新を一度だけ発行する', () async {
    final initialDetail = Completer<Earthquake>();
    final record = earthquakeRecord(eventId: 'Q', telegramType: .vxse62);
    final fixture = createFixture(
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await fixture.settle();

    fixture.realtime.add(
      RealtimeEvent.earthquakeUpsert(
        record: record,
        source: RealtimeSource.eqmonitor,
      ),
    );
    initialDetail.complete(
      record.toEarthquake(
        parameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      ),
    );
    await initialization;
    await fixture.settle();

    final events = fixture.events.where(
      (envelope) => envelope.event is LiveMonitorEarthquakeUpsertEvent,
    );
    expect(events, hasLength(1));
    final event = events.single.event as LiveMonitorEarthquakeUpsertEvent;
    expect(event.trigger.kind, LiveMonitorEarthquakeTriggerKind.vxse62);
  });

  test('初期detailをsnapshot境界としてraw fullの差分だけを到着順に発行する', () async {
    final initialDetail = Completer<Earthquake>();
    final baselineMetadata = [
      metadata(type: .vxse51, minute: 1),
      metadata(type: .vxse52, minute: 2),
      metadata(type: .vxse53, minute: 3),
      metadata(type: .vxse61, minute: 4),
      metadata(type: .vxse62, minute: 5),
    ];
    final fixture = createFixture(
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await fixture.settle();

    fixture.realtime.add(
      RealtimeEvent.earthquakeUpsert(
        record: earthquakeRecord(
          eventId: 'Q',
          metadata: [
            ...baselineMetadata,
            metadata(type: .vxse62, minute: 6),
          ],
          tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-2.pmtiles',
        ),
        source: RealtimeSource.eqmonitor,
      ),
    );
    initialDetail.complete(
      earthquake(
        eventId: 'Q',
        metadata: baselineMetadata,
        tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-1.pmtiles',
      ),
    );
    await initialization;
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .toList(growable: false);
    expect(events, hasLength(2));
    expect(
      events.first.trigger,
      LiveMonitorEarthquakeTrigger.telegram(
        kind: .vxse62,
        reportedAt: _reportedAt.add(const Duration(minutes: 6)),
      ),
    );
    expect(
      events.last.trigger,
      const LiveMonitorEarthquakeTrigger.estimatedIntensity(generatedAt: null),
    );
    expect(
      events.last.earthquake.estimatedIntensityTileUrl,
      'https://tiles.eqmonitor.app/estimated/tile-2.pmtiles',
    );
  });

  test('初期detail待機中に届いた同一推計震度を一度だけ発行する', () async {
    final initialDetail = Completer<Earthquake>();
    final generatedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await fixture.settle();

    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'Q',
        estimatedIntensityTile: 'estimated/tile-2.pmtiles',
        generatedAt: generatedAt,
        source: RealtimeSource.eqmonitor,
      ),
    );
    final resolvedDetail = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-2.pmtiles',
    );
    fixture.detailStore.values['Q'] = resolvedDetail;
    initialDetail.complete(resolvedDetail);
    await initialization;
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>();
    expect(events, hasLength(1));
    expect(
      events.single.trigger,
      LiveMonitorEarthquakeTrigger.estimatedIntensity(generatedAt: generatedAt),
    );
  });

  test('初期化中の重複Readyを保持して初期化直後に一度だけ再同期する', () async {
    final initialDetail = Completer<Earthquake>();
    final fixture = createFixture(
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await fixture.settle();

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      telegramType: .vxse62,
    );
    fixture.realtime
      ..add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor))
      ..add(const RealtimeEvent.ready(source: RealtimeSource.dmdata));
    initialDetail.complete(earthquake(eventId: 'Q'));
    await initialization;
    await fixture.settle();

    final event =
        fixture.events.single.event as LiveMonitorEarthquakeUpsertEvent;
    expect(event.trigger.kind, LiveMonitorEarthquakeTriggerKind.vxse62);
    expect(fixture.pageStore.loadCount, 2);
  });

  test('再同期中に届いた複数Readyを一度のfollow-up再同期へまとめる', () async {
    final fixture = createFixture();
    addTearDown(fixture.container.dispose);
    await fixture.start();
    final delayedResync = Completer<PaginatedResponse<EarthquakePartial>>();
    fixture.pageStore.delayedLoads[2] = delayedResync;

    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();
    expect(fixture.pageStore.loadCount, 2);
    fixture.realtime
      ..add(const RealtimeEvent.ready(source: RealtimeSource.dmdata))
      ..add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor));
    delayedResync.complete(emptyPage());
    await fixture.settle();

    expect(fixture.pageStore.loadCount, 3);
    expect(fixture.events, isEmpty);
  });

  test('stale初期baselineはrawで進んだ推計震度URLを巻き戻さない', () async {
    final initialDetail = Completer<Earthquake>();
    final generatedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {'Q': earthquake(eventId: 'Q')},
      firstDetailLoads: {'Q': initialDetail},
    );
    addTearDown(fixture.container.dispose);
    final initialization = fixture.container.read(
      liveMonitorDetectedEventProvider.future,
    );
    await fixture.settle();

    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'Q',
        estimatedIntensityTile: 'estimated/tile-2.pmtiles',
        generatedAt: generatedAt,
        source: RealtimeSource.eqmonitor,
      ),
    );
    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-2.pmtiles',
    );
    initialDetail.complete(
      earthquake(
        eventId: 'Q',
        tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-1.pmtiles',
      ),
    );
    await initialization;
    await fixture.settle();
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>();
    expect(events, hasLength(1));
    expect(
      events.single.trigger,
      LiveMonitorEarthquakeTrigger.estimatedIntensity(generatedAt: generatedAt),
    );
  });

  test('RealtimeとRESTの同一VXSE更新を一度だけ発行する', () async {
    final initial = earthquake(eventId: 'Q');
    final fixture = createFixture(details: {'Q': initial});
    addTearDown(fixture.container.dispose);
    await fixture.start();
    final record = earthquakeRecord(eventId: 'Q', telegramType: .vxse62);

    fixture.realtime.add(
      RealtimeEvent.earthquakeUpsert(
        record: record,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    fixture.detailStore.values['Q'] = record.toEarthquake(
      parameter: _earthquakeParameter,
      shindoDbStations: _shindoDbStations,
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    expect(
      fixture.events.where(
        (envelope) => envelope.event is LiveMonitorEarthquakeUpsertEvent,
      ),
      hasLength(1),
    );
  });

  test('初期一覧外のRealtime地震も既存converterで即時発行する', () async {
    final fixture = createFixture(details: {'Q': earthquake(eventId: 'Q')});
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime.add(
      RealtimeEvent.earthquakeUpsert(
        record: earthquakeRecord(eventId: 'OUTSIDE', telegramType: .vxse53),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();

    final event =
        fixture.events.single.event as LiveMonitorEarthquakeUpsertEvent;
    expect(event.eventId, 'OUTSIDE');
    expect(event.trigger.kind, LiveMonitorEarthquakeTriggerKind.vxse53);
  });

  test('推計震度はfull detail取得後だけ発行しReadyでpendingを再試行する', () async {
    final fixture = createFixture(details: {'Q': earthquake(eventId: 'Q')});
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'Q',
        estimatedIntensityTile: 'tile-2.pmtiles',
        generatedAt: _now,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    expect(fixture.events, isEmpty);

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/tile-2.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    final event =
        fixture.events.single.event as LiveMonitorEarthquakeUpsertEvent;
    expect(
      event.trigger,
      LiveMonitorEarthquakeTrigger.estimatedIntensity(generatedAt: _now),
    );
    expect(event.earthquake.estimatedIntensityTileUrl, isNotNull);
  });

  test('推計震度はraw identifierと一致するfull URLまでpendingを維持する', () async {
    final generatedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {
        'Q': earthquake(
          eventId: 'Q',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-1.pmtiles',
        ),
      },
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'Q',
        estimatedIntensityTile: 'estimated/tile-2.pmtiles',
        generatedAt: generatedAt,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    expect(fixture.events, isEmpty);

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-2.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    final event =
        fixture.events.single.event as LiveMonitorEarthquakeUpsertEvent;
    expect(
      event.trigger,
      LiveMonitorEarthquakeTrigger.estimatedIntensity(generatedAt: generatedAt),
    );
  });

  test('推計震度は相対URLで解決せずabsolute URLまでpendingを維持する', () async {
    final generatedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(details: {'Q': earthquake(eventId: 'Q')});
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'Q',
        estimatedIntensityTile: 'estimated/tile-2.pmtiles',
        generatedAt: generatedAt,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'estimated/tile-2.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();
    expect(fixture.events, isEmpty);

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-2.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.dmdata),
    );
    await fixture.settle();

    final event =
        fixture.events.single.event as LiveMonitorEarthquakeUpsertEvent;
    expect(
      event.trigger,
      LiveMonitorEarthquakeTrigger.estimatedIntensity(generatedAt: generatedAt),
    );
  });

  test('複数推計震度identifierを到着順と各generatedAtのまま解決する', () async {
    final tile2GeneratedAt = _now.subtract(const Duration(seconds: 2));
    final tile3GeneratedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {
        'Q': earthquake(
          eventId: 'Q',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-1.pmtiles',
        ),
      },
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'Q',
          estimatedIntensityTile: 'estimated/tile-2.pmtiles',
          generatedAt: tile2GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      )
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'Q',
          estimatedIntensityTile: 'estimated/tile-3.pmtiles',
          generatedAt: tile3GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      );
    await fixture.settle();
    expect(fixture.events, isEmpty);

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-2.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-3.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.dmdata),
    );
    await fixture.settle();

    final generatedTimes = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .map(
          (event) => switch (event.trigger) {
            LiveMonitorEstimatedIntensityTrigger(:final generatedAt) =>
              generatedAt,
            LiveMonitorTelegramTrigger() => null,
          },
        );
    expect(generatedTimes, [tile2GeneratedAt, tile3GeneratedAt]);
  });

  test('現在full URLに一致する最新pendingを発行し古いpendingを破棄する', () async {
    final tile2GeneratedAt = _now.subtract(const Duration(seconds: 2));
    final tile3GeneratedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {
        'Q': earthquake(
          eventId: 'Q',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-1.pmtiles',
        ),
      },
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'Q',
          estimatedIntensityTile: 'estimated/tile-2.pmtiles',
          generatedAt: tile2GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      )
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'Q',
          estimatedIntensityTile: 'estimated/tile-3.pmtiles',
          generatedAt: tile3GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      );
    await fixture.settle();
    fixture.detailStore.values['Q'] = earthquake(
      eventId: 'Q',
      tileUrl: 'https://tiles.eqmonitor.app/estimated/tile-3.pmtiles',
    );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.dmdata),
    );
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>();
    expect(events, hasLength(1));
    expect(
      events.single.trigger,
      LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: tile3GeneratedAt,
      ),
    );
    expect(
      events.single.earthquake.estimatedIntensityTileUrl,
      'https://tiles.eqmonitor.app/estimated/tile-3.pmtiles',
    );
  });

  test('別eventIdを跨ぐpendingはsupersede後もglobal到着順で発行する', () async {
    final a2GeneratedAt = _now.subtract(const Duration(seconds: 3));
    final b2GeneratedAt = _now.subtract(const Duration(seconds: 2));
    final a3GeneratedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {
        'A': earthquake(
          eventId: 'A',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/a-tile-1.pmtiles',
        ),
        'B': earthquake(
          eventId: 'B',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/b-tile-1.pmtiles',
        ),
      },
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'A',
          estimatedIntensityTile: 'estimated/a-tile-2.pmtiles',
          generatedAt: a2GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      )
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'B',
          estimatedIntensityTile: 'estimated/b-tile-2.pmtiles',
          generatedAt: b2GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      )
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'A',
          estimatedIntensityTile: 'estimated/a-tile-3.pmtiles',
          generatedAt: a3GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      );
    await fixture.settle();
    fixture.detailStore
      ..values['A'] = earthquake(
        eventId: 'A',
        tileUrl: 'https://tiles.eqmonitor.app/estimated/a-tile-3.pmtiles',
      )
      ..values['B'] = earthquake(
        eventId: 'B',
        tileUrl: 'https://tiles.eqmonitor.app/estimated/b-tile-2.pmtiles',
      );
    fixture.realtime.add(
      const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
    );
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .toList(growable: false);
    expect(events.map((event) => event.eventId), ['B', 'A']);
    expect(events.map((event) => event.trigger), [
      LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: b2GeneratedAt,
      ),
      LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: a3GeneratedAt,
      ),
    ]);
    expect(events, hasLength(2));
  });

  test('通常raw retryも別eventIdを跨ぐpendingをglobal到着順で発行する', () async {
    final b2GeneratedAt = _now.subtract(const Duration(seconds: 2));
    final a3GeneratedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {
        'A': earthquake(
          eventId: 'A',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/a-tile-1.pmtiles',
        ),
        'B': earthquake(
          eventId: 'B',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/b-tile-1.pmtiles',
        ),
      },
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'A',
        estimatedIntensityTile: 'estimated/a-tile-2.pmtiles',
        generatedAt: _now.subtract(const Duration(seconds: 3)),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'B',
        estimatedIntensityTile: 'estimated/b-tile-2.pmtiles',
        generatedAt: b2GeneratedAt,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    fixture.detailStore
      ..values['A'] = earthquake(
        eventId: 'A',
        tileUrl: 'https://tiles.eqmonitor.app/estimated/a-tile-3.pmtiles',
      )
      ..values['B'] = earthquake(
        eventId: 'B',
        tileUrl: 'https://tiles.eqmonitor.app/estimated/b-tile-2.pmtiles',
      );
    fixture.realtime.add(
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'A',
        estimatedIntensityTile: 'estimated/a-tile-3.pmtiles',
        generatedAt: a3GeneratedAt,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();

    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .toList(growable: false);
    expect(events.map((event) => event.eventId), ['B', 'A']);
    expect(events.map((event) => event.trigger), [
      LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: b2GeneratedAt,
      ),
      LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: a3GeneratedAt,
      ),
    ]);
  });

  test('1 retry passはeventIdごとにfull detailを一度だけ取得する', () async {
    final b2GeneratedAt = _now.subtract(const Duration(seconds: 2));
    final a3GeneratedAt = _now.subtract(const Duration(seconds: 1));
    final fixture = createFixture(
      details: {
        'A': earthquake(
          eventId: 'A',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/a-tile-1.pmtiles',
        ),
        'B': earthquake(
          eventId: 'B',
          tileUrl: 'https://tiles.eqmonitor.app/estimated/b-tile-1.pmtiles',
        ),
      },
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();
    fixture.detailStore.fetchCounts.clear();
    fixture.detailStore.failures.addAll(['A', 'B']);

    fixture.realtime
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'A',
          estimatedIntensityTile: 'estimated/a-tile-2.pmtiles',
          generatedAt: _now.subtract(const Duration(seconds: 3)),
          source: RealtimeSource.eqmonitor,
        ),
      )
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'B',
          estimatedIntensityTile: 'estimated/b-tile-2.pmtiles',
          generatedAt: b2GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      )
      ..add(
        RealtimeEvent.estimatedIntensityUpsert(
          eventId: 'A',
          estimatedIntensityTile: 'estimated/a-tile-3.pmtiles',
          generatedAt: a3GeneratedAt,
          source: RealtimeSource.eqmonitor,
        ),
      );
    await fixture.settle();
    expect(fixture.detailStore.fetchCounts, {'A': 3, 'B': 2});
    fixture.detailStore
      ..failures.clear()
      ..fetchCounts.clear()
      ..values['A'] = earthquake(
        eventId: 'A',
        tileUrl: 'https://tiles.eqmonitor.app/estimated/a-tile-3.pmtiles',
      )
      ..values['B'] = earthquake(
        eventId: 'B',
        tileUrl: 'https://tiles.eqmonitor.app/estimated/b-tile-2.pmtiles',
      );

    await fixture.container
        .read(liveMonitorDetectedEventProvider.notifier)
        .resolvePendingEstimatedIntensity();
    await fixture.settle();

    expect(fixture.detailStore.fetchCounts, {'A': 1, 'B': 1});
    final events = fixture.events
        .map((envelope) => envelope.event)
        .whereType<LiveMonitorEarthquakeUpsertEvent>()
        .toList(growable: false);
    expect(events.map((event) => event.eventId), ['B', 'A']);
    expect(events.map((event) => event.trigger), [
      LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: b2GeneratedAt,
      ),
      LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: a3GeneratedAt,
      ),
    ]);
  });

  test('推計震度detail失敗時はCardを合成せずforegroundで再試行する', () async {
    final fixture = createFixture(details: {'Q': earthquake(eventId: 'Q')});
    addTearDown(fixture.container.dispose);
    await fixture.start();
    fixture.detailStore.failures.add('Q');

    fixture.realtime.add(
      const RealtimeEvent.estimatedIntensityUpsert(
        eventId: 'Q',
        estimatedIntensityTile: 'tile-2.pmtiles',
        generatedAt: null,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();
    expect(fixture.events, isEmpty);

    fixture.detailStore
      ..failures.remove('Q')
      ..values['Q'] = earthquake(
        eventId: 'Q',
        tileUrl: 'https://tiles.eqmonitor.app/tile-2.pmtiles',
      );
    fixture.lifecycle
      ..publish(AppLifecycleState.paused)
      ..publish(AppLifecycleState.resumed);
    await fixture.settle();

    expect(
      fixture.events.single.event,
      isA<LiveMonitorEarthquakeUpsertEvent>(),
    );
  });

  test('REST再同期失敗後も後続raw eventを到着順に処理する', () async {
    final fixture = createFixture();
    addTearDown(fixture.container.dispose);
    await fixture.start();
    fixture.pageStore.failAfterFirstLoad = true;

    fixture.realtime
      ..add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor))
      ..add(
        const RealtimeEvent.earthquakeDelete(
          eventId: 'AFTER-ERROR',
          source: RealtimeSource.eqmonitor,
        ),
      );
    await fixture.settle();

    expect(fixture.events.single.event.eventId, 'AFTER-ERROR');
  });

  test('foreground REST再同期失敗を隔離して後続raw eventを処理する', () async {
    final fixture = createFixture();
    addTearDown(fixture.container.dispose);
    await fixture.start();
    fixture.pageStore.failAfterFirstLoad = true;

    fixture.lifecycle
      ..publish(AppLifecycleState.paused)
      ..publish(AppLifecycleState.resumed);
    await fixture.settle();
    fixture.realtime.add(
      const RealtimeEvent.earthquakeDelete(
        eventId: 'AFTER-FOREGROUND-ERROR',
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.settle();

    expect(fixture.events.single.event.eventId, 'AFTER-FOREGROUND-ERROR');
  });

  test('canonical揺れ検知は結合済みと期限切れを除外する', () async {
    final fixture = createFixture(
      shakeSnapshot: snapshot(
        revision: 1,
        events: [shakeEvent(eventId: 'baseline', serialNo: 1)],
      ),
    );
    addTearDown(fixture.container.dispose);
    await fixture.start();

    fixture.shake.publish(
      snapshot(
        revision: 2,
        events: [
          shakeEvent(eventId: 'visible', serialNo: 1),
          shakeEvent(
            eventId: 'correlated',
            serialNo: 1,
            correlatedEewEventId: 'E',
          ),
          shakeEvent(eventId: 'expired', serialNo: 1, expiresAt: _now),
        ],
      ),
    );
    await fixture.settle();

    expect(fixture.events.map((envelope) => envelope.event.eventId), [
      'visible',
    ]);
  });
}

_DetectedEventFixture createFixture({
  List<EewTelegramItem>? eews = const [],
  ShakeDetectionSnapshot? shakeSnapshot,
  Map<String, Earthquake> details = const {},
  Completer<PaginatedResponse<EarthquakePartial>>? pageCompleter,
  Map<String, Completer<Earthquake>> firstDetailLoads = const {},
  bool failFirstPageLoad = false,
}) {
  final realtime = StreamController<RealtimeEvent>.broadcast(sync: true);
  addTearDown(realtime.close);
  final mutableEews = _MutableEews(eews);
  final mutableShake = _MutableShakeSnapshot(shakeSnapshot);
  final lifecycle = _MutableLifecycle();
  final eventIds = details.keys.toList(growable: false);
  final pageStore =
      _PageStore(
          PaginatedResponse(
            items: eventIds.map(earthquakePartial).toList(growable: false),
            nextToken: null,
          ),
        )
        ..firstLoad = pageCompleter
        ..failFirstLoad = failFirstPageLoad;
  final detailStore = _DetailStore()
    ..values.addAll(details)
    ..firstLoads.addAll(firstDetailLoads);
  final repository = EarthquakeHistoryRepository(
    earthquake: api.ApiClient(Dio()).earthquake,
    earthquakeParameter: _earthquakeParameter,
    shindoDbStations: _shindoDbStations,
  );
  final container = ProviderContainer(
    overrides: [
      realtimeEventsProvider.overrideWith(
        () => _StubRealtimeEvents(realtime.stream),
      ),
      eewAliveTelegramProvider.overrideWith(() => mutableEews),
      shakeDetectionAcceptedSnapshotProvider.overrideWith(() => mutableShake),
      appLifecycleProvider.overrideWith(() => lifecycle),
      appClockProvider.overrideWith(_FixedAppClock.new),
      liveMonitorSettingsProvider.overrideWith(_StaticSettings.new),
      earthquakeHistoryProvider(
        liveMonitorLatestParameter,
      ).overrideWith(() => _StubHistoryNotifier(pageStore)),
      earthquakeHistoryRepositoryProvider.overrideWith(
        (ref) async => repository,
      ),
      for (final eventId in {'Q', 'OUTSIDE', ...eventIds})
        earthquakeHistoryDetailsProvider(
          eventId,
        ).overrideWith(() => _StubDetailsNotifier(detailStore)),
    ],
  );
  final events = <LiveMonitorEventEnvelope>[];
  container.listen(liveMonitorDetectedEventProvider, (_, next) {
    final envelope = next.value;
    if (envelope != null &&
        events.every((event) => event.sequence != envelope.sequence)) {
      events.add(envelope);
    }
  }, fireImmediately: true);
  return _DetectedEventFixture(
    container: container,
    realtime: realtime,
    eews: mutableEews,
    shake: mutableShake,
    lifecycle: lifecycle,
    pageStore: pageStore,
    detailStore: detailStore,
    events: events,
  );
}

PaginatedResponse<EarthquakePartial> emptyPage() =>
    const PaginatedResponse(items: <EarthquakePartial>[], nextToken: null);

EewTelegramItem eew({required String eventId, required int serialNo}) =>
    EewTelegramItem(
      eventId: eventId,
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: serialNo,
      isCanceled: false,
      isLastInfo: false,
      reportTime: _now,
      isPlum: false,
    );

ShakeDetectionSnapshot snapshot({
  required int revision,
  required List<ShakeDetectionEvent> events,
}) => ShakeDetectionSnapshot(
  revision: revision,
  responseAt: _now,
  events: events,
);

ShakeDetectionEvent shakeEvent({
  required String eventId,
  required int serialNo,
  DateTime? expiresAt,
  String? correlatedEewEventId,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: serialNo,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: expiresAt ?? _now.add(const Duration(minutes: 1)),
  level: api.ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);

Earthquake earthquake({
  required String eventId,
  EarthquakeTelegramType? telegramType,
  List<EarthquakeTelegramMetadata>? metadata,
  String? tileUrl,
}) => Earthquake(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: _reportedAt,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: _reportedAt,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes:
      metadata?.map((item) => item.type).toList(growable: false) ??
      (telegramType == null ? const [] : [telegramType]),
  telegramMetadata:
      metadata ??
      (telegramType == null
          ? const []
          : [
              EarthquakeTelegramMetadata(
                type: telegramType,
                reportedAt: _reportedAt,
              ),
            ]),
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  estimatedIntensityTileUrl: tileUrl,
);

EarthquakePartial earthquakePartial(String eventId) => EarthquakePartialNormal(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: _reportedAt,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: _reportedAt,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);

api.Earthquake earthquakeRecord({
  required String eventId,
  EarthquakeTelegramType? telegramType,
  List<EarthquakeTelegramMetadata>? metadata,
  String? tileUrl,
}) => api.Earthquake(
  eventId: eventId,
  status: api.TelegramStatus.normal,
  earthquakeType: api.EarthquakeType.normal,
  originTime: _reportedAt,
  arrivalTime: _reportedAt,
  originTimePrecision: api.OriginTimePrecision.second,
  datasources: const [api.EarthquakeDatasource.jmaDisasterInformationXml],
  telegrams:
      (metadata ??
              [
                EarthquakeTelegramMetadata(
                  type: telegramType ?? EarthquakeTelegramType.vxse53,
                  reportedAt: _reportedAt,
                ),
              ])
          .indexed
          .map(
            (entry) => api.EarthquakeTelegram(
              telegram: api.Telegram(
                id: 'telegram-$eventId-${entry.$1}',
                eventId: eventId,
                type: switch (entry.$2.type) {
                  EarthquakeTelegramType.vxse51 => api.TelegramType.vxse51,
                  EarthquakeTelegramType.vxse52 => api.TelegramType.vxse52,
                  EarthquakeTelegramType.vxse53 => api.TelegramType.vxse53,
                  EarthquakeTelegramType.vxse61 => api.TelegramType.vxse61,
                  EarthquakeTelegramType.vxse62 => api.TelegramType.vxse62,
                  EarthquakeTelegramType.vxse45Forecast =>
                    api.TelegramType.vxse45,
                  EarthquakeTelegramType.vxse45Warning =>
                    api.TelegramType.vxse45,
                },
                title: '地震情報',
                status: api.TelegramStatus.normal,
                infoType: api.InfoType.publication,
                editorialOffice: '気象庁本庁',
                publishingOffice: const ['気象庁'],
                pressedAt: _reportedAt,
                reportedAt: entry.$2.reportedAt,
                infoKind: '地震情報',
                infoKindVersion: '1.0_0',
                hash: 'hash-$eventId',
                createdAt: entry.$2.reportedAt,
              ),
              comments: const api.TelegramComments(),
            ),
          )
          .toList(growable: false),
  estimatedIntensityTile: tileUrl,
);

EarthquakeTelegramMetadata metadata({
  required EarthquakeTelegramType type,
  required int minute,
}) => EarthquakeTelegramMetadata(
  type: type,
  reportedAt: _reportedAt.add(Duration(minutes: minute)),
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
