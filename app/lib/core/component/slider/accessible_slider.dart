import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// Native expressive slider with screen-reader adjustment actions.
class AccessibleSlider extends StatelessWidget {
  const new({
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.label,
    this.semanticFormatterCallback,
    this.onChangeStart,
    this.onChangeEnd,
    super.key,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String Function(double)? semanticFormatterCallback;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null && max > min;
    final step = (max - min) / (divisions ?? 20);
    final increased = (value + step).clamp(min, max);
    final decreased = (value - step).clamp(min, max);
    return Semantics(
      slider: true,
      enabled: enabled,
      value: semanticFormatterCallback?.call(value) ?? label ?? '$value',
      increasedValue:
          semanticFormatterCallback?.call(increased) ?? '$increased',
      decreasedValue:
          semanticFormatterCallback?.call(decreased) ?? '$decreased',
      onIncrease: !enabled || value >= max
          ? null
          : () {
              onChangeStart?.call(value);
              onChanged?.call(increased);
              onChangeEnd?.call(increased);
            },
      onDecrease: !enabled || value <= min
          ? null
          : () {
              onChangeStart?.call(value);
              onChanged?.call(decreased);
              onChangeEnd?.call(decreased);
            },
      child: ExcludeSemantics(
        child: M3ESlider(
          value: value,
          onChanged: onChanged,
          min: min,
          max: max,
          divisions: divisions,
          label: label,
          onChangeStart: onChangeStart,
          onChangeEnd: onChangeEnd,
        ),
      ),
    );
  }
}
