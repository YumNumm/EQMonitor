import 'dart:async';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:eqmonitor/feature/feed/data/provider/unread_high_urgency_feed_provider.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeFeedSheet extends ConsumerWidget {
  const HomeFeedSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;
    final state = ref.watch(feedProvider);

    // 初回起動時: フィード読み込み完了時点の最新を既読基準として保存し、
    // 過去のお知らせがバナー表示されないようにする
    void initializeFeedLastRead(AsyncValue<FeedNotifierState> next) {
      final items = next.value?.items;
      if (items == null || items.isEmpty) {
        return;
      }
      final newest = items
          .map((e) => e.publishedAt)
          .reduce((a, b) => a.isAfter(b) ? a : b);
      unawaited(
        ref.read(feedLastReadProvider.notifier).initializeIfUnset(newest),
      );
    }

    ref.listen(feedProvider, (_, next) => initializeFeedLastRead(next));
    initializeFeedLastRead(state);
    final unreadItem = ref.watch(unreadHighUrgencyFeedProvider);

    return Card.outlined(
      margin: EdgeInsets.zero,
      color: colorTheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (unreadItem != null) _UnreadFeedBanner(item: unreadItem),
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
                          .map((item) => _HomeFeedListTile(item: item))
                          .toList(),
                    ),
            AsyncError<FeedNotifierState>(:final error) => ErrorCard(
              error: error,
              onReload: () async =>
                  ref.invalidate(feedProvider, asReload: true),
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
      onTap: () async =>
          FeedItemDetailsRoute(id: item.id, $extra: item).push<void>(context),
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
    final colorTheme = context.designSystem.colorTheme;

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
                  color: colorTheme.surfaceContainerLow,
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

/// 未読の緊急度の高いお知らせを知らせるバナー。
/// タップで詳細へ遷移して既読化、×ボタンで既読化のみ行う。
class _UnreadFeedBanner extends ConsumerWidget {
  const _UnreadFeedBanner({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final color = feedUrgencyColor(item) ?? const Color(0xFFF57C00);

    return Material(
      color: color,
      child: InkWell(
        onTap: () async {
          unawaited(
            ref.read(feedLastReadProvider.notifier).markRead(item.publishedAt),
          );
          await FeedItemDetailsRoute(
            id: item.id,
            $extra: item,
          ).push<void>(context);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.lg,
            spacing.xs,
            spacing.xs,
            spacing.xs,
          ),
          child: Row(
            children: [
              const Icon(Icons.campaign, color: Colors.white),
              SizedBox(width: spacing.sm),
              Expanded(
                child: Text(
                  (item.title ?? item.summary ?? '').replaceAll('◆', ''),
                  style: typography.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () async => ref
                    .read(feedLastReadProvider.notifier)
                    .markRead(item.publishedAt),
                icon: const Icon(Icons.close, color: Colors.white),
                tooltip: '既読にする',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
