import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';

import 'dart:io';

import 'package:eqmonitor/core/api/http_cache_disabled_provider.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/chuck_provider.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/debug/data/action/debug_mode_action.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_role_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_eew_estimation_debug_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_eew_estimation_debug_provider.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_check/app_check_debug_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hypocenter_icon/hypocenter_icon_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/ui/page/debug_live_activity_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/startup/debug_startup_timing_page.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/start/data/flow/forced_update_dialog_presenter.dart';
import 'package:eqmonitor/feature/start/data/model/required_version_model.dart';
import 'package:eqmonitor/feature/start/data/model/store_url_model.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class const DebugPage({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Page')),
      body: const _DebugWidget(),
    );
  }
}

class const _DebugWidget() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin =
        ref.watch(debugAccessLevelProvider) == DebugAccessLevel.full;

    return Theme(
      data: Theme.of(context).copyWith(visualDensity: .compact),
      child: ListTileTheme(
        dense: true,
        child: ListView(
          children: [
            ListTile(
              title: const Text('デバッグモード'),
              subtitle: const Text('オフにするとデバッグ画面を閉じます'),
              trailing: AppSwitch(
                value: true,
                onChanged: (_) async =>
                    ref.read(debugModeActionProvider).disable(ref, context),
              ),
              onTap: () async =>
                  ref.read(debugModeActionProvider).disable(ref, context),
            ),
            const _ReplaySection(),
            const _EewEarthquakeSection(),
            const _RealtimeMonitorSection(),
            _NotificationDeviceSection(isAdmin: isAdmin),
            _AppearanceSection(isAdmin: isAdmin),
            if (isAdmin) const _NetworkSection(),
            _StorageSection(isAdmin: isAdmin),
            const _BuildSection(),
          ],
        ),
      ),
    );
  }
}

class const _DebugSectionHeader({required final String title})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.xl,
        spacing.lg,
        spacing.xs,
      ),
      child: Semantics(
        header: true,
        child: Text(
          title,
          style: designSystem.typography.titleSmall.copyWith(
            color: designSystem.colorTheme.primary,
          ),
        ),
      ),
    );
  }
}

