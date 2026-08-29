import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state_earthquake.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/depth_type.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/magnitude_type.dart';
import 'package:material_ui/material_ui.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';

class TsunamiEarthquakeCard extends StatelessWidget {
  const new({
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

    final magnitudeStr = hypo.magnitudeType == MagnitudeType.normal
        ? 'M${hypo.magnitudeValue}'
        : 'M不明';
    final depthStr = hypo.depthType == DepthType.normal
        ? '深さ${hypo.depthValue}km'
        : '深さ不明';
    final timeStr = earthquake.originTime.formatWithTz(
      DateTimeFormat.yearMonthDayHourMinute,
    );

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
              ? () =>
                    EarthquakeHistoryDetailsRoute(eventId: eventIds.first)
                        .push<void>(context)
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
