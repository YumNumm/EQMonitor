import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'live_monitor_wake_lock_platform.g.dart';

abstract interface class LiveMonitorWakeLockPlatform {
  Future<void> setEnabled({required bool enabled});
}

final class WakelockPlusLiveMonitorWakeLockPlatform
    implements LiveMonitorWakeLockPlatform {
  @override
  Future<void> setEnabled({required bool enabled}) async {
    if (enabled) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }
}

@Riverpod(keepAlive: true)
LiveMonitorWakeLockPlatform liveMonitorWakeLockPlatform(Ref ref) =>
    WakelockPlusLiveMonitorWakeLockPlatform();
