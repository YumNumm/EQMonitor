import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/clock/replay_clock_progress.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_clock.g.dart';

/// アプリ全体の現在時刻を提供する統一クロック。
///
/// 状態として現在の [TimeMode] を保持し、`now` でモードに応じた「現在時刻」を返す。
/// - ベース時刻は NTP 補正済み時刻（`Ntp.now`）を優先し、未同期時は `clock` にフォールバックする。
/// - 強震モニタ・EEW・揺れ検知はこのクロックを参照することで、通常/リプレイの
///   いずれのモードでも整合した時刻基準で動作する。
@Riverpod(keepAlive: true)
class AppClock extends _$AppClock {
  @override
  TimeMode build() => const TimeMode.realtime();

  /// 現在のモードに応じた「現在時刻」を返す。
  DateTime now() => switch (state) {
    RealtimeTimeMode() => realtimeNow(),
    ReplayTimeMode(:final currentTime) =>
      ref.read(replayClockProgressProvider).positionFrom(currentTime),
  };

  DateTime realtimeNow() =>
      clock.now().add(ref.read(ntpProvider).value?.offset ?? Duration.zero);

  /// 通常再生へ戻す。
  void returnToRealtime() => state = const TimeMode.realtime();

  /// リプレイファイル再生へ切り替える。
  void enterReplay(DateTime currentTime) {
    ref.read(replayClockProgressProvider).restart(rate: 0, limit: null);
    final previous = state;
    state = TimeMode.replay(currentTime: currentTime);
    if (state == previous) {
      ref.notifyListeners();
    }
  }

  /// リプレイ再生中の再生位置を更新する。リプレイ中でない場合は何もしない。
  ///
  /// 次の更新までは [rate] 倍の速さで [limit] まで進んだ時刻を [now] が返す。
  void updateReplayTime(
    DateTime currentTime, {
    double rate = 0,
    DateTime? limit,
  }) {
    if (state is! ReplayTimeMode) {
      return;
    }
    ref.read(replayClockProgressProvider).restart(rate: rate, limit: limit);
    state = TimeMode.replay(currentTime: currentTime);
  }
}

/// リプレイ再生中かどうか。
///
/// 値が bool のため、再生位置更新（[AppClock.updateReplayTime] による
/// 毎フレームの [TimeMode] 再生成）では通知されず、リプレイの開始/終了という
/// モード遷移時のみ購読側へ通知される。
@Riverpod(keepAlive: true)
bool isReplayMode(Ref ref) => ref.watch(appClockProvider) is ReplayTimeMode;

/// 通常再生中かどうか。
///
/// 値が bool のため、リプレイ再生位置の更新では通知されず、通常/非通常の
/// モード遷移時のみ購読側へ通知される。
@Riverpod(keepAlive: true)
bool isRealtimeMode(Ref ref) => ref.watch(appClockProvider) is RealtimeTimeMode;
