// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
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

  static bool _isFirstHeightMissing(TsunamiStationObservationFirstHeight fh) =>
      fh.isMissing ?? false;

  static String _formatFirstHeight(TsunamiStationObservationFirstHeight fh) {
    if (fh.isUnidentifiable ?? false) {
      return '第一波: 識別不能';
    }
    final timePart = fh.arrivalTime != null
        ? DateFormat('HH:mm').format(fh.arrivalTime!.toLocal())
        : '--:--';
    final initialPart = switch (fh.initial) {
      WaveInitial.push => ' (押し)',
      WaveInitial.pull => ' (引き)',
      null => '',
    };
    return '第一波: $timePart到達$initialPart';
  }

  static String _formatMaxHeight(TsunamiStationObservationMaxHeight mh) {
    final parts = <String>['最大波:'];
    if (mh.value != null) {
      final valueStr = '${mh.value}m';
      parts.add((mh.isOver ?? false) ? '$valueStr超' : valueStr);
    } else if (mh.condition != null) {
      parts.add(switch (mh.condition!) {
        ObservationMaxHeightCondition.minor => '微弱',
        ObservationMaxHeightCondition.observing => '観測中',
        ObservationMaxHeightCondition.important => '重要',
      });
    }
    if (mh.observedAt != null) {
      parts.add('(${DateFormat('HH:mm').format(mh.observedAt!.toLocal())})');
    }
    if (mh.isRising == true) {
      parts.add('上昇中');
    }
    return parts.join(' ');
  }

  static bool _isImportant(TsunamiStationObservationMaxHeight mh) =>
      mh.condition == ObservationMaxHeightCondition.important;
}
