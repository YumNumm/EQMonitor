import 'package:eqmonitor/page/setting/term_of_service.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class AboutAppPage extends HookConsumerWidget {
  const AboutAppPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider.notifier).isDarkMode;

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
        ],
      ),
    );
  }
}
