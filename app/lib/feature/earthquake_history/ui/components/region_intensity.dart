import 'dart:async';

import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/component/intenisty/lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_map_focus.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_focus_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/route.dart';

class RegionIntensityWidget extends ConsumerWidget {
  const RegionIntensityWidget({
    required this.item,
    this.eventId,
    super.key,
  });

  final Earthquake item;
  final String? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ref: ref,
                  eventId: eventId,
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
  final PrefectureIntensityNode node;
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
  List<PrefectureIntensityNode> regions,
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
    required this.ref,
    required this.eventId,
    required this.intensity,
    required this.regions,
  });

  static Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
    required JmaIntensity intensity,
    required List<PrefectureIntensityNode> regions,
    String? eventId,
  }) => Navigator.of(context).push(
    SheetRoute(
      builder: (context) => _RegionModalBottomSheet(
        ref: ref,
        eventId: eventId,
        intensity: intensity,
        regions: regions,
      ),
    ),
  );

  final WidgetRef ref;
  final String? eventId;
  final JmaIntensity intensity;
  final List<PrefectureIntensityNode> regions;

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
                  ref,
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
    WidgetRef ref,
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
            ref,
            node,
            duration,
            curve,
            c.node,
          ),
          final _TreeCity c => _cityRow(
            context,
            ref,
            node,
            duration,
            curve,
            colorScheme,
            c.node,
          ),
          final _TreeStation c => _stationRow(
            context,
            ref,
            colorScheme,
            c.node,
          ),
        },
      ),
    );
  }

  Widget _regionRow(
    BuildContext context,
    WidgetRef ref,
    TreeSliverNode<Object?> node,
    Duration duration,
    Curve curve,
    PrefectureIntensityNode region,
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
        if (eventId != null)
          _mapFocusButton(
            context,
            ref,
            EarthquakeIntensityMapFocus(
              kind: EarthquakeIntensityMapFocusKind.prefectureRegion,
              code: region.region.region.code,
            ),
          ),
        if (node.children.isNotEmpty)
          _expandIcon(context, node, duration, curve),
      ],
    );
  }

  Widget _cityRow(
    BuildContext context,
    WidgetRef ref,
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
        if (eventId != null)
          _mapFocusButton(
            context,
            ref,
            EarthquakeIntensityMapFocus(
              kind: EarthquakeIntensityMapFocusKind.city,
              code: city.city.code,
            ),
          ),
        if (node.children.isNotEmpty)
          _expandIcon(context, node, duration, curve),
      ],
    );
  }

  Widget _stationRow(
    BuildContext context,
    WidgetRef ref,
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
        if (eventId != null)
          _mapFocusButton(
            context,
            ref,
            EarthquakeIntensityMapFocus(
              kind: EarthquakeIntensityMapFocusKind.station,
              code: station.station.code,
            ),
          ),
      ],
    );
  }

  Widget _mapFocusButton(
    BuildContext context,
    WidgetRef ref,
    EarthquakeIntensityMapFocus focus,
  ) {
    return IconButton(
      tooltip: '地図で表示',
      icon: const Icon(Icons.map_outlined, size: 20),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      onPressed: () {
        ref
            .read(earthquakeHistoryMapFocusProvider(eventId!).notifier)
            .select(
              focus,
            );
        unawaited(Navigator.of(context).maybePop());
      },
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
