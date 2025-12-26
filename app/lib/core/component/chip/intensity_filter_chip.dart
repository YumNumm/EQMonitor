import 'package:eqapi_types/eqapi_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IntensityFilterChip extends StatelessWidget {
  const IntensityFilterChip({this.min, this.max, this.onChanged, super.key});

  final void Function(IntensityValue?, IntensityValue?)? onChanged;

  final IntensityValue? min;
  final IntensityValue? max;

  static const IntensityValue initialMin = IntensityValue.one;
  static const IntensityValue initialMax = IntensityValue.seven;

  @override
  Widget build(BuildContext context) {
    final range = (min, max);

    return RawChip(
      onSelected: (_) async {
        final result =
            await showModalBottomSheet<(IntensityValue?, IntensityValue?)?>(
              clipBehavior: Clip.antiAlias,
              context: context,
              builder: (context) =>
                  _IntensityFilterModal(currentMin: min, currentMax: max),
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

  final IntensityValue? currentMin;
  final IntensityValue? currentMax;

  static const IntensityValue initialMin = IntensityFilterChip.initialMin;
  static const IntensityValue initialMax = IntensityFilterChip.initialMax;

  // スライダーで使用する震度値（zeroとfiveLowerNoInputを除外）
  static const _sliderValues = [
    IntensityValue.one,
    IntensityValue.two,
    IntensityValue.three,
    IntensityValue.four,
    IntensityValue.fiveLower,
    IntensityValue.fiveUpper,
    IntensityValue.sixLower,
    IntensityValue.sixUpper,
    IntensityValue.seven,
  ];

  @override
  Widget build(BuildContext context) {
    final min = useState<IntensityValue>(currentMin ?? initialMin);
    final max = useState<IntensityValue>(currentMax ?? initialMax);

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

    int valueToIndex(IntensityValue v) =>
        _sliderValues.indexOf(v).clamp(0, _sliderValues.length - 1);
    IntensityValue indexToValue(int i) =>
        _sliderValues[i.clamp(0, _sliderValues.length - 1)];

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
              valueToIndex(min.value).toDouble(),
              valueToIndex(max.value).toDouble(),
            ),
            max: (_sliderValues.length - 1).toDouble(),
            onChanged: (state) {
              min.value = indexToValue(state.start.toInt());
              max.value = indexToValue(state.end.toInt());
            },
            labels: RangeLabels('震度${min.value}', '震度${max.value}'),
            divisions: _sliderValues.length - 1,
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

extension MinMaxIntensityValue on (IntensityValue?, IntensityValue?) {
  IntensityValue? get min => this.$1;
  IntensityValue? get max => this.$2;

  bool get isMinSelected =>
      min == IntensityFilterChip.initialMin || min == null;
  bool get isMaxSelected =>
      max == IntensityFilterChip.initialMax || max == null;

  bool get isAllSelected => isMinSelected && isMaxSelected;

  String get toRangeString {
    if (isAllSelected) {
      return '全て';
    }
    if (min == max) {
      return '震度$min';
    }
    if (isMaxSelected) {
      return '震度$min 以上';
    }
    if (isMinSelected) {
      return '震度$max 以下';
    }
    return '震度$min ~ 震度$max';
  }
}
