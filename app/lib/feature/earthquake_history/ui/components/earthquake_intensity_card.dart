import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/collapsible_segmented_control.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_intensity.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';

class EarthquakeIntensityCard extends StatelessWidget {
  const EarthquakeIntensityCard({
    required this.item,
    required this.displayMode,
    required this.onDisplayModeChanged,
    required this.availableModes,
    super.key,
  });

  final Earthquake item;
  final IntensityDisplayMode displayMode;
  final ValueChanged<IntensityDisplayMode> onDisplayModeChanged;
  final List<IntensityDisplayMode> availableModes;

  @override
  Widget build(BuildContext context) {
    final intensity = item.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final title = switch (displayMode) {
      .jma => '各地の震度',
      .lpgm => '各地の長周期地震動階級',
      .estimated => '推計震度',
    };

    final segments = availableModes
        .map(
          (m) => SegmentItem(
            value: m,
            label: switch (m) {
              .jma => '各地の震度',
              .lpgm => '長周期階級',
              .estimated => '推計震度',
            },
          ),
        )
        .toList();

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Stack(
            alignment: .centerRight,
            children: [
              SheetHeader(title: title),
              if (segments.length > 1)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: CollapsibleSegmentedControl<IntensityDisplayMode>(
                    segments: segments,
                    selected: displayMode,
                    onSelected: onDisplayModeChanged,
                  ),
                ),
            ],
          ),
          switch (displayMode) {
            .jma => JmaIntensityContent(item: item),
            .lpgm => LpgmIntensityContent(item: item),
            .estimated => const SizedBox(
              height: 32,
              width: .infinity,
              child: Placeholder(
                strokeWidth: 1,
              ),
            ),
          },
        ],
      ),
    );
  }
}
