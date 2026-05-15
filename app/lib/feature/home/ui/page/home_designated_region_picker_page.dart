import 'package:eqmonitor/core/component/selector/city_selector.dart';
import 'package:eqmonitor/core/component/selector/prefecture_selector.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_picker_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム地震履歴カードの「指定地域」を設定するためのページ。
///
/// 都道府県/市区町村のいずれかを、リストもしくは地図から選択して
/// [EarthquakeHistoryParameter] を返す。
class HomeDesignatedRegionPickerPage extends HookConsumerWidget {
  const HomeDesignatedRegionPickerPage({super.key, this.initialParameter});

  final EarthquakeHistoryParameter? initialParameter;

  /// 結果として [EarthquakeHistoryParameter] を返すページを push する。
  ///
  /// クリアされた場合は [EarthquakeHistoryParameter] のフィールドが
  /// すべて未設定のインスタンスを返す。キャンセル時は `null`。
  static Future<EarthquakeHistoryParameter?> show(
    BuildContext context, {
    EarthquakeHistoryParameter? initialParameter,
  }) {
    return Navigator.of(context).push<EarthquakeHistoryParameter>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => HomeDesignatedRegionPickerPage(
          initialParameter: initialParameter,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedType = useState<RegionSearchType>(
      initialParameter?.regionSearchType ?? RegionSearchType.prefecture,
    );
    final selectedCode = useState<String?>(initialParameter?.regionCode);
    final selectedName = useState<String?>(initialParameter?.regionName);

    Future<void> openMap() async {
      final result = await RegionPickerMapPage.show(
        context,
        selectedType: selectedType.value == RegionSearchType.city
            ? 'city'
            : 'prefecture',
      );
      if (result != null) {
        selectedCode.value = result.code;
        selectedName.value = result.name;
      }
    }

    final canApply =
        selectedCode.value != null && selectedCode.value!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('指定地域を選択'),
        actions: [
          if (canApply)
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                EarthquakeHistoryParameter(
                  regionSearchType: selectedType.value,
                  regionCode: selectedCode.value,
                  regionName: selectedName.value,
                ),
              ),
              child: const Text('決定'),
            ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'ホーム画面の地震履歴で「指定地域」として表示する都道府県・市区町村を選択します。',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('都道府県'),
                  selected: selectedType.value == RegionSearchType.prefecture,
                  onSelected: (s) {
                    if (s) {
                      selectedType.value = RegionSearchType.prefecture;
                      selectedCode.value = null;
                      selectedName.value = null;
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('市区町村'),
                  selected: selectedType.value == RegionSearchType.city,
                  onSelected: (s) {
                    if (s) {
                      selectedType.value = RegionSearchType.city;
                      selectedCode.value = null;
                      selectedName.value = null;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (selectedType.value == RegionSearchType.prefecture)
              PrefectureSelector(
                selectedCode: selectedCode.value,
                onChanged: (selection) {
                  if (selection != null) {
                    selectedCode.value = selection.code;
                    selectedName.value = selection.name;
                  } else {
                    selectedCode.value = null;
                    selectedName.value = null;
                  }
                },
              )
            else
              CitySelector(
                selectedCode: selectedCode.value,
                selectedName: selectedName.value,
                onChanged: (selection) {
                  if (selection != null) {
                    selectedCode.value = selection.code;
                    selectedName.value = selection.name;
                  } else {
                    selectedCode.value = null;
                    selectedName.value = null;
                  }
                },
              ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: openMap,
              icon: const Icon(Icons.map_outlined),
              label: const Text('地図から選択'),
            ),
            const SizedBox(height: 16),
            if (selectedName.value != null && selectedName.value!.isNotEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.place_outlined),
                  title: Text(selectedName.value!),
                  subtitle: Text(
                    selectedType.value == RegionSearchType.prefecture
                        ? '都道府県'
                        : '市区町村',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: '選択を解除',
                    onPressed: () {
                      selectedCode.value = null;
                      selectedName.value = null;
                    },
                  ),
                ),
              ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: canApply
                  ? () => Navigator.of(context).pop(
                      EarthquakeHistoryParameter(
                        regionSearchType: selectedType.value,
                        regionCode: selectedCode.value,
                        regionName: selectedName.value,
                      ),
                    )
                  : null,
              child: const Text('この地域を設定する'),
            ),
            if (initialParameter?.regionCode != null) ...[
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(
                  const EarthquakeHistoryParameter(),
                ),
                child: const Text('設定を解除する'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
