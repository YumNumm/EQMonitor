import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/tsunami/data/tsunami_history_data_source.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DebugTsunamiDetailsPage extends HookConsumerWidget {
  const DebugTsunamiDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSourceAsync = ref.watch(tsunamiHistoryDataSourceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tsunami History')),
      body: dataSourceAsync.when(
        loading: () => const _TsunamiListSkeleton(),
        error: (error, _) => ErrorCard(
          error: error,
          onReload: () => ref.refresh(tsunamiHistoryDataSourceProvider.future),
        ),
        data: (dataSource) => _PagingBody(dataSource: dataSource),
      ),
    );
  }
}

class _PagingBody extends StatelessWidget {
  const _PagingBody({required this.dataSource});

  final TsunamiHistoryDataSource dataSource;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: dataSource.refresh,
      child: CustomScrollView(
        slivers: [
          SliverGroupedPagingList<String?, String, api.TsunamiState>(
            dataSource: dataSource,
            stickyHeader: true,
            headerBuilder: (_, date, _) => _DateHeader(date: date),
            itemBuilder: (context, item, globalIndex, localIndex) =>
                _TsunamiListTile(item: item),
            initialLoadingWidget: const _TsunamiListSkeleton(scrollable: false),
            appendLoadingWidget: const _TsunamiListSkeleton(
              itemCount: 2,
              scrollable: false,
            ),
            errorBuilder: (context, error, stackTrace) => ErrorCard(
              error: error,
              onReload: dataSource.refresh,
            ),
            emptyWidget: const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('津波情報はありません'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TsunamiListTile extends StatelessWidget {
  const _TsunamiListTile({required this.item});

  final api.TsunamiState item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final earthquake = item.earthquakes.firstOrNull;
    final hypocenterName = earthquake?.hypocenter.name;
    final magnitude = earthquake?.hypocenter.magnitude.value;
    final originTime = earthquake?.originTime;

    final statusLabel = item.isCanceled
        ? '解除'
        : item.isActive
            ? '発表中'
            : '終了';
    final statusColor = item.isCanceled
        ? theme.colorScheme.outline
        : item.isActive
            ? theme.colorScheme.error
            : theme.colorScheme.tertiary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 16,
            backgroundColor: statusColor.withValues(alpha: 0.15),
            child: Text(
              statusLabel.substring(0, 1),
              style: theme.textTheme.labelSmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            hypocenterName ?? '震源不明',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (originTime != null)
                Text(
                  '発生: ${DateFormat('MM/dd HH:mm').format(originTime.toLocal())}',
                  style: theme.textTheme.bodySmall,
                ),
              if (magnitude != null)
                Text(
                  'M$magnitude',
                  style: theme.textTheme.bodySmall,
                ),
              Text(
                'EventID: ${item.eventIds.join(", ")}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                '$statusLabel | 地域: ${item.regions.length} | '
                '電文: ${item.latestTelegrams.length}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.timeline),
            tooltip: 'タイムライン',
            onPressed: () => DebugTsunamiTimelineRoute(
              tsunamiId: item.id,
            ).push<void>(context),
          ),
          onTap: () => TsunamiDetailsRoute(
            tsunamiId: item.id,
          ).push<void>(context),
        ),
        Divider(
          height: 0,
          thickness: 0,
          color: theme.colorScheme.onInverseSurface,
        ),
      ],
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        date,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _TsunamiListSkeleton extends StatelessWidget {
  const _TsunamiListSkeleton({this.itemCount = 5, this.scrollable = true});

  final int itemCount;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      for (var i = 0; i < itemCount; i++)
        const ListTile(
          leading: CircleAvatar(radius: 16),
          title: Text('震源地名'),
          subtitle: Text('2026/01/15 14:30 / M6.5\nEventID: xxx'),
        ),
    ];
    return Skeletonizer(
      child: scrollable
          ? ListView(children: tiles)
          : Column(mainAxisSize: MainAxisSize.min, children: tiles),
    );
  }
}
