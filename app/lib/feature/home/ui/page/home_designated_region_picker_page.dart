import 'package:eqmonitor/core/component/selector/city_selector.dart';
import 'package:eqmonitor/core/component/selector/prefecture_selector.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_picker_map_page.dart';
import 'package:material_ui/material_ui.dart';
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
        builder: (_) =>
            HomeDesignatedRegionPickerPage(initialParameter: initialParameter),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedType = useState<RegionSearchType>(
      initialParameter is EarthquakeHistoryParameterCity
          ? RegionSearchType.city
          : RegionSearchType.prefecture,
    );
    final selectedCode = useState<String?>(switch (initialParameter) {
      EarthquakeHistoryParameterCity(:final cityCode) => cityCode,
      EarthquakeHistoryParameterRegion(:final regionCode) => regionCode,
      EarthquakeHistoryParameterPrefecture(:final prefectureCode) =>
        prefectureCode,
      _ => null,
    });
    // ユーザー操作で明示的に設定された地域名。未設定時は [resolvedName] で補完する。
    final selectedName = useState<String?>(null);
    // selectedCode/selectedType からパラメータ木を辿って地域名を解決する。
    // (初期パラメータ復元時など selectedName が未設定のケースを補完する)
    final resolvedName =
        (selectedCode.value != null && selectedCode.value!.isNotEmpty)
        ? ref
              .watch(
                regionNameProvider(selectedType.value, selectedCode.value!),
              )
              .value
        : null;
    final displayName = selectedName.value ?? resolvedName;

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

    /// 選択中の種別([selectedType])とコードから対応する
    /// [EarthquakeHistoryParameter] を生成する。
    EarthquakeHistoryParameter buildParameter() {
      final code =
          selectedCode.value ??
          () {
            throw Exception('code is null');
          }();
      return switch (selectedType.value) {
        RegionSearchType.prefecture => EarthquakeHistoryParameter.prefecture(
          sortBy: .eventId,
          sortOrder: .desc,
          prefectureCode: code,
        ),
        RegionSearchType.city => EarthquakeHistoryParameter.city(
          sortBy: .eventId,
          sortOrder: .desc,
          cityCode: code,
        ),
        RegionSearchType.region => EarthquakeHistoryParameter.region(
          sortBy: .eventId,
          sortOrder: .desc,
          regionCode: code,
        ),
        RegionSearchType.station => EarthquakeHistoryParameter.station(
          sortBy: .eventId,
          sortOrder: .desc,
          stationCode: code,
        ),
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('指定地域を選択'),
        actions: [
          if (canApply)
            TextButton(
              onPressed: () => Navigator.of(context).pop(buildParameter()),
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
            if (displayName != null && displayName.isNotEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.place_outlined),
                  title: Text(displayName),
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
                  ? () => Navigator.of(context).pop(buildParameter())
                  : null,
              child: const Text('この地域を設定する'),
            ),
            if (initialParameter is EarthquakeHistoryParameterCity ||
                initialParameter is EarthquakeHistoryParameterPrefecture) ...[
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(
                  const EarthquakeHistoryParameter.all(
                    sortBy: .eventId,
                    sortOrder: .desc,
                  ),
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
