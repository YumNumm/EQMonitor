import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    required this.child,
    this.backgroundColor,
    super.key,
  });
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor ?? Theme.of(context).colorScheme.background,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: child,
        ),
      ),
    );
  }
}
