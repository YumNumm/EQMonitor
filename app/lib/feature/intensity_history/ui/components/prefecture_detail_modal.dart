import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_intensity_list_data_source.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// 都道府県の詳細モーダルを表示する。
Future<void> showPrefectureDetailModal(
  BuildContext context, {
  required String prefectureCode,
  required String prefectureName,
  HighestIntensityEntry? summary,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  clipBehavior: Clip.antiAlias,
  builder: (context) => _PrefectureDetailModal(
    prefectureCode: prefectureCode,
    prefectureName: prefectureName,
    summary: summary,
  ),
);

class _PrefectureDetailModal extends ConsumerWidget {
  const _PrefectureDetailModal({
    required this.prefectureCode,
    required this.prefectureName,
    required this.summary,
  });

  final String prefectureCode;
  final String prefectureName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSourceAsync = ref.watch(
      prefectureIntensityListDataSourceProvider(
        prefectureCode,
        prefectureName,
      ),
    );

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) => CustomScrollView(
        controller: scrollController,
        slivers: [
          const SliverToBoxAdapter(child: _DragHandle()),
          SliverToBoxAdapter(
            child: _PrefectureSummarySection(
              prefectureName: prefectureName,
              summary: summary,
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 0,
              color: context.designSystem.colorTheme.outlineVariant,
            ),
          ),
          dataSourceAsync.when(
            loading: () => const _Skeleton(),
            error: (error, stackTrace) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ErrorCard(error: error),
              ),
            ),
            data: (dataSource) => _PagingBody(
              dataSource: dataSource,
              prefectureName: prefectureName,
            ),
          ),
          if (dataSourceAsync.hasValue)
            SliverToBoxAdapter(
              child: _ShowAllHistoryButton(
                regionSearchType: RegionSearchType.prefecture,
                regionCode: prefectureCode,
                regionName: prefectureName,
              ),
            ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.paddingOf(context).bottom + 16),
          ),
        ],
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: context.designSystem.colorTheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

class _PrefectureSummarySection extends StatelessWidget {
  const _PrefectureSummarySection({
    required this.prefectureName,
    required this.summary,
  });

  final String prefectureName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = summary;
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final eq = entry?.earthquake;
    final originTime = eq?.originTime;
    final hypocenter = eq?.hypocenter;
    final magnitude = hypocenter?.magnitude.toEarthquakeMagnitude;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (entry != null) ...[
                JmaIntensityIcon(
                  intensity: entry.intensity.toJmaIntensity,
                  type: IntensityIconType.filled,
                  size: 40,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  prefectureName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (entry != null) ...[
            const SizedBox(height: 8),
            Text(
              'この震度を観測した地震: ${entry.count}件',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.designSystem.colorTheme.onSurface,
              ),
            ),
            if (eq != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (originTime != null)
                          Text(
                            '代表: ${dateFormatter.format(originTime.toLocal())}発生',
                            style: theme.textTheme.bodySmall,
                          ),
                        if (hypocenter != null)
                          Text(
                            hypocenter.name,
                            style: theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                  if (magnitude != null) MagnitudeText(magnitude: magnitude),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _PagingBody extends ConsumerWidget {
  const _PagingBody({
    required this.dataSource,
    required this.prefectureName,
  });

  final PrefectureIntensityListDataSource dataSource;
  final String prefectureName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGroupedPagingList<String?, String, IntensityAreaSearchItem>(
      dataSource: dataSource,
      stickyHeader: true,
      headerBuilder: (_, intensity, _) => _IntensityHeader(
        intensity: intensity,
      ),
      itemBuilder: (context, item, globalIndex, localIndex) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EarthquakeHistoryListTile(
            item: item.earthquake,
            areaInfo: item.area,
            areaName: prefectureName,
            onTap: () async {
              await EarthquakeHistoryDetailsRoute(
                eventId: item.eventId,
              ).push<void>(context);
            },
          ),
          Divider(
            height: 0,
            thickness: 0,
            color: context.designSystem.colorTheme.onInverseSurface,
          ),
        ],
      ),
      initialLoadingWidget: const _SkeletonBox(),
      appendLoadingWidget: const _SkeletonBox(itemCount: 2),
      errorBuilder: (context, error, stackTrace) => ErrorCard(
        error: error,
        onReload: () async => dataSource.refresh(),
      ),
      emptyWidget: const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('震度の記録がありません'),
        ),
      ),
    );
  }
}

class _ShowAllHistoryButton extends StatelessWidget {
  const _ShowAllHistoryButton({
    required this.regionSearchType,
    required this.regionCode,
    required this.regionName,
  });

  final RegionSearchType regionSearchType;
  final String regionCode;
  final String regionName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: FilledButton.icon(
        onPressed: () async {
          final router = GoRouter.of(context);
          final parameter = EarthquakeHistoryParameter(
            regionSearchType: regionSearchType,
            regionCode: regionCode,
            regionName: regionName,
            sortBy: EarthquakeSortBy.maxIntensity,
            sortOrder: SortOrder.desc,
          );
          final route = EarthquakeHistoryRoute($extra: parameter);
          Navigator.of(context).pop();
          await router.push<void>(route.location, extra: parameter);
        },
        icon: const Icon(Icons.list_alt_rounded),
        label: const Text('すべて表示'),
      ),
    );
  }
}

class _IntensityHeader extends StatelessWidget {
  const _IntensityHeader({required this.intensity});

  final String intensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: context.designSystem.colorTheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        intensity,
        style: theme.textTheme.titleSmall?.copyWith(
          color: context.designSystem.colorTheme.onSurface,
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return SliverSkeletonizer(
      child: SliverList.builder(
        itemCount: 6,
        itemBuilder: (_, _) => const ListTile(
          leading: CircleAvatar(radius: 18),
          title: Text('宮城県沖'),
          subtitle: Text('震度7 / 2026/06/27 12:34発生'),
          trailing: Text('M6.0'),
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < itemCount; i++)
            const ListTile(
              leading: CircleAvatar(radius: 18),
              title: Text('宮城県沖'),
              subtitle: Text('2026/06/27 12:34発生'),
              trailing: Text('M6.0'),
            ),
        ],
      ),
    );
  }
}
