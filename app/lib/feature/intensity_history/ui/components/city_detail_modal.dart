import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CityDetailModalAction {
  Future<void> show(
    BuildContext context, {
    required String cityCode,
    required String cityName,
    required String prefectureName,
    JmaIntensity? maxIntensity,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (context) => _CityDetailModal(
      cityName: cityName,
      prefectureName: prefectureName,
      maxIntensity: maxIntensity,
      parameter: EarthquakeHistoryParameter.city(
        cityCode: cityCode,
        sortBy: EarthquakeSortBy.regionalIntensity,
        sortOrder: SortOrder.desc,
      ),
    ),
  );
}

class _CityDetailModal extends ConsumerWidget {
  const new({
    required this.cityName,
    required this.prefectureName,
    required this.maxIntensity,
    required this.parameter,
  });

  final String cityName;
  final String prefectureName;
  final JmaIntensity? maxIntensity;
  final EarthquakeHistoryParameter parameter;

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
                prefectureName: prefectureName,
                cityName: cityName,
                maxIntensity: maxIntensity,
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
    required this.prefectureName,
    required this.cityName,
    required this.maxIntensity,
  });

  final String prefectureName;
  final String cityName;
  final JmaIntensity? maxIntensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (maxIntensity case final maxIntensity?) ...[
            JmaIntensityIcon(
              intensity: maxIntensity,
              type: IntensityIconType.filled,
              size: 40,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prefectureName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  cityName,
                  textAlign: TextAlign.left,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  maxIntensity == null ? '市区町村' : '観測史上最大震度',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
