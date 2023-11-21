import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/component/sheet/debug_widget.dart';
import 'package:eqmonitor/feature/home/features/debugger/debugger_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/debug_attempt.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onInquiryTap(BuildContext context) async {
      // 問い合わせ方法を選択するダイアログを表示
      final result = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('お問い合わせ方法を選択してください'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('メールで問い合わせ'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Xで問い合わせ'),
              ),
            ],
          );
        },
      );
      if (result == null) {
        return;
      }
      final packageInfo = ref.read(packageInfoProvider);
      final androidDeviceInfo =
          Platform.isAndroid ? ref.read(androidDeviceInfoProvider) : null;
      final iosDeviceInfo =
          Platform.isIOS ? ref.read(iosDeviceInfoProvider) : null;

      final notificationSetting =
          await ref.read(firebaseMessagingProvider).getNotificationSettings();

      final base = '-------- 以下は編集せずに送信してください --------\n'
          'packageInfo: ${jsonEncode(packageInfo.data)}\n'
          'deviceInfo: ${jsonEncode({
            "machine": iosDeviceInfo?.model ?? androidDeviceInfo?.model,
            "systemVersion": iosDeviceInfo?.systemVersion ??
                androidDeviceInfo?.version.release,
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
        log('launchUrl: $uri');
        log((await launchUrl(uri)).toString());
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
    }

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
                  final result = await DebugAttempt.attempt(context);
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
            onTap: () => {},
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
            subtitle: const Text('ご意見・ご要望などもこちらからお願いします。'),
            leading: const Icon(Icons.contact_support),
            onTap: () => onInquiryTap(context),
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
            leading: const Icon(Icons.settings),
            onTap: () => context.push(
              const LicenseRoute().location,
            ),
          ),
          Center(
            child: Text(
              'EQMonitor v${packageInfo.version} (${packageInfo.buildNumber})',
              style: textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
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
