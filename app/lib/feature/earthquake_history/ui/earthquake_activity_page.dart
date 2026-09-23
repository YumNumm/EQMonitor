import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_binner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_summary_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_bin.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_bin_interval.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_activity_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeActivityPage extends HookConsumerWidget {
  const new({required this.initialQuery, super.key});

  final EarthquakeActivityQuery initialQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState(initialQuery);
    final interval = useState(
      EarthquakeActivityBinInterval.forDuration(
        initialQuery.requestedEnd.difference(initialQuery.start),
      ),
    );
    final state = ref.watch(earthquakeActivityProvider(query.value));
    final progress = ref.watch(earthquakeActivityProgressProvider(query.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('周辺の地震活動'),
        actions: [
          IconButton(
            tooltip: '再読み込み',
            onPressed: () => ref
                .read(earthquakeActivityProvider(query.value).notifier)
                .refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: switch (state) {
        AsyncValue(:final value?) => ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Text(
              '基準時刻 ${query.value.baseOriginTime.formatWithTz(DateTimeFormat.yearMonthDayHourMinute)}',
            ),
            const Text('近接する地震を時空間条件で抽出したもので、前震・余震を断定するものではありません。'),
            const Text('地震履歴に収録された情報を集計しており、観測された全地震ではありません。'),
            const SizedBox(height: 12),
            _ActivityControls(
              query: query.value,
              interval: interval.value,
              onQueryChanged: (value) => query.value = value,
              onIntervalChanged: (value) => interval.value = value,
            ),
            const SizedBox(height: 12),
            _ActivitySummary(query: query.value, items: value.items),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.map_outlined),
                        SizedBox(width: 8),
                        Text('震源分布（コンパクトマップ）'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '中心 ${query.value.latitude.toStringAsFixed(2)}, '
                      '${query.value.longitude.toStringAsFixed(2)} / '
                      '半径${query.value.radiusKm}km内 ${value.items.length}件',
                    ),
                  ],
                ),
              ),
            ),
            _ActivityChart(
              bins: const EarthquakeActivityBinner().build(
                items: value.items,
                interval: interval.value,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '地震一覧（${value.items.length}件）',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            for (final item in value.items)
              ListTile(
                leading: CircleAvatar(
                  child: Text(item.intensity?.maxIntensity.label ?? '－'),
                ),
                title: Text(item.hypocenter?.name ?? '震源地不明'),
                subtitle: Text(
                  '${(item.originTime ?? query.value.baseOriginTime).formatWithTz(DateTimeFormat.yearMonthDayHourMinute)}  '
                  '${switch (item.hypocenter?.magnitude) {
                    EarthquakeMagnitudeValue(:final value) => 'M${value.toStringAsFixed(1)}',
                    EarthquakeMagnitudeOverM8() => 'M8超',
                    _ => 'M不明',
                  }}',
                ),
              ),
            Text(
              '最終更新 ${value.fetchedAt.formatWithTz(DateTimeFormat.yearMonthDayHourMinute)}',
              textAlign: .end,
            ),
          ],
        ),
        AsyncError() => Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              const Text('周辺の地震活動を取得できませんでした'),
              M3EFilledButton(
                onPressed: () =>
                    ref.invalidate(earthquakeActivityProvider(query.value)),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
        _ => Center(child: Text('地震履歴を取得中… $progress件')),
      },
    );
  }
}

