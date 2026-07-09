import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_permission_provider.g.dart';

/// OS の通知許可状態(granted)を保持する。
/// アプリがフォアグラウンド復帰した時に自動で再取得する。
@Riverpod(keepAlive: true)
Future<bool> isNotificationPermissionGranted(Ref ref) async {
  ref.listen(appLifecycleProvider, (_, next) {
    if (next == AppLifecycleState.resumed) {
      ref.invalidateSelf();
    }
  });
  final permission = await ref
      .read(permissionRepositoryProvider)
      .getNotificationPermission();
  return permission.isOsNotificationGranted;
}
