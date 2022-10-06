import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/ui/view/setting/about_app.viewmodel.dart';
import 'package:eqmonitor/ui/view/widget/setting/about_widget.dart';
import 'package:eqmonitor/ui/view/widget/setting/license_widget.dart';
import 'package:eqmonitor/ui/view/widget/setting/setting_section.dart';
import 'package:eqmonitor/ui/view/widget/setting/thanks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutAppPage extends HookConsumerWidget {
  const AboutAppPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider.notifier).isDarkMode;
    final logoTapCount = useState<int>(0);
    final viewModel = AboutAppViewModel(ref);

    return Scaffold(
      appBar: AppBar(title: const Text('本アプリについて')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  logoTapCount.value++;
                  if (logoTapCount.value == 10) {
                    logoTapCount.value = 0;
                    viewModel.startKmoniTest(context);
                  }
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    isDarkMode ? 'assets/header-dark.png' : 'assets/header.png',
                  ),
                ),
              ),
            ),
            const Divider(),
            const SettingsSection(
              title: 'アプリ情報',
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: AboutWidget(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LicenseWidget(),
                ),
              ],
            ),
            const SettingsSection(
              title: 'その他',
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ThanksWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    //  return Scaffold(
    //    appBar: AppBar(
    //      title: const Text('アプリ情報'),
    //    ),
    //    body: SettingsList(
    //      sections: [
    //        SettingsSection(
    //          title: ref.watch(packageInfoProvider).when<Widget>(
    //                loading: () => const Text('Loading...'),
    //                error: (error, stackTrace) => Text('Error: $error'),
    //                data: (data) => Text(
    //                  '${data.appName} ${data.version} (${data.buildNumber})',
    //                  style: const TextStyle(
    //                    fontSize: 20,
    //                    fontWeight: FontWeight.bold,
    //                  ),
    //                ),
    //              ),
    //          tiles: const <SettingsTile>[],
    //        ),
    //        SettingsSection(
    //          title: const Text('基本情報'),
    //          tiles: <SettingsTile>[
    //            SettingsTile(
    //              title: const Text('ライセンス情報'),
    //              onPressed: (context) => showLicensePage(
    //                context: context,
    //                applicationName: 'EQMonitor',
    //                applicationIcon: ClipRRect(
    //                  borderRadius: BorderRadius.circular(16),
    //                  child: Image.asset(
    //                    'assets/icon.png',
    //                    height: 120,
    //                    width: 120,
    //                  ),
    //                ),
    //                applicationLegalese:
    //                    'MIT License\nCopyright (c) 2022 YumNumm',
    //                useRootNavigator: true,
    //              ),
    //            ),
    //            SettingsTile(
    //              title: const Text('利用規約'),
    //              onPressed: (context) =>
    //                  context.push('/settings/appinfo/termOfService/false'),
    //            ),
    //            SettingsTile(
    //              title: isDeveloper
    //                  ? const Text('Developer Mode (Enabled)')
    //                  : const SizedBox.shrink(),
    //              onPressed: (context) async =>
    //                  viewModel.onDeveloperModeTilePressed(context),
    //              leading: isDeveloper
    //                  ? const Icon(Icons.lock_open)
    //                  : const SizedBox.shrink(),
    //            ),
    //          ],
    //        ),
    //      ],
    //    ),
    //  );
  }
}
