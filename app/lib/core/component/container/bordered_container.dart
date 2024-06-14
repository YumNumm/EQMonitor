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
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.onPressed,
    super.key,
  });
  final Widget child;
  final Color? accentColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final BorderRadiusGeometry borderRadius;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final card = Card(
      clipBehavior: Clip.antiAlias,
      elevation: elevation,
      color: accentColor ?? theme.colorScheme.surfaceContainer,
      // border
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
        ),
        borderRadius: borderRadius,
      ),
      margin: margin,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
    if (onPressed != null) {
      return Ink(
        child: card,
      );
    }
    return card;
  }
}
