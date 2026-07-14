import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_data_source.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSourceAsync = ref.watch(feedDataSourceProvider);

    return Scaffold(
      body: dataSourceAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, _) => ErrorCard(
          error: error,
          onReload: () async => ref.invalidate(feedDataSourceProvider),
        ),
        data: (dataSource) => _PagingBody(dataSource: dataSource),
      ),
    );
  }
}

class _PagingBody extends StatelessWidget {
  const _PagingBody({required this.dataSource});

  final FeedDataSource dataSource;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: dataSource.refresh,
      edgeOffset: MediaQuery.paddingOf(context).top + kToolbarHeight,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: Text('お知らせ'),
          ),
          SliverToBoxAdapter(
            child: RevalidatingBanner(
              isRevalidating: dataSource.isRevalidating,
            ),
          ),
          SliverPagingList<String?, FeedItem>(
            dataSource: dataSource,
            builder: (context, item, index) =>
                FeedItemListTileContent(item: item),
            initialLoadingWidget: FeedItemListTileContent(
              item: FeedItem(
                id: '1',
                feedType: FeedType.appUpdate,
                priority: FeedPriority.normal,
                isImportant: false,
                title: 'アップデート',
                summary: 'アップデートがあります',
                data: FeedItemData.appUpdate(),
                publishedAt: DateTime.now(),
                expiresAt: DateTime.now().add(const Duration(days: 30)),
              ),
            ),
            appendLoadingWidget: FeedItemListTileContent(
              item: FeedItem(
                id: '2',
                feedType: FeedType.appUpdate,
                priority: FeedPriority.normal,
                isImportant: false,
                title: 'アップデート',
                summary: 'アップデートがあります',
                data: FeedItemData.appUpdate(),
                publishedAt: DateTime.now(),
                expiresAt: DateTime.now().add(const Duration(days: 30)),
              ),
            ),
            errorBuilder: (context, error, stackTrace) => ErrorCard(
              error: error,
              onReload: () async => dataSource.refresh(),
            ),
            emptyWidget: const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('お知らせはありません'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppendLoadStateBuilder(
              dataSource: dataSource,
              builder: (context, hasMore, isLoading) => !hasMore && !isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: Text('すべてのお知らせを表示しました')),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
