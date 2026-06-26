import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_group.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/similar_earthquakes_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/similar_earthquake_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 類似地震の全画面一覧。
///
/// 全代表地震を一覧し、各行のtoggleで同一グループの他の地震を展開する。
/// 展開状態は[ListView.builder]のitemリサイクルで失われないよう、ページ側で
/// 代表地震のeventId集合として保持する。
class SimilarEarthquakePage extends HookConsumerWidget {
  const SimilarEarthquakePage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(similarEarthquakesProvider(eventId));
    final expandedIds = useState(<String>{});
    return Scaffold(
      appBar: AppBar(title: const Text('類似地震')),
      body: state.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, _) => ErrorCard(
          error: error,
          onReload: () async =>
              ref.refresh(similarEarthquakesProvider(eventId)),
        ),
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(child: Text('類似地震は見つかりませんでした'));
          }
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              final id = group.representative.eventId;
              return _SimilarEarthquakeGroupTile(
                group: group,
                expanded: expandedIds.value.contains(id),
                onToggle: () {
                  final next = Set<String>.from(expandedIds.value);
                  if (!next.add(id)) {
                    next.remove(id);
                  }
                  expandedIds.value = next;
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _SimilarEarthquakeGroupTile extends ConsumerWidget {
  const _SimilarEarthquakeGroupTile({
    required this.group,
    required this.expanded,
    required this.onToggle,
  });

  final SimilarEarthquakeGroup group;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasChildren = group.groupedEarthquakes.isNotEmpty;
    final intensityColor = ref.watch(intensityColorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SimilarEarthquakeTile(
                earthquake: group.representative,
                grade: group.grade,
              ),
            ),
            if (hasChildren)
              IconButton(
                onPressed: onToggle,
                icon: AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.expand_more),
                ),
              ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: (expanded && hasChildren)
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      for (final child in group.groupedEarthquakes)
                        EarthquakeHistoryListTile(
                          item: child,
                          intensityColor: intensityColor,
                          dense: true,
                          onTap: () => EarthquakeHistoryDetailsRoute(
                            eventId: child.eventId,
                          ).push<void>(context),
                        ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
