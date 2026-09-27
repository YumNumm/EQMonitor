import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/selector/dropdown_menu_chip.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/estimated_intensity_notice_content.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_content.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeIntensityCard extends StatelessWidget {
  const new({
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
              crossAxisAlignment: .start,
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
                      child: AccessibleCircularProgressIndicator(),
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

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          if (availableModes.length > 1)
            Padding(
              padding: const EdgeInsets.all(8),
              child: DropdownMenuChip<IntensityDisplayMode>(
                label: switch (displayMode) {
                  .jma => '各地の震度',
                  .lpgm => '長周期地震動階級',
                  .estimated => '推計震度',
                },
                value: displayMode,
                entries: [
                  for (final mode in availableModes)
                    DropdownMenuChipEntry(
                      value: mode,
                      label: switch (mode) {
                        .jma => '各地の震度',
                        .lpgm => '長周期地震動階級',
                        .estimated => '推計震度',
                      },
                    ),
                ],
                onSelected: onDisplayModeChanged,
              ),
            )
          else
            SheetHeader(title: title),
          switch (displayMode) {
            .jma => JmaIntensityContent(item: item),
            .lpgm => LpgmIntensityContent(item: item),
            .estimated => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: EstimatedIntensityNoticeContent(),
            ),
          },
        ],
      ),
    );
  }
}
