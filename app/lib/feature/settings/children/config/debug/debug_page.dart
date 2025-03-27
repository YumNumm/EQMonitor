import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/env.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hypocenter_icon/hypocenter_icon_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/kyoshin_monitor/debug_kyoshin_monitor.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/playground/playground_page.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Page')),
      body: const _DebugWidget(),
    );
  }
}

class _DebugWidget extends ConsumerWidget {
  const _DebugWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugEnabled = ref.watch(debugProvider);

    final notificationToken = ref.watch(notificationTokenProvider).valueOrNull;

    return ListTileTheme(
      dense: true,
      child: ListView(
        children: [
          SwitchListTile(
            title: const Text('デバッグモード'),
            subtitle: Text(isDebugEnabled ? 'ON' : 'OFF'),
            value: isDebugEnabled,
            onChanged:
                (value) async =>
                    ref.read(debugProvider.notifier).save(isEnabled: value),
          ),
          ListTile(
            title: const Text('Flavor'),
            leading: const Icon(Icons.flag),
            subtitle: Text(Env.flavor.name),
          ),
          ListTile(
            title: const Text('ログ'),
            leading: const Icon(Icons.list),
            onTap: () async => context.push(const TalkerRoute().location),
          ),
          ListTile(
            title: const Text('REST APIエンドポイント'),
            leading: const Icon(Icons.http),
            subtitle: Text(ref.watch(telegramUrlProvider).restApiUrl),
            onTap:
                () async =>
                    const HttpApiEndpointSelectorRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('WebSocketエンドポイント'),
            leading: const Icon(Icons.http),
            subtitle: Text(ref.watch(telegramUrlProvider).wsApiUrl),
            onTap:
                () async =>
                    const WebsocketEndpointSelectorRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('KyoshinMonitor'),
            leading: const Icon(Icons.list),
            onTap: () async => const DebugKyoshinMonitorRoute().push(context),
          ),
          ListTile(
            title: const Text('Playground'),
            leading: const Icon(Icons.list),
            onTap: () async => const PlaygroundRoute().push(context),
          ),
          ListTile(
            title: const Text('震源アイコン生成'),
            leading: const Icon(Icons.place),
            onTap:
                () async => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const HypocenterIconPage(),
                  ),
                ),
          ),
          ListTile(
            title: const Text('FCM Token'),
            subtitle: Text(
              notificationToken?.fcmToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.jetBrainsMono),
            ),
            onTap:
                () async => Clipboard.setData(
                  ClipboardData(text: notificationToken?.fcmToken ?? ''),
                ),
          ),
          ListTile(
            title: const Text('APNS Token'),
            subtitle: Text(
              notificationToken?.apnsToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.jetBrainsMono),
            ),
            onTap:
                () async => Clipboard.setData(
                  ClipboardData(text: notificationToken?.apnsToken ?? ''),
                ),
          ),
          ListTile(
            title: const Text('観測点パラメータ'),
            subtitle: Text(
              'Earthquake: ${ref.watch(jmaParameterProvider).valueOrNull?.earthquakeStatus.toString() ?? 'null'}\n'
              'Tsunami   : ${ref.watch(jmaParameterProvider).valueOrNull?.tsunamiStatus.toString() ?? 'null'}',
              style: const TextStyle(fontFamily: FontFamily.jetBrainsMono),
            ),
          ),
        ],
      ),
    );
  }
}
