import 'dart:async';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class _StubRealtimeEvents extends RealtimeEvents {
  new(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

void main() {
  test('readyとアプリ復帰の再取得中も既存EEWを保持する', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final pending = <Completer<List<EewTelegramItem>>>[];
    final item = _eew(serialNo: 1, zoneName: 'rest').toEewTelegramItem;
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        eewRestProvider.overrideWith((ref) {
          final request = Completer<List<EewTelegramItem>>();
          pending.add(request);
          return request.future;
        }),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(eewProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.pump();
    pending.single.complete([item]);
    await container.pump();
    expect(container.read(eewProvider).value, [item]);

    for (var cycle = 0; cycle < 2; cycle += 1) {
      if (cycle == 0) {
        controller.add(
          const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
        );
      } else {
        final lifecycle = container.read(appLifecycleProvider.notifier);
        lifecycle.didChangeAppLifecycleState(AppLifecycleState.paused);
        await container.pump();
        lifecycle.didChangeAppLifecycleState(AppLifecycleState.resumed);
      }
      await container.pump();
      expect(pending.length, cycle + 2);
      // 通信中でも表示用データを消さない。
      expect(container.read(eewRestProvider).value, [item]);
      expect(container.read(eewRestProvider).isLoading, isTrue);
      expect(container.read(eewProvider).value, [item]);
      pending.last.complete([item]);
      await container.pump();
      expect(container.read(eewProvider).value, [item]);
    }
  });

  group('REST取得と表示状態の分離', () {
    late ProviderContainer container;
    late StreamController<RealtimeEvent> controller;
    late List<Completer<List<EewTelegramItem>>> requests;
    late StreamController<DateTime> ticks;

    setUp(() async {
      controller = StreamController<RealtimeEvent>.broadcast(sync: true);
      requests = [];
      ticks = StreamController<DateTime>.broadcast(sync: true);
      addTearDown(ticks.close);
      container = ProviderContainer(
        retry: (_, _) => null,
        overrides: [
          timeTickerProvider().overrideWith((ref) => ticks.stream),
          realtimeEventsProvider.overrideWith(
            () => _StubRealtimeEvents(controller.stream),
          ),
          eewRestProvider.overrideWith((ref) {
            final request = Completer<List<EewTelegramItem>>();
            requests.add(request);
            return request.future;
          }),
        ],
      );
      addTearDown(controller.close);
      addTearDown(container.dispose);
      final subscription = container.listen(eewProvider, (_, _) {});
      addTearDown(subscription.close);
      await container.pump();
    });

    for (final asReload in [true, false]) {
      test('再取得開始時にRealtimeの最新報を巻き戻さない: asReload=$asReload', () async {
        requests.single.complete([
          _eew(serialNo: 1, zoneName: 'rest').toEewTelegramItem,
        ]);
        await container.pump();
        controller.add(
          RealtimeEvent.eewUpsert(
            record: _eew(serialNo: 2, zoneName: 'realtime'),
            source: RealtimeSource.eqmonitor,
          ),
        );
        await container.pump();
        container.invalidate(eewRestProvider, asReload: asReload);
        await container.pump();
        expect(container.read(eewProvider).value?.single.serialNo, 2);
        requests.last.complete([
          _eew(serialNo: 1, zoneName: 'stale-rest').toEewTelegramItem,
        ]);
        await container.pump();
        expect(container.read(eewProvider).value?.single.serialNo, 2);
      });
    }

    test('初回RESTより先に届いたRealtimeを再取得中と失敗時にも保持する', () async {
      controller.add(
        RealtimeEvent.eewUpsert(
          record: _eew(serialNo: 2, zoneName: 'realtime'),
          source: RealtimeSource.eqmonitor,
        ),
      );
      await container.pump();
      container.invalidate(eewRestProvider, asReload: true);
      await container.pump();
      expect(container.read(eewProvider).value?.single.serialNo, 2);
      requests.first.complete([]);
      requests.last.completeError(StateError('REST unavailable'));
      await container.pump();
      expect(container.read(eewRestProvider).hasError, isTrue);
      expect(container.read(eewProvider).value?.single.serialNo, 2);
    });

    test('受信済みデータがない場合は初回LoadingとErrorを伝える', () async {
      expect(container.read(eewProvider).isLoading, isTrue);
      final error = StateError('REST unavailable');
      requests.single.completeError(error);
      await container.pump();
      expect(container.read(eewProvider).error, same(error));
      expect(container.read(eewProvider).hasValue, isFalse);
    });

  });

  test('full EEW recordを反映し古いserialを無視すること', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        eewRestProvider.overrideWith((ref) async => []),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(eewProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.pump();

    controller.add(
      RealtimeEvent.eewUpsert(
        record: _eew(serialNo: 2, zoneName: 'new'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    controller.add(
      RealtimeEvent.eewUpsert(
        record: _eew(serialNo: 1, zoneName: 'old'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();

    final item = container.read(eewProvider).value?.single;
    expect(item?.serialNo, 2);
    expect(item?.warning?.zones.single.name, 'new');
  });

  test('ready REST中の新しいrealtimeを古いREST完了で上書きしないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final readyRest = Completer<List<EewTelegramItem>>();
    var restFetchCount = 0;
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        eewRestProvider.overrideWith((ref) {
          restFetchCount += 1;
          if (restFetchCount == 1) {
            return Future.value([]);
          }
          return readyRest.future;
        }),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(eewProvider, (_, _) {});
    addTearDown(subscription.close);
    await _waitFor(() => restFetchCount == 1);
    await _waitFor(() => container.read(eewProvider).hasValue);

    controller.add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor));
    await _waitFor(() => restFetchCount == 2);
    controller.add(
      RealtimeEvent.eewUpsert(
        record: _eew(serialNo: 2, zoneName: 'realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    readyRest.complete([
      _eew(serialNo: 1, zoneName: 'old-rest').toEewTelegramItem,
    ]);
    await container.pump();

    final item = container.read(eewProvider).value?.single;
    expect(item?.serialNo, 2);
    expect(item?.warning?.zones.single.name, 'realtime');
    expect(restFetchCount, 2);
  });

  test('同一serialのREST確認後はrealtime overlayを退役させること', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    var restFetchCount = 0;
    final results = <List<EewTelegramItem>>[
      [],
      [_eew(serialNo: 2, zoneName: 'confirmed').toEewTelegramItem],
      [_eew(serialNo: 1, zoneName: 'later-rest').toEewTelegramItem],
    ];
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        eewRestProvider.overrideWith((ref) async {
          final result = results[restFetchCount];
          restFetchCount += 1;
          return result;
        }),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(eewProvider, (_, _) {});
    addTearDown(subscription.close);
    await _waitFor(() => restFetchCount == 1);
    await _waitFor(() => container.read(eewProvider).hasValue);

    controller.add(
      RealtimeEvent.eewUpsert(
        record: _eew(serialNo: 2, zoneName: 'realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    container.invalidate(eewRestProvider);
    await _waitFor(() => restFetchCount == 2);
    await container.pump();
    expect(
      container.read(eewProvider).value?.single.warning?.zones.single.name,
      'confirmed',
    );

    container.invalidate(eewRestProvider);
    await _waitFor(() => restFetchCount == 3);
    await container.pump();
    final item = container.read(eewProvider).value?.single;
    expect(item?.serialNo, 1);
    expect(item?.warning?.zones.single.name, 'later-rest');
  });

  test('非realtime再生への遷移でrealtime overlayを破棄すること', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        eewRestProvider.overrideWith((ref) async => []),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(eewProvider, (_, _) {});
    addTearDown(subscription.close);
    await _waitFor(() => container.read(eewProvider).hasValue);

    controller.add(
      RealtimeEvent.eewUpsert(
        record: _eew(serialNo: 2, zoneName: 'realtime'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    expect(container.read(eewProvider).value?.single.serialNo, 2);

    container
        .read(appClockProvider.notifier)
        .enterTimeShift(const Duration(minutes: -1));
    await container.pump();
    expect(container.read(eewProvider).value, isEmpty);

    container.read(appClockProvider.notifier).returnToRealtime();
    await container.pump();
    expect(container.read(eewProvider).value, isEmpty);
  });
}

Future<void> _waitFor(bool Function() condition) async {
  for (var i = 0; i < 20 && !condition(); i += 1) {
    await Future<void>.delayed(Duration.zero);
  }
  expect(condition(), isTrue);
}

api.EewItemWithRelations _eew({
  required int serialNo,
  required String zoneName,
}) => api.EewItemWithRelations(
  eventId: 'event-1',
  type: api.TelegramType.vxse45,
  status: api.TelegramStatus.normal,
  infoType: api.InfoType.publication,
  serialNo: serialNo,
  headline: null,
  isCanceled: false,
  isWarning: true,
  isLastInfo: false,
  originTime: null,
  arrivalTime: null,
  accuracy: null,
  isPlum: false,
  editorialOffice: '気象庁',
  reportTime: DateTime.utc(2026, 5, 1, 9),
  warning: api.EewWarning(
    zones: [
      api.EewWarningZoneItem(code: '9011', name: zoneName, hadWarning: false),
    ],
    prefectures: const [],
    regions: const [],
  ),
);
