import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/nied/data/provider/nied_api_client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nied_api_client/nied_api_client.dart';
import 'package:timezone/timezone.dart' as tz;

class FnetCatalogPage extends HookConsumerWidget {
  const FnetCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = useState<Month?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('F-net 地震カタログ'),
      ),
      body: Column(
        children: [
          _MonthSelector(
            selectedMonth: selectedMonth.value,
            onMonthChanged: (month) {
              selectedMonth.value = month;
            },
          ),
          Expanded(
            child: _FnetCatalogList(selectedMonth: selectedMonth.value),
          ),
        ],
      ),
    );
  }
}

class _FnetCatalogList extends HookConsumerWidget {
  const _FnetCatalogList({required this.selectedMonth});

  final Month? selectedMonth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final niedApiClient = ref.watch(niedApiClientProvider);

    final future = useMemoized(
      () async {
        final now = DateTime.now().toUtc();
        final targetYear = selectedMonth?.year ?? now.year;
        final targetMonth = selectedMonth?.month ?? now.month;

        return niedApiClient.hinet.fnet.getEventsByMonth(
          year: targetYear,
          month: targetMonth,
        );
      },
      [selectedMonth],
    );

    final snapshot = useFuture(future);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('エラーが発生しました\n${snapshot.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                (context as Element).markNeedsBuild();
              },
              child: const Text('再試行'),
            ),
          ],
        ),
      );
    }

    final events = snapshot.data ?? [];

    if (events.isEmpty) {
      return const Center(
        child: Text('データがありません'),
      );
    }

    final jst = tz.getLocation('Asia/Tokyo');
    final groupedByDate = events.groupListsBy(
      (e) => Date.fromDateTime(tz.TZDateTime.from(e.originTime, jst)),
    );

    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverMainAxisGroup(
            slivers: [
              for (final date in groupedByDate.keys) ...[
                SliverStickyHeader(
                  header: ColoredBox(
                    color: colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        '${date.year}/${date.month}/${date.day}',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          fontFamily: FontFamily.jetBrainsMono,
                        ),
                      ),
                    ),
                  ),
                  sliver: SliverList.builder(
                    itemCount: groupedByDate[date]!.length,
                    itemBuilder: (context, index) {
                      final event = groupedByDate[date]![index];
                      return _EventCard(event: event);
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MonthSelector extends StatelessWidget {
  const _MonthSelector({
    required this.selectedMonth,
    required this.onMonthChanged,
  });

  final Month? selectedMonth;
  final ValueChanged<Month?> onMonthChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              selectedMonth == null
                  ? '対象月: 最新'
                  : '対象月: ${selectedMonth!.year}年${selectedMonth!.month}月',
              style: theme.textTheme.titleSmall,
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              showDialog<Month?>(
                context: context,
                builder: (context) => _MonthPickerDialog(
                  initialMonth: selectedMonth,
                ),
              ).then((result) {
                if (result != null) {
                  onMonthChanged(result);
                }
              });
            },
            icon: const Icon(Icons.calendar_today, size: 18),
            label: const Text('月を選択'),
          ),
          if (selectedMonth != null) ...[
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () => onMonthChanged(null),
              child: const Text('クリア'),
            ),
          ],
        ],
      ),
    );
  }
}

class _MonthPickerDialog extends HookWidget {
  const _MonthPickerDialog({required this.initialMonth});

  final Month? initialMonth;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    final selectedYear = useState(initialMonth?.year ?? currentYear);
    final selectedMonth = useState(initialMonth?.month ?? currentMonth);

    const minYear = 2010;
    final years = List.generate(
      currentYear - minYear + 1,
      (index) => minYear + index,
    );

    final availableMonths = selectedYear.value == currentYear
        ? List.generate(currentMonth, (index) => index + 1)
        : List.generate(12, (index) => index + 1);

    if (!availableMonths.contains(selectedMonth.value)) {
      selectedMonth.value = availableMonths.last;
    }

    return AlertDialog(
      title: const Text('年月を選択'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: DropdownMenu<int>(
              initialSelection: selectedYear.value,
              label: const Text('年'),
              dropdownMenuEntries: years
                  .map(
                    (year) => DropdownMenuEntry(
                      value: year,
                      label: '$year年',
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                if (value != null) {
                  selectedYear.value = value;
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownMenu<int>(
              initialSelection: selectedMonth.value,
              label: const Text('月'),
              dropdownMenuEntries: availableMonths
                  .map(
                    (month) => DropdownMenuEntry(
                      value: month,
                      label: '$month月',
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                if (value != null) {
                  selectedMonth.value = value;
                }
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(
              Month(
                year: selectedYear.value,
                month: selectedMonth.value,
              ),
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _EventCard extends HookWidget {
  const _EventCard({required this.event});

  final FnetEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    final jst = tz.getLocation('Asia/Tokyo');
    final originTime = tz.TZDateTime.from(event.originTime, jst);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.regionName,
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DefaultTextStyle(
              style: theme.textTheme.bodyMedium!.copyWith(
                fontFamily: FontFamily.jetBrainsMono,
                fontFamilyFallback: [FontFamily.notoSansJP],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('発生日時: ${dateFormat.format(originTime)} JST'),
                  Text(
                    'Mj ${event.jmaMagnitude.toStringAsFixed(1)} / Mw ${event.momentMagnitude.toStringAsFixed(1)}',
                  ),
                  Text(
                    '深さ: JMA ${event.jmaDepth.toStringAsFixed(1)}km / MT ${event.mtDepth.toStringAsFixed(1)}km',
                  ),
                  Text(
                    '緯度 ${event.latitude.toStringAsFixed(4)}° / 経度 ${event.longitude.toStringAsFixed(4)}°',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Strike: ${event.strike.plane1.toStringAsFixed(0)}° / ${event.strike.plane2.toStringAsFixed(0)}°',
                  ),
                  Text(
                    'Dip: ${event.dip.plane1.toStringAsFixed(0)}° / ${event.dip.plane2.toStringAsFixed(0)}°',
                  ),
                  Text(
                    'Rake: ${event.rake.plane1.toStringAsFixed(0)}° / ${event.rake.plane2.toStringAsFixed(0)}°',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '地震モーメント: ${event.seismicMoment.toStringAsExponential(2)} Nm',
                  ),
                  Text(
                    '分散低減率: ${event.varianceReduction.toStringAsFixed(1)}%',
                  ),
                  Text(
                    '観測点数: ${event.numberOfStations}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
