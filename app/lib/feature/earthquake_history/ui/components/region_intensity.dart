import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/component/intenisty/lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sheet/route.dart';

class RegionIntensityWidget extends StatelessWidget {
  const RegionIntensityWidget({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensity = item.intensity;

    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final intensityTree = intensity.intensityTree;
    if (intensityTree.isEmpty) {
      return const SizedBox.shrink();
    }

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          const SheetHeader(title: '各地の震度'),
          ...intensityTree.entries.map(
            (entry) {
              final jmaIntensity = entry.key;
              return ListTile(
                isThreeLine: true,
                visualDensity: VisualDensity.compact,
                titleAlignment: ListTileTitleAlignment.titleHeight,
                leading: IntensityValueIcon(
                  intensity: jmaIntensity,
                  type: IntensityIconType.filled,
                  size: 40,
                ),
                title: Text(
                  '震度${jmaIntensity.label}',
                  style: textTheme.titleMedium,
                ),
                subtitle: Text(
                  entry.value
                      .map(
                        (e) => e.region.region.name,
                      )
                      .join('、'),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: FontFamily.notoSansJP,
                    fontSize: 13,
                  ),
                ),
                onTap: () async => _RegionModalBottomSheet.show(
                  context: context,
                  intensity: jmaIntensity,
                  regions: entry.value,
                ),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          ),
        ],
      ),
    );
  }
}

sealed class _RegionIntensityTreeContent {
  const _RegionIntensityTreeContent();
}

final class _TreeRegion extends _RegionIntensityTreeContent {
  const _TreeRegion(this.node);
  final RegionIntensityNode node;
}

final class _TreeCity extends _RegionIntensityTreeContent {
  const _TreeCity(this.node);
  final CityIntensityNode node;
}

final class _TreeStation extends _RegionIntensityTreeContent {
  const _TreeStation(this.node);
  final StationIntensityNode node;
}

List<TreeSliverNode<_RegionIntensityTreeContent>> _buildRegionDetailTree(
  List<RegionIntensityNode> regions,
) {
  return [
    for (final region in regions)
      TreeSliverNode<_RegionIntensityTreeContent>(
        _TreeRegion(region),
        children: [
          for (final city in region.cities)
            TreeSliverNode<_RegionIntensityTreeContent>(
              _TreeCity(city),
              children: [
                for (final station in city.stations)
                  TreeSliverNode<_RegionIntensityTreeContent>(
                    _TreeStation(station),
                  ),
              ],
            ),
        ],
      ),
  ];
}

class _RegionModalBottomSheet extends StatelessWidget {
  const _RegionModalBottomSheet({
    required this.intensity,
    required this.regions,
  });

  static Future<void> show({
    required BuildContext context,
    required JmaIntensity intensity,
    required List<RegionIntensityNode> regions,
  }) => Navigator.of(context).push(
    SheetRoute(
      builder: (context) => _RegionModalBottomSheet(
        intensity: intensity,
        regions: regions,
      ),
    ),
  );

  final JmaIntensity intensity;
  final List<RegionIntensityNode> regions;

  static const Curve _toggleCurve = TreeSliver.defaultAnimationCurve;
  static const Duration _toggleDuration = TreeSliver.defaultAnimationDuration;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tree = _buildRegionDetailTree(regions);

