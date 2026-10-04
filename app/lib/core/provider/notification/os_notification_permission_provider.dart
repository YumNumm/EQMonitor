import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'os_notification_permission_provider.g.dart';

@riverpod
Future<OsNotificationPermission> osNotificationPermission(Ref ref) async {
  ref.listen(appLifecycleProvider, (_, next) {
    if (next == AppLifecycleState.resumed) {
      ref.invalidateSelf();
    }
  });
  return ref.watch(permissionRepositoryProvider).getNotificationPermission();
}
