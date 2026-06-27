import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_item.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/similar_earthquake_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/similarity_score_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimilarEarthquakeCard extends HookConsumerWidget {
  const SimilarEarthquakeCard({
    required this.eventId,
    super.key,
  });

  final String eventId;

  static const _initialDisplayCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(similarEarthquakeProvider(eventId));
    final intensityColor = ref.watch(intensityColorProvider);

    return switch (asyncItems) {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.error_outline, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '類似地震の取得に失敗しました',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () => ref.invalidate(
                  similarEarthquakeProvider(eventId),
                ),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      AsyncData(value: final items) when items.isEmpty => const SizedBox
          .shrink(),
      AsyncData(value: final items) => _SimilarEarthquakeList(
          items: items,
          intensityColor: intensityColor,
        ),
    };
  }
}

class _SimilarEarthquakeList extends HookWidget {
  const _SimilarEarthquakeList({
    required this.items,
    required this.intensityColor,
  });

  final List<SimilarEarthquakeItem> items;
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context) {
    final showAll = useState(false);
    final theme = Theme.of(context);

    final displayItems = showAll.value
        ? items
        : items.take(SimilarEarthquakeCard._initialDisplayCount).toList();
    final hasMore =
        items.length > SimilarEarthquakeCard._initialDisplayCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            '類似している地震',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        for (final item in displayItems)
          _SimilarEarthquakeItemTile(
            item: item,
            intensityColor: intensityColor,
          ),
        if (hasMore && !showAll.value)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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

class _SimilarEarthquakeItemTile extends HookWidget {
  const _SimilarEarthquakeItemTile({
    required this.item,
    required this.intensityColor,
  });

  final SimilarEarthquakeItem item;
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final hasGroup = item.groupedEarthquakes.isNotEmpty;

    return Column(
      children: [
        Stack(
          children: [
            EarthquakeHistoryListTile(
              item: item.earthquake,
              intensityColor: intensityColor,
              onTap: () => EarthquakeHistoryDetailsRoute(
                eventId: item.earthquake.eventId,
              ).push<void>(context),
              showBackgroundColor: false,
              intensityIconSize: 32,
              dense: true,
            ),
            Positioned(
              right: 8,
              top: 8,
              child: SimilarityScoreIndicator(level: item.level),
            ),
          ],
        ),
        if (hasGroup)
          InkWell(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    isExpanded.value
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isExpanded.value
                        ? '閉じる'
                        : '他${item.groupedEarthquakes.length}件の余震',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        if (hasGroup && isExpanded.value)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                for (final grouped in item.groupedEarthquakes)
                  EarthquakeHistoryListTile(
                    item: grouped,
                    intensityColor: intensityColor,
                    onTap: () => EarthquakeHistoryDetailsRoute(
                      eventId: grouped.eventId,
                    ).push<void>(context),
                    showBackgroundColor: false,
                    intensityIconSize: 28,
                    dense: true,
                  ),
              ],
            ),
          ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}
