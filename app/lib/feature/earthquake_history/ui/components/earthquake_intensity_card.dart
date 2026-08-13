import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/collapsible_segmented_control.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/estimated_intensity_notice_content.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_content.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeIntensityCard extends StatelessWidget {
  const EarthquakeIntensityCard({
    required this.item,
    required this.displayMode,
    required this.onDisplayModeChanged,
    required this.availableModes,
    required this.source,
    required this.showDatabaseBadge,
    super.key,
  });

  final Earthquake item;
  final IntensityDisplayMode displayMode;
  final ValueChanged<IntensityDisplayMode> onDisplayModeChanged;
  final List<IntensityDisplayMode> availableModes;
  final EarthquakeDataSource source;
  final bool showDatabaseBadge;

  @override
  Widget build(BuildContext context) {
    final showingDb = source == EarthquakeDataSource.jmaIntensityDatabase;
    final intensity = item.intensity;

    if (intensity == null && !showingDb) {
      return const SizedBox.shrink();
    }

    if (showingDb) {
      return Consumer(
        builder: (context, ref, _) {
          final treeAsync = ref.watch(
            shindoDbIntensityTreeProvider(item.eventId),
          );
          return BorderedContainer(
            elevation: 1,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: SheetHeader(title: '各地の震度')),
                    if (showDatabaseBadge)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'データベース',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: context
                                    .designSystem
                                    .colorTheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ),
                  ],
                ),
                switch (treeAsync) {
                  AsyncData(:final value) =>
                    value != null
                        ? ShindoDbIntensityContent(tree: value)
                        : const SizedBox.shrink(),
                  AsyncError() => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text('震度データベースの読み込みに失敗しました'),
                  ),
                  _ => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                },
              ],
            ),
          );
        },
      );
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
            .estimated => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: EstimatedIntensityNoticeContent(),
            ),
          },
        ],
      ),
    );
  }
}