    return Scaffold(
      appBar: AppBar(title: Text('震度${intensity.label}の地域')),
      body: CustomScrollView(
        slivers: [
          TreeSliver<_RegionIntensityTreeContent>(
            tree: tree,
            indentation: TreeSliverIndentationType.none,
            treeNodeBuilder: (context, node, toggleAnimationStyle) =>
                _regionDetailTreeNodeBuilder(
                  context,
                  colorScheme,
                  node,
                  toggleAnimationStyle,
                ),
            treeRowExtentBuilder: (node, dimensions) {
              final content = node.content! as _RegionIntensityTreeContent;
              return switch (content) {
                _TreeRegion() => 56,
                _TreeCity() => 52,
                _TreeStation() => 44,
              };
            },
          ),
        ],
      ),
    );
  }

  Widget _regionDetailTreeNodeBuilder(
    BuildContext context,
    ColorScheme colorScheme,
    TreeSliverNode<Object?> node,
    AnimationStyle toggleAnimationStyle,
  ) {
    final content = node.content! as _RegionIntensityTreeContent;
    final duration = toggleAnimationStyle.duration ?? _toggleDuration;
    final curve = toggleAnimationStyle.curve ?? _toggleCurve;
    final depth = node.depth ?? 0;
    final indent = 12.0 * depth;

    return TreeSliver.wrapChildToToggleNode(
      node: node,
      child: Padding(
        padding: EdgeInsets.only(left: indent + 8, right: 8, top: 4, bottom: 4),
        child: switch (content) {
          final _TreeRegion c => _regionRow(
            context,
            node,
            duration,
            curve,
            c.node,
          ),
          final _TreeCity c => _cityRow(
            context,
            node,
            duration,
            curve,
            colorScheme,
            c.node,
          ),
          final _TreeStation c => _stationRow(
            colorScheme,
            c.node,
          ),
        },
      ),
    );
  }

  Widget _regionRow(
    BuildContext context,
    TreeSliverNode<Object?> node,
    Duration duration,
    Curve curve,
    RegionIntensityNode region,
  ) {
    final regionName = region.region.region.name;
    final regionMaxIntensity = region.region.maxIntensity;

    return Row(
      children: [
        _IntensityLpgmBadgeRow(
          maxIntensity: regionMaxIntensity,
          maxLpgm: null,
          intensityIconSize: 28,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            regionName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (node.children.isNotEmpty)
          _expandIcon(context, node, duration, curve),
      ],
    );
  }

  Widget _cityRow(
    BuildContext context,
    TreeSliverNode<Object?> node,
    Duration duration,
    Curve curve,
    ColorScheme colorScheme,
    CityIntensityNode city,
  ) {
    final maxIntensity = city.maxIntensity;
    final maxLpgm = city.maxLpgmIntensity;

    return Row(
      children: [
        _IntensityLpgmBadgeRow(
          maxIntensity: maxIntensity,
          maxLpgm: maxLpgm,
          intensityIconSize: 24,
          lpgmIconSize: 22,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            city.city.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (node.children.isNotEmpty)
          _expandIcon(context, node, duration, curve),
      ],
    );
  }

  Widget _stationRow(
    ColorScheme colorScheme,
    StationIntensityNode station,
  ) {
    return Row(
      children: [
        _IntensityLpgmBadgeRow(
          maxIntensity: station.intensity?.maxIntensity,
          maxLpgm: station.intensity?.maxLpgmIntensity,
          intensityIconSize: 18,
          lpgmIconSize: 16,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            station.station.name,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _expandIcon(
    BuildContext context,
    TreeSliverNode<Object?> node,
    Duration duration,
    Curve curve,
  ) {
    final index = TreeSliverController.of(context).getActiveIndexFor(node);
    return SizedBox(
      width: 40,
      height: 40,
      child: AnimatedRotation(
        key: ValueKey<int?>(index),
        turns: node.isExpanded ? 0.5 : 0.0,
        duration: duration,
        curve: curve,
        child: const Icon(Icons.expand_more),
      ),
    );
  }
}

class _IntensityLpgmBadgeRow extends StatelessWidget {
  const _IntensityLpgmBadgeRow({
    required this.maxIntensity,
    required this.maxLpgm,
    required this.intensityIconSize,
    this.lpgmIconSize,
  });

  final JmaIntensity? maxIntensity;
  final JmaLpgmIntensity? maxLpgm;
  final double intensityIconSize;
  final double? lpgmIconSize;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    if (maxIntensity != null) {
      children.add(
        IntensityValueIcon(
          intensity: maxIntensity!,
          type: IntensityIconType.filled,
          size: intensityIconSize,
        ),
      );
    }
    if (maxLpgm != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: 4));
      }
      children.add(
        LpgmIntensityIcon(
          intensity: maxLpgm!,
          type: IntensityIconType.filled,
          size: lpgmIconSize ?? intensityIconSize * 0.85,
        ),
      );
    }
    if (children.isEmpty) {
      return SizedBox(width: intensityIconSize, height: intensityIconSize);
    }
    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
