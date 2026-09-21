import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// Each expressive range thumb exposes an independent accessible control.
class AccessibleRangeSlider extends StatelessWidget {
  const new({
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.label,
    this.semanticFormatterCallback,
    super.key,
  });

  final RangeValues value;
  final ValueChanged<RangeValues>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String Function(double)? semanticFormatterCallback;

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null && max > min;
    final step = (max - min) / (divisions ?? 20);
    return Stack(
      children: [
        ExcludeSemantics(
          child: M3ERangeSlider(
            value: value,
            onChanged: onChanged,
            min: min,
            max: max,
            divisions: divisions,
            label: label,
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Row(
              children: [
                for (final isStart in [true, false])
                  Expanded(
                    child: _RangeThumbSemantics(
                      value: isStart ? value.start : value.end,
                      min: isStart ? min : value.start,
                      max: isStart ? value.end : max,
                      step: step,
                      enabled: enabled,
                      label: isStart ? '下限' : '上限',
                      formatter: semanticFormatterCallback,
                      onChanged: (next) => onChanged?.call(
                        isStart
                            ? RangeValues(next, value.end)
                            : RangeValues(value.start, next),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RangeThumbSemantics extends StatelessWidget {
  const new({
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.enabled,
    required this.label,
    required this.formatter,
    required this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final double step;
  final bool enabled;
  final String label;
  final String Function(double)? formatter;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final increased = (value + step).clamp(min, max);
    final decreased = (value - step).clamp(min, max);
    return Semantics(
      container: true,
      slider: true,
      enabled: enabled,
      label: label,
      value: formatter?.call(value) ?? '$value',
      increasedValue: formatter?.call(increased) ?? '$increased',
      decreasedValue: formatter?.call(decreased) ?? '$decreased',
      onIncrease: !enabled || value >= max ? null : () => onChanged(increased),
      onDecrease: !enabled || value <= min ? null : () => onChanged(decreased),
      child: const SizedBox.expand(),
    );
  }
}
