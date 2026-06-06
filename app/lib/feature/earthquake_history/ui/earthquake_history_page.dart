import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_search_parameter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  const EarthquakeHistoryPage({super.key, this.initialParameter});

  final EarthquakeHistoryParameter? initialParameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _SliverListBody(initialParameter: initialParameter),
    );
  }
}

class _SliverListBody extends HookConsumerWidget {
  const _SliverListBody({this.initialParameter});

  final EarthquakeHistoryParameter? initialParameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(
      initialParameter ?? const EarthquakeHistoryParameter(),
    );
    final dataSourceAsync = ref.watch(
      earthquakeHistoryDataSourceProvider(parameter.value),
    );

    return dataSourceAsync.when(
      loading: () => const _EarthquakeHistorySkeleton(),
      error: (error, _) => ErrorCard(
        error: error,
        onReload: () async => ref.refresh(
          earthquakeHistoryDataSourceProvider(parameter.value),
        ),
      ),
      data: (dataSource) => _PagingBody(
        dataSource: dataSource,
        parameter: parameter,
        onParameterChanged: (result) => parameter.value = result,
        onRefresh: () => dataSource.refresh(),
      ),
    );
  }
}

class _PagingBody extends StatelessWidget {
  const _PagingBody({
    required this.dataSource,
    required this.parameter,
    required this.onParameterChanged,
    required this.onRefresh,
  });

  final EarthquakeHistoryDataSource dataSource;
  final ValueNotifier<EarthquakeHistoryParameter> parameter;
  final ValueChanged<EarthquakeHistoryParameter> onParameterChanged;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: const Text('地震履歴'),
            actions: [
              OutlinedButton.icon(
                label: const Text('検索条件'),
                icon: const Icon(Icons.search),
                onPressed: () async {
                  final result =
                      await EarthquakeHistorySearchParameterModal.show(
                        context,
                        initialParameter: parameter.value,
                      );
                  if (result != null) {
                    onParameterChanged(result);
                  }
                },
              ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: EarthquakeHistoryParameterPersistentDelegate(
              parameter: parameter.value,
              onChanged: onParameterChanged,
            ),
          ),
          SliverGroupedPagingList<String?, String, EarthquakeHistoryItem>(
            dataSource: dataSource,
            stickyHeader: true,
            headerBuilder: (context, date, index) => _DateHeader(date: date),
            itemBuilder: (context, item, globalIndex, localIndex) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EarthquakeHistoryListTile(
                  item: item.earthquake,
                  areaInfo: item.areaInfo,
                  onTap: () async => EarthquakeHistoryDetailsRoute(
                    eventId: item.earthquake.eventId,
                  ).push<void>(context),
                  visualDensity: VisualDensity.compact,
                ),
                Divider(
                  height: 0,
                  thickness: 0,
                  color: theme.colorScheme.onInverseSurface,
                ),
              ],
            ),
            initialLoadingWidget: const _EarthquakeHistorySkeleton(
              scrollable: false,
            ),
            appendLoadingWidget: const _EarthquakeHistorySkeleton(
              itemCount: 2,
              scrollable: false,
            ),
            errorBuilder: (context, error, stackTrace) => ErrorCard(
              error: error,
              onReload: () async => dataSource.refresh(),
            ),
            emptyWidget: const EarthquakeHistoryNotFound(),
          ),
          const SliverToBoxAdapter(child: AdBanner()),
          SliverToBoxAdapter(
            child: AppendLoadStateBuilder(
              dataSource: dataSource,
              builder: (context, hasMore, isLoading) => !hasMore && !isLoading
                  ? const EarthquakeHistoryAllFetched()
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EarthquakeHistorySkeleton extends StatelessWidget {
  const _EarthquakeHistorySkeleton({
    this.itemCount = 5,
    this.scrollable = true,
  });

  final int itemCount;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      for (final i in List.generate(itemCount, (i) => i))
        ListTile(
          leading: const CircleAvatar(radius: 16),
          title: Text('震源地 $i'),
          subtitle: const Text('2026/04/21 12:34 / 最大震度4 / M5.5'),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
    ];

    return Skeletonizer(
      child: scrollable
          ? ListView(children: tiles)
          : Column(mainAxisSize: MainAxisSize.min, children: tiles),
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
      color: theme.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        date,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
