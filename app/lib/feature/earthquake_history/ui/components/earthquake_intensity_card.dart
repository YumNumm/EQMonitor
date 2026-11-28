import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/selector/dropdown_menu_chip.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/estimated_intensity_display_settings.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/estimated_intensity_notice_content.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_content.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const EarthquakeIntensityCard({
  required final Earthquake item,
  required final IntensityDisplayMode displayMode,
  required final ValueChanged<IntensityDisplayMode> onDisplayModeChanged,
  required final List<IntensityDisplayMode> availableModes,
  required final EarthquakeDataSource source,
  required final bool showDatabaseBadge,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showingDb = source == EarthquakeDataSource.jmaIntensityDatabase;
    final intensity = item.intensity;

    if (intensity == null && !showingDb) {
      return const SizedBox.shrink();
    }

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(
                child: _DisplayModeHeader(
                  displayMode: displayMode,
                  availableModes: availableModes,
                  onDisplayModeChanged: onDisplayModeChanged,
                ),
              ),
              if (showingDb && showDatabaseBadge)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'データベース',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: context.designSystem.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          switch (displayMode) {
            .jma when showingDb => _ShindoDbIntensityBody(
              eventId: item.eventId,
            ),
            .jma => JmaIntensityContent(item: item),
            .lpgm => LpgmIntensityContent(item: item),
            .estimated => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 12,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: EstimatedIntensityDisplaySettings(
                      hasDemArchive: item.estimatedIntensityDemTileUrl != null,
                    ),
                  ),
                  const EstimatedIntensityNoticeContent(),
                ],
              ),
            ),
          },
        ],
      ),
    );
  }
}

class const _DisplayModeHeader({
  required final IntensityDisplayMode displayMode,
  required final List<IntensityDisplayMode> availableModes,
  required final ValueChanged<IntensityDisplayMode> onDisplayModeChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (availableModes.length <= 1) {
      return SheetHeader(
        title: switch (displayMode) {
          .jma => '各地の震度',
          .lpgm => '各地の長周期地震動階級',
          .estimated => '推計震度',
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: DropdownMenuChip<IntensityDisplayMode>(
          label: _label(displayMode),
          value: displayMode,
          entries: [
            for (final mode in availableModes)
              DropdownMenuChipEntry(value: mode, label: _label(mode)),
          ],
          onSelected: onDisplayModeChanged,
        ),
      ),
    );
  }

  String _label(IntensityDisplayMode mode) => switch (mode) {
    .jma => '各地の震度',
    .lpgm => '長周期地震動階級',
    .estimated => '推計震度',
  };
}

class const _ShindoDbIntensityBody({required final String eventId})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(shindoDbIntensityTreeProvider(eventId))) {
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
    };
  }
}
