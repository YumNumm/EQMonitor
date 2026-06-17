import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SortFilterChip extends StatelessWidget {
  const SortFilterChip({
    this.sortBy,
    this.sortOrder,
    this.onChanged,
    super.key,
  });

  final EarthquakeSortBy? sortBy;
  final SortOrder? sortOrder;
  final void Function(EarthquakeSortBy?, SortOrder?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDefault = sortBy == null && sortOrder == null;
    final displaySortBy = sortBy ?? .eventId;
    final displayOrder = sortOrder ?? .desc;

    return RawChip(
      onSelected: (_) async {
        final result =
            await showModalBottomSheet<(EarthquakeSortBy?, SortOrder?)?>(
              clipBehavior: Clip.antiAlias,
              context: context,
              builder: (context) => _SortFilterModal(
                currentSortBy: sortBy,
                currentSortOrder: sortOrder,
              ),
            );
        if (result != null) {
          onChanged?.call(result.$1, result.$2);
        }
      },
      label: isDefault
          ? const Text('新しい順')
          : Text(
              '${displaySortBy.label} ${displayOrder.arrow}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
      onDeleted: isDefault ? null : () => onChanged?.call(null, null),
      selected: !isDefault,
      selectedColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }
}

class _SortFilterModal extends HookWidget {
  const _SortFilterModal({this.currentSortBy, this.currentSortOrder});

  final EarthquakeSortBy? currentSortBy;
  final SortOrder? currentSortOrder;

  @override
  Widget build(BuildContext context) {
    final sortBy = useState<EarthquakeSortBy>(currentSortBy ?? .eventId);
    final sortOrder = useState<SortOrder>(currentSortOrder ?? .desc);

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: sheetBar),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              '並び替え',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RadioGroup<EarthquakeSortBy>(
            groupValue: sortBy.value,
            onChanged: (value) {
              if (value != null) {
                sortBy.value = value;
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in EarthquakeSortBy.values)
                  RadioListTile<EarthquakeSortBy>(
                    title: Text(item.label),
                    value: item,
                  ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<SortOrder>(
              segments: [
                for (final order in SortOrder.values)
                  ButtonSegment(
                    value: order,
                    label: Text('${order.label} ${order.arrow}'),
                  ),
              ],
              selected: {sortOrder.value},
              onSelectionChanged: (selected) {
                sortOrder.value = selected.first;
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () {
                  final isDefault =
                      sortBy.value == .eventId && sortOrder.value == .desc;
                  Navigator.of(context).pop(
                    isDefault ? (null, null) : (sortBy.value, sortOrder.value),
                  );
                },
                child: const Text('完了'),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
