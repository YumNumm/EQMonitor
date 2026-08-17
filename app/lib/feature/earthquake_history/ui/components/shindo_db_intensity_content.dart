import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/expand_trailing_icon_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_station_detail_sheet.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShindoDbIntensityContent extends HookWidget {
  const new({required this.tree, super.key});

  final ShindoDbIntensityTree tree;

  @override
  Widget build(BuildContext context) {
    final intensityColors = context.designSystem.colorTheme.intensity;

    final allKeys = useMemoized(() {
      final keys = <ShindoDbIntensityClass>{
        ...tree.tree.keys,
        ...tree.unresolvedStations.keys,
      }.toList()..sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
      return keys;
    }, [tree.tree, tree.unresolvedStations]);

    if (allKeys.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          '震度データベースの観測点データはありません',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    return Column(
      children: allKeys.map((intensityClass) {
        final prefectures = tree.tree[intensityClass] ?? [];
        final unresolved = tree.unresolvedStations[intensityClass] ?? [];
        final colorJma = intensityClass.colorJmaIntensity;
        final dividerColor = colorJma != null
            ? intensityColors.fromJmaIntensity(colorJma).background
            : context.designSystem.colorTheme.surfaceContainerHighest;

        return _ShindoDbIntensityLevelSection(
          intensityClass: intensityClass,
          prefectures: prefectures,
          unresolvedStations: unresolved,
          dividerColor: dividerColor,
        );
      }).toList(),
    );
  }
}

class _ShindoDbIntensityLevelSection extends HookWidget {
  const new({
    required this.intensityClass,
    required this.prefectures,
    required this.unresolvedStations,
    required this.dividerColor,
  });

  final ShindoDbIntensityClass intensityClass;
  final List<ShindoDbPrefectureNode> prefectures;
  final List<ShindoDbStationNode> unresolvedStations;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final canExpand =
        prefectures.any((p) => p.cities.isNotEmpty) ||
        unresolvedStations.isNotEmpty;

    final theme = Theme.of(context);
    final prefectureNames = prefectures
        .map((e) => e.prefecture.name.ja)
        .join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          isThreeLine: true,
          visualDensity: VisualDensity.compact,
          titleAlignment: ListTileTitleAlignment.titleHeight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: ShindoDbIntensityClassIcon(
            intensityClass: intensityClass,
            size: 40,
          ),
          title: Text(
            intensityClass.sectionTitle,
            style: theme.textTheme.titleSmall,
          ),
          subtitle: Text(
            prefectureNames,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: FontFamily.notoSansJP,
              fontSize: 13,
            ),
          ),
          trailing: canExpand
              ? AnimatedRotation(
                  turns: isExpanded.value ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.expand_more),
                )
              : null,
          onTap: canExpand ? () => isExpanded.value = !isExpanded.value : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const EdgeInsets.only(left: 8),
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
                      children: [
                        ...prefectures.map(
                          (prefecture) =>
                              _ShindoDbPrefectureTile(prefecture: prefecture),
                        ),
                        if (unresolvedStations.isNotEmpty)
                          _ShindoDbUnresolvedTile(stations: unresolvedStations),
                      ],
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

class _ShindoDbPrefectureTile extends HookWidget {
  const new({required this.prefecture});

  final ShindoDbPrefectureNode prefecture;

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
          visualDensity: VisualDensity.compact,
          dense: true,
          contentPadding: const EdgeInsets.only(left: 8, right: 8),
          title: Text(
            prefecture.prefecture.name.ja,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: trailing,
          onTap: hasCities ? () => isExpanded.value = !isExpanded.value : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              children: prefecture.cities
                  .map((city) => _ShindoDbCityTile(city: city))
                  .toList(),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _ShindoDbCityTile extends HookWidget {
  const new({required this.city});

  final ShindoDbCityNode city;

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
          _ShindoDbStationChips(stations: city.stations)
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _ShindoDbUnresolvedTile extends HookWidget {
  const new({required this.stations});

  final List<ShindoDbStationNode> stations;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final trailing = const ExpandTrailingIconBuilder().build(
      hasChildren: true,
      isExpanded: isExpanded.value,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          dense: true,
          contentPadding: const EdgeInsets.only(left: 8, right: 8),
          title: const Text(
            '市区町村不明',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: trailing,
          onTap: () => isExpanded.value = !isExpanded.value,
        ),
        if (isExpanded.value)
          _ShindoDbStationChips(stations: stations)
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _ShindoDbStationChips extends StatelessWidget {
  const new({required this.stations});

  final List<ShindoDbStationNode> stations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 8, bottom: 4),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: stations.map((station) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => showModalBottomSheet<void>(
                context: context,
                clipBehavior: Clip.antiAlias,
                builder: (_) => ShindoDbStationDetailSheet(station: station),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.designSystem.colorTheme.outlineVariant,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(station.name, style: const TextStyle(fontSize: 12)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
