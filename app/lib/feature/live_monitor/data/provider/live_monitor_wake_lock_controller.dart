import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_wake_lock_owner.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_wake_lock_controller.g.dart';

@Riverpod(keepAlive: true)
class LiveMonitorWakeLockController extends _$LiveMonitorWakeLockController {
  @override
  Future<void> build() async {
    final owner = ref.watch(liveMonitorWakeLockOwnerProvider);
    final sessionActive = ref.watch(liveMonitorSessionProvider);
    final lifecycle = ref.watch(appLifecycleProvider);
    final settings = await ref.watch(liveMonitorSettingsProvider.future);
    final desired =
        sessionActive &&
        settings.keepScreenAwake &&
        lifecycle == AppLifecycleState.resumed;
    await owner.setDesired(enabled: desired);
  }
}
