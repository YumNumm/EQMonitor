import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/trimmed_mean_samples.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_timer_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
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
    // 画像の取得先が変わったら、往復時間の推定もその経路で測り直す。
    // LPGM 系列が選ばれている場合は monitorSource に関わらず
    // 長周期地震動モニタから取得するため effectiveMonitorSource を見る。
    final source = ref.watch(
      kyoshinMonitorSettingsProvider.select(
        (v) => v.requireValue.effectiveMonitorSource,
      ),
    );
    final resyncInterval = ref.watch(
      kyoshinMonitorSettingsProvider.select(
        (v) => v.requireValue.api.delayAdjustInterval,
      ),
    );

    final roundTripTimes = TrimmedMeanSamples();
    final shifts = TrimmedMeanSamples();

    final controller = StreamController<KyoshinMonitorTimerState>();
    ref.onDispose(controller.close);

    var disposed = false;
    ref.onDispose(() => disposed = true);

    /// 1 回測ってサンプルに加え、更新後の状態を返す。失敗時は null。
    Future<KyoshinMonitorTimerState?> syncOnce() async {
      final result = await _sample(source);
      switch (result) {
        case Success(:final value):
          roundTripTimes.add(value.roundTripTime);
          shifts.add(value.shift);
          final shift = shifts.value;
          final roundTripTime = roundTripTimes.value;
          if (shift == null || roundTripTime == null) {
            return null;
          }
          final state = KyoshinMonitorTimerState(
            shift: shift,
            roundTripTime: roundTripTime,
            source: source,
            sampleCount: shifts.length,
            lastSyncedAt: clock.now(),
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

    // 初回は成功するまで繰り返す。ここが通らないと画像取得を始められない。
    while (!disposed) {
      final state = await syncOnce();
      if (state != null) {
        yield state;
        break;
      }
      await Future<void>.delayed(_firstSyncRetryInterval);
    }

    // トリム平均を成立させるための追い込み。
    unawaited(
      Future<void>(() async {
        for (var i = 1; i < _initialBurstCount; i++) {
          await Future<void>.delayed(_initialBurstInterval);
          if (disposed || controller.isClosed) {
            return;
          }
          final state = await syncOnce();
          if (state != null && !controller.isClosed) {
            controller.add(state);
          }
        }
      }),
    );

    // 以降は設定された間隔で再同期する。
    var isResyncing = false;
    Timer? resyncTimer;
    resyncTimer = Timer.periodic(resyncInterval, (_) async {
      if (disposed || controller.isClosed || isResyncing) {
        return;
      }
      if (_isBackground) {
        return;
      }
      isResyncing = true;
      try {
        final state = await syncOnce();
        if (state != null && !controller.isClosed) {
          controller.add(state);
        }
      } finally {
        isResyncing = false;
      }
    });
    ref.onDispose(() => resyncTimer?.cancel());

    yield* controller.stream;
  }

  bool get _isBackground => const [
    AppLifecycleState.paused,
    AppLifecycleState.detached,
    AppLifecycleState.inactive,
  ].contains(ref.read(appLifecycleProvider));

  /// `latest.json` を 1 回取得する。
  ///
  /// 画像と同じホストの `latest.json` を叩くことで、往復時間の推定が
  /// 実際の画像取得の経路に近くなる。
  @visibleForTesting
  Future<Result<KyoshinMonitorTimeSample, Exception>> sample(
    KyoshinMonitorSource source,
  ) => _sample(source);

  Future<Result<KyoshinMonitorTimeSample, Exception>> _sample(
    KyoshinMonitorSource source,
  ) => Result.capture(() async {
    final sentAt = clock.now();
    final dataTime = switch (source) {
      KyoshinMonitorSource.kmoni =>
        await ref
            .read(kyoshinMonitorWebApiDataSourceProvider)
            .getLatestDataTime(),
      KyoshinMonitorSource.lmoni =>
        await ref
            .read(lpgmKyoshinMonitorWebApiDataSourceProvider)
            .getLatestDataTime(),
    };
    final receivedAt = clock.now();
    return KyoshinMonitorTimeSample(
      sentAt: sentAt,
      receivedAt: receivedAt,
      latestTime: dataTime.latestTime,
    );
  });
}
