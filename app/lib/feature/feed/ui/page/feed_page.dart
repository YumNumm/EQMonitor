import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_data_source.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSourceAsync = ref.watch(feedDataSourceProvider);

    return Scaffold(
      body: dataSourceAsync.when(
        loading: () => const _FeedSkeleton(),
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
          SliverPagingList<String?, FeedItem>(
            dataSource: dataSource,
            builder: (context, item, index) => FeedItemCard(item: item),
            initialLoadingWidget: const _FeedSkeleton(scrollable: false),
            appendLoadingWidget: const _FeedSkeleton(
              itemCount: 2,
              scrollable: false,
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
                      child: Center(
                        child: Text('すべてのお知らせを表示しました'),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedSkeleton extends StatelessWidget {
  const _FeedSkeleton({
    this.itemCount = 5,
    this.scrollable = true,
  });

  final int itemCount;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      for (var i = 0; i < itemCount; i++)
        const Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 40, height: 16),
                    SizedBox(width: 8),
                    SizedBox(width: 60, height: 16),
                    Spacer(),
                    SizedBox(width: 80, height: 12),
                  ],
                ),
                SizedBox(height: 8),
                SizedBox(width: 200, height: 16),
                SizedBox(height: 4),
                SizedBox(width: double.infinity, height: 14),
              ],
            ),
          ),
        ),
    ];

    return Skeletonizer(
      child: scrollable
          ? ListView(children: tiles)
          : Column(mainAxisSize: MainAxisSize.min, children: tiles),
    );
  }
}
