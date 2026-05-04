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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeIntensityWidget extends StatelessWidget {
  const EarthquakeIntensityWidget({
    required this.item,
    this.eventId,
    super.key,
  });

  final Earthquake item;
  final String? eventId;

  @override
  Widget build(BuildContext context) {
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
            (entry) => _IntensityLevelSection(
              intensity: entry.key,
              prefectures: entry.value,
              eventId: eventId,
            ),
          ),
        ],
      ),
    );
  }
}

/// 震度レベル別のセクション（例: 震度5弱）。
/// City以下のデータがある場合はインラインで展開可能。ない場合は速報震度として折りたたみなし。
class _IntensityLevelSection extends HookWidget {
  const _IntensityLevelSection({
    required this.intensity,
    required this.prefectures,
    required this.eventId,
  });

  final JmaIntensity intensity;
  final List<PrefectureIntensityNode> prefectures;
  final String? eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final theme = Theme.of(context);
    // City以下の要素がひとつでもあれば展開可能
    final hasCityData = prefectures.any((p) => p.cities.isNotEmpty);
    final regionNames = prefectures.map((e) => e.region.region.name).join('、');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          isThreeLine: true,
          visualDensity: VisualDensity.compact,
          titleAlignment: ListTileTitleAlignment.titleHeight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: IntensityValueIcon(
            intensity: intensity,
            type: IntensityIconType.filled,
            size: 40,
          ),
          title: Text(
            '震度${intensity.label}',
            style: theme.textTheme.titleMedium,
          ),
          subtitle: Text(
            regionNames,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
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
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: isExpanded.value
              ? Column(
                  children: [
                    for (final prefecture in prefectures)
                      _PrefectureTile(
                        prefecture: prefecture,
                        eventId: eventId,
                      ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// 都道府県単位のタイル。
/// cities が空の場合（速報震度のみ）は展開不可。そうでない場合は市区町村ツリーを展開。
class _PrefectureTile extends HookWidget {
  const _PrefectureTile({
    required this.prefecture,
    required this.eventId,
  });

  final PrefectureIntensityNode prefecture;
  final String? eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasCities = prefecture.cities.isNotEmpty;

    final mapButton = eventId != null
        ? _MapFocusButton(
            eventId: eventId!,
            focus: EarthquakeIntensityMapFocus(
              kind: EarthquakeIntensityMapFocusKind.prefectureRegion,
              code: prefecture.region.region.code,
            ),
          )
        : null;

    final trailing = _buildTrailing(
      hasChildren: hasCities,
      isExpanded: isExpanded.value,
      mapButton: mapButton,
    );

    return Column(
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          contentPadding: const EdgeInsets.only(left: 20, right: 8),
          leading: _IntensityLpgmBadgeRow(
            maxIntensity: prefecture.region.maxIntensity,
            maxLpgm: null,
            intensityIconSize: 28,
          ),
          title: Text(
            prefecture.region.region.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: trailing,
          onTap: hasCities ? () => isExpanded.value = !isExpanded.value : null,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: isExpanded.value
              ? Column(
                  children: [
                    for (final city in prefecture.cities)
                      _CityTile(city: city, eventId: eventId),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// 市区町村単位のタイル。stations がある場合は観測点ツリーを展開。
class _CityTile extends HookWidget {
  const _CityTile({
    required this.city,
    required this.eventId,
  });

  final CityIntensityNode city;
  final String? eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasStations = city.stations.isNotEmpty;

    final mapButton = eventId != null
        ? _MapFocusButton(
            eventId: eventId!,
            focus: EarthquakeIntensityMapFocus(
              kind: EarthquakeIntensityMapFocusKind.city,
              code: city.city.code,
            ),
          )
        : null;

    final trailing = _buildTrailing(
      hasChildren: hasStations,
      isExpanded: isExpanded.value,
      mapButton: mapButton,
    );

    return Column(
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          contentPadding: const EdgeInsets.only(left: 32, right: 8),
          leading: _IntensityLpgmBadgeRow(
            maxIntensity: city.maxIntensity,
            maxLpgm: city.maxLpgmIntensity,
            intensityIconSize: 24,
            lpgmIconSize: 22,
          ),
          title: Text(
            city.city.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: trailing,
          onTap: hasStations ? () => isExpanded.value = !isExpanded.value : null,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: isExpanded.value
              ? Column(
                  children: [
                    for (final station in city.stations)
                      _StationTile(station: station, eventId: eventId),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// 観測点単位のタイル。
class _StationTile extends StatelessWidget {
  const _StationTile({
    required this.station,
    required this.eventId,
  });

  final StationIntensityNode station;
  final String? eventId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.only(left: 44, right: 8),
      leading: _IntensityLpgmBadgeRow(
        maxIntensity: station.intensity?.maxIntensity,
        maxLpgm: station.intensity?.maxLpgmIntensity,
        intensityIconSize: 18,
        lpgmIconSize: 16,
      ),
      title: Text(
        station.station.name,
        style: TextStyle(
          fontSize: 13,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: eventId != null
          ? _MapFocusButton(
              eventId: eventId!,
              focus: EarthquakeIntensityMapFocus(
                kind: EarthquakeIntensityMapFocusKind.station,
                code: station.station.code,
              ),
            )
          : null,
    );
  }
}

/// 地図フォーカスボタン。タップで地図の表示範囲を指定箇所へ移動する。
class _MapFocusButton extends ConsumerWidget {
  const _MapFocusButton({
    required this.eventId,
    required this.focus,
  });

  final String eventId;
  final EarthquakeIntensityMapFocus focus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: '地図で表示',
      icon: const Icon(Icons.map_outlined, size: 20),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      onPressed: () {
        ref
            .read(earthquakeHistoryMapFocusProvider(eventId).notifier)
            .select(focus);
      },
    );
  }
}

/// trailing に地図ボタンと展開アイコンを組み合わせるヘルパー。
Widget? _buildTrailing({
  required bool hasChildren,
  required bool isExpanded,
  Widget? mapButton,
}) {
  if (!hasChildren && mapButton == null) {
    return null;
  }
  if (!hasChildren) {
    return mapButton;
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ?mapButton,
      AnimatedRotation(
        turns: isExpanded ? 0.5 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: const Icon(Icons.expand_more),
      ),
    ],
  );
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
