import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'os_notification_permission_provider.g.dart';

@riverpod
Future<OsNotificationPermission> osNotificationPermission(Ref ref) async {
  final messaging = ref.watch(firebaseMessagingProvider);
  final settings = await messaging.getNotificationSettings();
  return OsNotificationPermission.fromNotificationSettings(settings);
}
