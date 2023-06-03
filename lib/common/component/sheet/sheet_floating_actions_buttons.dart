import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sheet/sheet.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({
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
    final mediaQuery = MediaQuery.of(context);
    final height =
        mediaQuery.size.height - mediaQuery.padding.top - kToolbarHeight;
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          right: 0,
          bottom: height * min(0.3, controller.animation.value),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: fab
                  .mapIndexed(
                    (index, e) => [
                      e,
                      if (index != fab.length - 1)
                        const SizedBox(
                          height: 10,
                        ),
                    ],
                  )
                  .flattened
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
