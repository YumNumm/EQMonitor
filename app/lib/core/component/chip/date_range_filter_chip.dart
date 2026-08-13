import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

class DateRangeFilterChip extends StatelessWidget {
  const DateRangeFilterChip({this.min, this.max, this.onChanged, super.key});

  /// 震度の範囲が変更された時に呼ばれる
  /// `min` と `max` にはそれぞれ下限値と上限値が渡される
  /// どちらかが `null` の場合はその値は指定されていないことを示す
  final void Function(DateTime?, DateTime?)? onChanged;

  final DateTime? min;
  final DateTime? max;

  static final initialMin = DateTime(1919);
  static final initialMax = DateTime.now();

  static final format = DateFormat('yyyy/MM/dd');

  @visibleForTesting
  static DateTimeRange? clampInitialDateRange(DateTime? min, DateTime? max) {
    if (min == null || max == null) return null;
    final start = min.isBefore(initialMin) ? initialMin : min;
    final end = max.isAfter(initialMax) ? initialMax : max;
    if (start.isAfter(end)) return null;
    return DateTimeRange(start: start, end: end);
  }

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
          initialDateRange: clampInitialDateRange(min, max),
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
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
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
    final effectiveMin = min ?? DateRangeFilterChip.initialMin;
    final effectiveMax = max ?? DateRangeFilterChip.initialMax;
    // どちらも同じの時
    if (effectiveMin == effectiveMax) {
      return DateRangeFilterChip.format.format(effectiveMin);
    }
    // 下限値のみ指定している時
    if (isMaxSelected) {
      return '${DateRangeFilterChip.format.format(effectiveMin)} 以降';
    }
    // 上限値のみ指定している時
    if (isMinSelected) {
      return '${DateRangeFilterChip.format.format(effectiveMax)} 以前';
    }
    // それ以外
    return '${DateRangeFilterChip.format.format(effectiveMin)} ~ '
        '${DateRangeFilterChip.format.format(effectiveMax)}';
  }
}
