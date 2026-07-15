import 'dart:async';

import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_worker_state.dart';
import 'package:eqmonitor/feature/devices/data/repository/push_token_sync_worker.dart';
import 'package:eqmonitor/feature/devices/data/retry/interruptible_backoff.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PushTokenSyncWorker', () {
    test('deduplicates a synced token within one session', () async {
      final upserts = <String>[];
      final worker = PushTokenSyncWorker(
        upsert: (token) async => upserts.add(token),
        backoff: InterruptibleBackoff(delayOverride: (_) async {}),
      );
      addTearDown(worker.dispose);

      worker.accept(token: 'same-token');
      await worker.states.whereState<PushTokenSyncWorkerSynced>().first;
      worker.accept(token: 'same-token');
      await Future<void>.delayed(Duration.zero);
      expect(upserts, ['same-token']);

      final nextSynced = worker.states
          .whereState<PushTokenSyncWorkerSynced>()
          .first;
      worker.accept(token: 'new-token');
      await nextSynced;
      expect(upserts, ['same-token', 'new-token']);
    });

    test('keeps retrying after seven retryable failures', () async {
      var calls = 0;
      final delays = <Duration>[];
      final worker = PushTokenSyncWorker(
        upsert: (_) async {
          calls++;
          if (calls <= 7) {
            throw const NetworkUnreachableException();
          }
        },
        backoff: InterruptibleBackoff(
          delayOverride: (duration) async => delays.add(duration),
        ),
      );
      addTearDown(worker.dispose);

      worker.accept(token: 'eventually-synced');
      await worker.states.whereState<PushTokenSyncWorkerSynced>().first;

      expect(calls, 8);
      expect(delays, const [
        Duration(seconds: 2),
        Duration(seconds: 4),
        Duration(seconds: 8),
        Duration(seconds: 16),
        Duration(seconds: 32),
        Duration(seconds: 60),
        Duration(seconds: 60),
      ]);
    });

    test(
      'stops after a non-retryable failure until retry is requested',
      () async {
        var calls = 0;
        final worker = PushTokenSyncWorker(
          upsert: (_) async {
            calls++;
            if (calls == 1) {
              throw const InvalidRequestException(statusCode: 400);
            }
          },
          backoff: InterruptibleBackoff(delayOverride: (_) async {}),
        );
        addTearDown(worker.dispose);

        worker.accept(token: 'manual-retry');
        final failed = await worker.states
            .whereState<PushTokenSyncWorkerFailed>()
            .first;
        expect(failed.attempt, 0);
        expect(failed.error, isA<InvalidRequestException>());

        worker.accept(token: 'manual-retry');
        await Future<void>.delayed(Duration.zero);
        expect(calls, 1);

        final synced = worker.states
            .whereState<PushTokenSyncWorkerSynced>()
            .first;
        worker.retry();
        await synced;
        expect(calls, 2);
      },
    );

    test(
      'a new token interrupts waiting and only the latest becomes synced',
      () async {
        final delayed = Completer<void>();
        final upserts = <String>[];
        final worker = PushTokenSyncWorker(
          upsert: (token) async {
            upserts.add(token);
            if (token == 'old-token') {
              throw const NetworkUnreachableException();
            }
          },
          backoff: InterruptibleBackoff(delayOverride: (_) => delayed.future),
        );
        addTearDown(() async {
          if (!delayed.isCompleted) {
            delayed.complete();
          }
          await worker.dispose();
        });

        worker.accept(token: 'old-token');
        await worker.states.whereState<PushTokenSyncWorkerWaiting>().first;
        final emittedStates = <PushTokenSyncWorkerState>[];
        final subscription = worker.states.listen(emittedStates.add);
        addTearDown(subscription.cancel);

        worker.accept(token: 'new-token');
        await worker.states.whereState<PushTokenSyncWorkerSynced>().first;

        expect(upserts, ['old-token', 'new-token']);
        expect(
          emittedStates.whereType<PushTokenSyncWorkerSynced>(),
          hasLength(1),
        );
      },
    );

    test(
      'a token arriving in flight is sent immediately after completion',
      () async {
        final firstUpsert = Completer<void>();
        final upserts = <String>[];
        final delays = <Duration>[];
        final worker = PushTokenSyncWorker(
          upsert: (token) async {
            upserts.add(token);
            if (token == 'old-token') {
              await firstUpsert.future;
            }
          },
          backoff: InterruptibleBackoff(
            delayOverride: (duration) async => delays.add(duration),
          ),
        );
        addTearDown(worker.dispose);

        final syncing = worker.states
            .whereState<PushTokenSyncWorkerSyncing>()
            .first;
        worker.accept(token: 'old-token');
        await syncing;
        worker.accept(token: 'new-token');
        final synced = worker.states
            .whereState<PushTokenSyncWorkerSynced>()
            .first;
        firstUpsert.complete();
        await synced;

        expect(upserts, ['old-token', 'new-token']);
        expect(delays, isEmpty);
      },
    );

    test('dispose prevents later upserts', () async {
      final inFlight = Completer<void>();
      final upserts = <String>[];
      final worker = PushTokenSyncWorker(
        upsert: (token) async {
          upserts.add(token);
          await inFlight.future;
        },
        backoff: InterruptibleBackoff(delayOverride: (_) async {}),
      );

      final syncing = worker.states
          .whereState<PushTokenSyncWorkerSyncing>()
          .first;
      worker.accept(token: 'in-flight');
      await syncing;
      final disposing = worker.dispose();
      worker.accept(token: 'after-dispose');
      inFlight.complete();
      await disposing;

      expect(upserts, ['in-flight']);
      expect(worker.state, isA<PushTokenSyncWorkerDisposed>());
    });
  });
}

extension on Stream<PushTokenSyncWorkerState> {
  Stream<T> whereState<T extends PushTokenSyncWorkerState>() =>
      where((state) => state is T).cast<T>();
}
