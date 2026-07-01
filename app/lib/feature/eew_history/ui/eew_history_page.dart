import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/data/notifier/eew_list_data_source.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_history_list_tile.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_list_parameter_persistent_delegate.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/pinned_active_eew_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EewHistoryPage extends HookConsumerWidget {
  const EewHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(const EewListParameter());
    final dataSourceAsync = ref.watch(
      eewListDataSourceProvider(parameter.value),
    );

    return Scaffold(
      body: dataSourceAsync.when(
        loading: () => const _Skeleton(),
        error: (error, _) => ErrorCard(
          error: error,
          onReload: () async =>
              ref.refresh(eewListDataSourceProvider(parameter.value)),
        ),
        data: (dataSource) => _PagingBody(
          dataSource: dataSource,
          parameter: parameter,
          intensityColor: ref.watch(intensityColorProvider),
          onRefresh: () => dataSource.refresh(),
        ),
      ),
    );
  }
}

class _PagingBody extends StatelessWidget {
  const _PagingBody({
    required this.dataSource,
    required this.parameter,
    required this.intensityColor,
    required this.onRefresh,
  });

  final EewListDataSource dataSource;
  final ValueNotifier<EewListParameter> parameter;
  final IntensityColorModel intensityColor;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: Text('緊急地震速報 一覧'),
          ),
          const PinnedActiveEewSection(),
          SliverPersistentHeader(
            pinned: true,
            delegate: EewListParameterPersistentDelegate(
              parameter: parameter.value,
              onChanged: (next) => parameter.value = next,
            ),
          ),
          SliverGroupedPagingList<String?, String, EewTelegramItem>(
            dataSource: dataSource,
            stickyHeader: true,
            headerBuilder: (_, date, _) => _DateHeader(date: date),
            itemBuilder: (context, item, globalIndex, localIndex) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EewHistoryListTile(
                  item: item,
                  intensityColor: intensityColor,
                  visualDensity: VisualDensity.compact,
                  onTap: () async => EewDetailsByEventIdRoute(
                    eventId: item.eventId,
                  ).push<void>(context),
                ),
                Divider(
                  height: 0,
                  thickness: 0,
                  color: context.designSystem.colorTheme.onInverseSurface,
                ),
              ],
            ),
            initialLoadingWidget: const _Skeleton(scrollable: false),
            appendLoadingWidget: const _Skeleton(
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
                child: Text('緊急地震速報の履歴がありません'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton({this.itemCount = 5, this.scrollable = true});

  final int itemCount;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      for (var i = 0; i < itemCount; i++)
        const ListTile(
          leading: CircleAvatar(radius: 20),
          title: Text('宮城県沖'),
          subtitle: Text('2026/06/27 12:34発生 深さ 10km'),
          trailing: Text('M6.0'),
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
    final spacing = theme.designSystemThemeExtension.spacing;
    return Container(
      color: context.designSystem.colorTheme.surfaceContainer,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.xs,
      ),
      child: Text(
        date,
        style: theme.textTheme.titleSmall?.copyWith(
          color: context.designSystem.colorTheme.onSurface,
        ),
      ),
    );
  }
}
