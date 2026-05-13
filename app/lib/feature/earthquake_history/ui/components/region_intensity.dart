import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_map_focus.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_focus_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeIntensityWidget extends ConsumerWidget {
  const EarthquakeIntensityWidget({
    required this.item,
    super.key,
  });

  final Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorModel = ref.watch(intensityColorProvider);
    final intensity = item.intensity;

    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final intensityTree = intensity.intensityTree;
    final regions = intensity.regions;
    if (intensityTree.isEmpty) {
      return BorderedContainer(
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: SheetHeader(
                    title: '各地の震度',
                  ),
                ),
                RawChip(
                  label: const Text('速報'),
                  color: WidgetStatePropertyAll(Colors.red.shade700),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: .bold,
                  ),
                ),
              ],
            ),
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
                  dividerColor: colorModel
                      .fromJmaIntensity(entry.key)
                      .background,
                ),
              ),
          ],
        ),
      );
    } else {
      return BorderedContainer(
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            const SheetHeader(
              title: '各地の震度',
            ),
            ...intensityTree.entries.map(
              (entry) => _IntensityLevelSection(
                intensity: entry.key,
                prefectures: entry.value,
                eventId: item.eventId,
                dividerColor: colorModel.fromJmaIntensity(entry.key).background,
              ),
            ),
          ],
        ),
      );
    }
  }
}

/// 速報値（細分区域単位）の震度レベル別セクション。
/// 市区町村以下のデータがまだ無いため、震度速報の細分区域名を一覧表示する。
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
    final regionNames = regions.map((e) => e.region.name.ja).join('、');

    return ListTile(
      dense: true,
      isThreeLine: true,
      visualDensity: VisualDensity.compact,
      titleAlignment: ListTileTitleAlignment.titleHeight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: JmaIntensityIcon(
        intensity: intensity,
        type: .filled,
        size: 40,
      ),
      title: Row(
        children: [
          Text(
            '震度${intensity.mainText}',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: dividerColor.withValues(alpha: 0.15),
              border: Border.all(color: dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '速報値',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.notoSansJP,
              ),
            ),
          ),
        ],
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
    );
  }
}

/// 震度レベル別のセクション（例: 震度5弱）。
/// City以下のデータがある場合はインラインで展開可能。ない場合は速報震度として折りたたみなし。
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
        .join('、');

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
            '震度${intensity.mainText}',
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

/// 都道府県単位のタイル。
/// cities が空の場合（速報震度のみ）は展開不可。そうでない場合は市区町村ツリーを展開。
class _PrefectureTile extends HookWidget {
  const _PrefectureTile({
    required this.prefecture,
    required this.eventId,
  });

  final PrefectureIntensityNode prefecture;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasCities = prefecture.cities.isNotEmpty;

    final mapButton = _MapFocusButton(
      eventId: eventId,
      focus: EarthquakeIntensityMapFocus(
        kind: EarthquakeIntensityMapFocusKind.prefectureRegion,
        code: prefecture.prefecture.prefecture.code,
      ),
    );

    final trailing = _buildTrailing(
      hasChildren: hasCities,
      isExpanded: isExpanded.value,
      mapButton: mapButton,
    );

    return Column(
      children: [
        ListTile(
          visualDensity: .compact,
          dense: true,
          contentPadding: const .only(left: 8, right: 8),
          title: Text(
            prefecture.prefecture.prefecture.name.ja,
            style: const TextStyle(
              fontWeight: .bold,
            ),
          ),
          trailing: trailing,
          onTap: hasCities ? () => isExpanded.value = !isExpanded.value : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const .only(left: 8),
            child: Column(
              children: prefecture.cities
                  .map(
                    (city) => _CityTile(city: city, eventId: eventId),
                  )
                  .toList(),
            ),
          )
        else
          const SizedBox.shrink(),
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
      crossAxisAlignment: .start,
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          dense: true,
          title: Text(
            city.city.name.ja,
            style: const TextStyle(),
          ),
          trailing: trailing,
          onTap: hasStations
              ? () => isExpanded.value = !isExpanded.value
              : null,
        ),
        if (isExpanded.value)
          Padding(
            padding: const .only(left: 32),
            child: Text(
              city.stations
                  .map(
                    (station) => station.station.name.ja,
                  )
                  .join(', '),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
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
