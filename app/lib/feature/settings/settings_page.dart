import 'package:eqmonitor/core/api/http_cache_size_provider.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/feature/ads/data/notifier/ads_opt_out_notifier.dart';
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/asset_pack/data/notifier/asset_pack_manifest_provider.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_action.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugEnabled = ref.watch(debugProvider).value;
    final buildConfig = ref.watch(buildConfigProvider);
    final isDeveloperUiEnabled = buildConfig.isDeveloperUiEnabled;
    final isProFeaturesEnabled = buildConfig.isProFeaturesEnabled;
    final cacheSize = ref.watch(httpCacheSizeProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAlias,
                        elevation: 4,
                        child: Assets.images.icon.image(fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                const _AppVersionInformation(),
                if (isProFeaturesEnabled) ...[
                  const SettingsSectionHeader(text: 'EQMonitor Pro'),
                  ListTile(
                    title: const Text('EQMonitor Pro'),
                    leading: const Icon(Icons.workspace_premium_outlined),
                    onTap: () async =>
                        const SubscriptionSettingsRoute().push<void>(context),
                  ),
                ],
                const SettingsSectionHeader(text: '各種設定'),
                ListTile(
                  title: const Text('通知設定'),
                  leading: const Icon(Icons.notifications_outlined),
                  onTap: () async =>
                      const NotificationSettingsRoute().push<void>(context),
                ),
                ListTile(
                  title: const Text('表示設定'),
                  leading: const Icon(Icons.color_lens),
                  onTap: () async => const DisplayRoute().push<void>(context),
                ),
                ListTile(
                  title: const Text('地震履歴設定'),
                  leading: const Icon(Icons.history),
                  onTap: () async =>
                      const EarthquakeHistoryConfigRoute().push(context),
                ),
                ListTile(
                  title: const Text('地震活動'),
                  subtitle: const Text('震央分布・M-T図・深さ断面'),
                  leading: const Icon(Icons.bubble_chart_outlined),
                  onTap: () async =>
                      const SeismicityRoute().push<void>(context),
                ),
                ListTile(
                  title: const Text('ホーム画面ウィジェット'),
                  leading: const Icon(Icons.widgets_outlined),
                  onTap: () async =>
                      const HomeWidgetSettingsRoute().push<void>(context),
                ),
                const SettingsSectionHeader(text: 'アプリの情報と問い合わせ'),
                ListTile(
                  title: const Text('変更履歴'),
                  leading: const Icon(Icons.history_edu_outlined),
                  onTap: () async => const ChangelogRoute().push<void>(context),
                ),
                ListTile(
                  title: const Text('このアプリケーションについて'),
                  subtitle: const Text('利用規約やプライバシーポリシーを確認できます'),
                  leading: const Icon(Icons.description),
                  onTap: () async =>
                      const AboutThisAppRoute().push<void>(context),
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
                  title: const Text('問い合わせ'),
                  leading: const Icon(Icons.contact_support_outlined),
                  onTap: () async =>
                      ref.read(openContactProvider).call(ref, context),
                ),
                AppSwitchListTile(
                  title: '広告を非表示',
                  value: ref.watch(adsOptOutProvider).value ?? false,
                  onChanged: (_) => AdsOptOutNotifier.saveMutation.run(
                    ref,
                    (tsx) async => tsx.get(adsOptOutProvider.notifier).toggle(),
                  ),
                ),
                if (isDeveloperUiEnabled) ...[
                  const SettingsSectionHeader(text: 'キャッシュ'),
                  ListTile(
                    title: const Text('HTTPキャッシュ'),
                    leading: const Icon(Icons.storage_outlined),
                    subtitle: Text(
                      cacheSize.when(
                        data: const ByteSizeFormatter().format,
                        loading: () => '計算中…',
                        error: (_, _) => '取得に失敗しました',
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('HTTPキャッシュを削除'),
                    leading: const Icon(Icons.delete_outline),
                    onTap: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final store = await ref.read(
                        httpCacheStoreProvider.future,
                      );
                      await store.clearAll();
                      await store.vacuum();
                      ref.invalidate(httpCacheSizeProvider);
                      messenger.showSnackBar(
                        const SnackBar(content: Text('HTTPキャッシュを削除しました')),
                      );
                    },
                  ),
                ],
                Center(
                  child: Text(
                    'Powered by Flutter',
                    style: textTheme.bodySmall?.copyWith(
                      color: context.designSystem.colorTheme.onSurface
                          .withValues(alpha: 0.8),
                    ),
                  ),
                ),
                if (isDeveloperUiEnabled && (isDebugEnabled ?? false)) ...[
                  Center(
                    child: Text(
                      'Debug Mode',
                      style: textTheme.bodySmall?.copyWith(
                        color: context.designSystem.colorTheme.onSurface
                            .withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('デバッグメニュー'),
                    leading: const Icon(Icons.bug_report),
                    onTap: () => const DebugRoute().push<void>(context),
                  ),
                ],
              ],
            ),
          ),
          const AdBanner(),
        ],
      ),
    );
  }
}

class _AppVersionInformation extends HookConsumerWidget {
  const _AppVersionInformation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final commitRaw = ref.watch(buildConfigProvider).commitInformation;
    final commitLabel = commitRaw.isEmpty ? 'local-development' : commitRaw;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final manifestAsync = ref.watch(assetPackManifestProvider);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'EQMonitor v${packageInfo.version}',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: .bold,
              fontSize: 14,
            ),
          ),
          TextSpan(text: '(Build ${packageInfo.buildNumber})\n'),
          TextSpan(text: commitLabel + '\n'),
          TextSpan(
            text: switch (manifestAsync) {
              AsyncData(:final value) => 'Asset Pack v${value.packVersion}',
              AsyncError() => 'Asset Pack: 未取得',
              _ => 'Asset Pack: 確認中…',
            },
          ),
        ],
        style: textTheme.bodyMedium?.copyWith(
          fontFamily: FontFamily.googleSansCode,
          letterSpacing: -0.05,
          fontSize: 12,
        ),
      ),
      textAlign: .center,
    );
  }
}
