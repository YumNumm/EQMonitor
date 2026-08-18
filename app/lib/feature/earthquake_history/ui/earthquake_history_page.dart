import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_paging_list.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  const new({super.key, this.initialParameter});

  final EarthquakeHistoryParameter? initialParameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: _SliverListBody(initialParameter: initialParameter));
  }
}

class _SliverListBody extends HookConsumerWidget {
  const new({this.initialParameter});

  final EarthquakeHistoryParameter? initialParameter;

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
      canPop: isDefaultSort,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
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

class _PagingBody extends ConsumerWidget {
  const new({
    required this.dataSource,
    required this.parameter,
    required this.config,
    required this.onParameterChanged,
    required this.onRefresh,
  });

  final EarthquakeHistoryDataSource dataSource;
  final ValueNotifier<EarthquakeHistoryParameter> parameter;
  final EarthquakeHistoryListConfig config;
  final ValueChanged<EarthquakeHistoryParameter> onParameterChanged;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 広告非表示時は広告分の高さを確保しない
    final adBannerHeight = AdBanner.heightOf(ref);

    return RefreshIndicator(
      onRefresh: onRefresh,
      edgeOffset:
          MediaQuery.paddingOf(context).top +
          kToolbarHeight +
          adBannerHeight +
          EarthquakeHistoryParameterPersistentDelegate.height,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: const Text('地震履歴'),
            bottom: adBannerHeight == 0
                ? null
                : PreferredSize(
                    preferredSize: Size.fromHeight(adBannerHeight),
                    child: const AdBanner(),
                  ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: EarthquakeHistoryParameterPersistentDelegate(
              parameter: parameter.value,
              onChanged: onParameterChanged,
            ),
          ),
          SliverToBoxAdapter(
            child: RevalidatingBanner(
              isRevalidating: dataSource.isRevalidating,
            ),
          ),
          EarthquakeHistoryPagingList(
            dataSource: dataSource,
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
    );
  }
}
