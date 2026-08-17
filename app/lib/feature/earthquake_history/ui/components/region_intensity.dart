import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/extension/jma_forecast_intensity.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/expand_trailing_icon_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/lpgm_station_detail_sheet.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// JMA震度階級の各地の震度ツリー表示
class JmaIntensityContent extends HookWidget {
  const JmaIntensityContent({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context) {
    final intensityColors = context.designSystem.colorTheme.intensity;
    final intensity = item.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final intensityTree = useMemoized(() {
      final entries = intensity.intensityTree.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex));
      return Map.fromEntries(entries);
    }, [intensity.intensityTree]);

    final regions = useMemoized(() {
      final entries = intensity.regions.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex));
      return Map.fromEntries(entries);
    }, [intensity.regions]);

    if (intensityTree.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PreliminaryBadge(),
          if (regions.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                '各地の詳細な震度情報はまだ発表されていません',
                style: TextStyle(
                  fontFamily: FontFamily.notoSansJP,
                  fontSize: 13,
                ),
              ),
            )
          else
            ...regions.entries.map(
              (entry) => _PreliminaryIntensityLevelSection(
                intensity: entry.key,
                regions: entry.value,
                dividerColor: intensityColors
                    .fromJmaIntensity(entry.key)
                    .background,
              ),
            ),
        ],
      );
    }

    return Column(
      children: intensityTree.entries
          .map(
            (entry) => _IntensityLevelSection(
              intensity: entry.key,
              prefectures: entry.value,
              eventId: item.eventId,
              dividerColor: intensityColors
                  .fromJmaIntensity(entry.key)
                  .background,
            ),
          )
          .toList(),
    );
  }
}

/// 長周期地震動階級の各地のツリー表示
class LpgmIntensityContent extends HookWidget {
  const LpgmIntensityContent({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context) {
    final intensityColors = context.designSystem.colorTheme.intensity;
    final intensity = item.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final lpgmTree = useMemoized(() {
      final entries = intensity.lpgmIntensityTree.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex));
      return Map.fromEntries(entries);
    }, [intensity.lpgmIntensityTree]);

    if (lpgmTree.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          '長周期地震動階級のデータはありません',
          style: TextStyle(fontFamily: FontFamily.notoSansJP, fontSize: 13),
        ),
      );
    }

    return Column(
      children: lpgmTree.entries
          .map(
            (entry) => _LpgmIntensityLevelSection(
              intensity: entry.key,
              prefectures: entry.value,
              eventId: item.eventId,
              dividerColor: intensityColors
                  .fromJmaLpgmIntensity(entry.key)
                  .background,
            ),
          )
          .toList(),
    );
  }
}

// --- Private widgets ---

class _PreliminaryBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.designSystem.colorTheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.designSystem.colorTheme.onErrorContainer,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            '速報',
            style: TextStyle(
              color: context.designSystem.colorTheme.onErrorContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _PreliminaryIntensityLevelSection extends StatelessWidget {
  const _PreliminaryIntensityLevelSection({
    required this.intensity,
    required this.regions,
    required this.dividerColor,
  });

  final JmaIntensity intensity;
  final List<IntensityRegion> regions;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final regionNames = regions.map((e) => e.region.name.ja).join(' ');

    return ListTile(
      dense: true,
      isThreeLine: true,
      visualDensity: .compact,
      titleAlignment: .titleHeight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: JmaIntensityIcon(intensity: intensity, type: .filled, size: 40),
      title: Row(
        children: [
          Text(
            '震度${switch (intensity) {
              .fiveUnknown => "5弱以上 未入電",
              .sixUnknown => "6弱以上 未入電",
              _ => intensity.label.fromPlusMinus,
            }}',
            style: theme.textTheme.titleSmall,
          ),
        ],
      ),
      subtitle: Text(
        regionNames,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontFamily: FontFamily.notoSansJP, fontSize: 13),
      ),
    );
  }
}

class _IntensityLevelSection extends HookWidget {
  const _IntensityLevelSection({
    required this.intensity,
    required this.dividerColor,
    required this.prefectures,
    required this.eventId,
  });

  final JmaIntensity intensity;
  final Color dividerColor;
  final List<PrefectureIntensityNode> prefectures;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasCityData = prefectures.any((p) => p.cities.isNotEmpty);

