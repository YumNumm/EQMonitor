import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    required this.child,
    this.accentColor,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    ),
    this.elevation = 0,
    super.key,
  });
  final Widget child;
  final Color? accentColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: elevation,
      color: accentColor ?? theme.cardColor,
      // border
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.onSurface,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: margin,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
