import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeFeedSheet extends ConsumerWidget {
  const HomeFeedSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;
    final state = ref.watch(feedProvider);

    return Card.outlined(
      margin: EdgeInsets.zero,
      color: color.surfaceCard,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              spacing.lg,
              spacing.md,
              spacing.lg,
              spacing.xs,
            ),
            child: Text(
              'お知らせ',
              style: typography.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          switch (state) {
            AsyncData<FeedNotifierState>(:final value) =>
              value.items.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(spacing.lg),
                      child: const Center(child: Text('お知らせはありません')),
                    )
                  : Column(
                      children: value.items
                          .take(3)
                          .map(
                            (item) => _HomeFeedListTile(item: item),
                          )
                          .toList(),
                    ),
            AsyncError<FeedNotifierState>(:final error) => ErrorCard(
              error: error,
              onReload: () async => ref.invalidate(
                feedProvider,
                asReload: true,
              ),
            ),
            _ => const _HomeFeedSkeleton(),
          },
          Padding(
            padding: EdgeInsets.fromLTRB(
              spacing.lg,
              spacing.xs,
              spacing.lg,
              spacing.md,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async => const FeedRoute().push<void>(context),
                child: const Text('さらに表示'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeFeedListTile extends StatelessWidget {
  const _HomeFeedListTile({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return InkWell(
      borderRadius: BorderRadius.circular(shape.md),
      onTap: () => FeedItemCard.showDetail(context, item),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.lg,
          vertical: spacing.sm,
        ),
        child: FeedItemListTileContent(item: item),
      ),
    );
  }
}

class _HomeFeedSkeleton extends StatelessWidget {
  const _HomeFeedSkeleton();

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;
    final shape = context.designSystem.shape;
    final color = context.designSystem.color;

    return Padding(
      padding: EdgeInsets.all(spacing.lg),
      child: Skeletonizer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 3; i++) ...[
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: color.surfaceRaised,
                  borderRadius: BorderRadius.circular(shape.md),
                ),
              ),
              if (i != 2) SizedBox(height: spacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}
