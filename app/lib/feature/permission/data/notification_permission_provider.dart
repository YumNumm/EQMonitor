import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_permission_provider.g.dart';

/// OS の通知許可状態(granted)を保持する。
@Riverpod(keepAlive: true)
Future<bool> isNotificationPermissionGranted(Ref ref) async {
  final permission = await ref.watch(osNotificationPermissionProvider.future);
  return permission.isOsNotificationGranted;
}
