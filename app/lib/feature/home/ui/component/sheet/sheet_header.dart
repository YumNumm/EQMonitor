import 'package:material_ui/material_ui.dart';

class const SheetHeader({
  required final String title,
  super.key,
  final Widget? action,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: .bold,
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
