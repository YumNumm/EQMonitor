import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/widget/error_widget.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryScreen extends HookConsumerWidget {
  const EarthquakeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(const EarthquakeHistoryParameter());
    final state = ref.watch(earthquakeHistoryNotifierProvider(parameter.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('地震履歴'),
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
        onRefresh: () async {
          await ref
              .read(earthquakeHistoryNotifierProvider(parameter.value).notifier)
              .refresh();
        },
        onScrollEnd: () async {
          await ref
              .read(earthquakeHistoryNotifierProvider(parameter.value).notifier)
              .fetchNextData();
        },
      ),
    );
  }
}

class _SearchParameter extends StatelessWidget {
  const _SearchParameter({
    required this.parameter,
    required this.onChanged,
  });
  final EarthquakeHistoryParameter parameter;
  final void Function(EarthquakeHistoryParameter) onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
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
  final AsyncValue<(List<EarthquakeV1Extended>, int)> state;

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
      required (List<EarthquakeV1Extended>, int) data,
      Widget loading = const Padding(
        padding: EdgeInsets.all(48),
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    }) {
      if (data.$1.isEmpty) {
        return const EarthquakeHistoryNotFound();
      }
      return PrimaryScrollController(
        controller: controller,
        child: ListView.builder(
          clipBehavior: Clip.antiAlias,
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
                return const EarthquakeHistoryAllFetched();
              }
            }
            final item = data.$1[index];
            return EarthquakeHistoryListTile(
              item: item,
              onTap: () => EarthquakeHistoryDetailsRoute(
                eventId: item.eventId,
              ).push<void>(context),
            );
          },
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
            if (error is EarthquakeParameterHasNotInitializedException) {
              final parameterState = ref.watch(jmaParameterProvider);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('観測点情報が初期化されていません'),
                    if (parameterState.isLoading)
                      const CircularProgressIndicator.adaptive()
                    else
                      FilledButton(
                        child: const Text('観測点情報を再取得'),
                        onPressed: () async =>
                            ref.invalidate(jmaParameterProvider),
                      ),
                  ],
                ),
              );
            }
            final valueOrNull = state.valueOrNull;
            if (valueOrNull != null) {
              return listView(data: valueOrNull);
            }
            return ErrorInfoWidget(
              error: error,
              onRefresh: () =>
                  ref.invalidate(earthquakeHistoryNotifierProvider),
            );
          }(),
        AsyncData(:final value) => listView(data: value),
      },
    );
  }
}
