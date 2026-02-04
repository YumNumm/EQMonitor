import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:flutter/material.dart';

class EarthquakeHistoryParameterPersistentDelegate
    extends SliverPersistentHeaderDelegate {
  const EarthquakeHistoryParameterPersistentDelegate({
    required this.parameter,
    required this.onChanged,
  });

  final EarthquakeHistoryParameter parameter;
  final void Function(EarthquakeHistoryParameter) onChanged;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _SearchParameter(
      parameter: parameter,
      onChanged: onChanged,
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _SearchParameter extends StatelessWidget {
  const _SearchParameter({required this.parameter, required this.onChanged});

  final EarthquakeHistoryParameter parameter;
  final void Function(EarthquakeHistoryParameter) onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children:
              [
                    IntensityFilterChip(
                      min: parameter.intensityGte,
                      max: parameter.intensityLte,
                      onChanged: (min, max) =>
                          onChanged(parameter.updateIntensity(min, max)),
                    ),
                    MagnitudeFilterChip(
                      min: parameter.magnitudeGte,
                      max: parameter.magnitudeLte,
                      onChanged: (min, max) =>
                          onChanged(parameter.updateMagnitude(min, max)),
                    ),
                    DepthFilterChip(
                      min: parameter.depthGte,
                      max: parameter.depthLte,
                      onChanged: (min, max) => onChanged(
                        parameter.updateDepth(min, max),
                      ),
                    ),
                    StatusFilterChip(
                      statuses: parameter.statuses,
                      onChanged: (statuses) => onChanged(
                        parameter.updateStatuses(statuses),
                      ),
                    ),
                  ]
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: e,
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
