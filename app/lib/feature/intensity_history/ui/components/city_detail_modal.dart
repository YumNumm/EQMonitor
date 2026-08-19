import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

enum _AreaDetailType {
  prefecture(label: '都道府県'),
  city(label: '市区町村');

  new({required this.label});
  final String label;
}

class AreaDetailModalAction {
  Future<void> showPrefecture(
    BuildContext context, {
    required String prefectureCode,
    required String prefectureName,
    HighestIntensityEntry? summary,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (context) => _AreaDetailModal(
      areaType: _AreaDetailType.prefecture,
      areaName: prefectureName,
      parentAreaName: null,
      parameter: EarthquakeHistoryParameter.prefecture(
        prefectureCode: prefectureCode,
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      ),
      summary: summary,
    ),
  );

  Future<void> showCity(
    BuildContext context, {
    required String cityCode,
    required String cityName,
    required String regionName,
    HighestIntensityEntry? summary,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (context) => _AreaDetailModal(
      areaType: _AreaDetailType.city,
      areaName: cityName,
      parentAreaName: regionName,
      parameter: EarthquakeHistoryParameter.city(
        cityCode: cityCode,
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      ),
      summary: summary,
    ),
  );
}

class _AreaDetailModal extends ConsumerWidget {
  const new({
    required this.areaType,
    required this.areaName,
    required this.parentAreaName,
    required this.parameter,
    required this.summary,
  });

  final _AreaDetailType areaType;
  final String areaName;
  final String? parentAreaName;
  final EarthquakeHistoryParameter parameter;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPage = ref.watch(earthquakeHistoryProvider(parameter));
    final visiblePage = asyncPage.hasValue ? asyncPage.requireValue : null;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(child: _DragHandle()),
            SliverToBoxAdapter(
              child: _SummarySection(
                areaType: areaType,
                parentAreaName: parentAreaName,
                areaName: areaName,
                summary: summary,
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                height: 0,
                color: context.designSystem.colorTheme.outlineVariant,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  '観測した地震',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ...switch ((visiblePage, asyncPage)) {
              (final PaginatedResponse<EarthquakePartial> page?, _) => [
                _AreaEarthquakeListSliverGroup(
                  parameter: parameter,
                  page: page,
                ),
              ],
              (null, AsyncLoading()) => const [_InitialLoadingSliver()],
              (null, AsyncError(:final error)) => [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: ErrorCard(
                      error: error,
                      onReload: () async {
                        ref.invalidate(earthquakeHistoryProvider(parameter));
                      },
                    ),
                  ),
                ),
              ],
              _ => const [SliverToBoxAdapter(child: SizedBox.shrink())],
            },
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.paddingOf(context).bottom + 16,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AreaEarthquakeListSliverGroup extends HookConsumerWidget {
  const new({
    required this.parameter,
    required this.page,
  });

  final EarthquakeHistoryParameter parameter;
  final PaginatedResponse<EarthquakePartial> page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (page.items.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text('この地域で観測された地震はありません')),
      );
    }

    final activeCursor = useState<String?>(null);
    final nextToken = page.nextToken;
    final isAppending = nextToken != null && activeCursor.value == nextToken;

    return SliverMainAxisGroup(
      slivers: [
        SliverList.builder(
          itemCount: page.items.length,
          itemBuilder: (context, index) {
            final item = page.items[index];
            return EarthquakeHistoryListTile(
              item: item,
              searchParameter: parameter,
              dense: true,
              visualDensity: VisualDensity.compact,
              showBackgroundColor: false,
              onTap: () async {
                await EarthquakeHistoryDetailsRoute(
                  eventId: item.earthquake.eventId,
                ).push<void>(context);
              },
            );
          },
        ),
        if (nextToken != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: OutlinedButton.icon(
                onPressed: isAppending
                    ? null
                    : () async {
                        activeCursor.value = nextToken;
                        try {
                          await ref
                              .read(
                                earthquakeHistoryProvider(parameter).notifier,
                              )
                              .fetchNextData();
                        } finally {
                          if (activeCursor.value == nextToken) {
                            activeCursor.value = null;
                          }
                        }
                      },
                icon: const Icon(Icons.expand_more_rounded),
                label: const Text('さらに読み込む'),
              ),
            ),
          ),
      ],
    );
  }
}

class _InitialLoadingSliver extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 12),
            Text('地震一覧を読み込んでいます'),
          ],
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: context.designSystem.colorTheme.onSurface.withValues(
            alpha: 0.3,
          ),
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const new({
    required this.areaType,
    required this.parentAreaName,
    required this.areaName,
    required this.summary,
  });

  final _AreaDetailType areaType;
  final String? parentAreaName;
  final String areaName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = summary;
    final earthquakePartial = entry?.earthquake;
    final originTime = earthquakePartial?.earthquake.originTime;
    final hypocenter = earthquakePartial?.earthquake.hypocenter;
    final magnitude = hypocenter?.magnitude;
    final hypocenterName = switch (hypocenter?.name) {
      final String name when name.isNotEmpty => name,
      _ => '震源不明',
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry != null) ...[
                JmaIntensityIcon(
                  intensity: entry.intensity,
                  type: IntensityIconType.filled,
                  size: 40,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (parentAreaName case final parentAreaName?)
                      Text(
                        parentAreaName,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              context.designSystem.colorTheme.onSurfaceVariant,
                        ),
                      ),
                    Text(
                      areaName,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      areaType.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.designSystem.colorTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (entry != null) ...[
            const SizedBox(height: 8),
            Text(
              '最高震度を観測した地震: ${entry.count}件',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.designSystem.colorTheme.onSurface,
              ),
            ),
            if (earthquakePartial != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (originTime != null)
                          Text(
                            '代表: ${DateFormat('yyyy/MM/dd HH:mm').format(originTime.toLocal())}発生',
                            style: theme.textTheme.bodySmall,
                          ),
                        Text(hypocenterName, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  if (magnitude != null) MagnitudeText(magnitude: magnitude),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}
