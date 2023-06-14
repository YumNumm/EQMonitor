import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/common/fcm/channels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NotificationController extends ChangeNotifier {
  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

  static final NotificationController _instance =
      NotificationController._internal();

  String _firebaseToken = '';
  String get firebaseToken => _firebaseToken;

  String _nativeToken = '';
  String get nativeToken => _nativeToken;

  ReceivedAction? initialAction;

  /// *********************************************
  ///   INITIALIZATION METHODS
  /// *********************************************

  static Future<void> initializeLocalNotifications({
    required bool debug,
  }) async {
    await AwesomeNotifications().initialize(
      (Platform.isAndroid) ? 'resource://drawable/res_app_icon' : null,
      notificationChannels,
      debug: debug,
      channelGroups: notificationChannelGroups,
    );

    // Get initial notification action is optional
    _instance.initialAction =
        await AwesomeNotifications().getInitialNotificationAction();
  }

  static Future<void> initializeRemoteNotifications({
    required bool debug,
  }) async {
    await AwesomeNotificationsFcm().initialize(
      onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
      onFcmTokenHandle: NotificationController.myFcmTokenHandle,
      onNativeTokenHandle: NotificationController.myNativeTokenHandle,
      licenseKeys: [
        // net.yumnumm.eqmonitor
        'LsyxBtb1EycLGKVXBrTeOOrvXFK+QayEXEn5Zw4+z7h/+BxzT50I8m5uhlsRlfCjSEaVoPCi6EskM/9l9YYQZDsS+iIZEHUMv1mcxKofceoPIsRmu5kfuKKK/Cudeo9T8cRRGQRDQm9YAZY+kCk5ic/85+GNXqBl8apuPWFkb78=',
        // net.yumnumm.eqmonitor.dev
        'BlmPtVdPWrH6oPhmyQe7/C+8bGeuA3JSYSkNg2F6EhZ7/yvOBA/LWPYP7hrNO2pF3o5seo9c+jQmgY9GEIN1w6AlR3Ew6CSVntYWFAXeqZFiB0JaNXCdPqGAq++Jf0jEqLg47s+He7YeKdYc5AujYlKHgvcON3guBYuMl7W7yy4= ',
      ],
      debug: debug,
    );
  }

  static Future<void> startListeningNotificationEvents() async {
    await AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     LOCAL NOTIFICATION EVENTS
  ///  *********************************************

  static Future<void> getInitialNotificationAction() async {
    final receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: true);
    if (receivedAction == null) {
      return;
    }
    // Fluttertoast.showToast(
    //     msg: 'Notification action launched app: $receivedAction',
    //   backgroundColor: Colors.deepPurple
    // );
    print('Notification action launched app: $receivedAction');
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    print('onActionReceivedMethod: $receivedAction');
    /*MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/notification-page',
      (route) => (route.settings.name != '/notification-page') || route.isFirst,
      arguments: receivedAction,
    );*/
  }

  ///  *********************************************
  ///     REMOTE NOTIFICATION EVENTS
  ///  *********************************************

  /// Use this method to execute on background when a silent data arrives
  /// (even while terminated)
  @pragma('vm:entry-point')
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": $silentData');
    await FlutterTts().speak(silentData.data?['tts'] ?? 'データは空です');

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      print('bg');
    } else {
      print('FOREGROUND');
    }

    print('mySilentDataHandle received a FcmSilentData execution');
  }

  /// Use this method to detect when a new fcm token is received
  @pragma('vm:entry-point')
  static Future<void> myFcmTokenHandle(String token) async {
    print('Firebase Token:"$token"');

    _instance._firebaseToken = token;
    _instance.notifyListeners();
  }

  /// Use this method to detect when a new native token is received
  @pragma('vm:entry-point')
  static Future<void> myNativeTokenHandle(String token) async {
    print('Native Token:"$token"');

    _instance._nativeToken = token;
    _instance.notifyListeners();
  }

  ///  *********************************************
  ///     REQUEST NOTIFICATION PERMISSIONS
  ///  *********************************************

  static Future<bool> displayNotificationRationale() async {
    var userAuthorized = false;
    final context = App.navigatorKey.currentContext!;
    // 既に許可されている場合は何もしない
    if (await AwesomeNotifications().isNotificationAllowed()) {
      return userAuthorized;
    }
    if (context.mounted) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              '通知を許可しますか?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '緊急地震速報などの地震情報をお知らせします',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  '拒否',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () async {
                  userAuthorized = true;
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  '許可',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.deepPurple),
                ),
              ),
            ],
          );
        },
      );
      return userAuthorized &&
          await AwesomeNotifications().requestPermissionToSendNotifications();
    }
    return false;
  }

  static Future<void> resetBadge() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  ///  *********************************************
  ///     REMOTE TOKEN REQUESTS
  ///  *********************************************

  static Future<String> requestFirebaseToken() async {
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        return await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (exception) {
        print('$exception');
      }
    } else {
      print('Firebase is not available on this project');
    }
    return '';
  }
}
