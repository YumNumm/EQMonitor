import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DepthFilterChip extends StatelessWidget {
  const DepthFilterChip({
    this.min,
    this.max,
    this.onChanged,
    super.key,
  });

  /// マグニチュードの範囲が変更された時に呼ばれる
  /// `min` と `max` にはそれぞれ下限値と上限値が渡される
  /// どちらかが `null` の場合はその値は指定されていないことを示す
  final void Function(int?, int?)? onChanged;

  final int? min;
  final int? max;

  static const int initialMin = 0;
  static const int initialMax = 700;

  @override
  Widget build(BuildContext context) {
    final range = (min, max);

    return RawChip(
      onSelected: (_) async {
        final result = await showModalBottomSheet<(int?, int?)?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (context) => _DepthFilterModal(
            currentMin: min,
            currentMax: max,
          ),
        );
        if (result != null) {
          onChanged?.call(result.min, result.max);
        }
      },
      label: (range.isAllSelected)
          ? const Text('震源の深さ')
          : Text(range.toRangeString),
      onDeleted: range.isAllSelected
          ? null
          : () => onChanged?.call(initialMin, initialMax),
      selected: !range.isAllSelected,
      selectedColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }
}

class _DepthFilterModal extends HookWidget {
  const _DepthFilterModal({
    this.currentMin = initialMin,
    this.currentMax = initialMax,
  });
  final int? currentMin;
  final int? currentMax;

  static const int initialMin = DepthFilterChip.initialMin;
  static const int initialMax = DepthFilterChip.initialMax;

  @override
  Widget build(BuildContext context) {
    final min = useState<int>(currentMin ?? initialMin);
    final max = useState<int>(currentMax ?? initialMax);

    final theme = Theme.of(context);
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onBackground,
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
              '震源の深さ',
              style: theme.textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 24),
          RangeSlider(
            values: RangeValues(
              min.value.toDouble(),
              max.value.toDouble(),
            ),
            min: initialMin.toDouble(),
            max: initialMax.toDouble(),
            onChanged: (state) {
              min.value =
                  (state.start.toInt() / 10).roundToDouble().toInt() * 10;
              max.value = (state.end.toInt() / 10).roundToDouble().toInt() * 10;
            },
            labels: RangeLabels(
              '${min.value}km',
              '${max.value}km',
            ),
            divisions: (initialMax - initialMin) ~/ 10,
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              (min.value, max.value).toRangeString,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop((min.value, max.value)),
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

extension _MinMaxint on (int?, int?) {
  int? get min => this.$1;
  int? get max => this.$2;

  bool get isMinSelected => min == 0 || min == null;
  bool get isMaxSelected => max == 700 || max == null;

  bool get isAllSelected => isMinSelected && isMaxSelected;

  String get toRangeString {
    // 何も指定していない時
    if (isAllSelected) {
      return '全て';
    }
    // どちらも同じの時
    if (min == max) {
      return '${min}km';
    }
    // 下限値のみ指定している時
    if (isMaxSelected) {
      return '${min}km 以上';
    }
    // 上限値のみ指定している時
    if (isMinSelected) {
      return '${max}km 以下';
    }
    return '${min}km ~ ${max}km';
  }
}
