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
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_intensity_list_data_source.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// 市区町村の詳細モーダルを表示する。
///
/// サマリ(地域名・最高震度バッジ・件数・代表地震)と
/// ページネーション付きの過去地震一覧を表示する。
Future<void> showCityDetailModal(
  BuildContext context, {
  required String cityCode,
  required String cityName,
  required String regionName,
  HighestIntensityEntry? summary,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  clipBehavior: Clip.antiAlias,
  builder: (context) => _CityDetailModal(
    cityCode: cityCode,
    cityName: cityName,
    summary: summary,
    regionName: regionName,
  ),
);

class _CityDetailModal extends ConsumerWidget {
  const _CityDetailModal({
    required this.cityCode,
    required this.cityName,
    required this.regionName,
    required this.summary,
  });

  final String cityCode;
  final String cityName;
  final String regionName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSourceAsync = ref.watch(
      cityIntensityListDataSourceProvider(cityCode, cityName),
    );

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return dataSourceAsync.when(
          loading: () => _buildShell(
            scrollController: scrollController,
            context: context,
            child: const _Skeleton(),
          ),
          error: (error, stackTrace) => _buildShell(
            scrollController: scrollController,
            context: context,
            child: SliverToBoxAdapter(child: ErrorCard(error: error)),
          ),
          data: (dataSource) => _buildShell(
            scrollController: scrollController,
            context: context,
            child: _PagingBody(dataSource: dataSource, cityName: cityName),
            footer: _ShowAllHistoryButton(
              regionSearchType: RegionSearchType.city,
              regionCode: cityCode,
              regionName: cityName,
            ),
          ),
        );
      },
    );
  }

  Widget _buildShell({
    required BuildContext context,
    required ScrollController scrollController,
    required Widget child,
    Widget? footer,
  }) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // ドラッグハンドル
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: context.designSystem.colorTheme.onSurface.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
          ),
        ),
        // サマリ
        SliverToBoxAdapter(
          child: _SummarySection(
            regionName: regionName,
            cityName: cityName,
            summary: summary,
          ),
        ),
        // 区切り
        SliverToBoxAdapter(
          child: Divider(
            height: 0,
            color: context.designSystem.colorTheme.outlineVariant,
          ),
        ),
        // 一覧 or ローディング or エラー
        child,
        if (footer != null) SliverToBoxAdapter(child: footer),
        // BottomPadding
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).bottom + 16),
        ),
      ],
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({
    required this.regionName,
    required this.cityName,
    required this.summary,
  });

  final String regionName;
  final String cityName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final entry = summary;
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
                child: Column(
                  children: [
                    Text(
                      regionName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.designSystem.colorTheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      cityName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
  const _PagingBody({required this.dataSource, required this.cityName});

  final CityIntensityListDataSource dataSource;
  final String cityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGroupedPagingList<String?, String, IntensityAreaSearchItem>(
      dataSource: dataSource,
      stickyHeader: true,
      headerBuilder: (_, intensity, _) =>
          _IntensityHeader(intensity: intensity),
      itemBuilder: (context, item, globalIndex, localIndex) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EarthquakeHistoryListTile(
            item: item.earthquake,
            areaInfo: item.area,
            areaName: cityName,
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
      errorBuilder: (context, error, stackTrace) =>
          ErrorCard(error: error, onReload: () async => dataSource.refresh()),
      emptyWidget: const Center(
        child: Padding(padding: EdgeInsets.all(32), child: Text('震度の記録がありません')),
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

/// Sliver として使うスケルトン（CustomScrollView の slivers 内で使用）。
class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return SliverSkeletonizer(
      child: SliverList.builder(
        itemCount: 5,
        itemBuilder: (_, _) => const ListTile(
          leading: CircleAvatar(radius: 18),
          title: Text('宮城県沖'),
          subtitle: Text('2026/06/27 12:34発生'),
          trailing: Text('M6.0'),
        ),
      ),
    );
  }
}

/// 通常の Widget として使うスケルトン（SliverGroupedPagingList の loading widget 用）。
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
              subtitle: Text('震度7 / 2026/06/27 12:34発生'),
              trailing: Text('M6.0'),
            ),
        ],
      ),
    );
  }
}
