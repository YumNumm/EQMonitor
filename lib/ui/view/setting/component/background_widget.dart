import 'package:eqmonitor/utils/background_task/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:web_socket_channel/io.dart';

IOWebSocketChannel? ws;

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  void _initForegroundTask() => FlutterForegroundTask.init(
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

  Future<void> _startForegroundTask() async {
    // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
    // onNotificationPressed function to be called.
    //
    // When the notification is pressed while permission is denied,
    // the onNotificationPressed function is not called and the app opens.
    //
    // If you do not use the onNotificationPressed or launchApp function,
    // you do not need to write this code.
    if (!await FlutterForegroundTask.canDrawOverlays) {
      final isGranted =
          await FlutterForegroundTask.openSystemAlertWindowSettings();
      if (!isGranted) {
        print('SYSTEM_ALERT_WINDOW permission denied!');
      }
    }

    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        notificationTitle: 'EQMonitor WebSocket Service',
        notificationText: 'Connecting to WebSocket...',
        callback: startForegroundTask,
      );
    }
  }

  Future<bool> _stopForegroundTask() async {
    return FlutterForegroundTask.stopService();
  }

  @override
  void initState() {
    super.initState();
    _initForegroundTask();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    const titleTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: const Text('Background Task', style: titleTextStyle),
      subtitle: const Text(
        'Start/Stop background task',
        style: descriptionTextStyle,
      ),
      onTap: () async {
        final isRunning = await FlutterForegroundTask.isRunningService;
        if (isRunning) {
          await _stopForegroundTask();
        } else {
          await _startForegroundTask();
        }
      },
    );
  }
}
