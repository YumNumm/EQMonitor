import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class BasicModalSheet extends HookWidget {
  const BasicModalSheet({
    super.key,
    required this.controller,
    required this.children,
    this.hasAppBar = true,
  });
  final SheetController controller;
  final List<Widget> children;
  final bool hasAppBar;

  static double width(Size size) {
    return size.width > 600 && size.height < size.width
        ? size.width / 2
        : size.width;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barWidget = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    final size = MediaQuery.sizeOf(context);

    final sheetWidth = width(size);

    final sheet = Sheet(
      backgroundColor: Colors.transparent,
      initialExtent: size.height * 0.3,
      controller: controller,
      physics: const SnapSheetPhysics(
        stops: <double>[0.1, 0.2, 0.3, 0.5, 0.95, 1],
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          color: theme.colorScheme.surfaceContainerLowest,
          border: Border.all(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
          ),
        ),
        child: SafeArea(
          top: hasAppBar,
          bottom: false,
          child: RepaintBoundary(
            child: Column(
              children: <Widget>[
                barWidget,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: children,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
