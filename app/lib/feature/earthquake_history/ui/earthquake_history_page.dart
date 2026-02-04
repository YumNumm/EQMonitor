import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_search_parameter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
    final state = ref.watch(earthquakeHistoryProvider(parameter.value));

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then((_) async {
          if (parameter.value == const EarthquakeHistoryParameter() &&
              (state.value?.items.length ?? 0) <= 10) {
            await ref
                .read(
                  earthquakeHistoryProvider(parameter.value).notifier,
                )
                .fetchNextData();
          }
        }),
      );
      return null;
    }, [parameter.value]);

    Future<void> onRefresh() async =>
        ref.read(earthquakeHistoryProvider(parameter.value).notifier).refresh();

    final controller = PrimaryScrollController.of(context);
    useEffect(() {
      controller.addListener(() async {
        if (state.hasError || state.isRefreshing || !state.hasValue) {
          return;
        }
        if (controller.position.pixels >=
            controller.position.maxScrollExtent - 100) {
          await ref
              .read(earthquakeHistoryProvider(parameter.value).notifier)
              .fetchNextData();
        }
      });
      return null;
    }, [controller, state]);

    Widget buildStickyHeaderList({
      required List<EarthquakePartial> items,
      required bool hasNext,
    }) {
      if (items.isEmpty) {
        return const EarthquakeHistoryNotFound();
      }

      // 日付ごとにグループ化
      final groupedItems = _groupByDate(items);

      return CustomScrollView(
        controller: controller,
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
                    parameter.value = result;
                  }
                },
              ),
            ],
          ),
          for (final entry in groupedItems.entries) ...[
            SliverStickyHeader(
              header: _DateHeader(date: entry.key),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = entry.value[index];
                    final theme = Theme.of(context);
                    return Column(
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
                          indent: 0,
                          endIndent: 0,
                          thickness: 0,
                          color: theme.colorScheme.onInverseSurface,
                        ),
                      ],
                    );
                  },
                  childCount: entry.value.length,
                ),
              ),
            ),
          ],
          // ローディング/エラー/完了表示
          SliverToBoxAdapter(
            child: switch (state) {
              AsyncError(:final error) => ErrorCard(
                error: error,
                onReload: onRefresh,
              ),
              AsyncData(:final value) =>
                value.hasNext
                    ? const EarthquakeHistoryAllFetched()
                    : const SizedBox.shrink(),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh.call(),
      child: switch (state) {
        AsyncError(:final error) => () {
          final valueOrNull = state.value;
          if (valueOrNull != null) {
            return buildStickyHeaderList(
              items: valueOrNull.items,
              hasNext: valueOrNull.hasNext,
            );
          }
          return ErrorCard(
            error: error,
            onReload: () async =>
                ref.refresh(earthquakeHistoryProvider(parameter.value)),
          );
        }(),
        AsyncData(:final value) => buildStickyHeaderList(
          items: value.items,
          hasNext: value.hasNext,
        ),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
    );
  }

  /// 地震データを日付(JST)ごとにグループ化する
  Map<String, List<EarthquakePartial>> _groupByDate(
    List<EarthquakePartial> items,
  ) {
    final dateFormatter = DateFormat('yyyy/MM/dd');
    final grouped = <String, List<EarthquakePartial>>{};

    for (final item in items) {
      // originTimeを優先し、なければarrivalTimeを使用
      final dateTime = item.originTime ?? item.arrivalTime;
      final dateKey = dateTime != null
          ? dateFormatter.format(dateTime.toLocal())
          : '不明';

      grouped.putIfAbsent(dateKey, () => []).add(item);
    }

    return grouped;
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
