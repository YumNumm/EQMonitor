import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/layout/history_adaptive_view.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_paging_list.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:paging_view/paging_view.dart';

class const EarthquakeHistoryPage({
  super.key,
  final EarthquakeHistoryParameter? initialParameter,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEventId = useState<String?>(null);
    final eventId = selectedEventId.value;
    return Scaffold(
      body: HistoryAdaptiveView(
        onCloseDetail: () => selectedEventId.value = null,
        list: _SliverListBody(
          initialParameter: initialParameter,
          selectedEventId: eventId,
          onSelect: (value) => selectedEventId.value = value,
        ),
        detail: eventId == null
            ? null
            : EarthquakeHistoryDetailsPage(
                key: ValueKey(eventId),
                eventId: eventId,
                onClose: () => selectedEventId.value = null,
              ),
      ),
    );
  }
}

class const _SliverListBody({
  final EarthquakeHistoryParameter? initialParameter,
  required final String? selectedEventId,
  required final ValueChanged<String> onSelect,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(
      initialParameter ??
          const EarthquakeHistoryParameter.all(
            sortBy: .eventId,
            sortOrder: .desc,
          ),
    );
    final dataSourceAsync = ref.watch(
      earthquakeHistoryDataSourceProvider(parameter.value),
    );
    final configAsync = ref.watch(earthquakeHistoryConfigProvider);

    // デフォルト(発生時刻↓)以外のソート中は、戻る操作でページを閉じずに
    // ソートをデフォルトへ戻す
    final isDefaultSort =
        parameter.value.sortBy == EarthquakeSortBy.eventId &&
        parameter.value.sortOrder == SortOrder.desc;

    return PopScope(
      canPop: selectedEventId != null || isDefaultSort,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && selectedEventId == null) {
          parameter.value = parameter.value.copyWith(
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          );
        }
      },
      child: configAsync.when(
        loading: () => const EarthquakeHistorySkeleton(),
        error: (error, _) => ErrorCard(
          error: error,
          onReload: () async {
            ref.invalidate(earthquakeHistoryConfigProvider);
            await ref.read(earthquakeHistoryConfigProvider.future);
          },
        ),
        data: (config) => dataSourceAsync.when(
          loading: () => const EarthquakeHistorySkeleton(),
          error: (error, _) => ErrorCard(
            error: error,
            onReload: () async => ref.refresh(
              earthquakeHistoryDataSourceProvider(parameter.value),
            ),
          ),
          data: (dataSource) => _PagingBody(
            dataSource: dataSource,
            selectedEventId: selectedEventId,
            onSelect: onSelect,
            parameter: parameter,
            config: config.list,
            onParameterChanged: (result) => parameter.value = result,
            onRefresh: () => dataSource.refresh(),
          ),
        ),
      ),
    );
  }
}

class const _PagingBody({
  required final EarthquakeHistoryDataSource dataSource,
  required final String? selectedEventId,
  required final ValueChanged<String> onSelect,
  required final ValueNotifier<EarthquakeHistoryParameter> parameter,
  required final EarthquakeHistoryListConfig config,
  required final ValueChanged<EarthquakeHistoryParameter> onParameterChanged,
  required final Future<void> Function() onRefresh,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('地震履歴'),
        bottom: EarthquakeHistoryParameterRow(
          parameter: parameter.value,
          onChanged: onParameterChanged,
        ),
      ),
      body: M3EPullToRefreshIndicator(
        onError: (error, stackTrace) => talker.error(error, stackTrace),
        hapticFeedback: .medium,
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: RevalidatingBanner(
                isRevalidating: dataSource.isRevalidating,
              ),
            ),
            EarthquakeHistoryPagingList(
              dataSource: dataSource,
              selectedEventId: selectedEventId,
              onSelect: onSelect,
              parameter: parameter.value,
              config: config,
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
      ),
    );
  }
}
