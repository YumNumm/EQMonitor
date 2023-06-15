import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class SheetFloatingActionButtons extends HookWidget {
  const SheetFloatingActionButtons({
    super.key,
    required this.controller,
    required this.fab,
    this.maxHeight = 0.3,
  });

  /// FABの最大高さ
  /// 画面から見えなくなる高さ
  final double maxHeight;

  /// FAB
  final List<FloatingActionButton> fab;

  final SheetController controller;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = useMemoized(
      () => MediaQuery.of(context),
      [context],
    );
    final height = mediaQuery.size.height -
        (mediaQuery.padding.top + mediaQuery.padding.bottom) -
        kToolbarHeight;
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          right: 0,
          bottom: height * controller.animation.value,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: fab,
            ),
          ),
        );
      },
    );
  }
}
