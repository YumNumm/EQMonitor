import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:flutter/material.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EarthquakeHistoryPagingList extends StatelessWidget {
  const EarthquakeHistoryPagingList({
    required this.dataSource,
    required this.parameter,
    required this.config,
    super.key,
  });

  final EarthquakeHistoryDataSource dataSource;
  final EarthquakeHistoryParameter parameter;
  final EarthquakeHistoryListConfig config;

  @override
  Widget build(BuildContext context) {
    final showDateHeaders = config.dateHeaderDisplayMode.isVisible(
      sortBy: parameter.sortBy,
    );

    if (!showDateHeaders) {
      return SliverPagingList<String?, EarthquakePartial>(
        dataSource: dataSource,
        builder: (context, item, _) => _EarthquakeHistoryPagingItem(
          item: item,
          parameter: parameter,
          showBackgroundColor: config.isFillBackground,
        ),
        initialLoadingWidget: const EarthquakeHistorySkeleton(
          scrollable: false,
        ),
        appendLoadingWidget: const EarthquakeHistorySkeleton(
          itemCount: 2,
          scrollable: false,
        ),
        errorBuilder: (context, error, stackTrace) =>
            ErrorCard(error: error, onReload: () async => dataSource.refresh()),
        emptyWidget: const EarthquakeHistoryNotFound(),
      );
    }

    return SliverGroupedPagingList<String?, String, EarthquakePartial>(
      dataSource: dataSource,
      stickyHeader: true,
      headerBuilder: (_, date, _) => _DateHeader(date: date),
      itemBuilder: (context, item, _, _) => _EarthquakeHistoryPagingItem(
        item: item,
        parameter: parameter,
        showBackgroundColor: config.isFillBackground,
      ),
      initialLoadingWidget: const EarthquakeHistorySkeleton(scrollable: false),
      appendLoadingWidget: const EarthquakeHistorySkeleton(
        itemCount: 2,
        scrollable: false,
      ),
      errorBuilder: (context, error, stackTrace) =>
          ErrorCard(error: error, onReload: () async => dataSource.refresh()),
      emptyWidget: const EarthquakeHistoryNotFound(),
    );
  }
}

class _EarthquakeHistoryPagingItem extends StatelessWidget {
  const _EarthquakeHistoryPagingItem({
    required this.item,
    required this.parameter,
    required this.showBackgroundColor,
  });

  final EarthquakePartial item;
  final EarthquakeHistoryParameter parameter;
  final bool showBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EarthquakeHistoryListTile(
          item: item,
          searchParameter: parameter,
          onTap: () async => EarthquakeHistoryDetailsRoute(
            eventId: item.earthquake.eventId,
          ).push<void>(context),
          showBackgroundColor: showBackgroundColor,
          visualDensity: VisualDensity.compact,
        ),
        Divider(
          height: 0,
          thickness: 0,
          color: context.designSystem.colorTheme.onInverseSurface,
        ),
      ],
    );
  }
}

class EarthquakeHistorySkeleton extends StatelessWidget {
  const EarthquakeHistorySkeleton({
    this.itemCount = 5,
    this.scrollable = true,
    super.key,
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
    final designSystem = context.designSystem;
    return Container(
      color: designSystem.colorTheme.surfaceContainer,
      padding: EdgeInsets.symmetric(
        horizontal: designSystem.spacing.lg,
        vertical: designSystem.spacing.xs,
      ),
      child: Text(
        date,
        style: theme.textTheme.titleSmall?.copyWith(
          color: designSystem.colorTheme.onSurface,
        ),
      ),
    );
  }
}
