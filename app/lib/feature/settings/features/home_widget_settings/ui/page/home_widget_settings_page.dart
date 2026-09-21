import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/model/widget_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/notifier/widget_region_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class HomeWidgetSettingsPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isPro = ref.watch(isProProvider);
    final regionAsync = ref.watch(widgetRegionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ホーム画面ウィジェット')),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'ウィジェットに表示する地域は3種類あります。\n'
                '「全国」「現在地」はウィジェットを長押し→編集から切り替えられます。'
                '「任意地域」を表示したい場合は、下の設定で地域を選んでください。',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SettingsSectionHeader(text: '任意地域'),
            _WidgetRegionSection(isPro: isPro, regionAsync: regionAsync),
          ],
        ),
      ),
    );
  }
}

class _WidgetRegionSection extends ConsumerWidget {
  const new({required this.isPro, required this.regionAsync});

  final bool isPro;
  final AsyncValue<WidgetRegionSelection?> regionAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final region = regionAsync.value;

    Future<void> pick() async {
      if (!isPro) {
        await const ProUpgradeDialogAction().show(context);
        return;
      }
      final result = await RegionSelectionRoute(
        $extra: RegionSelectionRequest(
          title: '任意地域を選択',
          kinds: const [.prefecture, .city],
          initialSelection: [
            if (region != null)
              RegionOption(
                kind: region.searchType == RegionSearchType.prefecture
                    ? .prefecture
                    : .city,
                code: region.code,
                name: region.name,
              ),
          ],
        ),
      ).push<List<RegionOption>>(context);
      final picked = result?.firstOrNull;
      if (picked != null) {
        await ref
            .read(widgetRegionProvider.notifier)
            .save(
              WidgetRegionSelection(
                searchType: picked.kind == .prefecture ? .prefecture : .city,
                code: picked.code,
                name: picked.name,
              ),
            );
      }
    }

    return Column(
      children: [
        LockedSettingTile(
          title: '任意地域を選択',
          subtitle: region == null
              ? '都道府県または市区町村を指定します'
              : '${region.name}（${region.searchType == RegionSearchType.prefecture ? '都道府県' : '市区町村'}）',
          locked: !isPro,
          onTap: pick,
        ),
        if (region != null)
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('選択を解除'),
            onTap: () async => ref.read(widgetRegionProvider.notifier).clear(),
          ),
      ],
    );
  }
}
