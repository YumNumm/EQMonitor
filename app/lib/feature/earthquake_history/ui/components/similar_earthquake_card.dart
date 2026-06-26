import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/similar_earthquakes_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/similar_earthquake_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面に表示する「類似地震」Card。
///
/// 上位3グループの代表地震を表示し、3件を超える場合は「もっと見る」で
/// 全画面([SimilarEarthquakeRoute])に遷移する。類似地震が無い場合・取得に
/// 失敗した場合は非表示にする(詳細画面の主機能を阻害しないため)。
class SimilarEarthquakeCard extends ConsumerWidget {
  const SimilarEarthquakeCard({required this.eventId, super.key});

  final String eventId;

  static const _previewCount = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(similarEarthquakesProvider(eventId));
    final theme = Theme.of(context);

    return state.when(
      loading: () => BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(theme: theme),
            const SizedBox(height: 12),
            const Center(child: CircularProgressIndicator.adaptive()),
            const SizedBox(height: 12),
          ],
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (groups) {
        if (groups.isEmpty) {
          return const SizedBox.shrink();
        }
        final preview = groups.take(_previewCount).toList();
        return BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(theme: theme),
              const SizedBox(height: 4),
              for (final group in preview)
                SimilarEarthquakeTile(
                  earthquake: group.representative,
                  grade: group.grade,
                  dense: true,
                ),
              if (groups.length > _previewCount)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => SimilarEarthquakeRoute(
                      eventId: eventId,
                    ).push<void>(context),
                    icon: const Icon(Icons.chevron_right),
                    label: const Text('もっと見る'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text(
      '類似地震',
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
