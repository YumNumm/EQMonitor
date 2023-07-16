import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetupBackgroundImageWidget extends HookWidget {
  SetupBackgroundImageWidget({
    required this.child,
    super.key,
  });
  final Widget child;

  int _startTime = 0;

  double get _elapsedTimeInSeconds =>
      (_startTime - DateTime.now().millisecondsSinceEpoch) / 1000;

  @override
  Widget build(BuildContext context) {
    final shader = useFuture(
      FragmentProgram.fromAsset(
        'shaders/introduction.glsl',
      ),
    );
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat();
    useEffect(
      () {
        _startTime = DateTime.now().millisecondsSinceEpoch;

        return null;
      },
      [context],
    );
    if (shader.hasData) {
      return AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          final data = shader.data!.fragmentShader();
          return CustomPaint(
            painter: _ShaderPainter(data, _elapsedTimeInSeconds),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(child: child),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}

class _ShaderPainter extends CustomPainter {
  const _ShaderPainter(this.shader, this.elapsedSeconds);
  final FragmentShader shader;
  final double elapsedSeconds;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = (shader
          ..setFloat(0, elapsedSeconds)
          ..setFloat(1, size.width)
          ..setFloat(2, size.height)),
    );
  }

  @override
  bool shouldRepaint(_ShaderPainter oldDelegate) => true;
}
