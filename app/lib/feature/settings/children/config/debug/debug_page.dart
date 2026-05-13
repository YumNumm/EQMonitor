import 'dart:io';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
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
    final buildCfg = ref.watch(buildConfigProvider);

    return ListTileTheme(
      dense: true,
      child: ListView(
        children: [
          ListTile(
            title: const Text('デバッグモード'),
            subtitle: Text(isDebugEnabled ? 'ON' : 'OFF'),
            trailing: AppSwitch(
              value: isDebugEnabled,
              onChanged: (value) async =>
                  ref.read(debugProvider.notifier).save(isEnabled: value),
            ),
            onTap: () async => ref
                .read(debugProvider.notifier)
                .save(isEnabled: !isDebugEnabled),
          ),
          ListTile(
            title: const Text('Flavor'),
            leading: const Icon(Icons.flag),
            subtitle: Text(buildCfg.flavor.name),
          ),
          ListTile(
            title: const Text('ビルド時刻'),
            leading: const Icon(Icons.schedule),
            subtitle: Text(
              buildCfg.buildTimestamp.isEmpty ? '(not set)' : buildCfg.buildTimestamp,
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
          ),
          ListTile(
            title: const Text('ビルド時コミットメッセージ'),
            leading: const Icon(Icons.commit),
            subtitle: Text(
              buildCfg.buildCommitMessage.isEmpty ? '(not set)' : buildCfg.buildCommitMessage,
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
          ),
          ListTile(
            title: const Text('オンボーディング'),
            subtitle: const Text('オンボーディングフローをプレビュー'),
            leading: const Icon(Icons.start),
            onTap: () async => const OnboardingRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('オンボーディングリセット'),
            subtitle: const Text('完了フラグを消去してオンボーディングを再表示'),
            leading: const Icon(Icons.restart_alt),
            onTap: () async =>
                ref.read(onboardingCompletedProvider.notifier).reset(),
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
              ref.watch(telegramUrlProvider).requireValue.restApiUrl,
            ),
            onTap: () async =>
                const HttpApiEndpointSelectorRoute().push<void>(context),
          ),
          if (Platform.isIOS)
            ListTile(
              title: const Text('App Groups UserDefaults'),
              subtitle: const Text('Widget が参照する UserDefaults を直接操作'),
              leading: const Icon(Icons.widgets_outlined),
              onTap: () => const DebugAppGroupRoute().push<void>(context),
            ),
          ListTile(
            title: const Text('WebSocket'),
            leading: const Icon(Icons.cable),
            subtitle: const Text('WebSocket 接続状況と受信ログ'),
            onTap: () async => const DebugWebSocketRoute().push<void>(context),
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
            title: const Text('地震履歴 Card'),
            subtitle: Text(
              '各地の震度表示（速報値・確定値）をパラメータ検証',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            leading: const Icon(Icons.history_edu_outlined),
            onTap: () async =>
                const DebugEarthquakeHistoryCardRoute().push(context),
          ),
          ListTile(
            title: const Text('揺れ検知 Card'),
            subtitle: Text(
              'ホームと同じ揺れ検知カードの見た目をパラメータ検証',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            leading: const Icon(Icons.sensors_rounded),
            onTap: () async =>
                const DebugShakeDetectionCardRoute().push(context),
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
            title: const Text('ナビゲーション'),
            subtitle: const Text('ルート一覧から画面へ直接遷移'),
            leading: const Icon(Icons.navigation),
            onTap: () async => const DebugNavigationRoute().push<void>(context),
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
            title: const Text('揺れ検知履歴'),
            subtitle: const Text('このセッション中の揺れ検知イベント一覧'),
            leading: const Icon(Icons.sensors_rounded),
            onTap: () async =>
                const ShakeDetectionHistoryRoute().push<void>(context),
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
          const _BackgroundLocationDebugSection(),
          const Divider(),
          ListTile(
            title: const Text('FCM Token'),
            subtitle: Text(
              notificationToken?.fcmToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(text: notificationToken?.fcmToken ?? ''),
            ),
          ),
          ListTile(
            title: const Text('APNS Token'),
            subtitle: Text(
              notificationToken?.apnsToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(text: notificationToken?.apnsToken ?? ''),
            ),
          ),
          ListTile(
            title: const Text('Push To Start Token'),
            subtitle: Text(
              notificationToken?.apnsPushToStartToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(
                text: notificationToken?.apnsPushToStartToken ?? '',
              ),
            ),
          ),
          const _ParameterDebugSection(),
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
            style: const TextStyle(fontFamily: FontFamily.googleSansCode),
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
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
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

class _ParameterDebugSection extends ConsumerStatefulWidget {
  const _ParameterDebugSection();

  @override
  ConsumerState<_ParameterDebugSection> createState() =>
      _ParameterDebugSectionState();
}

class _ParameterDebugSectionState
    extends ConsumerState<_ParameterDebugSection> {
  var _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    final paramAsync = ref.watch(parameterSetProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('パラメータ'),
          leading: const Icon(Icons.data_object),
          trailing: _isRefreshing
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: '強制再取得',
                  onPressed: () async {
                    setState(() => _isRefreshing = true);
                    final messenger = ScaffoldMessenger.of(context);
                    try {
                      final updated = await ref
                          .read(parameterSetProvider.notifier)
                          .refresh();
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            updated ? 'パラメータを更新しました' : 'パラメータは最新です',
                          ),
                        ),
                      );
                    } on Exception catch (e) {
                      messenger.showSnackBar(
                        SnackBar(content: Text('エラー: $e')),
                      );
                    } finally {
                      if (mounted) {
                        setState(() => _isRefreshing = false);
                      }
                    }
                  },
                ),
        ),
        switch (paramAsync) {
          AsyncLoading() => const ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: Text('読み込み中...'),
          ),
          AsyncError(:final error) => ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text('読み込みエラー'),
            subtitle: Text(
              error.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          AsyncData(:final value) => Column(
            children: [
              for (final item in value.manifest.parameters)
                ListTile(
                  dense: true,
                  title: Text(item.type.pathSegment),
                  subtitle: Text(
                    'ver: ${item.sourceVersion}  generated: ${item.generatedAt}\n'
                    'sha256: ${item.sha256.substring(0, 8)}…',
                    style: const TextStyle(fontFamily: FontFamily.googleSansCode),
                  ),
                  isThreeLine: true,
                ),
            ],
          ),
        },
      ],
    );
  }
}

