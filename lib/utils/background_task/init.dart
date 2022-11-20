import 'dart:developer';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void initForegroundTask() {
  log('initForegroundTask');
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'foreground_task',
      channelName: 'Foreground Notification',
      channelDescription:
          'This notification appears when the foreground service is running.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      // iconData: const NotificationIconData(
      //   resType: ResourceType.mipmap,
      //   resPrefix: ResourcePrefix.ic,
      //   name: 'launcher',
      // ),
      buttons: [
        const NotificationButton(id: 'disconnectButton', text: '切断'),
        const NotificationButton(id: 'reconnectButton', text: '再接続'),
      ],
    ),
    iosNotificationOptions: const IOSNotificationOptions(),
    foregroundTaskOptions: const ForegroundTaskOptions(
      autoRunOnBoot: true,
      allowWifiLock: true,
    ),
  );
}
