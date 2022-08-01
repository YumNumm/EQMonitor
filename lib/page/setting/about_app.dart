import 'package:eqmonitor/main.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class AboutAppPage extends HookConsumerWidget {
  const AboutAppPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final travelTime = ref.watch(travelTimeController);
    final kmoniMap = ref.watch(kmoniMapController);
    final kmoni = ref.watch(kmoniNotifier);
    final fcm = ref.watch(firebaseCloudMessagingNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('アプリ情報'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile(
                title: Card(
                  child: Image.asset('assets/header.png'),
                ),
              )
            ],
          ),
          SettingsSection(
            title: const Text('基本情報'),
            tiles: <SettingsTile>[
              SettingsTile(
                title: const Text('ライセンス情報'),
                onPressed: (context) => showLicensePage(
                  context: context,
                  applicationName: 'EQMonitor',
                  applicationIcon: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.asset(
                      'assets/icon.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  applicationLegalese:
                      'MIT License\nCopyright (c) 2022 Onoue Ryotaro',
                  useRootNavigator: true,
                ),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('デバッグ情報'),
            tiles: <SettingsTile>[
              SettingsTile(
                title: const Text('走時表読み込み'),
                value: Text(
                  (travelTime.loadDuration != null)
                      ? '${travelTime.loadDuration!.inMicroseconds / 1000}ms '
                          '(${travelTime.travelTimeTable.length}件)'
                      : '読み込み失敗',
                ),
              ),
              SettingsTile(
                title: const Text('マップ読み込み'),
                value: Text(
                  (kmoniMap.loadDuration != null)
                      ? '${kmoniMap.loadDuration!.inMicroseconds / 1000}ms '
                          '(${kmoniMap.mapPolygons.length}件)'
                      : '読み込み失敗',
                ),
              ),
              SettingsTile(
                title: const Text('観測点読み込み'),
                value: Text(
                  (kmoni.loadDuration != null)
                      ? '${kmoni.loadDuration!.inMicroseconds / 1000}ms '
                          '(${kmoni.analyzedPoint.length}件)'
                      : '読み込み失敗',
                ),
              ),
              SettingsTile(
                title: const Text('ログ保管先'),
                value: Text(
                  logDirectory.path,
                ),
              ),
              SettingsTile(
                title: const Text('Firebase Cloud Messaging トークン'),
                value: Text(fcm.token.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
