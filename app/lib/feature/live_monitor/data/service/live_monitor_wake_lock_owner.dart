import 'package:eqmonitor/core/screen_behavior/data/service/screen_wake_lock_owner.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_wake_lock_platform.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_wake_lock_owner.g.dart';

// 既存セッションとアプリ全体の要求が同じ owner を共有する。
final class LiveMonitorWakeLockOwner extends ScreenWakeLockOwner {
  new({required LiveMonitorWakeLockPlatform platform})
    : super(setEnabled: platform.setEnabled);
}

@Riverpod(keepAlive: true)
LiveMonitorWakeLockOwner liveMonitorWakeLockOwner(Ref ref) {
  final owner = LiveMonitorWakeLockOwner(
    platform: ref.watch(liveMonitorWakeLockPlatformProvider),
  );
  ref.onDispose(owner.dispose);
  return owner;
}
