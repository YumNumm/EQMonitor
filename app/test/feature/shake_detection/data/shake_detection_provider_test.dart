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

final class _StubShakeDetectionRepository implements ShakeDetectionRepository {
  _StubShakeDetectionRepository(this.result);

  final Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  result;

  @override
  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive() => result;
}

final class _StubEqMonitorWsStatus extends EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() =>
      const EqMonitorWsStatusState(phase: WsPhase.connected);
}

void main() {
  setUpAll(() {
    talker_lib.talker = Talker();
  });

  group('ShakeDetection', () {
    late StreamController<RealtimeEvent> controller;
    late Completer<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
    restCompleter;
    late ProviderContainer container;
    late ProviderSubscription<List<ShakeDetectionEvent>> subscription;

    setUp(() async {
      controller = StreamController<RealtimeEvent>.broadcast(sync: true);
      restCompleter = Completer();
      container = ProviderContainer(
        overrides: [
          realtimeEventsProvider.overrideWith(
            () => _StubRealtimeEvents(controller.stream),
          ),
          shakeDetectionRepositoryProvider.overrideWith(
            (ref) async => _StubShakeDetectionRepository(restCompleter.future),
          ),
          eqMonitorWsStatusProvider.overrideWith(_StubEqMonitorWsStatus.new),
        ],
      );
      subscription = container.listen(shakeDetectionProvider, (_, _) {});
      await pumpEventQueue();
    });

    tearDown(() async {
      subscription.close();
      container.dispose();
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

      restCompleter.complete(
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
      restCompleter.complete(
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
      restCompleter.complete(
        Success(domainSnapshot(revision: 7, eventIds: ['restored'])),
      );
      await pumpEventQueue();
      expect(subscription.read(), isEmpty);

      container.read(appClockProvider.notifier).returnToRealtime();
      await pumpEventQueue();

      expect(subscription.read().single.eventId, 'restored');
    });
  });
}
