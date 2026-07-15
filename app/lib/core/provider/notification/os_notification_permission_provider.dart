import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
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
  final messaging = ref.watch(firebaseMessagingProvider);
  final settings = await messaging.getNotificationSettings();
  return settings.toOsNotificationPermission();
}
