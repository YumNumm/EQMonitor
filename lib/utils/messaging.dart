// ignore_for_file: constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/const/const.dart';
import 'package:eqmonitor/utils/notification/foregroundHandler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/notificationSettings/notificationSettings.dart';
import 'notification/backgroundHandler.dart';

class Messaging extends GetxController {
  final Logger logger = Get.find<Logger>();
  final SharedPreferences prefs = Get.find<SharedPreferences>();
  final Box<NotificationSettingsState?> notifBox =
      Get.find<Box<NotificationSettingsState?>>();
  final RxBool isInitalizing = true.obs;
  late Stream<RemoteMessage> onMessageOpenedApp;
  final RxString token = ''.obs;
  final RxBool isAllNotificationDisabled = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    final messaging = Get.find<FirebaseMessaging>();
    await messaging.requestPermission(
      announcement: true,
      criticalAlert: true,
      provisional: true,
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async => await foregroundHandler(message),
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await AwesomeNotifications().initialize(
      'resource://drawable/icon_monochrome',
      notificationChannels,
      channelGroups: channelGroups,
      debug: kDebugMode,
    );
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().actionStream.listen((event) {
      logger.i(event.bigPicturePath);
      Get.dialog<void>(
        AlertDialog(
          scrollable: true,
          title: Text(event.title.toString()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(event.body.toString()),
              Hero(
                tag: 'Image',
                child: Image.network(
                  event.bigPicture.toString(),
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(30),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      );
    });
    for (final e in Topics.values) {
      await messaging.subscribeToTopic(e.name);
    }
    await prefs.setBool('hasSubscribed', true);

    isInitalizing.value = false;
    token.value =
        await messaging.getToken() ?? "[E] coludn't get FCM Token...!";
  }
}
