import 'dart:async';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_delay_edge_search.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_delay_resolver.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_image_request.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_offset_adjustment_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_delay_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart' hide Result;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_delay_calibration_notifier.g.dart';

/// 較正結果に上乗せする余裕。通信ゆらぎで境目をまたがないようにする。
const _calibrationMargin = Duration(milliseconds: 50);

/// 較正をやり直す間隔。
///
/// サーバ側の遅延が短くなった場合や、404 で一時的に延びた補正量を戻すため。
/// 表示用の取得で詰めると毎回フレームを落とすため、較正の取得だけで試す。
const _recalibrateInterval = Duration(minutes: 5);

/// 較正に失敗した場合の再試行間隔。
const _retryInterval = Duration(minutes: 1);

/// 1 回の較正で試す回数の上限。
const _maxProbeCount = 12;

/// 時刻同期の確定後、画像取得で公開遅延を較正する。
///
/// `latest.json` から求まるのは強震モニタのパイプラインの 1 秒粒度の時刻で、
/// 実際に画像が公開されるタイミングとは 1 秒未満のずれがある。
/// 表示用の取得とは別に数回だけ画像を取りに行き、公開の境目を二分探索で
/// 求めて補正量へ反映する。表示用の取得は較正中も現在の遅延で続く。
/// 以後も一定間隔でやり直し、遅延の変化に追従する。
@riverpod
class KyoshinMonitorDelayCalibration extends _$KyoshinMonitorDelayCalibration {
  @override
  KyoshinMonitorDelayCalibrationStatus build() {
    // 測り直しのたびに settledAt が変わり、較正もやり直される。
    final settledAt = ref.watch(
      kyoshinMonitorTimerProvider.select((v) => v.value?.settledAt),
    );
    // 補正量の保存でも設定は更新されるため、必要な項目だけを購読する。
    final settings = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) {
        final value = v.value;
        if (value == null) {
          return null;
        }
        return (
          useKmoni: value.useKmoni,
          type: value.realtimeDataType,
          autoOffsetIncrement: value.api.autoOffsetIncrement,
          delayAdjustType: value.api.delayAdjustType,
          minOffset: value.api.minOffset,
          maxOffset: value.api.maxOffset,
        );
      }),
    );
    final isRealtime = ref.watch(isRealtimeModeProvider);
    final isBackground = ref.watch(
      appLifecycleProvider.select(KyoshinMonitorBackground.isBackground),
    );

    if (settledAt == null ||
        settings == null ||
        !settings.useKmoni ||
        !settings.autoOffsetIncrement ||
        !isRealtime ||
        isBackground) {
      return .idle;
    }
    switch (settings.delayAdjustType) {
      case .latestJson || .latestJsonMultiple:
        // 補正量を使わない方式では較正結果の反映先がない。
        return .idle;
      case .imageFetch404DeviceTime || .imageFetch404Ntp:
    }
    final request = ref.watch(kyoshinMonitorImageRequestProvider);
    final initialDelay = ref.read(kyoshinMonitorImageDelayProvider);
    if (initialDelay == null) {
      return .idle;
    }

    var disposed = false;
    ref.onDispose(() => disposed = true);

    Timer? rerunTimer;
    ref.onDispose(() => rerunTimer?.cancel());
    void scheduleRerun(Duration after) {
      rerunTimer = Timer(after, ref.invalidateSelf);
    }

    final config = KyoshinMonitorDelayAdjustConfig(
      minOffset: settings.minOffset,
      maxOffset: settings.maxOffset,
    );
    final appClock = ref.read(appClockProvider.notifier);
    final calibrator = KyoshinMonitorDelayCalibrator(
      repository: ref.read(kyoshinMonitorRepositoryProvider),
      edgeSearch: ref.read(kyoshinMonitorDelayEdgeSearchProvider),
      now: appClock.now,
    );

    unawaited(
      Future<void>(() async {
        final delay = await calibrator.calibrate(
          request: request,
          type: settings.type,
          initialDelay: initialDelay,
          config: config,
          isCancelled: () => disposed,
        );
        if (disposed) {
          return;
        }
        if (delay == null) {
          state = .failed;
          scheduleRerun(_retryInterval);
          return;
        }
        final timerState = ref.read(kyoshinMonitorTimerProvider).value;
        if (timerState == null) {
          state = .failed;
          scheduleRerun(_retryInterval);
          return;
        }
        final publishDelay = ref
            .read(kyoshinMonitorTimeSampleCalculatorProvider)
            .publishDelay(
              shift: timerState.shift,
              ntpOffset: ref.read(ntpProvider).value?.offset,
            );
        // 補正量は latest.json の実測値からの差分として保持されている。
        final adjustment = ref
            .read(kyoshinMonitorDelayResolverProvider)
            .clamp(
              value: delay + _calibrationMargin - publishDelay,
              min: -config.maxAdjustment,
              max: config.maxAdjustment,
            );
        talker.logCustom(
          KyoshinMonitorLog(
            'delay calibrated: ${request.delayProfile.name} '
            'delay=${delay.inMilliseconds}ms '
            'publishDelay=${publishDelay.inMilliseconds}ms',
          ),
        );
        ref
            .read(kyoshinMonitorOffsetAdjustmentProvider.notifier)
            .apply(request.delayProfile, adjustment);
        state = .calibrated;
        scheduleRerun(_recalibrateInterval);
      }),
    );

    return .probing;
  }
}

