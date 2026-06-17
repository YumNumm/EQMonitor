import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiObservationStationTile extends StatelessWidget {
  const TsunamiObservationStationTile({required this.station, super.key});

  final TsunamiObservationStation station;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final firstHeight = station.firstHeight;
    final maxHeight = station.maxHeight;

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
              color: designSystem.textColor.primary,
            ),
          ),
          const SizedBox(height: 2),
          if (!_isFirstHeightMissing(firstHeight))
            Text(
              _formatFirstHeight(firstHeight),
              style: TextStyle(
                fontSize: 13,
                color: designSystem.textColor.secondary,
              ),
            ),
          if (maxHeight != null && !(maxHeight.isMissing ?? false))
            Text(
              _formatMaxHeight(maxHeight),
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    _isImportant(maxHeight) ? FontWeight.bold : null,
                color: _isImportant(maxHeight)
                    ? const Color(0xFFB31A1A)
                    : designSystem.textColor.secondary,
              ),
            ),
        ],
      ),
    );
  }

  static bool _isFirstHeightMissing(
    TsunamiObservationStationFirstHeight fh,
  ) =>
      fh.isMissing ?? false;

  static String _formatFirstHeight(
    TsunamiObservationStationFirstHeight fh,
  ) {
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

  static String _formatMaxHeight(TsunamiObservationStationMaxHeight mh) {
    final parts = <String>['最大波:'];
    if (mh.value != null) {
      final valueStr = '${mh.value}m';
      parts.add(mh.over == true ? '$valueStr超' : valueStr);
    } else if (mh.condition != null) {
      parts.add(
        switch (mh.condition!) {
          ObservationMaxHeightCondition.minor => '微弱',
          ObservationMaxHeightCondition.observing => '観測中',
          ObservationMaxHeightCondition.important => '重要',
        },
      );
    }
    if (mh.dateTime != null) {
      parts.add(
        '(${DateFormat('HH:mm').format(mh.dateTime!.toLocal())})',
      );
    }
    if (mh.isRising == true) {
      parts.add('上昇中');
    }
    return parts.join(' ');
  }

  static bool _isImportant(TsunamiObservationStationMaxHeight mh) =>
      mh.condition == ObservationMaxHeightCondition.important;
}
