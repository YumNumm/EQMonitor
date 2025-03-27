import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class BasicModalSheet extends HookWidget {
  const BasicModalSheet({
    required this.child,
    super.key,
    this.hasAppBar = true,
  });

  final Widget child;
  final bool hasAppBar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = (
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
          final isLandscape = size.width > size.height;
          final sheet = Sheet(
            backgroundColor: colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              side: BorderSide(color: colorScheme.outlineVariant, width: 0),
            ),
            initialExtent: size.height * 0.2,
            physics: const SnapSheetPhysics(stops: [0.1, 0.2, 0.5, 0.8, 1]),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 36,
                  height: 4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                child,
              ],
            ),
          );

          if (isLandscape) {
            return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: size.width * 0.5,
                height: size.height,
                child: sheet,
              ),
            );
          }
          return sheet;
        },
      ),
    );
  }
}
