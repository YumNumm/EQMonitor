import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class BasicModalSheet extends HookWidget {
  const BasicModalSheet({
    super.key,
    required this.controller,
    required this.children,
    this.mapKey,
  });
  final SheetController controller;
  final List<Widget> children;
  final Key? mapKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final barWidget = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: theme.colorScheme.onBackground,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    return Sheet(
      backgroundColor: Colors.transparent,
      initialExtent: 120,
      controller: controller,
      physics: const SnapSheetPhysics(
        stops: <double>[0.1, 0.3, 1],
      ),
      child: AnimatedBuilder(
        animation: controller.animation,
        builder: (BuildContext context, Widget? child) {
          final showSheetBar = controller.animation.value > 0.95;
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: showSheetBar ? 1 : 0),
            duration: const Duration(milliseconds: 200),
            builder: (BuildContext context, double t, Widget? child) {
              final radius = Tween<double>(begin: 16, end: 0).transform(t);

              final shadow = ColorTween(
                begin: Colors.black12,
                end: Colors.black12.withOpacity(0),
              ).transform(t);
              final barColor = ColorTween(
                begin: Colors.grey[400],
                end: Colors.grey[400]?.withOpacity(0),
              ).transform(t);
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                    ),
                    color: theme.colorScheme.surface,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: shadow!, blurRadius: 12),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      barWidget,
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(4),
                          children: children,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
