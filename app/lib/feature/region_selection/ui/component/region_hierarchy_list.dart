import 'package:eqmonitor/feature/region_selection/data/logic/region_hierarchy.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

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

class RegionHierarchyList extends StatelessWidget {
  const new({
    required this.catalog,
    required this.kinds,
    required this.prefectures,
    required this.prefecture,
    required this.region,
    required this.selected,
    required this.unavailable,
    required this.unavailableLabel,
    required this.multiple,
    required this.bottomInset,
    required this.onPrefectureSelected,
    required this.onRegionSelected,
    required this.onOptionSelected,
    super.key,
  });

  final List<RegionOption> catalog;
  final List<RegionKind> kinds;
  final List<RegionOption> prefectures;
  final RegionOption? prefecture;
  final RegionOption? region;
  final List<RegionOption> selected;
  final Set<String> unavailable;
  final String unavailableLabel;
  final bool multiple;
  final double bottomInset;
  final ValueChanged<RegionOption> onPrefectureSelected;
  final ValueChanged<RegionOption> onRegionSelected;
  final ValueChanged<RegionOption> onOptionSelected;

  @override
  Widget build(BuildContext context) {
    const hierarchy = RegionHierarchy();
    final prefecture = this.prefecture;
    final region = this.region;
    final citySelectable = kinds.contains(RegionKind.city);

    if (prefecture == null) {
      return ListView.builder(
        key: const PageStorageKey('region-hierarchy-prefectures'),
        keyboardDismissBehavior: .onDrag,
        padding: EdgeInsets.only(bottom: bottomInset),
        itemCount: prefectures.length,
        itemBuilder: (context, index) {
          final item = prefectures[index];
          return _BranchTile(
            option: item,
            selected: selected,
            onTap: () => onPrefectureSelected(item),
          );
        },
      );
    }
    final whole = region == null
        ? (kinds.contains(RegionKind.prefecture) ? prefecture : null)
        : (kinds.contains(RegionKind.region) ? region : null);
    final children = region == null
        ? hierarchy.regions(catalog: catalog, prefecture: prefecture)
        : hierarchy.cities(catalog: catalog, region: region);
    final offset = whole == null ? 0 : 1;
    return ListView.builder(
      key: ValueKey('region-hierarchy-${prefecture.code}-${region?.code}'),
      keyboardDismissBehavior: .onDrag,
      padding: EdgeInsets.only(bottom: bottomInset),
      itemCount: children.length + offset,
      itemBuilder: (context, index) {
        if (whole != null && index == 0) {
          return _LeafTile(
            option: whole,
            title: '${whole.name} 全体',
            description: '${whole.kind.label}全体を対象にする',
            selected: selected,
            unavailable: unavailable,
            unavailableLabel: unavailableLabel,
            multiple: multiple,
            onTap: () => onOptionSelected(whole),
          );
        }
        final item = children[index - offset];
        if (region == null && citySelectable) {
          return _BranchTile(
            option: item,
            selected: selected,
            onTap: () => onRegionSelected(item),
          );
        }
        return _LeafTile(
          option: item,
          title: item.name,
          description: null,
          selected: selected,
          unavailable: unavailable,
          unavailableLabel: unavailableLabel,
          multiple: multiple,
          onTap: () => onOptionSelected(item),
        );
      },
    );
  }
}

class _BranchTile extends StatelessWidget {
  const new({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final RegionOption option;
  final List<RegionOption> selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final containsSelection = selected.any(
      (value) =>
          value.identity == option.identity ||
          (value.parentKind == option.kind &&
              value.parentCode == option.code) ||
          (option.kind == .prefecture && value.prefectureCode == option.code),
    );
    return ListTile(
      visualDensity: .compact,
      title: Text(option.name),
      subtitle: containsSelection ? const Text('選択中') : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _LeafTile extends StatelessWidget {
  const new({
    required this.option,
    required this.title,
    required this.description,
    required this.selected,
    required this.unavailable,
    required this.unavailableLabel,
    required this.multiple,
    required this.onTap,
  });

  final RegionOption option;
  final String title;
  final String? description;
  final List<RegionOption> selected;
  final Set<String> unavailable;
  final String unavailableLabel;
  final bool multiple;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected.any(
      (value) => value.identity == option.identity,
    );
    final isUnavailable = unavailable.contains(option.identity);
    final subtitle = [
      ?description,
      if (isUnavailable) unavailableLabel,
    ].join('・');
    return ListTile(
      visualDensity: .compact,
      selected: isSelected,
      enabled: !isUnavailable,
      leading: multiple
          ? Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank)
          : null,
      trailing: !multiple && (isSelected || isUnavailable)
          ? const Icon(Icons.check)
          : null,
      title: Text(title),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      onTap: onTap,
    );
  }
}
