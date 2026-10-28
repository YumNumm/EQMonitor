import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_intensity_region_model.dart';
import 'package:material_ui/material_ui.dart';

class LpgmIntensityRegionList extends StatelessWidget {
  const new({required this.regions, this.previousRegions, super.key});

  final List<EarthquakeTelegramBodyIntensityRegionModel> regions;
  final List<EarthquakeTelegramBodyIntensityRegionModel>? previousRegions;

  @override
  Widget build(BuildContext context) {
    final grouped = groupBy(
      [
        for (final region in regions)
          if (region.lpgmIntensity case final intensity?)
            (region: region, intensity: intensity),
      ],
      (entry) => entry.intensity,
    );
    final intensities = grouped.keys.sorted(
      (a, b) => b.orderIndex.compareTo(a.orderIndex),
    );
    final previousByCode = {
      for (final region
          in previousRegions ??
              const <EarthquakeTelegramBodyIntensityRegionModel>[])
        region.code: region.lpgmIntensity,
    };

    return Column(
      crossAxisAlignment: .start,
      children: [
        for (final intensity in intensities)
          if (grouped[intensity] case final entries?)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  Semantics(
                    label: '長周期地震動階級${intensity.label}',
                    excludeSemantics: true,
                    child: JmaLpgmIntensityIcon(
                      intensity: intensity,
                      type: .filled,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 2,
                      children: [
                        for (final entry in entries)
                          _LpgmRegionChip(
                            name: entry.region.name,
                            intensity: intensity,
                            previousIntensity:
                                previousByCode[entry.region.code],
                            hasPrevious: previousRegions?.isNotEmpty ?? false,
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

class _LpgmRegionChip extends StatelessWidget {
  const new({
    required this.name,
    required this.intensity,
    required this.previousIntensity,
    required this.hasPrevious,
  });

  final String name;
  final JmaLpgmIntensity intensity;
  final JmaLpgmIntensity? previousIntensity;
  final bool hasPrevious;

  @override
  Widget build(BuildContext context) {
    final previous = previousIntensity;
    final annotation = switch (previous) {
      _ when !hasPrevious || previous == intensity => '',
      null => '(追加)',
      _ when intensity.orderIndex > previous.orderIndex =>
        '(階級${previous.label}↑)',
      _ => '(階級${previous.label}↓)',
    };
    final style = Theme.of(context).textTheme.bodySmall;
    return Text(
      '$name$annotation',
      style: annotation.isEmpty ? style : style?.copyWith(fontWeight: .bold),
    );
  }
}
