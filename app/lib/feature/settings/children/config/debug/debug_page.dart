import 'dart:io';

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_check/app_check_debug_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hypocenter_icon/hypocenter_icon_page.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification/data/provider/notification_token_stream.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final isDebugEnabled = ref.watch(debugProvider).value ?? false;
    final notificationToken = ref.watch(notificationTokenStreamProvider).value;
    final flavorName = ref.watch(environmentProvider).flavor.name;

    return ListTileTheme(
      dense: true,
      child: ListView(
        children: [
          SwitchListTile(
            title: const Text('デバッグモード'),
            subtitle: Text(isDebugEnabled ? 'ON' : 'OFF'),
            value: isDebugEnabled,
            onChanged: (value) async =>
                ref.read(debugProvider.notifier).save(isEnabled: value),
          ),
          ListTile(
            title: const Text('Flavor'),
            leading: const Icon(Icons.flag),
            subtitle: Text(flavorName),
          ),
          ListTile(
            title: const Text('ログ'),
            leading: const Icon(Icons.list),
            onTap: () async => const TalkerRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('REST APIエンドポイント'),
            leading: const Icon(Icons.http),
            subtitle: Text(
              '${ref.watch(telegramUrlProvider).requireValue.restApiUrl}\n'
              '（/v2/realtime/stream の SSE は同じベース URL）',
            ),
            onTap: () async =>
                const HttpApiEndpointSelectorRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('SSE'),
            leading: const Icon(Icons.stream),
            subtitle: const Text('/v2/realtime/stream の受信ログ'),
            onTap: () async => const DebugSseRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('KyoshinMonitor'),
            leading: const Icon(Icons.list),
            onTap: () async => const DebugKyoshinMonitorRoute().push(context),
          ),
          ListTile(
            title: const Text('EEW Card'),
            subtitle: Text(
              'ホームと同じカードの見た目をパラメータ検証',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            leading: const Icon(Icons.flash_on),
            onTap: () async => const DebugEewCardRoute().push(context),
          ),
          ListTile(
            title: const Text('JmaMap'),
            leading: const Icon(Icons.map),
            onTap: () async => const DebugJmaMapRoute().push(context),
          ),
          ListTile(
            title: const Text('NIED'),
            leading: const Icon(Icons.science),
            onTap: () async => const NiedRoute().push(context),
          ),
          ListTile(
            title: const Text('Playground'),
            leading: const Icon(Icons.list),
            onTap: () async => const PlaygroundRoute().push(context),
          ),
          ListTile(
            title: const Text('地震リプレイ'),
            leading: const Icon(Icons.play_circle),
            onTap: () async => const EarthquakeReplayRoute().push(context),
          ),
          ListTile(
            title: const Text('震源アイコン生成'),
            leading: const Icon(Icons.place),
            onTap: () async => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const HypocenterIconPage(),
              ),
            ),
          ),
          ListTile(
            title: const Text('デバイス・通知'),
            subtitle: const Text('登録・トークン同期・設定・テスト通知・履歴'),
            leading: const Icon(Icons.phonelink_setup),
            onTap: () async => const DebugDeviceSettingsRoute().push<void>(
              context,
            ),
          ),
          ListTile(
            title: const Text('通知配信ログ'),
            subtitle: const Text('GET /v2/device/{id}/notification/history'),
            leading: const Icon(Icons.history),
            onTap: () async =>
                const DebugNotificationDeliveryLogRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('デバイス管理'),
            subtitle: const Text('登録・再登録・削除・通知条件の設定'),
            leading: const Icon(Icons.manage_accounts_outlined),
            onTap: () async => const DebugDeviceAdminRoute().push<void>(
              context,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('FCM Token'),
            subtitle: Text(
              notificationToken?.fcmToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(text: notificationToken?.fcmToken ?? ''),
            ),
          ),
          ListTile(
            title: const Text('APNS Token'),
            subtitle: Text(
              notificationToken?.apnsToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(text: notificationToken?.apnsToken ?? ''),
            ),
          ),
          ListTile(
            title: const Text('Push To Start Token'),
            subtitle: Text(
              notificationToken?.apnsPushToStartToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(
                text: notificationToken?.apnsPushToStartToken ?? '',
              ),
            ),
          ),
          ListTile(
            title: const Text('観測点パラメータ'),
            subtitle: Text(
              'Earthquake: ${ref.watch(jmaParameterProvider).value?.earthquake.header.version ?? 'null'}\n'
              'Tsunami   : ${ref.watch(jmaParameterProvider).value?.tsunami.header.version ?? 'null'}',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
          ),
          const Divider(),
          const _AppCheckSection(),
        ],
      ),
    );
  }
}

class _AppCheckSection extends ConsumerWidget {
  const _AppCheckSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenAsync = ref.watch(appCheckTokenProvider);
    final providerType = _resolveProviderType();

    return Column(
      children: [
        const ListTile(
          title: Text('Firebase App Check'),
          leading: Icon(Icons.verified_user),
        ),
        ListTile(
          title: const Text('Provider'),
          subtitle: Text(
            providerType,
            style: const TextStyle(fontFamily: FontFamily.notoSansMono),
          ),
        ),
        ListTile(
          title: const Text('Token'),
          subtitle: switch (tokenAsync) {
            AsyncLoading() => const Text('取得中...'),
            AsyncError(:final error) => Text(
              'エラー: $error',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            AsyncData(:final value) => Text(
              value ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          },
          onTap: () async {
            final token = tokenAsync.value;
            if (token != null) {
              await Clipboard.setData(ClipboardData(text: token));
            }
          },
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(appCheckTokenProvider),
          ),
        ),
        ListTile(
          title: const Text('Limited Use Token 取得'),
          subtitle: const Text('Replay Protection用の使い捨てトークンを取得'),
          leading: const Icon(Icons.vpn_key),
          onTap: () async {
            try {
              final token = await FirebaseAppCheck.instance
                  .getLimitedUseToken();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Token: $token')),
                );
              }
            } on Exception catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('エラー: $e')),
                );
              }
            }
          },
        ),
      ],
    );
  }

  String _resolveProviderType() {
    if (Platform.isAndroid) {
      return kDebugMode
          ? 'AndroidDebugProvider'
          : 'AndroidPlayIntegrityProvider';
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return kDebugMode ? 'AppleDebugProvider' : 'AppleAppAttestProvider';
    }
    return 'Unknown';
  }
}
