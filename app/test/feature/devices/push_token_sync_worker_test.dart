import 'dart:async';

import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_worker_state.dart';
import 'package:eqmonitor/feature/devices/data/repository/push_token_sync_worker.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PushTokenSyncWorker session behavior', () {
    test('同一トークンの再送信は upsert を重複させない', () async {
      final upserts = <String>[];
      final worker = PushTokenSyncWorker(
        upsert: (token) async {
          upserts.add(token);
        },
      );
      addTearDown(worker.dispose);

      // where().first を都度呼ぶと、subscription を切り替える間に発火したイベントを
      // 取りこぼす（broadcast stream は過去のイベントを再生しない）ため、
      // テスト全体で1本の subscription を張り続けてカウントする。
      var syncedCount = 0;
      final subscription = worker.states
          .where((s) => s is SyncedWorkerState)
          .listen((_) => syncedCount++);
      addTearDown(subscription.cancel);

      Future<void> waitForSyncedCount(int expected) async {
        while (syncedCount < expected) {
          await Future<void>.delayed(Duration.zero);
        }
      }

      worker.accept(token: 'same-token');
      await waitForSyncedCount(1);
      expect(upserts, ['same-token']);

      worker.accept(token: 'same-token');
      await Future<void>.delayed(Duration.zero);
      expect(upserts, ['same-token']);
      expect(syncedCount, 1, reason: '同一トークンの再受理では synced を再通知しない');

      worker.accept(token: 'new-token');
      await waitForSyncedCount(2);
      expect(upserts, ['same-token', 'new-token']);
    });

    test('初期状態は absent', () {
      final worker = PushTokenSyncWorker(upsert: (_) async {});
      addTearDown(worker.dispose);
      expect(worker.state, isA<AbsentWorkerState>());
    });
  });

  test('7回のリトライ可能な失敗の後に成功しても6回で打ち切られない', () {
    fakeAsync((async) {
      var callCount = 0;
      final upserts = <String>[];
      final worker = PushTokenSyncWorker(
        upsert: (token) async {
          callCount++;
          upserts.add(token);
          if (callCount <= 7) {
            throw const NetworkUnreachableException();
          }
        },
      );
      addTearDown(worker.dispose);

      final seenStates = <PushTokenSyncWorkerState>[];
      worker.states.listen(seenStates.add);

      worker.accept(token: 'flaky-token');
      async.elapse(const Duration(minutes: 10));

      expect(callCount, 8, reason: '7回失敗した後の8回目で成功するはず');
      expect(worker.state, isA<SyncedWorkerState>());
      expect(
        seenStates.whereType<FailedWorkerState>(),
        isEmpty,
        reason: 'リトライ可能なエラーでは6回で failed にならないはず',
      );
      expect(
        seenStates.whereType<WaitingWorkerState>().length,
        7,
        reason: '7回の失敗それぞれで waiting 状態を経由するはず',
      );
    });
  });

  test('リトライ不可の失敗は retry() が呼ばれるまで停止する', () async {
    var callCount = 0;
    final upserts = <String>[];
    final worker = PushTokenSyncWorker(
      upsert: (token) async {
        callCount++;
        upserts.add(token);
        if (callCount == 1) {
          throw const InvalidRequestException(statusCode: 400);
        }
      },
    );
    addTearDown(worker.dispose);

    worker.accept(token: 'bad-token');
    final failedState = await worker.states.firstWhere(
      (s) => s is FailedWorkerState,
    );
    expect(failedState, isA<FailedWorkerState>());
    expect(
      (failedState as FailedWorkerState).error,
      isA<InvalidRequestException>(),
    );
    expect(callCount, 1);

    // retry() を呼ばない限り再送信されない。
    await Future<void>.delayed(Duration.zero);
    expect(callCount, 1);

    worker.retry();
    await worker.states.firstWhere((s) => s is SyncedWorkerState);
    expect(callCount, 2);
    expect(upserts, ['bad-token', 'bad-token']);
  });

  test('待機中に新しいトークンが届くと待機を中断し、最新の値だけが同期される', () {
    fakeAsync((async) {
      final upserts = <String>[];
      final worker = PushTokenSyncWorker(
        upsert: (token) async {
          upserts.add(token);
          if (token == 'stale-token') {
            throw const NetworkUnreachableException();
          }
        },
      );
      addTearDown(worker.dispose);

      worker.accept(token: 'stale-token');
      async.elapse(Duration.zero);
      expect(worker.state, isA<WaitingWorkerState>());

      worker.accept(token: 'fresh-token');
      async.flushMicrotasks();

      expect(worker.state, isA<SyncedWorkerState>());
      expect(upserts, ['stale-token', 'fresh-token']);
    });
  });

  test('upsert 実行中に届いた新しいトークンは完了直後に送信される', () async {
    final upserts = <String>[];
    final firstCompleter = Completer<void>();
    final worker = PushTokenSyncWorker(
      upsert: (token) async {
        upserts.add(token);
        if (token == 'in-flight-token') {
          await firstCompleter.future;
        }
      },
    );
    addTearDown(worker.dispose);

    worker.accept(token: 'in-flight-token');
    await Future<void>.delayed(Duration.zero);
    expect(upserts, ['in-flight-token']);

    worker.accept(token: 'queued-token');
    await Future<void>.delayed(Duration.zero);
    expect(upserts, ['in-flight-token'], reason: 'まだ in-flight の upsert 中');

    firstCompleter.complete();
    await worker.states.firstWhere((s) => s is SyncedWorkerState);
    expect(upserts, ['in-flight-token', 'queued-token']);
  });

  test('dispose() 後は accept() しても upsert されない', () async {
    final upserts = <String>[];
    final worker = PushTokenSyncWorker(
      upsert: (token) async {
        upserts.add(token);
      },
    );

    worker.dispose();
    expect(worker.state, isA<DisposedWorkerState>());

    worker.accept(token: 'too-late');
    await Future<void>.delayed(Duration.zero);
    expect(upserts, isEmpty);
  });
}
