// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sentry/sentry.dart';

import '../../utils/messaging.dart';

final PackageInfo packageInfo = Get.find<PackageInfo>();
final Messaging messaging = Get.find<Messaging>();

Widget aboutThisApp() {
  return SettingsList(
    sections: [
      SettingsSection(
        tiles: [
          // Package Name

          SettingsTile.navigation(
            title: const Text('アプリ名'),
            description: Text(
              '${packageInfo.appName} (Build ${packageInfo.version} - ${packageInfo.buildNumber})',
            ),
          ),
          SettingsTile.navigation(
            title: const Text('パッケージ名'),
            description: Text(packageInfo.packageName),
          ),
          // FCM Token
          SettingsTile.navigation(
            title: const Text('FCMトークン'),
            description: Text(messaging.token.toString()),
            onPressed: (BuildContext context) async {
              await Clipboard.setData(
                ClipboardData(
                  text: messaging.token.toString(),
                ),
              );
              Get.showSnackbar(
                const GetSnackBar(
                  title: 'コピーしました。',
                  message: 'クリップボードにコピーしました。',
                  duration: Duration(milliseconds: 1500),
                ),
              );
            },
          ),
          SettingsTile.navigation(
            title: const Text('ライセンス情報'),
            onPressed: (BuildContext context) async => showLicensePage(
              context: context,
              applicationIcon: const FlutterLogo(),
              applicationVersion: packageInfo.version,
              applicationName: packageInfo.appName,
              applicationLegalese: 'MIT 2022 Onoue Ryotaro',
            ),
          ),
          SettingsTile.navigation(
            title: const Text('Special Thanks'),
            onPressed: (BuildContext context) => Get.dialog<void>(
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Chromium_Linux氏'),
                      subtitle: const Text('起動画面・アプリアイコン'),
                      onTap: () => launch('https://twitter.com/Chromium_Linux'),
                    ),
                    ListTile(
                      title: const Text('ingen084氏'),
                      subtitle: const Text('強震モニタ画像解析手法'),
                      onTap: () => launch('https://github.com/ingen084/KyoshinMonitorLib'),
                    ),
                    const Divider(
                      height: 5,
                      color: Colors.grey,
                    ),
                    ListTile(
                      title: const Text('国立研究開発法人 防災科学技術研究所'),
                      subtitle: const Text('リアルタイム震度データ'),
                      onTap: () => launch(
                        'https://www.kyoshin.bosai.go.jp/kyoshin/docs/new_kyoshinmonitor.html',
                      ),
                    ),
                    ListTile(
                      title: const Text('Yahoo 天気・災害'),
                      subtitle: const Text('過去の地震データ'),
                      onTap: () => launch(
                        'https://typhoon.yahoo.co.jp/weather/jp/earthquake/',
                      ),
                    ),
                  ],
                ),
                actions: const [],
                title: const Text('Special Thanks'),
                contentPadding: const EdgeInsets.all(30),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          SettingsTile.switchTile(
            initialValue: false,
            onToggle: (bool b) async {
              Get.snackbar(
                '(´･ω･｀)',
                'Developer Only Menu',
                duration: const Duration(milliseconds: 2000),
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            title: const Text('Debug Mode'),
          ),
          SettingsTile.navigation(
                      title: const Text('ソースコード'),
                      onPressed: (BuildContext context) => launch(
                        'https://github.com/YumNumm/EQMonitor',
                      ),
                    ),
                    SettingsTile.navigation(
                      title: const Text('crash!'),
                      onPressed: (BuildContext context) async {
                        try {
                         aMethodThatMightFail();
                        } catch (exception, stackTrace) {
                         await Sentry.captureException(
                           exception,
                           stackTrace: stackTrace,
                         );
                        }
                      }
                    ),
        ],
      ),
    ],
  );
}
