import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/fnet_catalog/data/notifier/fnet_catalog_notifier.dart';
import 'package:eqmonitor/feature/fnet_catalog/ui/components/fnet_catalog_list_tile.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';

/// F-netカタログページ
class FnetCatalogPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentYear = DateTime.now().tokyoDateTime.year;
    final selectedYear = useState(currentYear);
    final selectedMonth = useState<int?>(null);

    final state = ref.watch(
      fnetCatalogProvider(
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
            fnetCatalogProvider(
              year: selectedYear.value,
              month: selectedMonth.value,
            ),
            asReload: true,
          );
        },
        child: switch (state) {
          AsyncData(:final value) =>
            value.isEmpty
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
                M3EElevatedButton(
                  onPressed: () {
                    ref.invalidate(
                      fnetCatalogProvider(
                        year: selectedYear.value,
                        month: selectedMonth.value,
                      ),
                      asReload: true,
                    );
                  },
                  child: const Text('再読み込み'),
                ),
              ],
            ),
          ),
          _ => const Center(
            child: AccessibleCircularProgressIndicator(),
          ),
        },
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const new({
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
    final currentYear = DateTime.now().tokyoDateTime.year;
    final years = List.generate(10, (index) => currentYear - index);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ControlledDropdown<int>(
              singleSelect: true,
              fieldStyle: const M3EDropdownFieldStyle(
                hintText: '年',
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: years.map((year) {
                return M3EDropdownItem(
                  value: year,
                  selected: year == selectedYear,
                  label: '$year年',
                );
              }).toList(),
              onSelectionChanged: (selection) {
                if (selection.isNotEmpty) onYearChanged(selection.first.value);
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ControlledDropdown<int?>(
              singleSelect: true,
              fieldStyle: const M3EDropdownFieldStyle(
                hintText: '月',
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: [
                M3EDropdownItem<int?>(
                  value: null,
                  label: '全て',
                  selected: selectedMonth == null,
                ),
                ...List.generate(12, (index) => index + 1).map((month) {
                  return M3EDropdownItem(
                    value: month,
                    selected: month == selectedMonth,
                    label: '$month月',
                  );
                }),
              ],
              onSelectionChanged: (selection) {
                if (selection.isNotEmpty) onMonthChanged(selection.first.value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
