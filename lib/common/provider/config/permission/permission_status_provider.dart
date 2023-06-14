import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/common/provider/config/permission/model/permission_state.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_status_provider.g.dart';

@riverpod
class Permission extends _$Permission {
  @override
  PermissionStateModel build() {
    return const PermissionStateModel();
  }

  Future<void> init() async {
    state = PermissionStateModel(
      notification: await _notificationPermission(),
    );
  }

  Future<bool> _notificationPermission() async {
    final status = await handler.Permission.notification.status;
    return status == handler.PermissionStatus.granted;
  }

  Future<void> requestNotificationPermission() async {
    final status = await handler.Permission.notification.request();
    if (status != handler.PermissionStatus.granted) {
      // 通知設定の画面を開く
      await AwesomeNotifications().showNotificationConfigPage();
    }
    await init();
  }
}
