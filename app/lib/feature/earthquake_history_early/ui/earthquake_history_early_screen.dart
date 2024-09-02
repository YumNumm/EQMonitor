import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:eqmonitor/core/component/chip/date_range_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/widget/error_widget.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/earthquake_history_early_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/model/earthquake_history_early_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/chip/earthquake_history_early_sort_chip.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/earthquake_history_early_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/earthquake_history_early_not_found.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_details_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        title: const Text('震度データベース'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _SearchParameter(
            parameter: parameter.value,
            onChanged: (value) => parameter.value = value,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () async =>
                _EarthquakeHistoryEarlyInformationModal.show(context),
          ),
        ],
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
        shouldShowLatestEarthquakeMessage:
            parameter.value.sort == EarthquakeEarlySortType.origin_time &&
                !parameter.value.ascending,
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
    this.shouldShowLatestEarthquakeMessage = false,
  });

  final void Function()? onRefresh;
  final void Function()? onScrollEnd;
  final AsyncValue<(List<EarthquakeEarly>, int)> state;

  /// 「最新の地震情報を見るためには地震履歴を使ってください」メッセージを表示するかどうか
  final bool shouldShowLatestEarthquakeMessage;

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
    final theme = Theme.of(context);
    final colorSchema = theme.colorScheme;

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
                onTap: () async => EarthquakeHistoryEarlyDetailsRoute(
                  id: item.id,
                ).push<void>(context),
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
              if (shouldShowLatestEarthquakeMessage)
                Card(
                  color: colorSchema.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: '最新の地震情報を見るためには'),
                          TextSpan(
                            text: '地震履歴',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => const EarthquakeHistoryRoute()
                                  .push<void>(context),
                          ),
                          const TextSpan(text: 'を使ってください'),
                        ],
                      ),
                      style: TextStyle(
                        color: colorSchema.onSecondaryContainer,
                      ),
                    ),
                  ),
                ),
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

class _EarthquakeHistoryEarlyInformationModal extends StatelessWidget {
  const _EarthquakeHistoryEarlyInformationModal();

  static Future<void> show(BuildContext context) async => showModalBottomSheet(
        context: context,
        builder: (_) => const _EarthquakeHistoryEarlyInformationModal(),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Center(child: sheetBar),
          Expanded(
            child: Markdown(
              onTapLink: (_, url, __) async {
                if (url != null && await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                }
              },
              data: '''
### **震度データベースについて**
震度データベースは、1919年からの気象庁震度データを取りまとめたものです。

### **利用上の注意**
- 本アプリケーションで表示される震度データは、本アプリケーション用に構築した独自のサーバーにより提供されています。そのため、**気象庁の公開する震度データベースに掲載されてから本アプリケーションに反映されるまでには数週間程度のタイムラグ**が生じる場合があります。
  - 最新の地震情報については、アプリケーション内の地震履歴画面や気象庁の公式サイトなどをご確認ください。
- **本データベースには、一部計測時刻が不明なデータが含まれています。**(「日時分不明データ」や「時分不明データ」「分不明データ」と記載)
- 1996(平成8年)9月以前の震度5・6は、便宜上 それぞれ震度5弱・6弱と表記している箇所があります。

### **データの取得元**
- [気象庁 震度データベース](https://www.data.jma.go.jp/svd/eqdb/data/shindo/)

''',
              softLineBreak: true,
            ),
          ),
          ActionButton.text(
            context: context,
            text: '閉じる',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
