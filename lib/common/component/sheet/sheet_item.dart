import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SheetItem extends StatelessWidget {
  const SheetItem({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
