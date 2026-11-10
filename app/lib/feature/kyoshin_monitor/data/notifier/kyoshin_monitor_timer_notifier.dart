import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sync_estimator.dart';
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

/// 起動直後に連続して測る回数 (初回を含む)。
const _burstSampleCount = 5;

/// 連続測定の間隔。
///
/// `latest_time` は 1 秒粒度のため、1 秒間隔で測ると毎回同じ位相を引いて
/// しまい精度が上がらない。1 秒を割り切らない短い間隔にして位相を散らす。
const _burstSampleGap = Duration(milliseconds: 230);

/// `latest.json` でサーバ時刻と端末時計のずれを測る時刻同期エンジン。
///
/// 1. 最初の 1 サンプルが取れた時点でその値を公開し、すぐ画像取得を始められるようにする。
/// 2. 続けて位相をずらした測定を数回行い、1 秒粒度の切り捨て誤差を詰める。
///    確定したら `settledAt` を立て、画像取得による較正
///    (`KyoshinMonitorDelayCalibration`) へ引き継ぐ。
/// 3. 以後の定期測定は見積もりを動かさず、矛盾の検出だけに使う。
///    矛盾した場合 (端末時計の変更・サーバ側の遅延変動) は最初から測り直す。
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
      timeSampleCalculator: ref.read(
        kyoshinMonitorTimeSampleCalculatorProvider,
      ),
      estimator: ref.read(kyoshinMonitorTimeSyncEstimatorProvider),
    );

    Future<KyoshinMonitorTimeSample?> sampleOnce() async {
      final result = await sync.sample(source);
      switch (result) {
        case Success(:final value):
          return value;
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

    // サンプルを蓄積し、蓄積後の見積もりを返す。
    KyoshinMonitorTimerState? accept(KyoshinMonitorTimeSample sample) {
      ref
          .read(kyoshinMonitorTimeSyncSamplesProvider.notifier)
          .add(
            roundTripTime: sync.timeSampleCalculator.roundTripTime(sample),
            shift: sync.timeSampleCalculator.shift(sample),
          );
      return sync.stateFrom(
        samples: ref.read(kyoshinMonitorTimeSyncSamplesProvider),
        source: source,
        lastSyncedAt: clock.now(),
      );
    }

    // 1. 最初の 1 サンプルをそのまま使う。
    KyoshinMonitorTimerState? first;
    while (!disposed) {
      final sample = await sampleOnce();
      if (disposed) {
        return;
      }
      first = sample == null ? null : accept(sample);
      if (first != null) {
        break;
      }
      await Future<void>.delayed(_firstSyncRetryInterval);
    }
    if (first == null) {
      return;
    }
    var current = first;
    yield current;

    // 2. 位相をずらした連続測定で見積もりを詰める。
    var isSettled = false;
    unawaited(
      Future<void>(() async {
        for (var i = 1; i < _burstSampleCount; i++) {
          await Future<void>.delayed(_burstSampleGap);
          if (disposed || controller.isClosed) {
            return;
          }
          final sample = await sampleOnce();
          if (disposed || controller.isClosed) {
            return;
          }
          final next = sample == null ? null : accept(sample);
          if (next != null) {
            current = next;
            controller.add(current);
          }
        }
        current = current.copyWith(settledAt: clock.now());
        isSettled = true;
        controller.add(current);
      }),
    );

    // 3. 定期測定は矛盾の検出だけに使う。
    var isResyncing = false;
    Timer? resyncTimer;
    resyncTimer = Timer.periodic(resyncInterval, (_) async {
      if (disposed || controller.isClosed || isResyncing || !isSettled) {
        return;
      }
      if (KyoshinMonitorBackground.isBackground(
        ref.read(appLifecycleProvider),
      )) {
        return;
      }
      isResyncing = true;
      try {
        final sample = await sampleOnce();
        if (sample == null || disposed || controller.isClosed) {
          return;
        }
        final sampleShift = sync.timeSampleCalculator.shift(sample);
        if (sync.estimator.isConsistent(
          estimate: current.shift,
          sampleShift: sampleShift,
        )) {
          current = current.copyWith(lastSyncedAt: clock.now());
          controller.add(current);
          return;
        }
        talker.logCustom(
          KyoshinMonitorLog(
            'time sync drifted: source=${source.name} '
            'estimate=${current.shift.inMilliseconds}ms '
            'sample=${sampleShift.inMilliseconds}ms, resyncing',
          ),
        );
        ref.invalidateSelf();
      } finally {
        isResyncing = false;
      }
    });
    ref.onDispose(() => resyncTimer?.cancel());

    yield* controller.stream;
  }
}

class const KyoshinMonitorTimeSync({
  required final KyoshinMonitorRepository repository,
  required final KyoshinMonitorTimeSampleCalculator timeSampleCalculator,
  required final KyoshinMonitorTimeSyncEstimator estimator,
}) {
  Future<Result<KyoshinMonitorTimeSample, Exception>> sample(
    KyoshinMonitorSource source,
  ) => repository.fetchLatestTime(source: source);

  KyoshinMonitorTimerState? stateFrom({
    required KyoshinMonitorTimeSyncSamples samples,
    required KyoshinMonitorSource source,
    required DateTime lastSyncedAt,
  }) {
    final shift = estimator.shift(samples.shifts);
    final roundTripTime = estimator.roundTripTime(samples.roundTripTimes);
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
  /// 画面が見えていない状態だけを停止対象にする。
  ///
  /// `inactive` はコントロールセンター表示や Android のマルチウィンドウで
  /// フォーカスを失った場合など、画面が見えたままでも遷移するため含めない。
  static bool isBackground(AppLifecycleState lifecycle) => const [
    AppLifecycleState.hidden,
    AppLifecycleState.paused,
    AppLifecycleState.detached,
  ].contains(lifecycle);
}
