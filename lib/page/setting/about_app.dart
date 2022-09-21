import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:crypto/crypto.dart';
import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/kmoni_controller.dart';
import 'package:eqmonitor/provider/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../provider/setting/developer_mode.dart';
import '../../provider/theme_providers.dart';

class AboutAppPage extends HookConsumerWidget {
  const AboutAppPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider.notifier).isDarkMode;
    final logoTapCount = useState<int>(0);
    final isDeveloper = ref.watch(developerModeProvider).isDeveloper;

    return Scaffold(
      appBar: AppBar(
        title: const Text('アプリ情報'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: ref.watch(packageInfoProvider).when<Widget>(
                  loading: () => const Text('Loading...'),
                  error: (error, stackTrace) => Text('Error: $error'),
                  data: (data) => Text(
                    '${data.appName} ${data.version} (${data.buildNumber})',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            tiles: <SettingsTile>[
              SettingsTile(
                title: InkWell(
                  onTap: () {
                    logoTapCount.value++;
                    if (logoTapCount.value == 10) {
                      logoTapCount.value = 0;
                      //Notification
                      AwesomeNotifications().createNotification(
                        content: NotificationContent(
                          id: 0,
                          channelKey: 'fromdev',
                          title: 'テストモードを開始します',
                          body: '強震モニタを確認してください',
                          fullScreenIntent: true,
                          color: const Color.fromARGB(255, 159, 0, 24),
                        ),
                      );
                      GoRouter.of(context).pop();

                      ref.read(kmoniProvider.notifier).startTestCase();
                      ref.read(eewHistoryProvider.notifier).startTestcase();
                    }
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Image.asset(
                      isDarkMode
                          ? 'assets/header-dark.png'
                          : 'assets/header.png',
                    ),
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
                onPressed: (context) => context.push('/settings/appinfo/termOfService/false'),
              ),
              SettingsTile(
                title: isDeveloper
                    ? const Text('Developer Mode (Enabled)')
                    : const SizedBox.shrink(),
                onPressed: (context) async {
                  if (isDeveloper) {
                    final v = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('Developer Modeを無効にしますか？'),
                          actions: [
                            ElevatedButton(
                              child: const Text('キャンセル'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            ElevatedButton(
                              child: const Text('OK'),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                        );
                      },
                    );
                    if (v ?? false) {
                      await ref
                          .read(developerModeProvider.notifier)
                          .change(isDeveloper: false);
                      await Fluttertoast.showToast(
                        msg: 'Developer Mode Disabled',
                      );
                    }
                  } else {
                    final key = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        // パスワード入力ダイアログ
                        return AlertDialog(
                          content: TextField(
                            autofocus: true,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Developer Key',
                            ),
                            onSubmitted: (password) {
                              Navigator.of(context).pop(password);
                            },
                          ),
                        );
                      },
                    );
                    if (key == null) {
                      await Fluttertoast.showToast(msg: '認証失敗(値が入力されていません)');
                      return;
                    }
                    final result = sha512.convert(utf8.encode(key)).toString();
                    const rightAnswer =
                        '3024d7c8491f94448dc4f38100c514391824ced1fe687346c84396151d411b7b77c538817b4e4916a87dececbdd3561bc8e0afe03363bd5b1e05df7ce6c5b6e7';
                    if (result == rightAnswer) {
                      await Fluttertoast.showToast(msg: '認証成功');
                      await ref
                          .read(developerModeProvider.notifier)
                          .change(isDeveloper: true);
                    } else {
                      await Fluttertoast.showToast(msg: '認証失敗: Keyが違います');
                    }
                  }
                },
                leading: isDeveloper
                    ? const Icon(Icons.lock_open)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
