import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_trimmed_mean_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_time_sample.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_time_sync_samples.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_timer_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_time_sync_samples_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_notifier.g.dart';

/// 初回成功までの再試行間隔
const _firstSyncRetryInterval = Duration(seconds: 5);

/// トリム平均を成立させるため、起動直後は短い間隔で連続して測る。
///
/// 長周期地震動モニタの公式フロントエンドと同じ「最初の5回は1秒間隔」。
const _initialBurstCount = 5;
const _initialBurstInterval = Duration(seconds: 1);

/// `latest.json` を定期的に取得し、サーバ時刻と端末時計のずれを測り続ける。
///
/// 単発の測定では往復時間のゆらぎがそのまま残るため、往復時間とずれの
/// どちらもトリム平均 (直近5件から最小・最大を除いた平均) で扱う。
@riverpod
class KyoshinMonitorTimerNotifier extends _$KyoshinMonitorTimerNotifier {
  @override
  Stream<KyoshinMonitorTimerState> build() async* {
    final source = ref.watch(
      kyoshinMonitorImageRequestProvider.select((v) => v.source),
    );
    final resyncInterval = ref.watch(
      kyoshinMonitorSettingsProvider.select(
        (v) => v.requireValue.api.delayAdjustInterval,
      ),
    );

    ref.read(kyoshinMonitorTimeSyncSamplesProvider.notifier).clear();

    final controller = StreamController<KyoshinMonitorTimerState>();
    ref.onDispose(controller.close);

    var disposed = false;
    ref.onDispose(() => disposed = true);

    final sync = KyoshinMonitorTimeSync(
      repository: ref.read(kyoshinMonitorRepositoryProvider),
      timeSampleCalculator: ref.read(kyoshinMonitorTimeSampleCalculatorProvider),
      trimmedMeanCalculator: ref.read(
        kyoshinMonitorTrimmedMeanCalculatorProvider,
      ),
    );

    Future<KyoshinMonitorTimerState?> syncOnce() async {
      final samplesNotifier = ref.read(
        kyoshinMonitorTimeSyncSamplesProvider.notifier,
      );
      final result = await sync.sample(source);
      switch (result) {
        case Success(:final value):
          samplesNotifier.add(
            roundTripTime: sync.timeSampleCalculator.roundTripTime(value),
            shift: sync.timeSampleCalculator.shift(value),
          );
          final samples = ref.read(kyoshinMonitorTimeSyncSamplesProvider);
          return sync.stateFrom(
            samples: samples,
            source: source,
            lastSyncedAt: clock.now(),
          );
        case Failure(:final exception):
          talker.logCustom(
            KyoshinMonitorLog(
              'time sync failed: source=${source.name} '
              '$exception',
            ),
          );
          return null;
      }
    }

    while (!disposed) {
      final next = await syncOnce();
      if (next != null) {
        yield next;
        break;
      }
      await Future<void>.delayed(_firstSyncRetryInterval);
    }

    unawaited(
      Future<void>(() async {
        for (var i = 1; i < _initialBurstCount; i++) {
          await Future<void>.delayed(_initialBurstInterval);
          if (disposed || controller.isClosed) {
            return;
          }
          final next = await syncOnce();
          if (next != null && !controller.isClosed) {
            controller.add(next);
          }
        }
      }),
    );

    var isResyncing = false;
    Timer? resyncTimer;
    resyncTimer = Timer.periodic(resyncInterval, (_) async {
      if (disposed || controller.isClosed || isResyncing) {
        return;
      }
      if (KyoshinMonitorBackground.isBackground(
        ref.read(appLifecycleProvider),
      )) {
        return;
      }
      isResyncing = true;
      try {
        final next = await syncOnce();
        if (next != null && !controller.isClosed) {
          controller.add(next);
        }
      } finally {
        isResyncing = false;
      }
    });
    ref.onDispose(() => resyncTimer?.cancel());

    yield* controller.stream;
  }
}

class KyoshinMonitorTimeSync {
  const new({
    required this.repository,
    required this.timeSampleCalculator,
    required this.trimmedMeanCalculator,
  });

  final KyoshinMonitorRepository repository;
  final KyoshinMonitorTimeSampleCalculator timeSampleCalculator;
  final KyoshinMonitorTrimmedMeanCalculator trimmedMeanCalculator;

  Future<Result<KyoshinMonitorTimeSample, Exception>> sample(
    KyoshinMonitorSource source,
  ) => repository.fetchLatestTime(source: source);

  KyoshinMonitorTimerState? stateFrom({
    required KyoshinMonitorTimeSyncSamples samples,
    required KyoshinMonitorSource source,
    required DateTime lastSyncedAt,
  }) {
    final shift = trimmedMeanCalculator.mean(samples.shifts);
    final roundTripTime = trimmedMeanCalculator.mean(samples.roundTripTimes);
    if (shift == null || roundTripTime == null) {
      return null;
    }
    final state = KyoshinMonitorTimerState(
      shift: shift,
      roundTripTime: roundTripTime,
      source: source,
      sampleCount: samples.shifts.length,
      lastSyncedAt: lastSyncedAt,
    );
    talker.logCustom(
      KyoshinMonitorLog(
        'time sync: source=${source.name} '
        'shift=${state.shift.inMilliseconds}ms '
        'rtt=${state.roundTripTime.inMilliseconds}ms '
        'samples=${state.sampleCount}',
      ),
    );
    return state;
  }
}

abstract final class KyoshinMonitorBackground {
  static bool isBackground(AppLifecycleState lifecycle) => const [
    AppLifecycleState.paused,
    AppLifecycleState.detached,
    AppLifecycleState.inactive,
  ].contains(lifecycle);
}