class const _DebugTile({
  required final String title,
  required final IconData icon,
  required final VoidCallback onTap,
  final String? subtitle,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return ListTile(
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      leading: Icon(icon),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class const _ReplaySection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final colorScheme = designSystem.colorTheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        0,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colorScheme.primaryContainer,
        child: Padding(
          padding: EdgeInsets.all(spacing.lg),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history_rounded,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  SizedBox(width: spacing.sm),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        'リプレイ（.eqrp）',
                        style: designSystem.typography.titleMedium.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing.xs),
              Text(
                '過去の強震モニタと緊急地震速報をホームで再生します。'
                'ファイルはアプリ内に年/月のフォルダで保存され、保存済みの一覧から再生できます。',
                style: designSystem.typography.bodySmall.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(height: spacing.md),
              Wrap(
                spacing: spacing.sm,
                runSpacing: spacing.sm,
                children: [
                  FilledButton.icon(
                    onPressed: () async =>
                        const DebugReplayCreationRoute().push<void>(context),
                    icon: const Icon(Icons.fiber_manual_record_rounded),
                    label: const Text('リプレイファイルを作成'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () async =>
                        const DebugReplayLibraryRoute().push<void>(context),
                    icon: const Icon(Icons.folder_open_rounded),
                    label: const Text('保存済みから再生・ファイルを追加'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _EewEarthquakeSection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEstimatedIntensityAllowed =
        ref.watch(estimatedIntensityOnEewReplayAllowedProvider).value ?? false;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const _DebugSectionHeader(title: 'EEW・地震情報'),
        ListTile(
          title: const Text('EEW 推定震度表示'),
          subtitle: const Text('EEW詳細画面で距離減衰式による推定震度を表示'),
          leading: const Icon(Icons.layers),
          trailing: AppSwitch(
            value: isEstimatedIntensityAllowed,
            onChanged: (value) async => ref
                .read(estimatedIntensityOnEewReplayAllowedProvider.notifier)
                .save(isEnabled: value),
          ),
          onTap: () async => ref
              .read(estimatedIntensityOnEewReplayAllowedProvider.notifier)
              .save(isEnabled: !isEstimatedIntensityAllowed),
        ),
        const _HomeEewEstimationTile(),
        _DebugTile(
          title: 'EEW Card',
          subtitle: 'ホームと同じカードの見た目をパラメータ検証',
          icon: Icons.flash_on,
          onTap: () async => const DebugEewCardRoute().push<void>(context),
        ),
        _DebugTile(
          title: 'EEW 一覧',
          subtitle: '発表中EEWのピン留めと過去EEWの履歴(将来一般公開予定)',
          icon: Icons.list_alt,
          onTap: () async => const EewHistoryRoute().push<void>(context),
        ),
        _DebugTile(
          title: '地震履歴 Card',
          subtitle: '各地の震度表示（速報値・確定値）をパラメータ検証',
          icon: Icons.history_edu_outlined,
          onTap: () async =>
              const DebugEarthquakeHistoryCardRoute().push<void>(context),
        ),
        _DebugTile(
          title: '地震履歴 ListTile',
          subtitle: '各種地震・検索対象地域の震度・海外遠地地震・海外噴火の見た目を確認',
          icon: Icons.list_alt_outlined,
          onTap: () async =>
              const DebugEarthquakeHistoryListTileRoute().push<void>(context),
        ),
        _DebugTile(
          title: '地震履歴 レイヤーパラメータ',
          subtitle: 'マップレイヤーのズーム閾値・透明度・サイズを調整',
          icon: Icons.layers_outlined,
          onTap: () async => EarthquakeHistoryDebugModal.show(context: context),
        ),
      ],
    );
  }
}

class const _RealtimeMonitorSection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShakeDetectionEnabled = ref
        .watch(buildConfigProvider)
        .isShakeDetectionEnabled;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const _DebugSectionHeader(title: '強震モニタ・揺れ検知'),
        _DebugTile(
          title: 'KyoshinMonitor',
          icon: Icons.monitor_heart_outlined,
          onTap: () async =>
              const DebugKyoshinMonitorRoute().push<void>(context),
        ),
        _DebugTile(
          title: '揺れ検知エンジン',
          subtitle: '端末内検知の有効化・履歴の作り直し・検知パラメータの変更',
          icon: Icons.tune_rounded,
          onTap: () async =>
              const DebugShakeDetectionEngineRoute().push<void>(context),
        ),
        _DebugTile(
          title: '揺れ検知の通知設定',
          subtitle: '現在地・全国・細分化地域の通知条件を設定',
          icon: Icons.notifications_active_outlined,
          onTap: () async =>
              const DebugShakeDetectionSettingsRoute().push<void>(context),
        ),
        if (isShakeDetectionEnabled) ...[
          _DebugTile(
            title: '揺れ検知 Card',
            subtitle: 'ホームと同じ揺れ検知カードの見た目をパラメータ検証',
            icon: Icons.sensors_rounded,
            onTap: () async =>
                const DebugShakeDetectionCardRoute().push<void>(context),
          ),
          _DebugTile(
            title: '揺れ検知を挿入',
            subtitle: 'プリセットをホーム地図・カードへマージ表示',
            icon: Icons.add_location_alt_outlined,
            onTap: () async =>
                const DebugShakeDetectionInsertRoute().push<void>(context),
          ),
        ],
      ],
    );
  }
}

class const _NotificationDeviceSection({required final bool isAdmin})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const _DebugSectionHeader(title: '通知・デバイス'),
        if (isAdmin)
          _DebugTile(
            title: 'デバイス・通知',
            subtitle: '登録・トークン同期・設定・テスト通知・履歴',
            icon: Icons.phonelink_setup,
            onTap: () async =>
                const DebugDeviceSettingsRoute().push<void>(context),
          ),
        if (isAdmin)
          _DebugTile(
            title: 'デバイス管理',
            subtitle: '登録・再登録・削除・通知条件の設定',
            icon: Icons.manage_accounts_outlined,
            onTap: () async =>
                const DebugDeviceAdminRoute().push<void>(context),
          ),
        _DebugTile(
          title: '通知配信ログ',
          subtitle: 'GET /v2/device/{id}/notification/history',
          icon: Icons.history,
          onTap: () async =>
              const DebugNotificationDeliveryLogRoute().push<void>(context),
        ),
        if (isAdmin)
          _DebugTile(
            title: '通知Webhook',
            subtitle: 'Webhookの発行・一覧表示',
            icon: Icons.webhook,
            onTap: () async =>
                const DebugNotificationWebhookRoute().push<void>(context),
          ),
        if (Platform.isIOS)
          _DebugTile(
            title: 'Live Activity テスト',
            subtitle: 'アプリ内から EEW の Live Activity を開始・更新・終了',
            icon: Icons.bolt_outlined,
            onTap: () async => Navigator.of(context).push<void>(
              MaterialPageRoute(builder: (_) => const DebugLiveActivityPage()),
            ),
          ),
        const _NotificationTokenTiles(),
        const _BackgroundLocationDebugSection(),
      ],
    );
  }
}

