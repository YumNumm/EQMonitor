import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_clock.g.dart';

/// アプリ全体の現在時刻を提供する統一クロック。
///
/// 状態として現在の [TimeMode] を保持し、`now` でモードに応じた「現在時刻」を返す。
/// - ベース時刻は NTP 補正済み時刻（`Ntp.now`）を優先し、未同期時は `clock` にフォールバックする。
/// - 強震モニタ・EEW・揺れ検知はこのクロックを参照することで、通常/タイムシフト/リプレイの
///   いずれのモードでも整合した時刻基準で動作する。
@Riverpod(keepAlive: true)
class AppClock extends _$AppClock {
  @override
  TimeMode build() => const TimeMode.realtime();

  /// 現在のモードに応じた「現在時刻」を返す。
  DateTime now() {
    final base = ref.read(ntpProvider.notifier).now() ?? clock.now();
    return switch (state) {
      RealtimeTimeMode() => base,
      TimeShiftTimeMode(:final offset) => base.add(offset),
      ReplayTimeMode(:final currentTime) => currentTime,
    };
  }

  /// 通常再生へ戻す。
  void returnToRealtime() => state = const TimeMode.realtime();

  /// タイムシフト再生へ切り替える。[offset] は過去方向（負の [Duration]）。
  void enterTimeShift(Duration offset) =>
      state = TimeMode.timeShift(offset: offset);

  /// リプレイファイル再生へ切り替える。
  void enterReplay(DateTime currentTime) =>
      state = TimeMode.replay(currentTime: currentTime);

  /// リプレイ再生中の再生位置を更新する。リプレイ中でない場合は何もしない。
  void updateReplayTime(DateTime currentTime) {
    if (state is ReplayTimeMode) {
      state = TimeMode.replay(currentTime: currentTime);
    }
  }
}
