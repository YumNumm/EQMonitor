import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:eqmonitor/core/api/api_authentication_service.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/extension/string_ex.dart';
import 'package:eqmonitor/core/provider/debugger/debugger_provider.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/feedback/data/custom_feedback.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    child: Assets.images.icon.image(
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'EQMonitor v${packageInfo.version} '
                '(${packageInfo.buildNumber})',
                style: textTheme.bodyMedium,
              ),
            ),
          ),
          BorderedContainer(
            accentColor: Theme.of(context).colorScheme.secondaryContainer,
            padding: EdgeInsets.zero,
            child: ListTile(
              title: const Text('EQMonitorを応援する'),
              subtitle: const Text(
                '開発者に寄付することで、アプリの開発を支援できます',
              ),
              leading: const Icon(Icons.lightbulb),
              onTap: () => const DonationRoute().push<void>(context),
            ),
          ),
          const SettingsSectionHeader(text: '各種設定'),
          ListTile(
            title: const Text('通知条件設定'),
            leading: const Icon(Icons.notifications),
            onTap: () => const NotificationRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('表示設定'),
            leading: const Icon(Icons.color_lens),
            onTap: () => const DisplayRoute().push<void>(context),
          ),
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
          const SettingsSectionHeader(text: 'アプリの情報と問い合わせ'),
          ListTile(
            title: const Text('フィードバック'),
            subtitle: const Text('ご意見・ご要望などもこちらからお願いします'),
            leading: const Icon(Icons.feedback),
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
            child: Text(
              'Powered by Flutter',
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
  BetterFeedback.of(context).show(
    (feedback) async {
      final packageInfo = ref.read(packageInfoProvider);
      final payload = await ref
          .read(apiAuthenticationServiceProvider.notifier)
          .extractPayload();

      final base = '--------------------------\n'
          'EQMonitor v${packageInfo.version}+${packageInfo.buildNumber}\n'
          'Payload: $payload\n'
          '--------------------------';
      // draft an email and send to developer
      final screenshotFilePath = await writeImageToStorage(feedback.screenshot);
      final extra = CustomFeedback.fromJson(feedback.extra!);

      final email = Email(
        body: '${feedback.text}\n\n$base\n\n${jsonEncode(extra.toJson())}',
        subject: 'EQMonitor Feedback',
        recipients: ['feedback@eqmonitor.app'],
        attachmentPaths: [
          if (extra.isScreenshotAttached ?? true) screenshotFilePath,
        ],
      );
      await FlutterEmailSender.send(email);
    },
  );
}

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final output = await getTemporaryDirectory();
  final screenshotFilePath = '${output.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
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