class const _NotificationTokenTiles() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(notificationTokenStreamProvider).value;
    final tokens = [
      (title: 'FCM Token', value: token?.fcmToken),
      (title: 'APNS Token', value: token?.apnsToken),
      (title: 'Push To Start Token', value: token?.apnsPushToStartToken),
    ];
    return Column(
      children: [
        for (final (:title, :value) in tokens)
          ListTile(
            title: Text(title),
            subtitle: Text(
              value ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.googleSansCode),
            ),
            leading: const Icon(Icons.key_outlined),
            trailing: const Icon(Icons.copy_rounded),
            onTap: () async =>
                Clipboard.setData(ClipboardData(text: value ?? '')),
          ),
      ],
    );
  }
}

class const _AppearanceSection({required final bool isAdmin})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const _DebugSectionHeader(title: '表示確認'),
        _DebugTile(
          title: 'JmaMap',
          icon: Icons.map,
          onTap: () async => const DebugJmaMapRoute().push<void>(context),
        ),
        _DebugTile(
          title: '震度アイコン確認',
          subtitle: '全震度・全タイプのアイコンをプレビュー',
          icon: Icons.format_list_numbered,
          onTap: () async =>
              const DebugIntensityIconRoute().push<void>(context),
        ),
        _DebugTile(
          title: '地震履歴詳細アイコン一覧',
          subtitle: '震源・JMA震度・長周期地震動階級アイコンのプレビュー',
          icon: Icons.place,
          onTap: () async => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (_) => const HypocenterIconPage()),
          ),
        ),
        _DebugTile(
          title: 'Playground',
          icon: Icons.science_outlined,
          onTap: () async => const PlaygroundRoute().push<void>(context),
        ),
        if (isAdmin) ...[
          _DebugTile(
            title: 'ナビゲーション',
            subtitle: 'ルート一覧から画面へ直接遷移',
            icon: Icons.navigation,
            onTap: () async => const DebugNavigationRoute().push<void>(context),
          ),
          _DebugTile(
            title: 'オンボーディング',
            subtitle: 'オンボーディングフローをプレビュー',
            icon: Icons.start,
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
        ],
      ],
    );
  }
}

class const _NetworkSection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHttpCacheDisabled =
        ref.watch(httpCacheDisabledProvider).value ?? false;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const _DebugSectionHeader(title: '通信・サーバ'),
        _DebugTile(
          title: 'サーバ選択',
          icon: Icons.dns,
          onTap: () async =>
              const HttpApiEndpointSelectorRoute().push<void>(context),
        ),
        _DebugTile(
          title: '認証',
          subtitle: 'Google・Apple・Passkey・JWT疎通を確認',
          icon: Icons.verified_user_outlined,
          onTap: () async => const DebugAuthRoute().push<void>(context),
        ),
        _DebugTile(
          title: 'WebSocket',
          subtitle: 'WebSocket 接続状況と受信ログ',
          icon: Icons.cable,
          onTap: () async => const DebugWebSocketRoute().push<void>(context),
        ),
        _DebugTile(
          title: 'ログ',
          icon: Icons.article_outlined,
          onTap: () async => const TalkerRoute().push<void>(context),
        ),
        if (chuckBuildModePolicy.showInspector)
          _DebugTile(
            title: 'Chuck',
            subtitle: 'HTTP 通信のインスペクタ',
            icon: Icons.network_check,
            onTap: () async => ref.read(chuckProvider).showInspector(),
          ),
        ListTile(
          title: const Text('HTTPキャッシュを無効化'),
          subtitle: const Text('キャッシュの読み書きをスキップします'),
          leading: const Icon(Icons.cached),
          trailing: AppSwitch(
            value: isHttpCacheDisabled,
            onChanged: (value) async => ref
                .read(httpCacheDisabledProvider.notifier)
                .save(isDisabled: value),
          ),
        ),
        _DebugTile(
          title: 'HTTPキャッシュ',
          subtitle: 'キャッシュエントリの一覧・削除',
          icon: Icons.storage_outlined,
          onTap: () async => const DebugHttpCacheRoute().push<void>(context),
        ),
        const _StartApiDebugSection(),
        const _AppCheckSection(),
      ],
    );
  }
}

