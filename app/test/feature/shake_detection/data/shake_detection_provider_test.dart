import 'dart:async';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_snapshot.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/repository/shake_detection_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

final _baseTime = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent domainEvent(String eventId) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: _baseTime,
  updatedAt: _baseTime,
  expiresAt: _baseTime.add(const Duration(minutes: 1)),
  level: api.ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
);

ShakeDetectionSnapshot domainSnapshot({
  required int revision,
  required List<String> eventIds,
}) => ShakeDetectionSnapshot(
  revision: revision,
  responseAt: _baseTime,
  events: eventIds.map(domainEvent).toList(growable: false),
);

RealtimeShakeSnapshot realtimeSnapshot({
  required int revision,
  required List<String> eventIds,
}) => RealtimeShakeSnapshot(
  revision: revision,
  responseAt: _baseTime,
  events: eventIds
      .map(
        (eventId) => RealtimeShakeEventData(
          eventId: eventId,
          serialNo: 1,
          createdAt: _baseTime,
          updatedAt: _baseTime,
          expiresAt: _baseTime.add(const Duration(minutes: 1)),
          level: 'Medium',
          pointCount: 1,
          minLat: 35,
          maxLat: 36,
          minLng: 139,
          maxLng: 140,
          changeReasons: const ['new_event'],
        ),
      )
      .toList(growable: false),
);

RealtimeEvent shakeRealtime({
  required int revision,
  required List<String> eventIds,
}) => RealtimeEvent.shakeSnapshot(
  data: realtimeSnapshot(revision: revision, eventIds: eventIds),
  source: RealtimeSource.eqmonitor,
);

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this._stream);

  final Stream<RealtimeEvent> _stream;

  @override
  Stream<RealtimeEvent> build() => _stream;
}

final class _QueuedShakeDetectionRepository
    implements ShakeDetectionRepository {
  _QueuedShakeDetectionRepository(this.results);

  final List<
    Completer<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  >
  results;
  int callCount = 0;

  @override
  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive() {
    final result = results[callCount];
    callCount += 1;
    return result.future;
  }
}

final class _MutableEqMonitorWsStatus extends EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() =>
      const EqMonitorWsStatusState(phase: WsPhase.connected);

  void setPhase(WsPhase phase) {
    state = state.copyWith(phase: phase);
  }
}

final class _RecordingTalkerObserver extends TalkerObserver {
  int notificationCount = 0;

  void reset() {
    notificationCount = 0;
  }

  @override
  void onError(TalkerError err) {
    notificationCount += 1;
  }

  @override
  void onException(TalkerException err) {
    notificationCount += 1;
  }

  @override
  void onLog(TalkerData log) {
    notificationCount += 1;
  }
}

final _talkerObserver = _RecordingTalkerObserver();

