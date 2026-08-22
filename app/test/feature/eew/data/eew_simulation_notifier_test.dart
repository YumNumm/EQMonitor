import 'package:clock/clock.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew_simulation_notifier.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('pause中は再生位置と報を進めない', () {
    fakeAsync((async) {
      withClock(async.getClock(DateTime.utc(2026)), () {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        final subscription = container.listen(eewSimulationProvider, (_, _) {});
        addTearDown(subscription.close);
        final notifier = container.read(eewSimulationProvider.notifier);

        notifier.start(_reports);
        async.elapse(const Duration(seconds: 1));
        notifier.pause();
        final paused = container.read(eewSimulationProvider);

        async.elapse(const Duration(seconds: 10));
        final stillPaused = container.read(eewSimulationProvider);

        expect(
          paused?.playbackElapsedAt(clock.now()),
          const Duration(seconds: 1),
        );
        expect(
          stillPaused?.playbackElapsedAt(clock.now()),
          const Duration(seconds: 1),
        );
        expect(stillPaused?.currentIndex, 0);
      });
    });
  });

  test('resume後は停止前の残り時間から報と再生位置を進める', () {
    fakeAsync((async) {
      withClock(async.getClock(DateTime.utc(2026)), () {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        final subscription = container.listen(eewSimulationProvider, (_, _) {});
        addTearDown(subscription.close);
        final notifier = container.read(eewSimulationProvider.notifier);

        notifier.start(_reports);
        async.elapse(const Duration(seconds: 1));
        notifier.pause();
        async.elapse(const Duration(seconds: 10));
        notifier.resume();
        async.elapse(const Duration(milliseconds: 999));

        expect(container.read(eewSimulationProvider)?.currentIndex, 0);

        async.elapse(const Duration(milliseconds: 1));
        final resumed = container.read(eewSimulationProvider);

        expect(resumed?.currentIndex, 1);
        expect(
          resumed?.playbackElapsedAt(clock.now()),
          const Duration(seconds: 2),
        );
      });
    });
  });

  test('再生中のresumeは再生位置を巻き戻さない', () {
    fakeAsync((async) {
      withClock(async.getClock(DateTime.utc(2026)), () {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        final subscription = container.listen(eewSimulationProvider, (_, _) {});
        addTearDown(subscription.close);
        final notifier = container.read(eewSimulationProvider.notifier);

        notifier.start(_reports);
        async.elapse(const Duration(seconds: 1));
        notifier.resume();
        async.elapse(const Duration(seconds: 1));
        final playing = container.read(eewSimulationProvider);

        expect(playing?.currentIndex, 1);
        expect(
          playing?.playbackElapsedAt(clock.now()),
          const Duration(seconds: 2),
        );
      });
    });
  });

  test('最終報到達後は再生位置を固定する', () {
    fakeAsync((async) {
      withClock(async.getClock(DateTime.utc(2026)), () {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        final subscription = container.listen(eewSimulationProvider, (_, _) {});
        addTearDown(subscription.close);
        final notifier = container.read(eewSimulationProvider.notifier);

        notifier.start(_reports.take(2).toList());
        async.elapse(const Duration(seconds: 2));
        final completed = container.read(eewSimulationProvider);
        async.elapse(const Duration(seconds: 10));
        final stillCompleted = container.read(eewSimulationProvider);

        expect(completed?.isComplete, isTrue);
        expect(completed?.isPlaying, isFalse);
        expect(
          completed?.playbackElapsedAt(clock.now()),
          const Duration(seconds: 2),
        );
        expect(
          stillCompleted?.playbackElapsedAt(clock.now()),
          const Duration(seconds: 2),
        );
      });
    });
  });
}

final _reports = List.generate(3, (index) {
  return EewTelegramItem(
    eventId: 'event-1',
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.publication,
    serialNo: index + 1,
    isCanceled: false,
    isLastInfo: index == 2,
    reportTime: DateTime.utc(2026).add(Duration(seconds: index * 2)),
    isPlum: false,
  );
});