class const _StorageSection({required final bool isAdmin})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const _DebugSectionHeader(title: 'データ・ストレージ'),
        _DebugTile(
          title: 'Asset Pack',
          subtitle: 'Pack バージョン・アセットの整合性を確認',
          icon: Icons.inventory_2_outlined,
          onTap: () async => const AssetPackDebugRoute().push<void>(context),
        ),
        if (isAdmin) ...[
          _DebugTile(
            title: 'SharedPreferences',
            subtitle: '保存されている Key-Value の一覧・編集',
            icon: Icons.data_object,
            onTap: () async =>
                const DebugSharedPreferencesRoute().push<void>(context),
          ),
          _DebugTile(
            title: 'SecureStorage',
            subtitle: '保存されている Key-Value の一覧・編集',
            icon: Icons.lock_outline,
            onTap: () async =>
                const DebugSecureStorageRoute().push<void>(context),
          ),
          if (Platform.isIOS)
            _DebugTile(
              title: 'App Groups UserDefaults',
              subtitle: 'Widget が参照する UserDefaults を直接操作',
              icon: Icons.widgets_outlined,
              onTap: () async => const DebugAppGroupRoute().push<void>(context),
            ),
        ],
        const _ParameterDebugSection(),
      ],
    );
  }
}

class const _BuildSection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildCfg = ref.watch(buildConfigProvider);
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const _DebugSectionHeader(title: 'ビルド・計測'),
        ListTile(
          title: const Text('Flavor'),
          leading: const Icon(Icons.flag),
          subtitle: Text(buildCfg.flavor.name),
        ),
        _DebugTile(
          title: 'Startup Timing',
          subtitle: '起動フェーズごとの所要時間',
          icon: Icons.timer_outlined,
          onTap: () async => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (_) => const DebugStartupTimingPage()),
          ),
        ),
        if (!buildCfg.isProduction)
          _DebugTile(
            title: 'Telemetry Events',
            subtitle: 'ローカルテレメトリーイベントの閲覧',
            icon: Icons.analytics_outlined,
            onTap: () async => const DebugTelemetryRoute().push<void>(context),
          ),
      ],
    );
  }
}

class const _AppCheckSection() extends ConsumerWidget {
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
              overflow: .ellipsis,
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Token: $token')));
              }
            } on Exception catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('エラー: $e')));
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

