import 'dart:async';

import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_duration_save_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('異なるrawの先行保存待ちが複数あっても同じ後続保存は1回だけ実行する', () async {
    final queue = LiveMonitorDurationSaveQueue();
    final firstStarted = Completer<void>();
    final releaseFirst = Completer<void>();
    var firstSaveCount = 0;
    var secondSaveCount = 0;

    final first = queue.run(
      raw: '60',
      operation: () async {
        firstSaveCount++;
        firstStarted.complete();
        await releaseFirst.future;
        return true;
      },
    );
    await firstStarted.future;
    final secondA = queue.run(
      raw: '90',
      operation: () async {
        secondSaveCount++;
        return true;
      },
    );
    final secondB = queue.run(
      raw: '90',
      operation: () async {
        secondSaveCount++;
        return true;
      },
    );

    expect(firstSaveCount, 1);
    expect(secondSaveCount, 0);
    releaseFirst.complete();

    expect(await first, isTrue);
    expect(await Future.wait([secondA, secondB]), everyElement(isTrue));
    expect(secondSaveCount, 1);
  });

  test('同じrawでも異なるrawが間に予約済みなら到着順に保存する', () async {
    final queue = LiveMonitorDurationSaveQueue();
    final firstStarted = Completer<void>();
    final releaseFirst = Completer<void>();
    final saved = <String>[];

    final first = queue.run(
      raw: '60',
      operation: () async {
        saved.add('A1');
        firstStarted.complete();
        await releaseFirst.future;
        return true;
      },
    );
    await firstStarted.future;
    final second = queue.run(
      raw: '90',
      operation: () async {
        saved.add('B2');
        return true;
      },
    );
    final third = queue.run(
      raw: '60',
      operation: () async {
        saved.add('A3');
        return true;
      },
    );
    releaseFirst.complete();

    expect(await Future.wait([first, second, third]), everyElement(isTrue));
    expect(saved, ['A1', 'B2', 'A3']);
  });
}