class _BackgroundLocationDebugSection extends ConsumerWidget {
  const _BackgroundLocationDebugSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(backgroundLocationDebugSettingsProvider);
    final notifier = ref.read(backgroundLocationDebugSettingsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('バックグラウンド位置情報デバッグ通知'),
          leading: Icon(Icons.location_on_outlined),
          subtitle: Text('位置情報の変化時にローカル通知を発行します'),
        ),
        AppSwitchListTile(
          title: 'LatLng 変化通知',
          subtitle: '位置更新のたびに通知',
          value: settings.notifyLatLng,
          onChanged: (v) => notifier.setNotifyLatLng(value: v),
        ),
        AppSwitchListTile(
          title: '細分区域コード 変化通知',
          subtitle: 'JMA細分区域が変わった時に通知',
          value: settings.notifyRegion,
          onChanged: (v) => notifier.setNotifyRegion(value: v),
        ),
        AppSwitchListTile(
          title: '都道府県コード 変化通知',
          subtitle: '都道府県（細分コード÷1000）が変わった時に通知',
          value: settings.notifyPrefecture,
          onChanged: (v) => notifier.setNotifyPrefecture(value: v),
        ),
        AppSwitchListTile(
          title: '通知API 更新通知',
          subtitle: '通知APIへ送信した際に送信パラメータと結果を通知',
          value: settings.notifyApiUpdate,
          onChanged: (v) => notifier.setNotifyApiUpdate(value: v),
        ),
      ],
    );
  }
}