class const _ParameterDebugSection() extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefreshing = useState(false);
    final paramAsync = ref.watch(parameterSetProvider);

    return Column(
      crossAxisAlignment: .start,
      children: [
        ListTile(
          title: const Text('パラメータ'),
          leading: const Icon(Icons.data_object),
          trailing: isRefreshing.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: AccessibleCircularProgressIndicator(strokeWidth: 2),
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
              child: AccessibleCircularProgressIndicator(strokeWidth: 2),
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
              for (final item in value.manifest.assets)
                ListTile(
                  dense: true,
                  title: Text(item.id.name),
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

class const _HomeEewEstimationTile() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugEnabled = ref.watch(debugProvider).value ?? false;
    final roleAsync = ref.watch(deviceRoleProvider);
    final isAvailable =
        ref.watch(isHomeEewEstimationDebugAvailableProvider).value ?? false;
    final isEnabled = ref.watch(homeEewEstimationDebugProvider).value ?? false;

    final subtitle = isAvailable
        ? 'JMAが現在地の予想震度を発表していない場合に、推計震度とS波到達予想時刻をホームのEEWカードへ表示'
        : switch ((isDebugEnabled, roleAsync)) {
            (false, _) => 'デバッグモードが無効のため変更できません',
            (_, AsyncLoading()) => 'デバイスのロールを確認中です',
            (_, AsyncError()) => 'デバイスのロールを取得できませんでした',
            (_, AsyncData(:final value)) =>
              'Admin ロールのデバイスのみ変更できます'
                  '(現在のロール: ${value?.value ?? '未提供'})',
          };

    return ListTile(
      title: const Text('ホームに推計震度・到達予想時刻を表示'),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      leading: const Icon(Icons.speed),
      trailing: AppSwitch(
        value: isEnabled && isAvailable,
        onChanged: isAvailable
            ? (value) async => ref
                  .read(homeEewEstimationDebugProvider.notifier)
                  .save(isEnabled: value)
            : null,
      ),
      onTap: isAvailable
          ? () async => ref
                .read(homeEewEstimationDebugProvider.notifier)
                .save(isEnabled: !isEnabled)
          : null,
    );
  }
}

class const _BackgroundLocationDebugSection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(backgroundLocationDebugSettingsProvider).value;
    if (settings == null) {
      return const SizedBox.shrink();
    }
    final notifier = ref.read(backgroundLocationDebugSettingsProvider.notifier);

    return Column(
      crossAxisAlignment: .start,
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

class const _StartApiDebugSection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startAsync = ref.watch(startProvider);
    final startValue = startAsync.value;

    return Column(
      crossAxisAlignment: .start,
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
        if (startAsync.isRefreshing) const AccessibleLinearProgressIndicator(),
        switch (startAsync) {
          AsyncLoading() when !startAsync.hasValue => const ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: AccessibleCircularProgressIndicator(strokeWidth: 2),
            ),
            title: Text('取得中...'),
          ),
          AsyncError(:final error) when !startAsync.hasValue => ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text('エラー'),
            subtitle: Text(error.toString()),
          ),
          _ when startValue != null => _StartApiDebugContent(
            data: startValue,
            hasError: startAsync.hasError,
            error: startAsync.error,
          ),
          _ => const SizedBox.shrink(),
        },
      ],
    );
  }
}

class const _StartApiDebugContent({
  required final api.StartResponse data,
  required final bool hasError,
  required final Object? error,
}) extends ConsumerWidget {
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
        if (data.flags.maintenance.message case final message?)
          ListTile(
            dense: true,
            title: const Text('maintenance.message'),
            subtitle: Text(message),
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
        ListTile(
          dense: true,
          title: const Text('latest.version'),
          trailing: Text(data.app.version.latest?.version ?? '(なし)'),
        ),
        switch (data.app.version.latest) {
          final latest? => AppSwitchListTile(
            title: 'latest.showWhatsNew',
            subtitle: "What's New バナー表示",
            value: latest.showWhatsNew,
            onChanged: (v) => _override(
              ref,
              data.copyWith(
                app: data.app.copyWith(
                  version: data.app.version.copyWith(
                    latest: latest.copyWith(showWhatsNew: v),
                  ),
                ),
              ),
            ),
          ),
          null => const AppSwitchListTile(
            title: 'latest.showWhatsNew',
            subtitle: "What's New バナー表示",
            value: false,
            onChanged: null,
          ),
        },
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
        ListTile(
          dense: true,
          title: const Text('強制アップデートダイアログ'),
          subtitle: const Text('閉じられるプレビューを表示'),
          leading: const Icon(Icons.system_update_alt),
          onTap: () async {
            final storeUrl = data.app.storeUrl;
            await ref
                .read(forcedUpdateDialogPresenterProvider)
                .showForcedUpdateDialog(
                  context,
                  req: const RequiredVersionModel(
                    version: '99.0.0',
                    message: '【デバッグ】最新バージョンへのアップデートが必要です。',
                  ),
                  storeUrl: StoreUrlModel(
                    ios: storeUrl.ios,
                    android: storeUrl.android,
                  ),
                  dismissible: false,
                );
          },
        ),
      ],
    );
  }

  void _override(WidgetRef ref, api.StartResponse response) {
    ref.read(startProvider.notifier).setDebugOverride(response);
  }
}
