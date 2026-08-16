import 'package:eqmonitor/core/component/selector/city_selector.dart';
import 'package:eqmonitor/core/component/selector/prefecture_selector.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/model/widget_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/notifier/widget_region_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeWidgetSettingsPage extends ConsumerWidget {
  const HomeWidgetSettingsPage({super.key});

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
  const _WidgetRegionSection({required this.isPro, required this.regionAsync});

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
      final result = await Navigator.of(context).push<WidgetRegionSelection>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => _WidgetRegionPickerPage(initial: region),
        ),
      );
      if (result != null) {
        await ref.read(widgetRegionProvider.notifier).save(result);
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

class _WidgetRegionPickerPage extends HookWidget {
  const _WidgetRegionPickerPage({this.initial});

  final WidgetRegionSelection? initial;

  @override
  Widget build(BuildContext context) {
    final searchType = useState(
      initial?.searchType ?? RegionSearchType.prefecture,
    );
    final selectedCode = useState<String?>(initial?.code);
    final selectedName = useState<String?>(initial?.name);

    return Scaffold(
      appBar: AppBar(
        title: const Text('任意地域を選択'),
        actions: [
          switch (selectedCode.value) {
            final code? when code.isNotEmpty => TextButton(
              onPressed: () => Navigator.of(context).pop(
                WidgetRegionSelection(
                  searchType: searchType.value,
                  code: code,
                  name: selectedName.value ?? '',
                ),
              ),
              child: const Text('決定'),
            ),
            _ => const TextButton(onPressed: null, child: Text('決定')),
          },
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                ChoiceChip(
                  label: const Text('都道府県'),
                  selected: searchType.value == RegionSearchType.prefecture,
                  onSelected: (s) {
                    if (s) {
                      searchType.value = RegionSearchType.prefecture;
                      selectedCode.value = null;
                      selectedName.value = null;
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('市区町村'),
                  selected: searchType.value == RegionSearchType.city,
                  onSelected: (s) {
                    if (s) {
                      searchType.value = RegionSearchType.city;
                      selectedCode.value = null;
                      selectedName.value = null;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (searchType.value == RegionSearchType.prefecture)
              PrefectureSelector(
                selectedCode: selectedCode.value,
                onChanged: (selection) {
                  selectedCode.value = selection?.code;
                  selectedName.value = selection?.name;
                },
              )
            else
              CitySelector(
                selectedCode: selectedCode.value,
                selectedName: selectedName.value,
                onChanged: (selection) {
                  selectedCode.value = selection?.code;
                  selectedName.value = selection?.name;
                },
              ),
            if (selectedName.value case final name? when name.isNotEmpty) ...[
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.place_outlined),
                  title: Text(name),
                  subtitle: Text(
                    searchType.value == RegionSearchType.prefecture
                        ? '都道府県'
                        : '市区町村',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