    final theme = Theme.of(context);
    final regionNames = prefectures
        .map((e) => e.prefecture.prefecture.name.ja)
        .join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          isThreeLine: true,
          visualDensity: .compact,
          titleAlignment: .titleHeight,
          contentPadding: const .symmetric(horizontal: 8),
          leading: JmaIntensityIcon(
            intensity: intensity,
            type: .filled,
            size: 40,
          ),
          title: Text(
            '震度${switch (intensity) {
              .fiveUnknown => "5弱以上 未入電",
              .sixUnknown => "6弱以上 未入電",
              _ => intensity.label.fromPlusMinus,
            }}',
            style: theme.textTheme.titleSmall,
          ),
          subtitle: Text(
            regionNames,
            maxLines: 4,
            overflow: .ellipsis,
            style: const TextStyle(
              fontFamily: FontFamily.notoSansJP,
              fontSize: 13,
            ),
          ),
          trailing: hasCityData
              ? AnimatedRotation(
                  turns: isExpanded.value ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.expand_more),
                )
              : null,
          onTap: hasCityData
              ? () => isExpanded.value = !isExpanded.value
              : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const .only(left: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    color: dividerColor,
                    thickness: 4,
                    width: 4,
                    radius: BorderRadiusGeometry.circular(2),
                  ),
                  Expanded(
                    child: Column(
                      children: prefectures
                          .map(
                            (prefecture) => _PrefectureTile(
                              prefecture: prefecture,
                              eventId: eventId,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _LpgmIntensityLevelSection extends HookWidget {
  const _LpgmIntensityLevelSection({
    required this.intensity,
    required this.dividerColor,
    required this.prefectures,
    required this.eventId,
  });

  final JmaLpgmIntensity intensity;
  final Color dividerColor;
  final List<PrefectureLpgmIntensityNode> prefectures;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasCityData = prefectures.any((p) => p.cities.isNotEmpty);

    final theme = Theme.of(context);
    final regionNames = prefectures.map((e) => e.region.name.ja).join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          isThreeLine: true,
          visualDensity: .compact,
          titleAlignment: .titleHeight,
          contentPadding: const .symmetric(horizontal: 8),
          leading: JmaLpgmIntensityIcon(
            intensity: intensity,
            type: .filled,
            size: 40,
          ),
          title: Text(
            '長周期地震動階級${intensity.label}',
            style: theme.textTheme.titleSmall,
          ),
          subtitle: Text(
            regionNames,
            maxLines: 4,
            overflow: .ellipsis,
            style: const TextStyle(
              fontFamily: FontFamily.notoSansJP,
              fontSize: 13,
            ),
          ),
          trailing: hasCityData
              ? AnimatedRotation(
                  turns: isExpanded.value ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.expand_more),
                )
              : null,
          onTap: hasCityData
              ? () => isExpanded.value = !isExpanded.value
              : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const .only(left: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    color: dividerColor,
                    thickness: 4,
                    width: 4,
                    radius: BorderRadiusGeometry.circular(2),
                  ),
                  Expanded(
                    child: Column(
                      children: prefectures
                          .map(
                            (prefecture) => _LpgmPrefectureTile(
                              prefecture: prefecture,
                              eventId: eventId,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _PrefectureTile extends HookWidget {
  const _PrefectureTile({required this.prefecture, required this.eventId});

  final PrefectureIntensityNode prefecture;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasCities = prefecture.cities.isNotEmpty;

    final trailing = const ExpandTrailingIconBuilder().build(
      hasChildren: hasCities,
      isExpanded: isExpanded.value,
    );

    return Column(
      children: [
        ListTile(
          visualDensity: .compact,
          dense: true,
          contentPadding: const .only(left: 8, right: 8),
          title: Text(
            prefecture.prefecture.prefecture.name.ja,
            style: const TextStyle(fontWeight: .bold),
          ),
          trailing: trailing,
          onTap: hasCities ? () => isExpanded.value = !isExpanded.value : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const .only(left: 8),
            child: Column(
              children: prefecture.cities
                  .map((city) => _CityTile(city: city, eventId: eventId))
                  .toList(),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _LpgmPrefectureTile extends HookWidget {
  const _LpgmPrefectureTile({required this.prefecture, required this.eventId});

  final PrefectureLpgmIntensityNode prefecture;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasCities = prefecture.cities.isNotEmpty;

    final trailing = const ExpandTrailingIconBuilder().build(
      hasChildren: hasCities,
      isExpanded: isExpanded.value,
    );

    return Column(
      children: [
        ListTile(
          visualDensity: .compact,
          dense: true,
          contentPadding: const .only(left: 8, right: 8),
          title: Text(
            prefecture.region.name.ja,
            style: const TextStyle(fontWeight: .bold),
          ),
          trailing: trailing,
          onTap: hasCities ? () => isExpanded.value = !isExpanded.value : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const .only(left: 8),
            child: Column(
              children: prefecture.cities
                  .map((city) => _LpgmCityTile(city: city, eventId: eventId))
                  .toList(),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _CityTile extends HookWidget {
  const _CityTile({required this.city, required this.eventId});

  final CityIntensityNode city;
  final String? eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasStations = city.stations.isNotEmpty;

    final trailing = const ExpandTrailingIconBuilder().build(
      hasChildren: hasStations,
      isExpanded: isExpanded.value,
    );

    return Column(
      crossAxisAlignment: .start,
      children: [
        ListTile(
          visualDensity: .compact,
          dense: true,
          title: Text(city.city.name.ja),
          trailing: trailing,
          onTap: hasStations
              ? () => isExpanded.value = !isExpanded.value
              : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const .only(left: 32),
            child: Text(
              city.stations.map((s) => s.station.name.ja).join(', '),
              style: const TextStyle(fontSize: 12),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _LpgmCityTile extends HookWidget {
  const _LpgmCityTile({required this.city, required this.eventId});

  final CityLpgmIntensityNode city;
  final String? eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasStations = city.stations.isNotEmpty;
    final trailing = const ExpandTrailingIconBuilder().build(
      hasChildren: hasStations,
      isExpanded: isExpanded.value,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          dense: true,
          title: Text(city.city.name.ja),
          trailing: trailing,
          onTap: hasStations
              ? () => isExpanded.value = !isExpanded.value
              : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 8, bottom: 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: city.stations.map((station) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => showModalBottomSheet<void>(
                      context: context,
                      clipBehavior: Clip.antiAlias,
                      builder: (_) => LpgmStationDetailSheet(station: station),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.designSystem.colorTheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        station.station.name.ja,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
