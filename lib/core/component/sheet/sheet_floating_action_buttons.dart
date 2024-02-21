import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class SheetFloatingActionButtons extends HookWidget {
  const SheetFloatingActionButtons({
    super.key,
    required this.controller,
    required this.fab,
    this.maxHeight = 0.3,
    this.hasAppBar = true,
  });

  /// FABの最大高さ
  /// 画面から見えなくなる高さ
  final double maxHeight;

  final bool hasAppBar;

  /// FAB
  final List<Widget> fab;

  final SheetController controller;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    // safearea取得
    final height = size.height -
        (padding.top +
            // SafeAreaのtop部分, AppBarの高さ
            (hasAppBar ? AppBar().preferredSize.height : 0));
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (BuildContext context, Widget? child) {
        final bottom = height * controller.animation.value;
        return Positioned(
          right: padding.right,
          left: padding.left,
          bottom: bottom,
          child: Container(
            margin: const EdgeInsets.all(4),
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