void main() {
  setUpAll(() {
    talker_lib.talker = Talker(observer: _talkerObserver);
  });

  setUp(_talkerObserver.reset);

  group('ShakeDetection', () {
    late StreamController<RealtimeEvent> controller;
    late List<
      Completer<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
    >
    restCompleters;
    late _QueuedShakeDetectionRepository repository;
    late ProviderContainer container;
    late ProviderSubscription<List<ShakeDetectionEvent>> subscription;
    var containerDisposed = false;

    setUp(() async {
      controller = StreamController<RealtimeEvent>.broadcast(sync: true);
      restCompleters = List.generate(4, (_) => Completer());
      repository = _QueuedShakeDetectionRepository(restCompleters);
      containerDisposed = false;
      container = ProviderContainer(
        overrides: [
          realtimeEventsProvider.overrideWith(
            () => _StubRealtimeEvents(controller.stream),
          ),
          shakeDetectionRepositoryProvider.overrideWith(
            (ref) async => repository,
          ),
          eqMonitorWsStatusProvider.overrideWith(_MutableEqMonitorWsStatus.new),
        ],
      );
      subscription = container.listen(shakeDetectionProvider, (_, _) {});
      await pumpEventQueue();
    });

    tearDown(() async {
      if (!containerDisposed) {
        subscription.close();
        container.dispose();
      }
      await controller.close();
    });

    test('ready後のREST中に新しいWebSocket revisionが来ても巻き戻さないこと', () async {
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();

      controller.add(
        RealtimeEvent.shakeSnapshot(
          data: realtimeSnapshot(revision: 12, eventIds: ['ws-new']),
          source: RealtimeSource.eqmonitor,
        ),
      );
      await pumpEventQueue();

      restCompleters[0].complete(
        Success(domainSnapshot(revision: 11, eventIds: ['rest-old'])),
      );
      await pumpEventQueue();

      expect(subscription.read().map((event) => event.eventId), ['ws-new']);
    });

    test('新しいsnapshotのevents全体で置換すること', () async {
      controller.add(shakeRealtime(revision: 1, eventIds: ['a', 'b']));
      controller.add(shakeRealtime(revision: 2, eventIds: ['b', 'c']));
      await pumpEventQueue();

      expect(subscription.read().map((event) => event.eventId), ['b', 'c']);
    });

    test('空snapshotでactive eventを全件削除すること', () async {
      controller.add(shakeRealtime(revision: 1, eventIds: ['a']));
      controller.add(shakeRealtime(revision: 2, eventIds: []));
      await pumpEventQueue();

      expect(subscription.read(), isEmpty);
    });

    test('同一・古いrevisionを無視すること', () async {
      controller.add(shakeRealtime(revision: 5, eventIds: ['current']));
      controller.add(shakeRealtime(revision: 5, eventIds: ['same-revision']));
      controller.add(shakeRealtime(revision: 4, eventIds: ['older']));
      await pumpEventQueue();

      expect(subscription.read().single.eventId, 'current');
    });

    test('REST 503で現在stateを固定値へ置換しないこと', () async {
      controller.add(shakeRealtime(revision: 5, eventIds: ['current']));
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      restCompleters[0].complete(
        const Failure(
          ShakeDetectionApiException(
            message: 'Shake detection state is not available.',
            statusCode: 503,
          ),
        ),
      );
      await pumpEventQueue();

      expect(subscription.read().single.eventId, 'current');
    });

    test('タイムシフト復帰時にready済み接続のREST snapshotを再同期すること', () async {
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();

      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));
      await pumpEventQueue();
      expect(subscription.read(), isEmpty);

      container.read(appClockProvider.notifier).returnToRealtime();
      await pumpEventQueue();

      expect(repository.callCount, 2);
      restCompleters[0].complete(
        Success(domainSnapshot(revision: 9, eventIds: ['obsolete'])),
      );
      await pumpEventQueue();
      expect(subscription.read(), isEmpty);

      restCompleters[1].complete(
        Success(domainSnapshot(revision: 7, eventIds: ['restored'])),
      );
      await pumpEventQueue();
      expect(subscription.read().single.eventId, 'restored');
    });

    test('disconnect前のRESTはreconnect後のready同期を上書きしないこと', () async {
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();

      final wsStatus =
          container.read(eqMonitorWsStatusProvider.notifier)
              as _MutableEqMonitorWsStatus;
      wsStatus.setPhase(WsPhase.disconnected);
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.tsunamiDelete(
          eventId: 'separator',
          source: RealtimeSource.eqmonitor,
        ),
      );
      await pumpEventQueue();
      wsStatus.setPhase(WsPhase.connected);
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();

      expect(repository.callCount, 2);
      restCompleters[0].complete(
        Success(domainSnapshot(revision: 20, eventIds: ['old-session'])),
      );
      restCompleters[1].complete(
        Success(domainSnapshot(revision: 3, eventIds: ['new-session'])),
      );
      await pumpEventQueue();

      expect(subscription.read().single.eventId, 'new-session');
    });

    test('repeated readyで後発RESTが先に完了しても先発RESTを無視すること', () async {
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.tsunamiDelete(
          eventId: 'separator',
          source: RealtimeSource.eqmonitor,
        ),
      );
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();

      expect(repository.callCount, 2);
      restCompleters[1].complete(
        Success(domainSnapshot(revision: 4, eventIds: ['second'])),
      );
      await pumpEventQueue();
      restCompleters[0].complete(
        Success(domainSnapshot(revision: 30, eventIds: ['obsolete-first'])),
      );
      await pumpEventQueue();

      expect(subscription.read().single.eventId, 'second');
    });

    test('repeated readyで先発RESTが先に完了しても後発RESTだけを採用すること', () async {
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.tsunamiDelete(
          eventId: 'separator',
          source: RealtimeSource.eqmonitor,
        ),
      );
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();

      expect(repository.callCount, 2);
      restCompleters[0].complete(
        Success(domainSnapshot(revision: 30, eventIds: ['obsolete-first'])),
      );
      await pumpEventQueue();
      expect(subscription.read(), isEmpty);

      restCompleters[1].complete(
        Success(domainSnapshot(revision: 4, eventIds: ['second'])),
      );
      await pumpEventQueue();
      expect(subscription.read().single.eventId, 'second');
    });

    test('obsolete REST failureをstateに適用せずログにも記録しないこと', () async {
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.tsunamiDelete(
          eventId: 'separator',
          source: RealtimeSource.eqmonitor,
        ),
      );
      await pumpEventQueue();
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();

      restCompleters[0].complete(
        const Failure(ShakeDetectionApiException(message: 'obsolete')),
      );
      await pumpEventQueue();

      expect(subscription.read(), isEmpty);
      expect(_talkerObserver.notificationCount, 0);
      restCompleters[1].complete(
        Success(domainSnapshot(revision: 1, eventIds: ['current'])),
      );
      await pumpEventQueue();
      expect(subscription.read().single.eventId, 'current');
    });

    test('fetch待機中にdisposeしてもstate・ログを更新しないこと', () async {
      controller.add(
        const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
      );
      await pumpEventQueue();
      expect(repository.callCount, 1);

      subscription.close();
      container.dispose();
      containerDisposed = true;
      restCompleters[0].complete(
        const Failure(ShakeDetectionApiException(message: 'disposed')),
      );
      await pumpEventQueue();

      expect(_talkerObserver.notificationCount, 0);
    });
  });

  test('repository解決待機中にdisposeしてもfetch・ログを実行しないこと', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    final repositoryCompleter = Completer<ShakeDetectionRepository>();
    final restCompleters =
        <Completer<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>>[
          Completer(),
        ];
    final repository = _QueuedShakeDetectionRepository(restCompleters);
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        shakeDetectionRepositoryProvider.overrideWith(
          (ref) => repositoryCompleter.future,
        ),
        eqMonitorWsStatusProvider.overrideWith(_MutableEqMonitorWsStatus.new),
      ],
    );
    final subscription = container.listen(shakeDetectionProvider, (_, _) {});
    await pumpEventQueue();
    controller.add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor));
    await pumpEventQueue();

    subscription.close();
    container.dispose();
    repositoryCompleter.complete(repository);
    await pumpEventQueue();

    expect(repository.callCount, 0);
    expect(_talkerObserver.notificationCount, 0);
    await controller.close();
  });
}
