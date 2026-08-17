import 'package:material_ui/material_ui.dart';

/// 「警報のみ」を絞り込むトグルチップ。
class EewWarningFilterChip extends StatelessWidget {
  const EewWarningFilterChip({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final bool selected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: const Text('警報のみ'),
      selected: selected,
      onSelected: onChanged,
    );
  }
}
