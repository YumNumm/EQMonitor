import 'package:core/core.dart' show Date;
import 'package:eqmonitor/core/component/chip/date_range_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_warning_filter_chip.dart';
import 'package:flutter/material.dart';

class EewListParameterPersistentDelegate
    extends SliverPersistentHeaderDelegate {
  const EewListParameterPersistentDelegate({
    required this.parameter,
    required this.onChanged,
  });

  final EewListParameter parameter;
  final void Function(EewListParameter) onChanged;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: _FilterChipBar(parameter: parameter, onChanged: onChanged),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant EewListParameterPersistentDelegate old) =>
      parameter != old.parameter;
}

class _FilterChipBar extends StatelessWidget {
  const _FilterChipBar({required this.parameter, required this.onChanged});

  final EewListParameter parameter;
  final void Function(EewListParameter) onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).designSystemThemeExtension.spacing;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          spacing: spacing.sm,
          children: [
            EewWarningFilterChip(
              selected: parameter.isWarning ?? false,
              onChanged: (v) => onChanged(parameter.updateIsWarning(value: v)),
            ),
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
              onChanged: (min, max) =>
                  onChanged(parameter.updateDepth(min, max)),
            ),
            DateRangeFilterChip(
              min: parameter.originTimeGte?.toDateTime(),
              max: parameter.originTimeLte?.toDateTime(),
              onChanged: (min, max) => onChanged(
                parameter.updateOriginTimeRange(
                  min != null ? Date.fromDateTime(min) : null,
                  max != null ? Date.fromDateTime(max) : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
