import 'dart:io';

import 'package:eqmonitor/core/api/http_cache_disabled_provider.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/chuck_provider.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_check/app_check_debug_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hypocenter_icon/hypocenter_icon_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/startup/debug_startup_timing_page.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    return Theme(
      data: Theme.of(context).copyWith(visualDensity: .compact),
      child: ListTileTheme(
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
            if (chuckBuildModePolicy.showInspector)
              ListTile(
                title: const Text('Chuck'),
                leading: const Icon(Icons.list),
                onTap: () async => ref.read(chuckProvider).showInspector(),
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
                buildCfg.buildTimestamp.isEmpty
                    ? '(not set)'
                    : buildCfg.buildTimestamp,
                style: const TextStyle(fontFamily: FontFamily.googleSansCode),
              ),
            ),
            ListTile(
              title: const Text('ビルド時コミットメッセージ'),
              leading: const Icon(Icons.commit),
              subtitle: Text(
                buildCfg.buildCommitMessage.isEmpty
                    ? '(not set)'
                    : buildCfg.buildCommitMessage,
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
              onTap: () async => OnboardingCompleted.resetMutation.run(
                ref,
                (tsx) async =>
                    tsx.get(onboardingCompletedProvider.notifier).reset(),
              ),
            ),
            ListTile(
              title: const Text('ログ'),
              leading: const Icon(Icons.list),
              onTap: () async => const TalkerRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('サーバ選択'),
              leading: const Icon(Icons.dns),
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
              title: const Text('SharedPreferences'),
              subtitle: const Text('保存されている Key-Value の一覧・編集'),
              leading: const Icon(Icons.data_object),
              onTap: () async =>
                  const DebugSharedPreferencesRoute().push<void>(context),
            ),
            Builder(
              builder: (context) {
                final isDisabled =
                    ref.watch(httpCacheDisabledProvider).value ?? false;
                return ListTile(
                  title: const Text('HTTPキャッシュを無効化'),
                  subtitle: const Text('キャッシュの読み書きをスキップします'),
                  leading: const Icon(Icons.cached),
                  trailing: AppSwitch(
                    value: isDisabled,
                    onChanged: (value) async => ref
                        .read(httpCacheDisabledProvider.notifier)
                        .save(isDisabled: value),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Telemetry Events'),
              leading: const Icon(Icons.analytics_outlined),
              subtitle: const Text('ローカルテレメトリーイベントの閲覧'),
              onTap: () async =>
                  const DebugTelemetryRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('Startup Timing'),
              leading: const Icon(Icons.timer_outlined),
              subtitle: const Text('起動フェーズごとの所要時間'),
              onTap: () => Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (_) => const DebugStartupTimingPage(),
                ),
              ),
            ),
            ListTile(
              title: const Text('WebSocket'),
              leading: const Icon(Icons.cable),
              subtitle: const Text('WebSocket 接続状況と受信ログ'),
              onTap: () async =>
                  const DebugWebSocketRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('KyoshinMonitor'),
              leading: const Icon(Icons.list),
              onTap: () async => const DebugKyoshinMonitorRoute().push(context),
            ),
            Builder(
              builder: (context) {
                final isAllowed =
                    ref.watch(estimatedIntensityOnEewReplayAllowedProvider).value ??
                    false;
                return ListTile(
                  title: const Text('EEW 推定震度表示'),
                  subtitle: Text(
                    'EEW詳細画面で距離減衰式による推定震度を表示',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  leading: const Icon(Icons.layers),
                  trailing: AppSwitch(
                    value: isAllowed,
                    onChanged: (value) async => ref
                        .read(
                          estimatedIntensityOnEewReplayAllowedProvider.notifier,
                        )
                        .save(isEnabled: value),
                  ),
                  onTap: () async => ref
                      .read(
                        estimatedIntensityOnEewReplayAllowedProvider.notifier,
                      )
                      .save(isEnabled: !isAllowed),
                );
              },
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
              title: const Text('EEW 一覧'),
              subtitle: Text(
                '発表中EEWのピン留めと過去EEWの履歴(将来一般公開予定)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              leading: const Icon(Icons.list_alt),
              onTap: () async => const EewHistoryRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('Tsunami Details'),
              subtitle: const Text('津波情報詳細画面のデバッグ'),
              leading: const Icon(Icons.tsunami),
              onTap: () async =>
                  const DebugTsunamiDetailsRoute().push<void>(context),
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
              title: const Text('地震履歴 レイヤーパラメータ'),
              subtitle: Text(
                'マップレイヤーのズーム閾値・透明度・サイズを調整',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              leading: const Icon(Icons.layers_outlined),
              onTap: () async =>
                  EarthquakeHistoryDebugModal.show(context: context),
            ),
            ListTile(
              title: const Text('地震履歴 ListTile'),
              subtitle: Text(
                '各種地震・検索対象地域の震度・海外遠地地震・海外噴火の見た目を確認',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              leading: const Icon(Icons.list_alt_outlined),
              onTap: () async =>
                  const DebugEarthquakeHistoryListTileRoute().push(context),
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
              onTap: () async =>
                  const DebugNavigationRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('Playground'),
              leading: const Icon(Icons.list),
              onTap: () async => const PlaygroundRoute().push(context),
            ),
            ListTile(
              title: const Text('揺れ検知履歴'),
              subtitle: const Text('このセッション中の揺れ検知イベント一覧'),
              leading: const Icon(Icons.sensors_rounded),
              onTap: () async =>
                  const ShakeDetectionHistoryRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('震度アイコン確認'),
              subtitle: Text(
                '全震度・全タイプのアイコンをプレビュー',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              leading: const Icon(Icons.format_list_numbered),
              onTap: () async =>
                  const DebugIntensityIconRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('地震履歴詳細アイコン一覧'),
              subtitle: const Text('震源・JMA震度・長周期地震動階級アイコンのプレビュー'),
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
              onTap: () async =>
                  const DebugDeviceSettingsRoute().push<void>(context),
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
              onTap: () async =>
                  const DebugDeviceAdminRoute().push<void>(context),
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
            const _StartApiDebugSection(),
            const Divider(),
            const _AppCheckSection(),
          ],
        ),
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
              style: TextStyle(color: context.designSystem.colorTheme.error),
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
            onPressed: () =>
                ref.invalidate(appCheckTokenProvider, asReload: true),
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
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Token: $token')));
              }
            } on Exception catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('エラー: $e')));
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

class _ParameterDebugSection extends HookConsumerWidget {
  const _ParameterDebugSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefreshing = useState(false);
    final paramAsync = ref.watch(parameterSetProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('パラメータ'),
          leading: const Icon(Icons.data_object),
          trailing: isRefreshing.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: '強制再取得',
                  onPressed: () async {
                    isRefreshing.value = true;
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
                      isRefreshing.value = false;
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
              style: TextStyle(color: context.designSystem.colorTheme.error),
            ),
          ),
          AsyncData(:final value) => Column(
            children: [
              for (final item in value.manifest.parameters)
                ListTile(
                  dense: true,
                  title: Text(item.type.pathSegment),
                  subtitle: Text(
                    'ver: ${item.sourceVersion}  updated: ${item.sourceUpdatedAt}\n'
                    'sha256: ${item.sha256.substring(0, 8)}…',
                    style: const TextStyle(
                      fontFamily: FontFamily.googleSansCode,
                    ),
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
    final settings = ref.watch(backgroundLocationDebugSettingsProvider).value;
    if (settings == null) {
      return const SizedBox.shrink();
    }
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

class _StartApiDebugSection extends ConsumerWidget {
  const _StartApiDebugSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startAsync = ref.watch(startProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Start API'),
          leading: const Icon(Icons.rocket_launch_outlined),
          subtitle: const Text('アプリ起動フラグ・バージョン情報'),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '強制再取得',
            onPressed: () => ref.invalidate(startProvider),
          ),
        ),
        if (startAsync.isRefreshing) const LinearProgressIndicator(),
        switch (startAsync) {
          AsyncLoading() when !startAsync.hasValue => const ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: Text('取得中...'),
          ),
          AsyncError(:final error) when !startAsync.hasValue => ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text('エラー'),
            subtitle: Text(error.toString()),
          ),
          _ when startAsync.hasValue => _StartApiDebugContent(
            data: startAsync.value!,
            hasError: startAsync.hasError,
            error: startAsync.error,
          ),
          _ => const SizedBox.shrink(),
        },
      ],
    );
  }
}

class _StartApiDebugContent extends ConsumerWidget {
  const _StartApiDebugContent({
    required this.data,
    required this.hasError,
    required this.error,
  });

  final api.StartResponse data;
  final bool hasError;
  final Object? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (hasError)
          ListTile(
            dense: true,
            leading: const Icon(Icons.warning_amber),
            title: const Text('再検証エラー（stale 表示中）'),
            subtitle: Text(error.toString()),
          ),
        AppSwitchListTile(
          title: 'maintenance.enabled',
          subtitle: 'メンテナンスモード',
          value: data.flags.maintenance.enabled,
          onChanged: (v) => _override(
            ref,
            data.copyWith(
              flags: data.flags.copyWith(
                maintenance: data.flags.maintenance.copyWith(enabled: v),
              ),
            ),
          ),
        ),
        if (data.flags.maintenance.message != null)
          ListTile(
            dense: true,
            title: const Text('maintenance.message'),
            subtitle: Text(data.flags.maintenance.message!),
          ),
        AppSwitchListTile(
          title: 'planConstraints.isPro',
          subtitle: 'EQMonitor Pro サブスクリプション',
          value: data.planConstraints.free.isPro,
          onChanged: (v) => _override(
            ref,
            data.copyWith(
              planConstraints: data.planConstraints.copyWith(
                free: data.planConstraints.free.copyWith(isPro: v),
              ),
            ),
          ),
        ),
        AppSwitchListTile(
          title: 'flags.ads_enabled',
          subtitle: '広告有効フラグ',
          value: data.flags.adsEnabled,
          onChanged: (v) => _override(
            ref,
            data.copyWith(flags: data.flags.copyWith(adsEnabled: v)),
          ),
        ),
        ListTile(
          dense: true,
          title: const Text('latest.version'),
          trailing: Text(data.app.version.latest?.version ?? '(なし)'),
        ),
        AppSwitchListTile(
          title: 'latest.showWhatsNew',
          subtitle: "What's New バナー表示",
          value: data.app.version.latest?.showWhatsNew ?? false,
          onChanged: data.app.version.latest != null
              ? (v) => _override(
                  ref,
                  data.copyWith(
                    app: data.app.copyWith(
                      version: data.app.version.copyWith(
                        latest: data.app.version.latest!.copyWith(
                          showWhatsNew: v,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
        ListTile(
          dense: true,
          title: const Text('requiredVersions'),
          subtitle: Text(
            data.app.version.requiredVersions
                    .map((r) => r.version)
                    .join(', ')
                    .isNotEmpty
                ? data.app.version.requiredVersions
                      .map((r) => r.version)
                      .join(', ')
                : '(なし)',
          ),
        ),
      ],
    );
  }

  void _override(WidgetRef ref, api.StartResponse response) {
    ref.read(startProvider.notifier).setDebugOverride(response);
  }
}
