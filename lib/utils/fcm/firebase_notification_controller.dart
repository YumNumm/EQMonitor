// ignore_for_file: constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/model/setting/notification_settings_model.dart';
import 'package:eqmonitor/utils/fcm/background_handler.dart';
import 'package:eqmonitor/utils/fcm/foreground_handler.dart';
import 'package:eqmonitor/utils/fcm/notification_channel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> initFirebaseCloudMessaging() async {
  final talker = Talker(
    filter: BaseTalkerFilter(
      titles: ['Firebase Cloud Messaging'],
    ),
  );
  final messaging = FirebaseMessaging.instance;
  // 権限を取得
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  // Foreground/Backgroundでイベントを受け取るHandlerを登録
  FirebaseMessaging.onMessage.listen(
    (message) async => firebaseMessagingForegroundHandler(message),
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Awesome Notificationの初期化
  await AwesomeNotifications().initialize(
    'resource://drawable/icon_monochrome',
    notificationChannels,
    channelGroups: channelGroups,
    debug: kDebugMode,
  );

  Future<void> subscribe() async {
    // TopicをSubscribe
    for (final e in Topics.values) {
      await messaging.subscribeToTopic(e.name);
      talker.debug('Subscribed to Topic ${e.name}');
    }
    // Notification Settingを取得
    final prefs = await SharedPreferences.getInstance();
    final setting = NotificationSettingsModel.loadFromPrefs(prefs);
    if (setting.isRecieveTraining) {
      await messaging.subscribeToTopic('test');
      talker.debug('Subscribed to Topic test');
    } else {
      await messaging.unsubscribeFromTopic('test');
      talker.debug('Unsubscribed to Topic test');
    }
    if (setting.isRecieveVzse40) {
      await messaging.subscribeToTopic('vzse40');
      talker.debug('Subscribed to Topic vzse40');
    } else {
      await messaging.unsubscribeFromTopic('vzse40');
      talker.debug('Unsubscribed to Topic vzse40');
    }
  }

  void sub() => subscribe();
  sub();
}

enum Topics {
  /// ## 地震情報
  eew,
  everyone,
}
