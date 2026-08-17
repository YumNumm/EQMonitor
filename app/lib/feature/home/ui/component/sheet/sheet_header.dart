import 'package:material_ui/material_ui.dart';

class SheetHeader extends StatelessWidget {
  const new({required this.title, super.key, this.action});

  final String title;
  final Widget? action;

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
              fontWeight: FontWeight.bold,
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
