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
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_sheet_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeFeedSheet extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = context.designSystem.spacing;
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

    return HomeSheetCard(
      children: [
        if (unreadItem != null) _UnreadFeedBanner(item: unreadItem),
        const HomeSheetCardHeader(title: 'お知らせ'),
        switch (state) {
          AsyncData<FeedNotifierState>(:final value) =>
            value.items.isEmpty
                ? const _HomeFeedEmpty()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final (index, item)
                          in value.items.take(3).indexed) ...[
                        if (index != 0)
                          Divider(
                            height: 1,
                            indent: spacing.lg,
                            endIndent: spacing.lg,
                          ),
                        _HomeFeedListTile(item: item),
                      ],
                    ],
                  ),
          AsyncError<FeedNotifierState>(:final error) => ErrorCard(
            error: error,
            onReload: () async => ref.invalidate(feedProvider, asReload: true),
          ),
          _ => const _HomeFeedSkeleton(),
        },
        Align(
          alignment: .centerEnd,
          child: TextButton(
            onPressed: () async => const FeedRoute().push<void>(context),
            child: Text('さらに表示'),
          ),
        ),
      ],
    );
  }
}

class _HomeFeedEmpty extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final colorTheme = designSystem.colorTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.md,
      ),
      child: Column(
        children: [
          Icon(
            Icons.notifications_none_rounded,
            color: colorTheme.onSurfaceVariant,
          ),
          SizedBox(height: spacing.xs),
          Text(
            'お知らせはありません',
            style: designSystem.typography.bodyMedium.copyWith(
              color: colorTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HomeFeedListTile extends StatelessWidget {
  const new({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;

    return InkWell(
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
  const new();

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;
    final shape = context.designSystem.shape;
    final colorTheme = context.designSystem.colorTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.lg, spacing.sm),
      child: Skeletonizer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
  const new({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final color = item.urgencyColor ?? const Color(0xFFF57C00);

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
            spacing.sm,
            spacing.xs,
          ),
          child: Row(
            spacing: spacing.md,
            children: [
              const Icon(Icons.campaign_rounded, color: Colors.white, size: 20),
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
                icon: const Icon(Icons.close, color: Colors.white, size: 20),
                visualDensity: VisualDensity.compact,
                tooltip: '既読にする',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