/// 画像の公開の境目を、実際の取得で探す。
class const KyoshinMonitorDelayCalibrator({
  required final KyoshinMonitorRepository repository,
  required final KyoshinMonitorDelayEdgeSearch edgeSearch,

  /// 画像取得の対象時刻を決めるのと同じ時計 (`AppClock.now`)
  required final DateTime Function() now,
}) {
  /// 取得に成功することを確認できた最小の遅延を返す。
  ///
  /// 通信失敗や中断で確認できなかった場合は null。
  Future<Duration?> calibrate({
    required KyoshinMonitorImageRequest request,
    required RealtimeDataType type,
    required Duration initialDelay,
    required KyoshinMonitorDelayAdjustConfig config,
    required bool Function() isCancelled,
  }) async {
    var bracket = edgeSearch.start(currentDelay: initialDelay, config: config);
    for (var i = 0; i < _maxProbeCount; i++) {
      if (edgeSearch.isConverged(bracket)) {
        return bracket.upper;
      }
      if (edgeSearch.isExhausted(bracket, config: config)) {
        return null;
      }
      final probeDelay = edgeSearch.nextProbe(bracket);

      // 「対象時刻 + probeDelay」ちょうどに送るため、次の秒境界まで待つ。
      await Future<void>.delayed(untilNextTarget(probeDelay));
      if (isCancelled()) {
        return null;
      }
      final target = truncateToSecond(now().subtract(probeDelay));
      final result = await repository.isRealtimeImagePublished(
        source: request.source,
        type: type,
        layer: request.layer,
        dateTime: target,
      );
      if (isCancelled()) {
        return null;
      }
      switch (result) {
        case Success(:final value):
          bracket = edgeSearch.onProbed(
            bracket: bracket,
            isPublished: value,
            config: config,
          );
        case Failure(:final exception):
          talker.logCustom(
            KyoshinMonitorLog('delay calibration failed: $exception'),
          );
          return null;
      }
    }
    // 回数内に収束しなくても、確認済みの上限は使える。
    return bracket.isUpperVerified ? bracket.upper : null;
  }

  /// `now - delay` が次に秒境界へ乗るまでの時間。
  Duration untilNextTarget(Duration delay) {
    final shifted = now().subtract(delay);
    final elapsed = shifted.difference(truncateToSecond(shifted));
    return const Duration(seconds: 1) - elapsed;
  }

  DateTime truncateToSecond(DateTime value) => value.subtract(
    Duration(milliseconds: value.millisecond, microseconds: value.microsecond),
  );
}
