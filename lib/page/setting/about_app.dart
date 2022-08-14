import 'package:eqmonitor/page/setting/term_of_service.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/state/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class AboutAppPage extends HookConsumerWidget {
  const AboutAppPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final travelTime = ref.watch(travelTimeController);
    final kmoniMap = ref.watch(kmoniMapController);
    final kmoni = ref.watch(kmoniController);
    final fcm = ref.watch(firebaseCloudMessagingNotifier);
    final eew = ref.watch(eewHistoryController);
    final isDarkMode = ref.watch(themeController.notifier).isDarkMode;

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
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Image.asset(
                    isDarkMode ? 'assets/header-dark.png' : 'assets/header.png',
                  ),
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
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/icon.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                  applicationLegalese:
                      'MIT License\nCopyright (c) 2022 YumNumm',
                  useRootNavigator: true,
                ),
              ),
              SettingsTile(
                title: const Text('利用規約'),
                onPressed: (context) => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const TermOfServicePage(
                      showAcceptButton: false,
                    ),
                  ),
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
                title: const Text('Firebase Cloud Messaging トークン'),
                value: Text(fcm.token.toString()),
                onPressed: (context) async {
                  final data = ClipboardData(text: fcm.token.toString());
                  await Clipboard.setData(data);
                  await Fluttertoast.showToast(msg: 'クリップボードにコピーしました');
                },
              ),
              SettingsTile(
                title: const Text('読み込んだEEW電文数'),
                value: Text(eew.eewTelegrams.length.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
