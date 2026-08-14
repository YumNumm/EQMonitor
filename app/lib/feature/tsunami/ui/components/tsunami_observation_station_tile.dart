import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/observation_max_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/wave_initial.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

class TsunamiObservationStationTile extends StatelessWidget {
  const TsunamiObservationStationTile({required this.station, super.key});

  final TsunamiRegionStation station;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final observation = station.observation;
    final firstHeight = observation?.firstHeight;
    final maxHeight = observation?.maxHeight;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: designSystem.colorTheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          if (firstHeight != null && !_isFirstHeightMissing(firstHeight))
            Text(
              _formatFirstHeight(firstHeight),
              style: TextStyle(
                fontSize: 13,
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
          if (maxHeight != null && !(maxHeight.isMissing ?? false))
            Text(
              _formatMaxHeight(maxHeight),
              style: TextStyle(
                fontSize: 13,
                fontWeight: _isImportant(maxHeight) ? FontWeight.bold : null,
                color: _isImportant(maxHeight)
                    ? const Color(0xFFB31A1A)
                    : designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }

  static bool _isFirstHeightMissing(TsunamiObservationFirstHeight fh) =>
      fh.isMissing ?? false;

  static String _formatFirstHeight(TsunamiObservationFirstHeight fh) {
    if (fh.isUnidentifiable ?? false) {
      return '第一波: 識別不能';
    }
    final timePart = switch (fh.arrivalTime) {
      final arrivalTime? => DateFormat('HH:mm').format(arrivalTime.toLocal()),
      null => '--:--',
    };
    final initialPart = switch (fh.initial) {
      WaveInitial.push => ' (押し)',
      WaveInitial.pull => ' (引き)',
      null => '',
    };
    return '第一波: $timePart到達$initialPart';
  }

  static String _formatMaxHeight(TsunamiObservationMaxHeight mh) {
    final parts = <String>['最大波:'];
    final condition = mh.condition;
    if (mh.value != null) {
      final valueStr = '${mh.value}m';
      parts.add((mh.isOver ?? false) ? '$valueStr超' : valueStr);
    } else if (condition != null) {
      parts.add(switch (condition) {
        ObservationMaxHeightCondition.minor => '微弱',
        ObservationMaxHeightCondition.observing => '観測中',
        ObservationMaxHeightCondition.important => '重要',
      });
    }
    final dateTime = mh.dateTime;
    if (dateTime != null) {
      parts.add('(${DateFormat('HH:mm').format(dateTime.toLocal())})');
    }
    if (mh.isRising == true) {
      parts.add('上昇中');
    }
    return parts.join(' ');
  }

  static bool _isImportant(TsunamiObservationMaxHeight mh) =>
      mh.condition == ObservationMaxHeightCondition.important;
}
