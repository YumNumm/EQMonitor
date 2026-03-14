import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree_converter.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:eqmonitor_api/export.dart' as eqmonitor_api;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/route.dart';

class PrefectureIntensityWidget extends HookConsumerWidget {
  const PrefectureIntensityWidget({required this.item, super.key});

  final eqmonitor_api.Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensity = item.intensity;
    final jmaParameter = ref.watch(jmaParameterProvider).value;

    if (intensity == null) {
      return const SizedBox.shrink();
    }

    // EarthquakeParameterがロードされていればツリー構造に変換
    final intensityTree = jmaParameter != null
        ? convertToIntensityTree(
            intensity: intensity,
            parameter: jmaParameter.earthquake,
          )
        : null;

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          const SheetHeader(title: '各地の震度'),
          if (intensityTree != null)
            ...intensityTree.entries.map((entry) {
              final intensity = entry.key;
              return ListTile(
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
                subtitle: Text(
                  entry.value.map((e) => e.region.name).join(', '),
                  style: const TextStyle(fontFamily: FontFamily.notoSansJP),
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

class _RegionListTile extends HookWidget {
  const _RegionListTile({required this.region});

  final RegionIntensityNode region;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final shrinked = ListTile(
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

class _CityListTile extends HookWidget {
  const _CityListTile({
    required this.city,
    required this.colorScheme,
  });

  final CityIntensityNode city;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final maxIntensity = city.maxIntensity;

    final cityHeader = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          if (maxIntensity != null)
            IntensityValueIcon(
              intensity: maxIntensity,
              type: IntensityIconType.filled,
              size: 24,
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
                      if (station.intensity?.maxIntensity case final jma?)
                        IntensityValueIcon(
                          intensity: jma,
                          type: IntensityIconType.filled,
                          size: 18,
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
