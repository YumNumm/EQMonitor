import 'dart:io';

import 'package:eqmonitor/core/provider/config/permission/model/permission_state.dart';
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
    if (Platform.isIOS) {}
    await init();
  }
}
