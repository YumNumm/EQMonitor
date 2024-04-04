import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/components/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IntensityFilterChip extends StatelessWidget {
  const IntensityFilterChip({
    this.min,
    this.max,
    this.onChanged,
    super.key,
  });

  /// 震度の範囲が変更された時に呼ばれる
  /// `min` と `max` にはそれぞれ下限値と上限値が渡される
  /// どちらかが `null` の場合はその値は指定されていないことを示す
  final void Function(JmaIntensity?, JmaIntensity?)? onChanged;

  final JmaIntensity? min;
  final JmaIntensity? max;

  static const JmaIntensity initialMin = JmaIntensity.one;
  static const JmaIntensity initialMax = JmaIntensity.seven;

  @override
  Widget build(BuildContext context) {
    final range = (min, max);

    return RawChip(
      onSelected: (_) async {
        final result =
            await showModalBottomSheet<(JmaIntensity?, JmaIntensity?)?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (context) => _IntensityFilterModal(
            currentMin: min,
            currentMax: max,
          ),
        );
        if (result != null) {
          onChanged?.call(result.min, result.max);
        }
      },
      label: (range.isAllSelected)
          ? const Text('最大観測震度')
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

class _IntensityFilterModal extends HookWidget {
  const _IntensityFilterModal({
    this.currentMin = initialMin,
    this.currentMax = initialMax,
  });
  final JmaIntensity? currentMin;
  final JmaIntensity? currentMax;

  static const JmaIntensity initialMin = IntensityFilterChip.initialMin;
  static const JmaIntensity initialMax = IntensityFilterChip.initialMax;

  @override
  Widget build(BuildContext context) {
    final min = useState<JmaIntensity>(currentMin ?? initialMin);
    final max = useState<JmaIntensity>(currentMax ?? initialMax);

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
              '最大観測震度',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          RangeSlider(
            values: RangeValues(
              min.value.index.toDouble(),
              max.value.index.toDouble(),
            ),
            max: JmaIntensity.seven.index.toDouble(),
            onChanged: (state) {
              min.value = JmaIntensity.values[state.start.toInt()];
              max.value = JmaIntensity.values[state.end.toInt()];
            },
            labels: RangeLabels(
              '震度${min.value}',
              '震度${max.value}',
            ),
            divisions: JmaIntensity.seven.index,
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

extension MinMaxJmaIntensity on (JmaIntensity?, JmaIntensity?) {
  JmaIntensity? get min => this.$1;
  JmaIntensity? get max => this.$2;

  bool get isMinSelected =>
      min == IntensityFilterChip.initialMin || min == null;
  bool get isMaxSelected =>
      max == IntensityFilterChip.initialMax || max == null;

  bool get isAllSelected => isMinSelected && isMaxSelected;

  String get toRangeString {
    // 何も指定していない時
    if (isAllSelected) {
      return '全て';
    }
    // どちらも同じの時
    if (min == max) {
      return '震度$min';
    }
    // 下限値のみ指定している時
    if (isMaxSelected) {
      return '震度$min 以上';
    }
    // 上限値のみ指定している時
    if (isMinSelected) {
      return '震度$max 以下';
    }
    return '震度$min ~ 震度$max';
  }
}
