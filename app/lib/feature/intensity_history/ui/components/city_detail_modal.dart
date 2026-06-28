import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_intensity_list_data_source.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
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
  HighestIntensityEntry? summary,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  clipBehavior: Clip.antiAlias,
  builder: (context) => _CityDetailModal(
    cityCode: cityCode,
    cityName: cityName,
    summary: summary,
  ),
);

class _CityDetailModal extends ConsumerWidget {
  const _CityDetailModal({
    required this.cityCode,
    required this.cityName,
    required this.summary,
  });

  final String cityCode;
  final String cityName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSourceAsync = ref.watch(
      cityIntensityListDataSourceProvider(cityCode),
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
            child: SliverToBoxAdapter(
              child: ErrorCard(error: error),
            ),
          ),
          data: (dataSource) => _buildShell(
            scrollController: scrollController,
            context: context,
            child: _PagingBody(dataSource: dataSource),
          ),
        );
      },
    );
  }

  Widget _buildShell({
    required BuildContext context,
    required ScrollController scrollController,
    required Widget child,
  }) {
    final theme = Theme.of(context);
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
        // サマリ
        SliverToBoxAdapter(
          child: _SummarySection(cityName: cityName, summary: summary),
        ),
        // 区切り
        SliverToBoxAdapter(
          child: Divider(height: 0, color: theme.colorScheme.outlineVariant),
        ),
        // 一覧 or ローディング or エラー
        child,
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
    required this.cityName,
    required this.summary,
  });

  final String cityName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final eq = summary?.earthquake;
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
              if (summary != null) ...[
                JmaIntensityIcon(
                  intensity: summary!.intensity.toJmaIntensity,
                  type: IntensityIconType.filled,
                  size: 40,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  cityName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (summary != null) ...[
            const SizedBox(height: 8),
            Text(
              '観測件数: ${summary!.count}件',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
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

class _PagingBody extends StatelessWidget {
  const _PagingBody({required this.dataSource});

  final CityIntensityListDataSource dataSource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverGroupedPagingList<String?, String, IntensityCitySearchItem>(
      dataSource: dataSource,
      stickyHeader: true,
      headerBuilder: (_, date, _) => _DateHeader(date: date),
      itemBuilder: (context, item, globalIndex, localIndex) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CityIntensityListTile(item: item),
          Divider(
            height: 0,
            thickness: 0,
            color: theme.colorScheme.onInverseSurface,
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

class _CityIntensityListTile extends StatelessWidget {
  const _CityIntensityListTile({required this.item});

  final IntensityCitySearchItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eq = item.earthquake;
    final originTime = eq.originTime;
    final hypocenter = eq.hypocenter;
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final magnitude = hypocenter?.magnitude.toEarthquakeMagnitude;

    return ListTile(
      leading: JmaIntensityIcon(
        intensity: item.intensity.toJmaIntensity,
        type: IntensityIconType.filled,
        size: 36,
      ),
      title: Text(
        hypocenter?.name ?? '震源不明',
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: originTime != null
          ? Text('${dateFormatter.format(originTime.toLocal())}発生')
          : null,
      trailing: magnitude != null ? MagnitudeText(magnitude: magnitude) : null,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        date,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurface,
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
              subtitle: Text('2026/06/27 12:34発生'),
              trailing: Text('M6.0'),
            ),
        ],
      ),
    );
  }
}
