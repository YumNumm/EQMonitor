import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../private/keys.dart';

Future<void> foregroundHandler(RemoteMessage message) async {
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
