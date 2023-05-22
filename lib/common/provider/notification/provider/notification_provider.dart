import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/common/provider/app_lifecycle.dart';
import 'package:eqmonitor/common/provider/notification/model/notification_state_model.dart';
import 'package:eqmonitor/common/provider/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_provider.g.dart';

@Riverpod(keepAlive: true)
class NotificationState extends _$NotificationState {
  @override
  NotificationStateModel build() {
    _prefs = ref.read(sharedPreferencesProvider);
    // アプリから一旦離れて戻ってきたときに
    // 再度、通知権限の状態を取得する
    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.resumed) {
        init();
      }
    });
    final res = _loadFromPrefs();
    if (res != null) {}
    return const NotificationStateModel();
  }

  late final SharedPreferences _prefs;

  static const _key = 'NotificationState';

  Future<void> init() async {
    /// 通知権限の状態を取得する
    final isNotificationPermissionAllowed = await _notificationPermission();
    state = state.copyWith(
      isAccepted: isNotificationPermissionAllowed,
    );
  }

  // 通知権限のリクエスト
  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      // 通知設定の画面を開く
      await AppSettings.openNotificationSettings();
    }
    await init();
  }

  Future<bool> _notificationPermission() async {
    final status = await Permission.notification.status;
    return status == PermissionStatus.granted;
  }

  NotificationStateModel? _loadFromPrefs() {
    final data = _prefs.getString(_key);
    if (data == null) {
      return const NotificationStateModel();
    }
    return NotificationStateModel.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
  }
}
