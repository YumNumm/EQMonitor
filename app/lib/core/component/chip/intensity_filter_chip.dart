import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IntensityFilterChip extends StatelessWidget {
  const new({this.min, this.max, this.onChanged, super.key});

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
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }
}

class _IntensityFilterModal extends HookWidget {
  const new({
    this.currentMin = initialMin,
    this.currentMax = initialMax,
  });

  final JmaIntensity? currentMin;
  final JmaIntensity? currentMax;

  static const JmaIntensity initialMin = IntensityFilterChip.initialMin;
  static const JmaIntensity initialMax = IntensityFilterChip.initialMax;

  static const List<JmaIntensity> _sliderValues = [
    JmaIntensity.one,
    JmaIntensity.two,
    JmaIntensity.three,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  @override
  Widget build(BuildContext context) {
    final min = useState<JmaIntensity>(currentMin ?? initialMin);
    final max = useState<JmaIntensity>(currentMax ?? initialMax);

    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: designSystem.colorTheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    int valueToIndex(JmaIntensity v) =>
        _sliderValues.indexOf(v).clamp(0, _sliderValues.length - 1);
    JmaIntensity indexToValue(int i) =>
        _sliderValues[i.clamp(0, _sliderValues.length - 1)];

    return SafeArea(
      child: SingleChildScrollView(
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
              labels: RangeLabels(
                '震度${min.value.label}',
                '震度${max.value.label}',
              ),
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
    if (isAllSelected) {
      return '全て';
    }
    if (min == max) {
      return '震度${min?.label}';
    }
    if (isMaxSelected) {
      return '震度${min?.label} 以上';
    }
    if (isMinSelected) {
      return '震度${max?.label} 以下';
    }
    return '震度${min?.label} ~ 震度${max?.label}';
  }
}
