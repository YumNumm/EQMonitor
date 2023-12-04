import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:eqmonitor/core/extension/string_ex.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/component/sheet/debug_widget.dart';
import 'package:eqmonitor/feature/home/features/debugger/debugger_provider.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final isDebugger = ref.watch(debuggerProvider).isDebugger;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final debugAttemptCount = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onScaleEnd: (_) async {
              debugAttemptCount.value++;
              if (debugAttemptCount.value >= 10) {
                debugAttemptCount.value = 0;
                if (isDebugger) {
                  await ref
                      .read(debuggerProvider.notifier)
                      .setDebugger(value: false);
                } else {
                  final result = await _debugAttempt(context);
                  if (result) {
                    await ref
                        .read(debuggerProvider.notifier)
                        .setDebugger(value: true);
                  }
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                child: Assets.header.image(),
              ),
            ),
          ),
          const SettingsSectionHeader(text: '各種設定'),
          ListTile(
            title: const Text('通知設定'),
            leading: const Icon(Icons.notifications),
            onTap: () =>
                context.push(const NotificationSettingsRoute().location),
          ),
          ListTile(
            title: const Text('強震モニタ設定'),
            leading: const Icon(Icons.settings),
            onTap: () => context.push(const KmoniRoute().location),
          ),
          ListTile(
            title: const Text('震度配色設定'),
            leading: const Icon(Icons.color_lens),
            onTap: () => context.push(const ColorSchemeConfigRoute().location),
          ),
          const SettingsSectionHeader(text: 'アプリの情報と問い合わせ'),
          ListTile(
            title: const Text('お問い合わせ'),
            subtitle: const Text('ご意見・ご要望などもこちらからお願いします'),
            leading: const Icon(Icons.contact_support),
            onTap: () => _onInquiryTap(context, ref),
          ),
          ListTile(
            title: const Text('利用規約'),
            leading: const Icon(Icons.description),
            onTap: () => context.push(
              const TermOfServiceRoute($extra: null).location,
            ),
          ),
          ListTile(
            title: const Text('プライバシーポリシー'),
            leading: const Icon(Icons.info),
            onTap: () => context.push(
              const PrivacyPolicyRoute($extra: null).location,
            ),
          ),
          ListTile(
            title: const Text('ライセンス情報'),
            subtitle: Text('MIT License ${DateTime.now().year} Ryotaro Onoue'),
            leading: const Icon(Icons.settings),
            onTap: () => context.push(
              const LicenseRoute().location,
            ),
          ),
          ListTile(
            title: const Text('サーバの稼働状況'),
            subtitle: const Text('外部Webサイトへ遷移します'),
            leading: const Icon(Icons.network_ping),
            onTap: () => launchUrlString(
              'https://status.eqmonitor.app/',
              mode: LaunchMode.externalApplication,
            ),
          ),
          ListTile(
            title: const Text('ロードマップ'),
            subtitle: const Text('アプリの開発ロードマップを確認できます'),
            leading: const Icon(Icons.view_timeline),
            onTap: () => launchUrlString(
              'https://github.com/YumNumm/EQMonitor/issues/412',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'EQMonitor v${packageInfo.version} (${packageInfo.buildNumber})',
                style: textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ),
          ),
          if (isDebugger) ...[
            Center(
              child: Text(
                'Debug Mode',
                style: textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ),
            const Divider(),
            const DebugWidget(),
          ],
        ],
      ),
    );
  }
}

Future<void> _onInquiryTap(BuildContext context, WidgetRef ref) async {
  // 問い合わせ方法を選択するダイアログを表示
  final result = await showModalActionSheet<bool>(
    context: context,
    title: 'お問い合わせ方法を選択してください',
    cancelLabel: 'キャンセル',
    actions: [
      const SheetAction(
        key: true,
        label: 'メールで問い合わせ',
      ),
      const SheetAction(
        key: false,
        label: 'Xで問い合わせ',
      ),
    ],
  );
  if (result == null || !context.mounted) {
    return;
  }
  unawaited(
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator.adaptive()),
    ),
  );
  final packageInfo = ref.read(packageInfoProvider);
  final androidDeviceInfo =
      Platform.isAndroid ? ref.read(androidDeviceInfoProvider) : null;
  final iosDeviceInfo = Platform.isIOS ? ref.read(iosDeviceInfoProvider) : null;

  final notificationSetting =
      await ref.read(firebaseMessagingProvider).getNotificationSettings();

  final base = '-------- 以下は編集せずに送信してください --------\n'
      'packageInfo: ${jsonEncode(packageInfo.data)}\n'
      'deviceInfo: ${jsonEncode({
        "machine": iosDeviceInfo?.model ?? androidDeviceInfo?.model,
        "systemVersion":
            iosDeviceInfo?.systemVersion ?? androidDeviceInfo?.version.release,
      })}\n'
      'alertPermission: ${notificationSetting.alert}\n'
      '--------------------------';

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  if (result) {
    // メール
    final uri = Uri(
      scheme: 'mailto',
      path: 'contacts@eqmonitor.app',
      query: encodeQueryParameters(
        <String, String>{
          'subject': 'EQMonitor 問い合わせ: ',
          'body': '\n[こちらに内容を記載してください]\n\n$base',
        },
      ),
    );
    await launchUrl(uri);
  } else {
    // X
    final uri = Uri(
      scheme: 'https',
      host: 'twitter.com',
      path: 'messages/compose',
      query: encodeQueryParameters(
        <String, String>{
          'recipient_id': '1443896594529619970',
          'text': '\n[こちらに内容を記載してください]\n\n$base',
        },
      ),
    );
    await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
  }
  if (!context.mounted) {
    return;
  }
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}

Future<bool> _debugAttempt(BuildContext context) async {
  final str = await showTextInputDialog(
    context: context,
    barrierDismissible: false,
    title: 'Debug Attempt',
    message: 'Input debug key.',
    textFields: const [
      DialogTextField(),
    ],
  );
  if (str == null) {
    return false;
  }
  if ('SALT${str}SALT'.sha512 ==
      // ignore: lines_longer_than_80_chars
      'debf7168f29c6b58d15ba0168663d36804d16f143ef3d81ff8c205bb8e840ddb5fcf0d0ab33a3f8b13fa44b772f852130986f0dc2d259f04e1587bbd559260b1') {
    return true;
  }
  return false;
}
