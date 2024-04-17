import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MagnitudeFilterChip extends StatelessWidget {
  const MagnitudeFilterChip({
    this.min,
    this.max,
    this.onChanged,
    super.key,
  });

  /// マグニチュードの範囲が変更された時に呼ばれる
  /// `min` と `max` にはそれぞれ下限値と上限値が渡される
  /// どちらかが `null` の場合はその値は指定されていないことを示す
  final void Function(double?, double?)? onChanged;

  final double? min;
  final double? max;

  static const double initialMin = 0;
  static const double initialMax = 9;

  @override
  Widget build(BuildContext context) {
    final range = (min, max);

    return RawChip(
      onSelected: (_) async {
        final result = await showModalBottomSheet<(double?, double?)?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (context) => _MagnitudeFilterModal(
            currentMin: min,
            currentMax: max,
          ),
        );
        if (result != null) {
          onChanged?.call(result.min, result.max);
        }
      },
      label: (range.isAllSelected)
          ? const Text('マグニチュード')
          : Text(
              range.toRangeString,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
      onDeleted: range.isAllSelected
          ? null
          : () => onChanged?.call(initialMin, initialMax),
      selected: !range.isAllSelected,
      selectedColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }
}

class _MagnitudeFilterModal extends HookWidget {
  const _MagnitudeFilterModal({
    this.currentMin = MagnitudeFilterChip.initialMin,
    this.currentMax = MagnitudeFilterChip.initialMax,
  });
  final double? currentMin;
  final double? currentMax;

  @override
  Widget build(BuildContext context) {
    final min = useState<double>(currentMin ?? MagnitudeFilterChip.initialMin);
    final max = useState<double>(currentMax ?? MagnitudeFilterChip.initialMax);

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
              'マグニチュード',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          RangeSlider(
            values: RangeValues(
              min.value,
              max.value,
            ),
            max: 9,
            onChanged: (state) {
              // 小数第1位以下切り捨て
              min.value = (state.start * 10).floorToDouble() / 10;
              max.value = (state.end * 10).floorToDouble() / 10;
            },
            labels: RangeLabels(
              'M${min.value}',
              'M${max.value}',
            ),
            divisions: (MagnitudeFilterChip.initialMax -
                        MagnitudeFilterChip.initialMin)
                    .toInt() *
                10,
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              (min.value, max.value).toRangeString,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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

extension _MinMaxdouble on (double?, double?) {
  double? get min => this.$1;
  double? get max => this.$2;

  bool get isMinSelected =>
      min == MagnitudeFilterChip.initialMin || min == null;
  bool get isMaxSelected =>
      max == MagnitudeFilterChip.initialMax || max == null;

  bool get isAllSelected => isMinSelected && isMaxSelected;

  String get toRangeString {
    // 何も指定していない時
    if (isAllSelected) {
      return '全て';
    }
    // どちらも同じの時
    if (min == max) {
      return 'M$min';
    }
    // 下限値のみ指定している時
    if (isMaxSelected) {
      return 'M$min 以上';
    }
    // 上限値のみ指定している時
    if (isMinSelected) {
      return 'M$max 以下';
    }
    return 'M$min ~ M$max';
  }
}
