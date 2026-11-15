import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/screen_behavior/data/notifier/screen_behavior_settings_notifier.dart';
import 'package:eqmonitor/core/screen_behavior/data/provider/screen_wake_lock_owner_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_wake_lock_controller.g.dart';

@Riverpod(keepAlive: true)
class ScreenWakeLockController extends _$ScreenWakeLockController {
  @override
  Future<void> build() {
    final owner = ref.watch(screenWakeLockOwnerProvider);
    final lifecycle = ref.watch(appLifecycleProvider);
    final keepScreenAwake = ref.watch(
      screenBehaviorSettingsProvider.select(
        (settings) => settings.value?.keepScreenAwake ?? false,
      ),
    );
    return owner.setDesired(
      enabled: keepScreenAwake && lifecycle == AppLifecycleState.resumed,
      force: keepScreenAwake && lifecycle == AppLifecycleState.resumed,
    );
  }
}
