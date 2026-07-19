import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/playback_mode/data/auto_return_policy.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_to_realtime_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_return_watcher.g.dart';

/// タイムシフト/リプレイ再生中に、ライブの EEW・揺れ検知が
/// 発生したら通常再生へ自動復帰させる常駐ウォッチャ。
///
/// リプレイ中は `eewProvider` 等がライブ受信を遮断するため、ここでは
/// ライブの [realtimeEventsProvider] を直接購読してモード遷移のみを判断する。
/// `main` で起動時に常駐させる。
@Riverpod(keepAlive: true)
class AutoReturnWatcher extends _$AutoReturnWatcher {
  @override
  void build() {
    final policy = ref.read(autoReturnPolicyProvider);

    ref.listen(eqMonitorWsStatusProvider, (_, next) {
      if (next.phase != WsPhase.connected) {
        policy.resetShakeBaseline();
      }
    });

    ref.listen(shakeDetectionAcceptedSnapshotProvider, (_, next) {
      if (next != null && ref.read(isRealtimeModeProvider)) {
        policy.acceptShakeSnapshot(next);
      }
    }, fireImmediately: true);

    ref.listen(realtimeEventsProvider, (_, next) {
      next.whenData((event) {
        final shouldReturn = policy.shouldReturnToRealtime(event);
        if (ref.read(appClockProvider) is RealtimeTimeMode ||
            !(ref.read(autoReturnToRealtimeProvider).value ?? true) ||
            !shouldReturn) {
          return;
        }
        if (ref.read(replayProvider) != null) {
          ref.read(replayProvider.notifier).exit();
        } else {
          ref.read(appClockProvider.notifier).returnToRealtime();
        }
      });
    });
  }
}
