import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_role_notifier.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_app_icon_action.g.dart';

@riverpod
SettingsAppIconAction settingsAppIconAction(Ref ref) =>
    const SettingsAppIconAction();

class const SettingsAppIconAction() {
  /// デバイスのロールを取得し直す。
  ///
  /// 結果は画面に表示せず、取得が終わったことだけを触覚で知らせる。
  Future<void> refreshDeviceRole(WidgetRef ref) async {
    try {
      await DeviceRoleNotifier.refreshMutation.run(
        ref,
        (tsx) => tsx.get(deviceRoleProvider.notifier).refresh(),
      );
    } on Object catch (error, stackTrace) {
      talker.warning('[DeviceRole] refresh failed', error, stackTrace);
    }
    await HapticFeedback.mediumImpact();
  }
}
