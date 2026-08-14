import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_observation_station_tile.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class TsunamiRegionList extends StatelessWidget {
  const TsunamiRegionList({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByWarningKind(tsunami.regions);
    if (grouped.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final entry in grouped.entries) ...[
            _WarningGroupHeader(kind: entry.key),
            for (final region in entry.value)
              _ForecastRegionCard(region: region),
          ],
        ],
      ),
    );
  }

  static Map<TsunamiWarningKind, List<TsunamiRegion>> _groupByWarningKind(
    List<TsunamiRegion> regions,
  ) {
    final grouped = <TsunamiWarningKind, List<TsunamiRegion>>{};
    const order = [
      TsunamiWarningKind.majorWarning,
      TsunamiWarningKind.warning,
      TsunamiWarningKind.advisory,
      TsunamiWarningKind.forecast,
    ];
    for (final kind in order) {
      final matching = regions.where((r) => r.kind == kind).toList();
      if (matching.isNotEmpty) {
        grouped[kind] = matching;
      }
    }
    return grouped;
  }
}

class _WarningGroupHeader extends StatelessWidget {
  const _WarningGroupHeader({required this.kind});

  final TsunamiWarningKind kind;

  @override
  Widget build(BuildContext context) {
    final headerColor = TsunamiWarningColor.headerColor(kind);

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: headerColor, width: 4)),
          color: headerColor.withValues(alpha: 0.1),
        ),
        child: Text(
          TsunamiWarningColor.displayName(kind),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: headerColor,
          ),
        ),
      ),
    );
  }
}

class _ForecastRegionCard extends StatelessWidget {
  const _ForecastRegionCard({required this.region});

  final TsunamiRegion region;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final observedStations = region.stations
        .where(
          (s) => switch (s.observation) {
            final observation? => observation.firstHeight.isMissing != true,
            null => false,
          },
        )
        .toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              region.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: designSystem.colorTheme.onSurface,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: _ForecastDetails(region: region),
          ),
          if (observedStations.isNotEmpty)
            _ObservationExpansion(stations: observedStations),
          if (observedStations.isEmpty) const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ForecastDetails extends StatelessWidget {
  const _ForecastDetails({required this.region});

  final TsunamiRegion region;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final parts = <String>[];

    final forecast = region.forecast;
    if (forecast != null) {
      final mh = forecast.maxHeight;
      if (mh != null) {
        if (mh.qualitative != null) {
          parts.add(
            '予想最大波高: ${switch (mh.qualitative!) {
              QualitativeHeight.enormous => '巨大',
              QualitativeHeight.high => '高い',
            }}',
          );
        } else if (mh.value != null) {
          final valueStr = '${mh.value}m';
          parts.add(
            '予想最大波高: ${(mh.isOver ?? false) ? '$valueStr超' : valueStr}',
          );
        }
      }

      final fh = forecast.firstHeight;
      if (fh != null) {
        if (fh.condition != null) {
          parts.add(
            '到達予想: ${switch (fh.condition!) {
              FirstHeightCondition.arriving => '第一波到達中',
              FirstHeightCondition.firstWaveConfirmed => '第一波確認',
              FirstHeightCondition.imminent => 'まもなく到達',
            }}',
          );
        } else if (fh.arrivalTime != null) {
          parts.add(
            '到達予想: ${DateFormat('HH:mm').format(fh.arrivalTime!.toLocal())}頃',
          );
        }
      }
    }

    if (parts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        parts.join('\n'),
        style: TextStyle(
          fontSize: 13,
          color: designSystem.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ObservationExpansion extends HookWidget {
  const _ObservationExpansion({required this.stations});

  final List<TsunamiRegionStation> stations;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final expanded = useState(false);

    if (stations.isEmpty) {
      return const SizedBox(height: 8);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => expanded.value = !expanded.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(
                  expanded.value ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: designSystem.colorTheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '観測点を表示 (${stations.length})',
                  style: TextStyle(
                    fontSize: 13,
                    color: designSystem.colorTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded.value)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final station in stations)
                  TsunamiObservationStationTile(station: station),
              ],
            ),
          ),
      ],
    );
  }
}
