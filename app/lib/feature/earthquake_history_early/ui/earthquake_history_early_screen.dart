import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/component/chip/date_range_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/widget/error_widget.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/earthquake_history_early_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/model/earthquake_history_early_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/chip/earthquake_history_early_sort_chip.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/earthquake_history_early_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/earthquake_history_early_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeHistoryEarlyRoute extends GoRouteData {
  const EarthquakeHistoryEarlyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EarthquakeHistoryEarlyScreen();
  }
}

class EarthquakeHistoryEarlyScreen extends HookConsumerWidget {
  const EarthquakeHistoryEarlyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(
      const EarthquakeHistoryEarlyParameter(
        sort: EarthquakeEarlySortType.max_intensity,
        ascending: false,
      ),
    );
    final state = ref.watch(
      earthquakeHistoryEarlyNotifierProvider(parameter.value),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('過去の地震履歴(仮)'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _SearchParameter(
            parameter: parameter.value,
            onChanged: (value) => parameter.value = value,
          ),
        ),
      ),
      body: _SliverListBody(
        state: state,
        onRefresh: () async => ref.refresh(
          earthquakeHistoryEarlyNotifierProvider(parameter.value).notifier,
        ),
        onScrollEnd: () async => ref
            .read(
              earthquakeHistoryEarlyNotifierProvider(parameter.value).notifier,
            )
            .fetchNextData(),
      ),
    );
  }
}

class _SearchParameter extends StatelessWidget {
  const _SearchParameter({
    required this.parameter,
    required this.onChanged,
  });
  final EarthquakeHistoryEarlyParameter parameter;
  final void Function(EarthquakeHistoryEarlyParameter) onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: IntrinsicHeight(
          child: Row(
            children: [
              EarthquakeHistoryEarlySortChip(
                type: parameter.sort,
                ascending: parameter.ascending,
                onChanged: (type, ascending) => onChanged(
                  parameter.updateSort(
                    type: type,
                    ascending: ascending,
                  ),
                ),
              ),
              const VerticalDivider(),
              IntensityFilterChip(
                min: parameter.intensityGte,
                max: parameter.intensityLte,
                onChanged: (min, max) => onChanged(
                  parameter.updateIntensity(min, max),
                ),
              ),
              MagnitudeFilterChip(
                min: parameter.magnitudeGte,
                max: parameter.magnitudeLte,
                onChanged: (min, max) => onChanged(
                  parameter.updateMagnitude(min, max),
                ),
              ),
              DepthFilterChip(
                min: parameter.depthGte?.toInt(),
                max: parameter.depthLte?.toInt(),
                onChanged: (min, max) => onChanged(
                  parameter.updateDepth(
                    min?.toDouble(),
                    max?.toDouble(),
                  ),
                ),
              ),
              DateRangeFilterChip(
                min: parameter.originTimeGte,
                max: parameter.originTimeLte,
                onChanged: (min, max) => onChanged(
                  parameter.updateOriginTime(min, max),
                ),
              ),
            ]
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _SliverListBody extends HookConsumerWidget {
  const _SliverListBody({
    required this.state,
    this.onRefresh,
    this.onScrollEnd,
  });

  final void Function()? onRefresh;
  final void Function()? onScrollEnd;
  final AsyncValue<(List<EarthquakeEarly>, int)> state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => PrimaryScrollController.of(context));
    useEffect(
      () {
        controller.addListener(() {
          if (state.hasError || state.isRefreshing || !state.hasValue) {
            return;
          }
          if (controller.position.pixels >=
              controller.position.maxScrollExtent - 100) {
            onScrollEnd?.call();
          }
        });
        return null;
      },
      [controller, state, onScrollEnd, onRefresh],
    );

    Widget listView({
      required (List<EarthquakeEarly>, int) data,
      Widget loading = const Padding(
        padding: EdgeInsets.all(48),
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    }) {
      if (data.$1.isEmpty) {
        return const EarthquakeHistoryEarlyNotFound();
      }
      return Material(
        child: PrimaryScrollController(
          controller: controller,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: data.$1.length + 1,
            itemBuilder: (context, index) {
              if (index == data.$1.length) {
                if (state.isLoading) {
                  return loading;
                }
                if (state.hasError) {
                  final error = state.error!;
                  return ErrorInfoWidget(
                    error: error,
                    onRefresh: onRefresh,
                  );
                }
                final hasNext = state.valueOrNull?.hasNext ?? false;
                if (hasNext) {
                  return loading;
                } else {
                  return const EarthquakeHistoryEarlyAllFetched();
                }
              }
              final item = data.$1[index];
              return EarthquakeHistoryEarlyListTile(
                item: item,
              );
            },
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: switch (state) {
        AsyncLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        AsyncError(:final error) => () {
            final valueOrNull = state.valueOrNull;
            if (valueOrNull != null) {
              return listView(data: valueOrNull);
            }
            return ErrorInfoWidget(
              error: error,
              onRefresh: () =>
                  ref.invalidate(earthquakeHistoryEarlyNotifierProvider),
            );
          }(),
        AsyncData(:final value) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: '全'),
                      TextSpan(
                        text: NumberFormat('#,###').format(value.$2),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: '件の地震情報が見つかりました'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: listView(data: value),
              ),
            ],
          ),
      },
    );
  }
}
