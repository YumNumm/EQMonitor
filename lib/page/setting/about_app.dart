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

    return Scaffold(
      appBar: AppBar(
        title: const Text('アプリ情報'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('基本情報'),
            tiles: <SettingsTile>[
              SettingsTile(
                title: const Text('ライセンス情報'),
                onPressed: (context) => showLicensePage(
                  context: context,
                  applicationName: 'EQMonitor',
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
                      ? '${travelTime.loadDuration!.inMicroseconds / 1000}ms (${travelTime.travelTimeTable.length}件)'
                      : '読み込み失敗',
                ),
              ),
              SettingsTile(
                title: const Text('マップ読み込み'),
                value: Text(
                  (kmoniMap.loadDuration != null)
                      ? '${kmoniMap.loadDuration!.inMicroseconds / 1000}ms (${kmoniMap.mapPolygons.length}件)'
                      : '読み込み失敗',
                ),
              ),
              SettingsTile(
                title: const Text('観測点読み込み'),
                value: Text(
                  (kmoni.loadDuration != null)
                      ? '${kmoni.loadDuration!.inMicroseconds / 1000}ms (${kmoni.analyzedPoint.length}件)'
                      : '読み込み失敗',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
