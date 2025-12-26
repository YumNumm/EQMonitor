import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/lpgm_intensity_icon.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/route.dart';

class PrefectureLpgmIntensityWidget extends HookConsumerWidget {
  const PrefectureLpgmIntensityWidget({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensity = item.intensity;

    if (intensity == null || intensity.lpgmPrefectures == null) {
      return const SizedBox.shrink();
    }

    final groupedByLpgmIntensity = intensity.lpgmPrefectures!
        .where((p) => p.maxLpgmIntensity != null)
        .groupListsBy((p) => p.maxLpgmIntensity!)
        .entries
        .sorted((a, b) => b.key.index.compareTo(a.key.index));

    if (groupedByLpgmIntensity.isEmpty) {
      return const SizedBox.shrink();
    }

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          const SheetHeader(title: '各地の長周期地震動観測状況'),
          for (final kv in groupedByLpgmIntensity) ...[
            ListTile(
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: LpgmIntensityIcon(
                intensity: kv.key,
                type: IntensityIconType.filled,
              ),
              title: Text(
                '長周期地震動階級${kv.key.value}',
                style: textTheme.titleMedium,
              ),
              subtitle: Text(kv.value.map((e) => e.value.name).join(', ')),
              onTap: intensity.lpgmStations != null
                  ? () async => _PrefectureModalBottomSheet.show(
                        context: context,
                        lpgmIntensity: kv.key,
                        prefectures: kv.value,
                        stations: intensity.lpgmStations,
                      )
                  : null,
              trailing: intensity.lpgmStations != null
                  ? const Icon(Icons.chevron_right)
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}

class _PrefectureModalBottomSheet extends StatelessWidget {
  const _PrefectureModalBottomSheet({
    required this.lpgmIntensity,
    required this.prefectures,
    required this.stations,
  });

  static Future<void> show({
    required BuildContext context,
    required LpgmIntensityValue lpgmIntensity,
    required List<IntensityItem> prefectures,
    required List<IntensityItem>? stations,
  }) =>
      Navigator.of(context).push(
        SheetRoute(
          builder: (context) => _PrefectureModalBottomSheet(
            lpgmIntensity: lpgmIntensity,
            prefectures: prefectures,
            stations: stations,
          ),
        ),
      );

  final LpgmIntensityValue lpgmIntensity;
  final List<IntensityItem> prefectures;
  final List<IntensityItem>? stations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('長周期地震動階級$lpgmIntensityの観測点')),
      body: ListView(
        children: [
          for (final prefecture in prefectures)
            _PrefectureListTile(
              prefecture: prefecture,
              stations: stations,
            ),
        ],
      ),
    );
  }
}

class _PrefectureListTile extends HookWidget {
  const _PrefectureListTile({
    required this.prefecture,
    required this.stations,
  });

  final IntensityItem prefecture;
  final List<IntensityItem>? stations;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final prefectureCode = prefecture.value.code;

    final relatedStations = stations
            ?.where((s) => s.value.code.startsWith(prefectureCode))
            .toList() ??
        [];

    final shrinked = ListTile(
      title: Text(
        prefecture.value.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: relatedStations.isNotEmpty ? const Icon(Icons.expand_more) : null,
      onTap:
          relatedStations.isNotEmpty ? () => isExpanded.value = true : null,
    );

    final expanded = ListTile(
      title: Text(
        prefecture.value.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(relatedStations.map((e) => e.value.name).join(', ')),
      onTap: () => isExpanded.value = false,
      trailing: const Icon(Icons.expand_less),
    );

    if (relatedStations.isEmpty) {
      return shrinked;
    }

    return AnimatedCrossFade(
      firstChild: shrinked,
      secondChild: expanded,
      crossFadeState:
          isExpanded.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
