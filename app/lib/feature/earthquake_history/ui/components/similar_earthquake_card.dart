import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/similar_earthquake_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimilarEarthquakeCard extends HookConsumerWidget {
  const SimilarEarthquakeCard({
    required this.earthquake,
    super.key,
  });

  final Earthquake earthquake;

  static const _initialDisplayCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = earthquake.hypocenter?.coordinates;
    if (coordinates is! CoordinateLatLng) {
      return const SizedBox.shrink();
    }

    final depth = switch (earthquake.hypocenter?.depth) {
      EarthquakeDepthShallow() => 0,
      EarthquakeDepthValue(:final value) => value,
      EarthquakeDepthOver700km() => 700,
      _ => null,
    };

    final sortBy = useState(api.EarthquakeSortBy.originTime);
    final sortOrder = useState(api.SortOrder.desc);
    final showAll = useState(false);
    final intensityColor = ref.watch(intensityColorProvider);
    final theme = Theme.of(context);

    final asyncItems = ref.watch(
      nearbyEarthquakeProvider(
        earthquake.eventId,
        coordinates.latitude,
        coordinates.longitude,
        depth,
        sortBy.value,
        sortOrder.value,
      ),
    );

    void onSortChanged(api.EarthquakeSortBy newSortBy) {
      if (sortBy.value == newSortBy) {
        sortOrder.value = sortOrder.value == api.SortOrder.asc
            ? api.SortOrder.desc
            : api.SortOrder.asc;
      } else {
        sortBy.value = newSortBy;
        sortOrder.value = switch (newSortBy) {
          api.EarthquakeSortBy.depth => api.SortOrder.asc,
          _ => api.SortOrder.desc,
        };
        showAll.value = false;
      }
    }

    return BorderedContainer(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Text(
              'この震源の近傍で発生した地震',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _SortButtonRow(
            sortBy: sortBy.value,
            sortOrder: sortOrder.value,
            onSortChanged: onSortChanged,
          ),
          const SizedBox(height: 8),
          switch (asyncItems) {
            AsyncLoading() => const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  ),
                ),
              ),
            AsyncError() => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '近傍の地震の取得に失敗しました',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    TextButton(
                      onPressed: () => ref.invalidate(
                        nearbyEarthquakeProvider(
                          earthquake.eventId,
                          coordinates.latitude,
                          coordinates.longitude,
                          depth,
                          sortBy.value,
                          sortOrder.value,
                        ),
                      ),
                      child: const Text('再試行'),
                    ),
                  ],
                ),
              ),
            AsyncData(value: final items) when items.isEmpty => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Center(
                  child: Text(
                    '該当する地震がありません',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            AsyncData(value: final items) => _NearbyEarthquakeList(
                items: items,
                showAll: showAll,
                intensityColor: intensityColor,
              ),
          },
        ],
      ),
    );
  }
}

class _NearbyEarthquakeList extends StatelessWidget {
  const _NearbyEarthquakeList({
    required this.items,
    required this.showAll,
    required this.intensityColor,
  });

  final List<EarthquakePartial> items;
  final ValueNotifier<bool> showAll;
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context) {
    final displayItems = showAll.value
        ? items
        : items.take(SimilarEarthquakeCard._initialDisplayCount).toList();
    final hasMore =
        items.length > SimilarEarthquakeCard._initialDisplayCount;

    return Column(
      children: [
        for (final item in displayItems) ...[
          EarthquakeHistoryListTile(
            item: item,
            intensityColor: intensityColor,
            onTap: () => EarthquakeHistoryDetailsRoute(
              eventId: item.eventId,
            ).push<void>(context),
            showBackgroundColor: false,
            intensityIconSize: 32,
            dense: true,
          ),
          const Divider(height: 1, indent: 12, endIndent: 12),
        ],
        if (hasMore && !showAll.value)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: TextButton(
              onPressed: () => showAll.value = true,
              child: Text(
                'すべて表示（残り${items.length - SimilarEarthquakeCard._initialDisplayCount}件）',
              ),
            ),
          ),
      ],
    );
  }
}

class _SortButtonRow extends StatelessWidget {
  const _SortButtonRow({
    required this.sortBy,
    required this.sortOrder,
    required this.onSortChanged,
  });

  final api.EarthquakeSortBy sortBy;
  final api.SortOrder sortOrder;
  final ValueChanged<api.EarthquakeSortBy> onSortChanged;

  static const List<(api.EarthquakeSortBy, String)> _sortOptions = [
    (api.EarthquakeSortBy.originTime, '日時'),
    (api.EarthquakeSortBy.magnitude, 'M'),
    (api.EarthquakeSortBy.maxIntensity, '最大震度'),
    (api.EarthquakeSortBy.depth, '深さ'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          for (final (value, label) in _sortOptions)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                selected: sortBy == value,
                showCheckmark: false,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label),
                    if (sortBy == value) ...[
                      const SizedBox(width: 2),
                      Icon(
                        sortOrder == api.SortOrder.asc
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 14,
                      ),
                    ],
                  ],
                ),
                onSelected: (_) => onSortChanged(value),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
        ],
      ),
    );
  }
}
