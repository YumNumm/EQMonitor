import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/notifier/fnet_catalog_notifier.dart';
import 'components/fnet_catalog_list_tile.dart';

/// F-netカタログページ
class FnetCatalogPage extends HookConsumerWidget {
  const FnetCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentYear = DateTime.now().year;
    final selectedYear = useState(currentYear);
    final selectedMonth = useState<int?>(null);

    final state = ref.watch(
      fnetCatalogNotifierProvider(
        year: selectedYear.value,
        month: selectedMonth.value,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('F-net 地震カタログ'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _FilterBar(
            selectedYear: selectedYear.value,
            selectedMonth: selectedMonth.value,
            onYearChanged: (year) {
              selectedYear.value = year;
            },
            onMonthChanged: (month) {
              selectedMonth.value = month;
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(
            fnetCatalogNotifierProvider(
              year: selectedYear.value,
              month: selectedMonth.value,
            ),
          );
        },
        child: switch (state) {
          AsyncData(:final value) => value.isEmpty
              ? const Center(
                  child: Text('データがありません'),
                )
              : ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final event = value[index];
                    return FnetCatalogListTile(event: event);
                  },
                ),
          AsyncError(:final error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('エラーが発生しました\n$error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(
                        fnetCatalogNotifierProvider(
                          year: selectedYear.value,
                          month: selectedMonth.value,
                        ),
                      );
                    },
                    child: const Text('再読み込み'),
                  ),
                ],
              ),
            ),
          _ => const Center(
              child: CircularProgressIndicator(),
            ),
        },
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.selectedYear,
    required this.selectedMonth,
    required this.onYearChanged,
    required this.onMonthChanged,
  });

  final int selectedYear;
  final int? selectedMonth;
  final ValueChanged<int> onYearChanged;
  final ValueChanged<int?> onMonthChanged;

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final years = List.generate(10, (index) => currentYear - index);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int>(
              value: selectedYear,
              decoration: const InputDecoration(
                labelText: '年',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: years.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text('$year年'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onYearChanged(value);
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<int?>(
              value: selectedMonth,
              decoration: const InputDecoration(
                labelText: '月',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('全て'),
                ),
                ...List.generate(12, (index) => index + 1).map((month) {
                  return DropdownMenuItem(
                    value: month,
                    child: Text('$month月'),
                  );
                }),
              ],
              onChanged: onMonthChanged,
            ),
          ),
        ],
      ),
    );
  }
}
