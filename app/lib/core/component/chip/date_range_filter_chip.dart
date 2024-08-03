import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeFilterChip extends StatelessWidget {
  const DateRangeFilterChip({
    this.min,
    this.max,
    this.onChanged,
    super.key,
  });

  /// 震度の範囲が変更された時に呼ばれる
  /// `min` と `max` にはそれぞれ下限値と上限値が渡される
  /// どちらかが `null` の場合はその値は指定されていないことを示す
  final void Function(DateTime?, DateTime?)? onChanged;

  final DateTime? min;
  final DateTime? max;

  static DateTime initialMin = DateTime(1919);
  static DateTime initialMax = DateTime.now();

  static DateFormat format = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    final range = (min, max);

    return RawChip(
      onSelected: (_) async {
        final result = await showDateRangePicker(
          context: context,
          firstDate: initialMin,
          lastDate: initialMax,
          currentDate: DateTime.now(),
          locale: const Locale('ja'),
          initialEntryMode: DatePickerEntryMode.input,
        );
        if (result != null) {
          onChanged?.call(result.start, result.end);
        }
      },
      label: (range.isAllSelected)
          ? const Text('地震発生日')
          : Text(range.toRangeString),
      onDeleted: range.isAllSelected
          ? null
          : () => onChanged?.call(initialMin, initialMax),
      selected: !range.isAllSelected,
      selectedColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }
}

extension MinMaxDateTime on (DateTime?, DateTime?) {
  DateTime? get min => this.$1;
  DateTime? get max => this.$2;

  bool get isMinSelected =>
      min == DateRangeFilterChip.initialMin || min == null;
  bool get isMaxSelected =>
      max == DateRangeFilterChip.initialMax || max == null;

  bool get isAllSelected => isMinSelected && isMaxSelected;

  String get toRangeString {
    // 何も指定していない時
    if (isAllSelected) {
      return '全て';
    }
    // どちらも同じの時
    if (min == max) {
      return DateRangeFilterChip.format.format(min!);
    }
    // 下限値のみ指定している時
    if (isMaxSelected) {
      return '${DateRangeFilterChip.format.format(min!)} 以降';
    }
    // 上限値のみ指定している時
    if (isMinSelected) {
      return '${DateRangeFilterChip.format.format(max!)} 以前';
    }
    // それ以外
    return '${DateRangeFilterChip.format.format(min!)} ~ ${DateRangeFilterChip.format.format(max!)}';
  }
}
