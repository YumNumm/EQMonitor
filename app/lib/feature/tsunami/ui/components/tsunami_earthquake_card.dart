// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

class TsunamiEarthquakeCard extends StatelessWidget {
  const TsunamiEarthquakeCard({
    required this.earthquake,
    required this.eventIds,
    super.key,
  });

  final TsunamiStateEarthquake earthquake;
  final List<String> eventIds;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final hypo = earthquake.hypocenter;

    final magnitudeStr = hypo.magnitude.type == MagnitudeType.normal
        ? 'M${hypo.magnitude.value}'
        : 'M不明';
    final depthStr = hypo.depth.type == DepthType.normal
        ? '深さ${hypo.depth.value}km'
        : '深さ不明';
    final timeStr = DateFormat(
      'yyyy/MM/dd HH:mm',
    ).format(earthquake.originTime.toLocal());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorTheme.outlineVariant),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: eventIds.isNotEmpty
              ? () => EarthquakeHistoryDetailsRoute(
                  eventId: eventIds.first,
                ).push<void>(context)
              : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hypo.name ?? '', // TODO: 名前がない場合のUIを決める
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: designSystem.colorTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$timeStr  $magnitudeStr  $depthStr',
                  style: TextStyle(
                    fontSize: 13,
                    color: designSystem.colorTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
