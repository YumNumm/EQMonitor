import 'dart:async';

import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/latest_map_operation_guard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('新しい世代が始まると古い世代を無効化する', () {
    final guard = LatestMapOperationGuard();
    final first = guard.begin();
    final second = guard.begin();

    expect(guard.isCurrent(first), isFalse);
    expect(guard.isCurrent(second), isTrue);
    guard.dispose();
    expect(guard.isCurrent(second), isFalse);
  });

  test('cameraキューは実行開始時点で最新の世代だけを実行する', () async {
    final guard = LatestMapOperationGuard();
    final releaseFirst = Completer<void>();
    final firstStarted = Completer<void>();
    final executed = <String>[];
    final first = guard.begin();
    final firstFuture = guard.runLatest(
      generation: first,
      operation: () async {
        executed.add('first');
        firstStarted.complete();
        await releaseFirst.future;
      },
    );
    await firstStarted.future;

    final second = guard.begin();
    final secondFuture = guard.runLatest(
      generation: second,
      operation: () async => executed.add('second'),
    );
    final third = guard.begin();
    final thirdFuture = guard.runLatest(
      generation: third,
      operation: () async => executed.add('third'),
    );
    releaseFirst.complete();

    await Future.wait([firstFuture, secondFuture, thirdFuture]);
    expect(executed, ['first', 'third']);
  });

  test('dispose後は待機中のcamera処理を実行しない', () async {
    final guard = LatestMapOperationGuard();
    final releaseFirst = Completer<void>();
    final firstStarted = Completer<void>();
    var queuedDidRun = false;
    final first = guard.begin();
    final firstFuture = guard.runLatest(
      generation: first,
      operation: () async {
        firstStarted.complete();
        await releaseFirst.future;
      },
    );
    await firstStarted.future;
    final queued = guard.begin();
    final queuedFuture = guard.runLatest(
      generation: queued,
      operation: () async => queuedDidRun = true,
    );

    guard.dispose();
    releaseFirst.complete();
    await Future.wait([firstFuture, queuedFuture]);

    expect(queuedDidRun, isFalse);
  });
}
