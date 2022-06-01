// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:eqmonitor/const/const.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../db/notificationSettings/notificationSettings.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  const fss = FlutterSecureStorage();
  //? TTSを使うかどうか
  final useTTS =
      (await fss.read(key: 'useTTS')).toString().parseBool(defaultValue: false);
  //? 通知条件をクリアしているかをチェックする
  final j =
      json.decode(message.data['content'].toString()) as Map<String, dynamic>;
  var shouldNotif = false;

  if (j['channelKey'].toString() == 'eew_forecast') {
    final Map<String, dynamic> fssData = await fss.readAll();
    final state = NotificationSettingsState(
      notifAll: fss.read(key: 'notifAll').toString().parseBool(),
      notifFirstReport: fss.read(key: 'notifFirstReport').toString().parseBool(),
      notifLastReport: fss.read(key: 'notifLastReport').toString().parseBool(),
      notifOnUpdate: fss.read(key: 'notifOnUpdate').toString().parseBool(),
      notifOnUpwardUpdate:
          fss.read(key: 'notifOnUpwardUpdate').toString().parseBool(),
      useTTS: fss.read(key: 'useTTS').toString().parseBool(),
    );
    if (state.notifAll) shouldNotif = true;
    try {
      final condition =
          json.decode(message.data['condition'].toString()) as List<dynamic>;
      final payload = List<bool>.generate(
        condition.length,
        (index) => condition[index].toString().parseBool(),
      );
      print(
        'Notification Settings: ${state.notifAll},${state.notifFirstReport},${state.notifLastReport},${state.notifOnUpdate},${state.notifOnUpwardUpdate}',
      );
      if (state.notifFirstReport && payload[0]) shouldNotif = true;
      if (state.notifLastReport && payload[1]) shouldNotif = true;
      if (state.notifOnUpdate && payload[2]) shouldNotif = true;
      if (state.notifOnUpwardUpdate && payload[3]) {
        shouldNotif = true;
      }
    } catch (e) {
      print(e);
    }
  } else {
    shouldNotif = true;
  }
  if (shouldNotif) {
    print(message.messageType);
    await AwesomeNotifications().createNotificationFromJsonData(message.data);
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage('ja-JP');
    if (message.data['tts'] != null) {
      if (useTTS) await flutterTts.speak(message.data['tts'].toString());
    }
    if (fss.read(key: 'toTweet').toString().toLowerCase() == 'true') {
      await fss.read(key: 'tweetIntensityList') ?? '{}';
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
}
