// ignore_for_file: constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/const/notification_channel.dart';
import 'package:eqmonitor/model/firebase/firebase_notification_status_model.dart';
import 'package:eqmonitor/utils/fcm/background_handler.dart';
import 'package:eqmonitor/utils/fcm/foreground_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseCloudMessagingController
    extends StateNotifier<FirebaseCloudMessagingModel> {
  FirebaseCloudMessagingController()
      : super(
          const FirebaseCloudMessagingModel(
            token: null,
            hasToken: false,
          ),
        );

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printTime: true,
    ),
  );

  Future<void> onInit() async {
    // 権限を取得
    final permissionResult = await Permission.notification.request();
    _logger.d('通知権限: ${permissionResult.isGranted}');
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

    // FCM Tokenを取得
    final token = await _messaging.getToken();
    if (token != null) {
      _logger.d('FCM Token: $token');
      state = state.copyWith(
        token: token,
        hasToken: true,
      );
    }
    // TopicをSubscribe
    for (final e in Topics.values) {
      await _messaging.subscribeToTopic(e.name);
    }
  }
}

enum Topics {
  /// ## 緊急地震速報
  eew,

  /// ## 震度速報
  VXSE51,

  /// ## 震源に関する情報
  VXSE52,

  /// ## 震源・震度に関する情報
  VXSE53,

  /// ## 長周期地震動に関する情報
  VXSE62,

  /// ## 地震・津波に関するお知らせ
  VZSE40,

  /// ## 利用者全員への緊急連絡
  everyone,
}
