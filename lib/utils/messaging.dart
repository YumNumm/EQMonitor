import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Messaging extends GetxController {
  final Logger logger = Get.find<Logger>();
  final RxBool isInitalizing = true.obs;
  late Stream<RemoteMessage> onMessageOpenedApp;
  final RxString token = ''.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    final messaging = Get.find<FirebaseMessaging>();
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async => await AwesomeNotifications()
          .createNotificationFromJsonData(message.data),
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    if (!kIsWeb) {
      await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
            channelGroupKey: 'eqNotification',
            channelKey: 'eew_alert',
            channelName: '緊急地震速報(警報)',
            channelDescription: '緊急地震速報(警報)の通知',
            defaultColor: const Color.fromARGB(255, 255, 0, 0),
            ledColor: const Color.fromARGB(255, 255, 0, 0),
            channelShowBadge: true,
            criticalAlerts: true,
            enableVibration: true,
            importance: NotificationImportance.Max,
          ),
          NotificationChannel(
            channelKey: 'eqNotification',
            channelName: 'eew_forecast',
            channelDescription: '地震速報(予報)',
            defaultColor: const Color.fromARGB(255, 255, 138, 0),
            importance: NotificationImportance.High,
          ),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
            channelGroupkey: 'eqNotification',
            channelGroupName: '地震通知',
          ),
          NotificationChannelGroup(
            channelGroupkey: 'fromDev',
            channelGroupName: '開発者からのお知らせ',
          ),
        ],
        debug: true,
      );
      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    await messaging.subscribeToTopic('everyone');
    await messaging.subscribeToTopic('eq');
    await messaging.subscribeToTopic('alpha');

    //? Init Done!
    isInitalizing.value = false;
    token.value =
        await messaging.getToken() ?? "[E] coludn't get FCM Token...!";
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await AwesomeNotifications().createNotificationFromJsonData(message.data);
}
