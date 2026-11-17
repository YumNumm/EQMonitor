import 'package:material_ui/material_ui.dart';

/// 「警報のみ」を絞り込むトグルチップ。
class const EewWarningFilterChip({
  required final bool selected,
  required final ValueChanged<bool> onChanged,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: const Text('警報のみ'),
      selected: selected,
      onSelected: onChanged,
    );
  }
}
