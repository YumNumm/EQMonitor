import 'dart:ui';

import 'package:flutter/material.dart';

/// ブラーをかけたコンテナ
/// 枠 0.5
/// 背景 0.75
class BlurContainer extends StatelessWidget {
  const BlurContainer({
    required this.child,
    this.blurColor = const Color.fromARGB(100, 78, 82, 82),
    this.blurRadius = 4,
    this.borderRadius = 8,
    this.borderColor = Colors.white,
    this.borderWidth = 1,
    super.key,
  });

  final Widget child;
  final Color? blurColor;
  final double blurRadius;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurRadius,
            sigmaY: blurRadius,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: blurColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
