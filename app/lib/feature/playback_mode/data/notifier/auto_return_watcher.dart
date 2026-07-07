import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/playback_mode/data/auto_return_policy.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_to_realtime_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_return_watcher.g.dart';

/// タイムシフト/リプレイ再生中に、ライブのリアルタイムイベント（EEW・揺れ検知）が
/// 発生したら通常再生へ自動復帰させる常駐ウォッチャ。
///
/// リプレイ中は `eewProvider` 等がライブ受信を遮断するため、ここでは
/// ライブの [realtimeEventsProvider] を直接購読してモード遷移のみを判断する。
/// `main` で起動時に常駐させる。
@Riverpod(keepAlive: true)
class AutoReturnWatcher extends _$AutoReturnWatcher {
  @override
  void build() {
    ref.listen(realtimeEventsProvider, (_, next) {
      next.whenData(_onEvent);
    });
  }

  void _onEvent(RealtimeEvent event) {
    // 通常再生中は対象外
    if (ref.read(appClockProvider) is RealtimeTimeMode) {
      return;
    }
    // 設定で無効化されている場合は何もしない
    if (!(ref.read(autoReturnToRealtimeProvider).value ?? true)) {
      return;
    }
    if (!ref.read(autoReturnPolicyProvider).shouldReturnToRealtime(event)) {
      return;
    }
    // リプレイ中なら再生停止（appClock も通常再生へ戻る）、
    // タイムシフト中なら通常再生へ戻す。
    if (ref.read(replayProvider) != null) {
      ref.read(replayProvider.notifier).exit();
    } else {
      ref.read(appClockProvider.notifier).returnToRealtime();
    }
  }
}
