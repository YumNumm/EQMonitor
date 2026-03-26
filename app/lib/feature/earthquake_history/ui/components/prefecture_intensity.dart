import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/component/intenisty/lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/route.dart';

class PrefectureIntensityWidget extends HookConsumerWidget {
  const PrefectureIntensityWidget({required this.item, super.key});

  final EarthquakePartial item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensity = item.intensity;

    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final intensityTree = intensity.intensityTree;

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          const SheetHeader(title: '各地の震度'),
          ...intensityTree.entries.map((entry) {
            final intensity = entry.key;
            return ListTile(
              isThreeLine: true,
              visualDensity: VisualDensity.compact,
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: IntensityValueIcon(
                intensity: intensity,
                type: IntensityIconType.filled,
                size: 40,
              ),
              title: Text(
                '震度${intensity.label}',
                style: textTheme.titleMedium,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '都道府県 ${entry.value.length}',
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    entry.value.map((e) => e.region.name).join('、'),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: FontFamily.notoSansJP,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              onTap: () async => _RegionModalBottomSheet.show(
                context: context,
                intensity: intensity,
                regions: entry.value,
              ),
              trailing: const Icon(Icons.chevron_right),
            );
          }),
        ],
      ),
    );
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('震度${intensity.label}の地域')),
      body: ListView(
        children: [
          for (final region in regions) _RegionListTile(region: region),
        ],
      ),
    );
  }
}

class _RegionListTile extends HookConsumerWidget {
  const _RegionListTile({required this.region});

  final RegionIntensityNode region;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    final shrinked = ListTile(
      leading: _IntensityLpgmBadgeRow(
        maxIntensity: region.maxIntensity,
        maxLpgm: null,
        intensityIconSize: 28,
      ),
      title: Text(
        region.region.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: region.cities.isNotEmpty ? const Icon(Icons.expand_more) : null,
      onTap: region.cities.isNotEmpty ? () => isExpanded.value = true : null,
    );

    final expanded = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: _IntensityLpgmBadgeRow(
            maxIntensity: region.maxIntensity,
            maxLpgm: null,
            intensityIconSize: 28,
          ),
          title: Text(
            region.region.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.expand_less),
          onTap: () => isExpanded.value = false,
        ),
        for (final city in region.cities)
          _CityListTile(city: city, colorScheme: colorScheme),
      ],
    );

    if (region.cities.isEmpty) {
      return shrinked;
    }

    return AnimatedCrossFade(
      firstChild: shrinked,
      secondChild: expanded,
      crossFadeState: isExpanded.value
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class _CityListTile extends HookConsumerWidget {
  const _CityListTile({
    required this.city,
    required this.colorScheme,
  });

  final CityIntensityNode city;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final maxIntensity = city.maxIntensity;
    final maxLpgm = city.maxLpgmIntensity;

    final cityHeader = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (city.stations.isNotEmpty)
            IconButton(
              icon: Icon(
                isExpanded.value ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () => isExpanded.value = !isExpanded.value,
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );

    if (city.stations.isEmpty || !isExpanded.value) {
      return InkWell(
        onTap: city.stations.isNotEmpty
            ? () => isExpanded.value = !isExpanded.value
            : null,
        child: cityHeader,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => isExpanded.value = !isExpanded.value,
          child: cityHeader,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48, right: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final station in city.stations)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
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
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IntensityLpgmBadgeRow extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
