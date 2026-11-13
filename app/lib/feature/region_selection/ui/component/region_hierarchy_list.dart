import 'package:eqmonitor/feature/region_selection/data/logic/region_hierarchy.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// 階層のどこを表示しているかを示し、上位の階層へ戻れるパンくず。
class RegionHierarchyBreadcrumb extends StatelessWidget {
  const new({
    required this.prefecture,
    required this.region,
    required this.onRootSelected,
    required this.onPrefectureSelected,
    super.key,
  });

  final RegionOption? prefecture;
  final RegionOption? region;
  final VoidCallback onRootSelected;
  final VoidCallback onPrefectureSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentStyle = theme.textTheme.labelLarge?.copyWith(
      color: theme.colorScheme.onSurface,
    );
    final separator = Icon(
      Icons.chevron_right,
      size: 18,
      color: theme.colorScheme.onSurfaceVariant,
    );
    final prefecture = this.prefecture;
    final region = this.region;

    return SingleChildScrollView(
      scrollDirection: .horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          if (prefecture == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text('都道府県を選択', style: currentStyle),
            )
          else ...[
            M3ETextButton(
              onPressed: onRootSelected,
              child: const Text('都道府県'),
            ),
            separator,
            if (region == null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(prefecture.name, style: currentStyle),
              )
            else ...[
              M3ETextButton(
                onPressed: onPrefectureSelected,
                child: Text(prefecture.name),
              ),
              separator,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(region.name, style: currentStyle),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// 都道府県 → 細分化地域 → 「全体」または市区町村 の順に辿る一覧。
///
/// 都道府県と細分化地域の行は次の階層へ進むだけで、選択は最下層で行う。
class RegionHierarchyList extends StatelessWidget {
  const new({
    required this.catalog,
    required this.prefectures,
    required this.prefecture,
    required this.region,
    required this.selected,
    required this.unavailable,
    required this.unavailableLabel,
    required this.multiple,
    required this.onPrefectureSelected,
    required this.onRegionSelected,
    required this.onOptionSelected,
    super.key,
  });

  final List<RegionOption> catalog;
  final List<RegionOption> prefectures;
  final RegionOption? prefecture;
  final RegionOption? region;
  final List<RegionOption> selected;
  final Set<String> unavailable;
  final String unavailableLabel;
  final bool multiple;
  final ValueChanged<RegionOption> onPrefectureSelected;
  final ValueChanged<RegionOption> onRegionSelected;
  final ValueChanged<RegionOption> onOptionSelected;

  @override
  Widget build(BuildContext context) {
    const hierarchy = RegionHierarchy();
    final prefecture = this.prefecture;
    final region = this.region;

    if (prefecture == null) {
      return ListView.builder(
        key: const PageStorageKey('region-hierarchy-prefectures'),
        keyboardDismissBehavior: .onDrag,
        itemCount: prefectures.length,
        itemBuilder: (context, index) {
          final item = prefectures[index];
          return ListTile(
            title: Text(item.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onPrefectureSelected(item),
          );
        },
      );
    }
    if (region == null) {
      final regions = hierarchy.regions(
        catalog: catalog,
        prefecture: prefecture,
      );
      return ListView.builder(
        key: ValueKey('region-hierarchy-regions-${prefecture.code}'),
        keyboardDismissBehavior: .onDrag,
        itemCount: regions.length,
        itemBuilder: (context, index) {
          final item = regions[index];
          final selectedCount = selected
              .where(
                (value) =>
                    value.identity == item.identity ||
                    (value.parentKind == .region &&
                        value.parentCode == item.code),
              )
              .length;
          return ListTile(
            title: Text(item.name),
            subtitle: selectedCount == 0 ? null : const Text('選択中'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onRegionSelected(item),
          );
        },
      );
    }
    final cities = hierarchy.cities(catalog: catalog, region: region);
    return ListView.builder(
      key: ValueKey('region-hierarchy-cities-${region.code}'),
      keyboardDismissBehavior: .onDrag,
      itemCount: cities.length + 1,
      itemBuilder: (context, index) {
        final item = index == 0 ? region : cities[index - 1];
        final isSelected = selected.any(
          (value) => value.identity == item.identity,
        );
        final isUnavailable = unavailable.contains(item.identity);
        final description = [
          if (index == 0) '${RegionKind.region.label}全体を対象にする',
          if (isUnavailable) unavailableLabel,
        ].join('・');
        return ListTile(
          selected: isSelected,
          enabled: !isUnavailable,
          leading: Icon(
            isUnavailable
                ? Icons.check
                : multiple
                ? (isSelected ? Icons.check_box : Icons.check_box_outline_blank)
                : (isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked),
          ),
          title: Text(index == 0 ? '${item.name} 全体' : item.name),
          subtitle: description.isEmpty ? null : Text(description),
          onTap: () => onOptionSelected(item),
        );
      },
    );
  }
}
