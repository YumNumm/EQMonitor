import 'dart:developer';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:eqmonitor/core/component/widget/app_empty_state.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/nied/data/provider/nied_api_client_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nied_api_client/nied_api_client.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timezone/timezone.dart' as tz;

class AquaCatalogPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = useState<Month?>(null);

    return Scaffold(
      appBar: AppBar(title: const Text('メカニズム解カタログ')),
      body: Column(
        children: [
          _MonthSelector(
            selectedMonth: selectedMonth.value,
            onMonthChanged: (month) {
              selectedMonth.value = month;
            },
          ),
          Expanded(child: _AquaCatalogList(selectedMonth: selectedMonth.value)),
        ],
      ),
    );
  }
}

class _AquaCatalogList extends HookConsumerWidget {
  const new({required this.selectedMonth});

  final Month? selectedMonth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final niedApiClient = ref.watch(niedApiClientProvider);

    final future = useMemoized(() async {
      final response = await niedApiClient.hinet.aqua.catalog.getCatalogHtml(
        year: selectedMonth?.year.toString(),
        month: selectedMonth?.month.toString().padLeft(2, '0'),
        onReceiveProgress: (received, total) {
          log('received: $received, total: $total', name: 'onReceiveProgress');
        },
      );
      final parser = AquaHtmlParser();
      return parser.parseCatalog(bytes: Uint8List.fromList(response.data));
    }, [selectedMonth]);

    final snapshot = useFuture(future);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const _AquaCatalogSkeleton();
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
      return const AppEmptyState(
        message: 'データがありません',
        icon: Icons.folder_open_outlined,
      );
    }

    final groupedByDate = events.groupListsBy(
      (e) => Date.fromDateTime(e.originTime),
    );

    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverMainAxisGroup(
            slivers: [
              for (final entry in groupedByDate.entries) ...[
                SliverStickyHeader(
                  header: ColoredBox(
                    color: designSystem.colorTheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        '${entry.key.year}/${entry.key.month}/${entry.key.day}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: designSystem.colorTheme.onSurface,
                          fontFamily: FontFamily.googleSansCode,
                        ),
                      ),
                    ),
                  ),
                  sliver: SliverList.builder(
                    itemCount: entry.value.length,
                    itemBuilder: (context, index) {
                      final event = entry.value[index];
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

class _AquaCatalogSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView(
        children: [
          for (final i in List.generate(5, (i) => i))
            ListTile(
              title: Text('震源地 $i'),
              subtitle: const Text(
                '発生日時: 2026-04-21 12:34:56 JST\nM5.5 / 深さ 10km',
              ),
              trailing: const SizedBox(width: 80, height: 48),
            ),
        ],
      ),
    );
  }
}

class _MonthSelector extends StatelessWidget {
  const new({
    required this.selectedMonth,
    required this.onMonthChanged,
  });

  final Month? selectedMonth;
  final ValueChanged<Month?> onMonthChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: designSystem.colorTheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(color: designSystem.colorTheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(switch (selectedMonth) {
              null => '対象月: 最新',
              final month => '対象月: ${month.year}年${month.month}月',
            }, style: theme.textTheme.titleSmall),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final result = await showAdaptiveDialog<Month?>(
                context: context,
                builder: (context) =>
                    _MonthPickerDialog(initialMonth: selectedMonth),
              );
              if (result != null) {
                onMonthChanged(result);
              }
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
  const new({required this.initialMonth});

  final Month? initialMonth;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    final selectedYear = useState(initialMonth?.year ?? currentYear);
    final selectedMonth = useState(initialMonth?.month ?? currentMonth);

    const minYear = 2004;
    final years = List.generate(
      currentYear - minYear + 1,
      (index) => minYear + index,
    );

    final availableMonths = selectedYear.value == 2004
        ? List.generate(5, (index) => 8 + index)
        : selectedYear.value == currentYear
        ? List.generate(currentMonth, (index) => index + 1)
        : List.generate(12, (index) => index + 1);

    if (!availableMonths.contains(selectedMonth.value)) {
      selectedMonth.value = availableMonths.last;
    }

    return AlertDialog.adaptive(
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
                    (year) => DropdownMenuEntry(value: year, label: '$year年'),
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
                    (month) =>
                        DropdownMenuEntry(value: month, label: '$month月'),
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
            Navigator.of(
              context,
            ).pop(Month(year: selectedYear.value, month: selectedMonth.value));
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _EventCard extends HookWidget {
  const new({required this.event});

  final AquaEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    final urlGenerator = useMemoized(FocalMechanismUrlGenerator.new);
    final urls = useMemoized(
      () => (
        normal: urlGenerator.normal(id: event.id, type: event.type),
        detail: urlGenerator.detail(id: event.id, type: event.type),
      ),
      [event],
    );
    final jst = tz.getLocation('Asia/Tokyo');
    final originTime = tz.TZDateTime.from(event.originTime, jst);
    return ListTile(
      title: Text(event.region),
      subtitle: DefaultTextStyle.merge(
        style: theme.textTheme.bodyMedium?.copyWith(
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: [FontFamily.notoSansJP],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('発生日時: ${dateFormat.format(originTime)} JST'),
            Text(
              'M${event.magnitude.toStringAsFixed(1)} / 深さ ${event.depth.toStringAsFixed(0)}km',
            ),
            Text(
              '緯度 ${event.latitude.toStringAsFixed(1)}° / 経度 ${event.longitude.toStringAsFixed(1)}°',
            ),
            Text('${event.type.fullName} / 観測点数: ${event.stationCount}'),
            if (event.varianceReduction case final varianceReduction?)
              Text('品質: ${varianceReduction.toStringAsFixed(1)}%'),
          ],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Image.network(
            urls.normal,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          Image.network(
            urls.detail,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}
