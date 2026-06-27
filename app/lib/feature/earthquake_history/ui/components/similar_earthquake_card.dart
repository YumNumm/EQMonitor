import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_item.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/similar_earthquake_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimilarEarthquakeCard extends HookConsumerWidget {
  const SimilarEarthquakeCard({
    required this.eventId,
    super.key,
  });

  final String eventId;

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
                'この地震の近傍で発生した地震の取得に失敗しました',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            TextButton(
              onPressed: asyncItems.isReloading
                  ? null
                  : () async => ref.invalidate(
                      similarEarthquakeProvider(eventId),
                      asReload: true,
                    ),
              child: const Text('再試行'),
            ),
          ],
        ),
      ),
      AsyncData(value: final items) when items.isEmpty =>
        const SizedBox.shrink(),
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
    final theme = Theme.of(context);

    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'この震源の近傍で発生した地震',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Placeholder(
                child: Text('SORT BUTTON'),
              ),
            ],
          ),
          const SizedBox(
            height: 64,
            width: .infinity,
            child: Placeholder(
              strokeWidth: 1,
              // TODO: Implement the actual content
              child: Center(child: Text('NOT IMPLEMENTED YET')),
            ),
          ),
          // for (final item in displayItems)
          //   _SimilarEarthquakeItemTile(
          //     item: item,
          //     intensityColor: intensityColor,
          //   ),
          // if (hasMore && !showAll.value)
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //     child: TextButton(
          //       onPressed: () => showAll.value = true,
          //       child: Text(
          //         'すべて表示（残り${items.length - SimilarEarthquakeCard._initialDisplayCount}件）',
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