class _ActivityControls extends StatelessWidget {
  const new({
    required this.query,
    required this.interval,
    required this.onQueryChanged,
    required this.onIntervalChanged,
  });
  final EarthquakeActivityQuery query;
  final EarthquakeActivityBinInterval interval;
  final ValueChanged<EarthquakeActivityQuery> onQueryChanged;
  final ValueChanged<EarthquakeActivityBinInterval> onIntervalChanged;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: .center,
        children: [
          M3EOutlinedButton(
            onPressed: query.beforeDays >= 30
                ? null
                : () => onQueryChanged(
                    query.copyWith(beforeDays: query.beforeDays + 1),
                  ),
            child: const Text('前日を表示'),
          ),
          M3EOutlinedButton(
            onPressed: query.afterDays >= 365
                ? null
                : () => onQueryChanged(
                    query.copyWith(afterDays: query.afterDays + 1),
                  ),
            child: const Text('翌日を表示'),
          ),
          M3ETextButton(
            onPressed: () => onQueryChanged(
              query.copyWith(
                beforeDays: 1,
                afterDays: 7,
                radiusKm: 25,
                depthOffsetKm: query.depth == null ? null : 20,
              ),
            ),
            child: const Text('初期値に戻す'),
          ),
          SizedBox(
            width: 180,
            child: ControlledDropdown<int>(
              singleSelect: true,
              items:
                  ([25, 50, 100, 200]
                          .map(
                            (v) => M3EDropdownItem(value: v, label: '半径${v}km'),
                          )
                          .toList())
                      .map(
                        (item) => item.copyWith(
                          selected: item.value == query.radiusKm,
                        ),
                      )
                      .toList(),
              onSelectionChanged: (selection) {
                if (selection.isEmpty) return;
                final v = selection.first.value;
                onQueryChanged(query.copyWith(radiusKm: v));
              },
            ),
          ),
          if (query.depth != null)
            SizedBox(
              width: 180,
              child: ControlledDropdown<int>(
                singleSelect: true,
                items:
                    ([20, 50, 100, 200]
                            .map(
                              (v) =>
                                  M3EDropdownItem(value: v, label: '深さ±${v}km'),
                            )
                            .toList())
                        .map(
                          (item) => item.copyWith(
                            selected: item.value == query.depthOffsetKm,
                          ),
                        )
                        .toList(),
                onSelectionChanged: (selection) {
                  if (selection.isEmpty) return;
                  final v = selection.first.value;
                  onQueryChanged(query.copyWith(depthOffsetKm: v));
                },
              ),
            ),
          SizedBox(
            width: 180,
            child: ControlledDropdown<EarthquakeActivityBinInterval>(
              singleSelect: true,
              items:
                  (EarthquakeActivityBinInterval.values
                          .map((v) => M3EDropdownItem(value: v, label: v.label))
                          .toList())
                      .map(
                        (item) =>
                            item.copyWith(selected: item.value == interval),
                      )
                      .toList(),
              onSelectionChanged: (selection) {
                if (selection.isEmpty) return;
                final v = selection.first.value;
                onIntervalChanged(v);
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class _ActivitySummary extends StatelessWidget {
  const new({required this.query, required this.items});
  final EarthquakeActivityQuery query;
  final List<EarthquakePartialNormal> items;
  @override
  Widget build(BuildContext context) {
    final summary = const EarthquakeActivitySummaryBuilder().build(
      items: items,
      query: query,
    );
    return Card(
      child: ListTile(
        title: Text(
          '前${query.beforeDays}日 ${summary.beforeCount}件 / 発生後${query.afterDays}日 ${summary.afterCount}件',
        ),
        subtitle: Text('最大震度 ${summary.maxIntensity?.label ?? '不明'}'),
      ),
    );
  }
}

class _ActivityChart extends StatelessWidget {
  const new({required this.bins});
  final List<EarthquakeActivityBin> bins;
  @override
  Widget build(BuildContext context) {
    final maximum = bins.fold<int>(
      1,
      (m, b) => b.totalCount > m ? b.totalCount : m,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const Text('時間別地震回数'),
            for (final bin in bins)
              Semantics(
                label: '${bin.start}から、合計${bin.totalCount}件',
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          bin.start.formatWithTz(
                            DateTimeFormat.monthDayHourMinute,
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Expanded(
                        child: AccessibleLinearProgressIndicator(
                          value: bin.totalCount / maximum,
                          minHeight: 12,
                        ),
                      ),
                      SizedBox(width: 32, child: Text('${bin.totalCount}')),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
