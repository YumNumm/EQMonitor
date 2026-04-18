import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_search_parameter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  const EarthquakeHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: _SliverListBody(),
    );
  }
}

class _SliverListBody extends HookConsumerWidget {
  const _SliverListBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(const EarthquakeHistoryParameter());
    final dataSourceAsync = ref.watch(
      earthquakeHistoryDataSourceProvider(parameter.value),
    );

    return dataSourceAsync.when(
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
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
          SliverGroupedPagingList<String?, String, EarthquakePartial>(
            dataSource: dataSource,
            stickyHeader: true,
            headerBuilder: (context, date, index) => _DateHeader(date: date),
            itemBuilder: (context, item, globalIndex, localIndex) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EarthquakeHistoryListTile(
                  item: item,
                  onTap: () async => EarthquakeHistoryDetailsRoute(
                    eventId: item.eventId,
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
            initialLoadingWidget: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            appendLoadingWidget: const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
            errorBuilder: (context, error, stackTrace) => ErrorCard(
              error: error,
              onReload: () async => dataSource.refresh(),
            ),
            emptyWidget: const EarthquakeHistoryNotFound(),
          ),
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
