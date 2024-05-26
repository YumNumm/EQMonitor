import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/extension/string_ex.dart';
import 'package:eqmonitor/core/provider/debugger/debugger_provider.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
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
            onTapDown: (_) async {
              debugAttemptCount.value++;
              if (debugAttemptCount.value >= 10) {
                debugAttemptCount.value = 0;
                if (isDebugger) {
                  await ref
                      .read(debuggerProvider.notifier)
                      .setDebugger(value: false);
                } else {
                  final result = await _debugAttempt(context);
                  if (result == _DebugAttemptResult.debugger) {
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
          BorderedContainer(
            padding: EdgeInsets.zero,
            elevation: 1,
            child: ListTile(
              title: const Text('EQMonitorを応援する'),
              subtitle: const Text(
                '開発者に寄付することで、アプリの開発を支援できます',
              ),
              leading: const Icon(Icons.upcoming),
              onTap: () => const DonationRoute().push<void>(context),
            ),
          ),
          const SettingsSectionHeader(text: '各種設定'),
          ListTile(
            title: const Text('強震モニタ設定'),
            leading: const Icon(Icons.settings),
            onTap: () => context.push(const KmoniRoute().location),
          ),
          ListTile(
            title: const Text('地震履歴設定'),
            leading: const Icon(Icons.history),
            onTap: () => context.push(
              const EarthquakeHistoryConfigRoute().location,
            ),
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
            title: const Text('このアプリケーションについて'),
            subtitle: const Text('利用規約やプライバシーポリシーを確認できます'),
            leading: const Icon(Icons.description),
            onTap: () => const AboutThisAppRoute().push<void>(context),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'EQMonitor v${packageInfo.version} '
                '(${packageInfo.buildNumber})',
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
            ListTile(
              title: const Text('デバッグメニュー'),
              leading: const Icon(Icons.bug_report),
              onTap: () => context.push(const DebuggerRoute().location),
            ),
          ],
        ],
      ),
    );
  }
}

Future<void> _onInquiryTap(BuildContext context, WidgetRef ref) async {
  unawaited(
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator.adaptive()),
    ),
  );
  final packageInfo = ref.read(packageInfoProvider);
  final androidDeviceInfo = !kIsWeb && Platform.isAndroid
      ? ref.read(androidDeviceInfoProvider)
      : null;
  final iosDeviceInfo =
      !kIsWeb && Platform.isIOS ? ref.read(iosDeviceInfoProvider) : null;

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
  if (!context.mounted) {
    return;
  }
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}

Future<_DebugAttemptResult> _debugAttempt(BuildContext context) async {
  final str = await showTextInputDialog(
    context: context,
    barrierDismissible: false,
    title: 'Debug Attempt',
    message: 'Input debug key.',
    textFields: const [
      DialogTextField(),
    ],
  );
  final hash = 'SALT${str}SALT'.sha512;
  log('hash: $hash');

  return switch (hash) {
    'debf7168f29c6b58d15ba0168663d36804d16f143ef3d81ff8c205bb8e840ddb5fcf0d0ab33a3f8b13fa44b772f852130986f0dc2d259f04e1587bbd559260b1' =>
      _DebugAttemptResult.debugger,
    '' => _DebugAttemptResult.keviNotifier,
    _ => _DebugAttemptResult.none,
  };
}

enum _DebugAttemptResult {
  debugger,
  keviNotifier,
  none,
  ;
}
