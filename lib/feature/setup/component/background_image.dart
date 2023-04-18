import 'dart:ui';

import 'package:flutter/material.dart';

class SetupBackgroundImageWidget extends StatelessWidget {
  const SetupBackgroundImageWidget({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        // 背景に画像を設定
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/setup-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        // 背景をぼかす
        child: SizedBox.expand(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: SafeArea(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
