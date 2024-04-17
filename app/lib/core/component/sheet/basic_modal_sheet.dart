import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class BasicModalSheet extends HookWidget {
  const BasicModalSheet({
    super.key,
    required this.controller,
    required this.children,
    this.hasAppBar = true,
    this.useColumn = false,
  });
  final SheetController controller;
  final List<Widget> children;
  final bool hasAppBar;
  final bool useColumn;

  static double width(BoxConstraints constraints) {
    final isTablet = constraints.maxWidth > 600 &&
        constraints.maxHeight < constraints.maxWidth;
    return isTablet ? constraints.maxWidth / 2 : constraints.maxWidth;
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600 &&
            constraints.maxHeight < constraints.maxWidth;

        final sheet = Sheet(
          backgroundColor: Colors.transparent,
          initialExtent: constraints.maxHeight * 0.3,
          controller: controller,
          physics: const SnapSheetPhysics(
            stops: <double>[0.1, 0.2, 0.3, 0.5, 0.95, 1],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: theme.colorScheme.surface,
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Colors.black12, blurRadius: 12),
              ],
            ),
            child: SafeArea(
              top: hasAppBar,
              bottom: false,
              child: Column(
                children: <Widget>[
                  barWidget,
                  if (useColumn)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: children,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(2),
                        children: children,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
        if (isTablet) {
          return Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              top: hasAppBar,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: constraints.maxWidth / 2,
                  child: sheet,
                ),
              ),
            ),
          );
        }
        return sheet;
      },
    );
  }
}
