import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/screen_behavior/data/notifier/screen_behavior_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_wake_lock_owner.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_wake_lock_controller.g.dart';

@Riverpod(keepAlive: true)
class ScreenWakeLockController extends _$ScreenWakeLockController {
  @override
  Future<void> build() {
    final owner = ref.watch(liveMonitorWakeLockOwnerProvider);
    final lifecycle = ref.watch(appLifecycleProvider);
    final keepScreenAwake = ref.watch(
      screenBehaviorSettingsProvider.select(
        (settings) => settings.value?.keepScreenAwake ?? false,
      ),
    );
    return owner.setApplicationDesired(
      enabled: keepScreenAwake && lifecycle == AppLifecycleState.resumed,
      force: keepScreenAwake && lifecycle == AppLifecycleState.resumed,
    );
  }
}
