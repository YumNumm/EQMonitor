import 'dart:async';

import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/scroll/bottom_bouncing_scroll_physics.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_selection.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_sort_chips.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const CityDetailSheet({
  required final IntensityHistorySelectedCity city,
  required final VoidCallback onClose,
  super.key,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = useState(
      const EarthquakeSortSelection(
        sortBy: EarthquakeSortBy.regionalIntensity,
        sortOrder: SortOrder.desc,
      ),
    );
    final parameter = EarthquakeHistoryParameter.city(
      cityCode: city.code,
      sortBy: sort.value.sortBy,
      sortOrder: sort.value.sortOrder,
    );
    final asyncPage = ref.watch(earthquakeHistoryProvider(parameter));
    final visiblePage = asyncPage.hasValue ? asyncPage.requireValue : null;
    final maxIntensity = ref.watch(
      cityMaxIntensityProvider.select(
        (value) => value.valueOrPrevious?.intensityOfCity(city.code),
      ),
    );

    return CustomScrollView(
      physics: const BottomBouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _SummarySection(
            prefectureName: city.prefectureName,
            cityName: city.name,
            maxIntensity: maxIntensity,
            onClose: onClose,
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
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: EarthquakeSortChips(
            sortBy: sort.value.sortBy,
            sortOrder: sort.value.sortOrder,
            showRegionalIntensity: true,
            onChanged: (value) {
              sort.value = sort.value.selecting(value);
            },
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
                    unawaited(HapticFeedback.lightImpact());
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
  }
}

class const _AreaEarthquakeListSliverGroup({
  required final EarthquakeHistoryParameter parameter,
  required final PaginatedResponse<EarthquakePartial> page,
}) extends HookConsumerWidget {
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
              child: M3EOutlinedButton.icon(
                onPressed: isAppending
                    ? null
                    : () async {
                        unawaited(HapticFeedback.lightImpact());
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

class const _InitialLoadingSliver() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            AccessibleCircularProgressIndicator(),
            SizedBox(height: 12),
            Text('地震履歴を読み込んでいます'),
          ],
        ),
      ),
    );
  }
}

class const _SummarySection({
  required final String prefectureName,
  required final String cityName,
  required final JmaIntensity? maxIntensity,
  required final VoidCallback onClose,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 16),
      child: Row(
        crossAxisAlignment: .start,
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
              crossAxisAlignment: .start,
              children: [
                Text(
                  prefectureName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  cityName,
                  textAlign: .left,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: .bold,
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
          IconButton(
            onPressed: onClose,
            tooltip: '閉じる',
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}
