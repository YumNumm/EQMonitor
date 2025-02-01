import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class BasicModalSheet extends HookWidget {
  const BasicModalSheet({
    required this.children,
    super.key,
    this.hasAppBar = true,
  });

  final List<Widget> children;
  final bool hasAppBar;

  static double? width(Size size) {
    return size.width > 600 && size.height < size.width ? size.width / 2 : null;
  }

  static const double kSheetBorderRadius = 28;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = MediaQuery.sizeOf(context);

    final sheetWidth = width(size);

    final sheet = Stack(
      children: [
        Sheet(
          backgroundColor: Colors.transparent,
          initialExtent: size.height * 0.2,
          physics: const SnapSheetPhysics(
            stops: <double>[0.2, 0.5, 1],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(kSheetBorderRadius),
              ),
              color: theme.colorScheme.surfaceContainerLowest,
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            child: SafeArea(
              top: hasAppBar,
              bottom: false,
              child: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ],
    );
    if (sheetWidth == null) {
      return sheet;
    }
    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        top: hasAppBar,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SizedBox(
            width: sheetWidth,
            child: sheet,
          ),
        ),
      ),
    );
  }
}
