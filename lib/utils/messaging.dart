// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import '../db/notificationSettings/notificationSettings.dart';

class Messaging extends GetxController {
  final Logger logger = Get.find<Logger>();
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
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      //? 通知条件をクリアしているかをチェックする
      final j = json.decode(message.data['content'].toString())
          as Map<String, dynamic>;
      if (j['channelKey'].toString() == 'eew_forecast') {
        final state = notifBox.get('recent')!;

        var shouldNotif = false;
        if (state.notifAll) shouldNotif = true;
        final payload = List<bool>.generate(
          (message.data['condition'] as List<dynamic>).length,
          (index) => bool.fromEnvironment(
            (message.data['condition'] as List<dynamic>)[index].toString(),
          ),
        );

        if (state.notifFirstReport && payload[0]) shouldNotif = true;
        if (state.notifLastReport && payload[1]) shouldNotif = true;
        if (state.notifOnUpdate && payload[2]) shouldNotif = true;
        if (state.notifOnUpwardUpdate && payload[3]) {
          shouldNotif = true;
        }
        if (!shouldNotif) return;
      }
      const fss = FlutterSecureStorage();
      await AwesomeNotifications().createNotificationFromJsonData(message.data);
      final flutterTts = FlutterTts();
      await flutterTts.setLanguage('ja-JP');
      if (message.data['tts'] != null) {
        await flutterTts.speak(message.data['tts'].toString());
      }
      if (bool.fromEnvironment(
        fss.read(key: 'toTweet').toString(),
        defaultValue: true,
      )) {
        final AT = await fss.read(key: 'AT');
        final AS = await fss.read(key: 'AS');
        if (AT != null && AS != null) {
          final twitterApi = TwitterApi(
            client: TwitterClient(
              consumerKey: clientCredentials.token,
              consumerSecret: clientCredentials.tokenSecret,
              token: AT,
              secret: AS,
            ),
          );
          //print(AT + AS);
          final res = await twitterApi.tweetService.update(
            status:
                '${message.data['content']['title']}\n${message.data['content']['body']}',
          );
        }
      }
    });
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
            channelGroupKey: 'fromdev',
            channelKey: 'fromdev',
            channelName: '開発者からのお知らせ',
            channelDescription: '開発者からなにか連絡があった時に使用されます。',
            channelShowBadge: true,
            enableVibration: true,
            playSound: true,
            importance: NotificationImportance.High,
          ),
          //! EEW
          NotificationChannel(
            channelGroupKey: 'eew',
            channelKey: 'eew_alert',
            channelName: '緊急地震速報(警報)',
            channelDescription: '緊急地震速報(警報)通知',
            defaultColor: const Color.fromARGB(255, 190, 0, 0),
            ledColor: const Color.fromARGB(255, 190, 0, 0),
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            criticalAlerts: true,
            enableVibration: true,
            soundSource: 'resource://raw/res_eew',
            importance: NotificationImportance.Max,
          ),
          NotificationChannel(
            channelGroupKey: 'eew',
            channelKey: 'eew_forecast',
            channelName: '緊急地震速報(予報)',
            channelDescription: '緊急地震速報(予報)通知',
            defaultColor: const Color.fromARGB(255, 255, 59, 59),
            ledColor: const Color.fromARGB(255, 255, 59, 59),
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            criticalAlerts: true,
            enableVibration: true,
            soundSource: 'resource://raw/res_eq1',
            importance: NotificationImportance.Max,
          ),
          //! 地震通知
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VZSE40',
            channelName: '地震・津波に関するお知らせ',
            channelDescription: '地震・津波の試験・訓練配信のお知らせ、自治体震度データの入電停止等のお知らせ、その他を発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            soundSource: 'resource://raw/res_eq1',
            importance: NotificationImportance.Low,
          ),
          NotificationChannel(
            channelGroupKey: 'tsunami',
            channelKey: 'VTSE41',
            channelName: '津波警報・注意報・予報',
            channelDescription:
                '影響をもたらす津波が到達すると予測された地域、または影響がなくなった地域に対して、津波警報・注意報・予報の発表・切替及び解除について、予報区ごとに予想の高さや津波到達時間、震源要素等を発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'tsunami',
            channelKey: 'VTSE51',
            channelName: '津波情報',
            channelDescription:
                '各地の満潮時刻、津波到達予想時刻に関する情報及び地上観測点における津波観測に関する情報を発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'tsunami',
            channelKey: 'VTSE52',
            channelName: '沖合の津波情報',
            channelDescription: '沖合の観測点における津波観測に関する情報を発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'tsunami',
            channelKey: 'WEPA60',
            channelName: '国際津波関連情報(国内向け)',
            channelDescription:
                '北西太平洋域でM6.5以上の地震が発生した場合、北西太平洋域の各国が津波警報等の発表に資するための支援情報として発表するものを複製した国内向け配信',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VXSE51',
            channelName: '震度速報',
            channelDescription: '震度3以上の地域を90秒程度で第1報を通知',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VXSE52',
            channelName: '震源に関する情報',
            channelDescription: '震源速報、津波の有無を通知',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VXSE53',
            channelName: '震源・震度に関する情報',
            channelDescription: '震源要素・各地の震度、海外で発生した大きな地震の震源要素等、津波の有無を通知',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VXSE56',
            channelName: '地震の活動状況等に関する情報',
            channelDescription: '地震の活動状況等に関する情報や、伊豆東部の地震活動に関する情報などの解説情報を発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VXSE60',
            channelName: '地震回数に関する情報',
            channelDescription: '顕著な地震に対して、有感地震の回数経過状況を発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VXSE61',
            channelName: '顕著な地震の震源要素更新のお知らせ',
            channelDescription: '顕著な地震に対して、震源要素をより正確にした情報を発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VXSE62',
            channelName: '長周期地震動に関する観測情報',
            channelDescription: '長周期地震動階級1以上を観測した地震について、観測した要素などを地震発生後10分程度で発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VYSE50',
            channelName: '南海トラフ地震臨時情報',
            channelDescription:
                '南海トラフ沿いで異常な現象が観測され、その現象が南海トラフ沿いの大規模な地震発生が警戒される場合に発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VYSE51',
            channelName: '南海トラフ地震関連解説情報(定例外)',
            channelDescription:
                '南海トラフ沿いで異常な現象が観測され、その現象が南海トラフ沿いの大規模な地震と関連するかどうか調査を開始・解説・終了した場合等に発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelGroupKey: 'earthquake',
            channelKey: 'VYSE52',
            channelName: '南海トラフ地震関連解説情報(定例)',
            channelDescription: '南海トラフ沿いの地震に関する評価検討会の定例会合における調査結果の発表',
            channelShowBadge: true,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
          ),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
            channelGroupkey: 'eew',
            channelGroupName: '緊急地震速報',
          ),
          NotificationChannelGroup(
            channelGroupkey: 'earthquake',
            channelGroupName: '地震通知',
          ),
          NotificationChannelGroup(
            channelGroupkey: 'tsunami',
            channelGroupName: '津波通知',
          ),
          NotificationChannelGroup(
            channelGroupkey: 'fromdev',
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

    //if (!(prefs.getBool('hasInited') ?? false)) {
    for (final e in Topics.values) {
      //final now = prefs.getStringList('topics') ?? [];
      //if (!now.contains(e.name)) {
      await messaging.subscribeToTopic(e.name);
      //now.add(e.name);
      //await prefs.setStringList('topics', now);
      //}
    }
    //}

    isInitalizing.value = false;
    token.value =
        await messaging.getToken() ?? "[E] coludn't get FCM Token...!";
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //? 通知条件をクリアしているかをチェックする
  final j =
      json.decode(message.data['content'].toString()) as Map<String, dynamic>;
  if (j['channelKey'].toString() == 'eew_forecast') {
    await Hive.initFlutter();
    final notifBox =
        await Hive.openBox<NotificationSettingsState?>('NotificationSettings');
    final state = notifBox.get('recent')!;
    var shouldNotif = false;
    if (state.notifAll) shouldNotif = true;
    final payload = List<bool>.generate(
      (message.data['condition'] as List<dynamic>).length,
      (index) => bool.fromEnvironment(
        (message.data['condition'] as List<dynamic>)[index].toString(),
      ),
    );

    if (state.notifFirstReport && payload[0]) shouldNotif = true;
    if (state.notifLastReport && payload[1]) shouldNotif = true;
    if (state.notifOnUpdate && payload[2]) shouldNotif = true;
    if (state.notifOnUpwardUpdate && payload[3]) {
      shouldNotif = true;
    }
    if (!shouldNotif) return;
  }
  await Firebase.initializeApp();
  const fss = FlutterSecureStorage();
  await AwesomeNotifications().createNotificationFromJsonData(message.data);
  final flutterTts = FlutterTts();
  await flutterTts.setLanguage('ja-JP');
  if (message.data['tts'] != null) {
    await flutterTts.speak(message.data['tts'].toString());
  }
  if (bool.fromEnvironment(
    fss.read(key: 'toTweet').toString(),
    defaultValue: true,
  )) {
    final AT = await fss.read(key: 'AT');
    final AS = await fss.read(key: 'AS');
    if (AT != null && AS != null) {
      final twitterApi = TwitterApi(
        client: TwitterClient(
          consumerKey: clientCredentials.token,
          consumerSecret: clientCredentials.tokenSecret,
          token: AT,
          secret: AS,
        ),
      );
      //print(AT + AS);
      final res = await twitterApi.tweetService.update(
        status:
            '${message.data['content']['title']}\n${message.data['content']['body']}',
      );
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
