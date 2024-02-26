import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetupBackgroundImageWidget extends HookWidget {
  const SetupBackgroundImageWidget({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final startTime = useState(0);

    if (kIsWeb) {
      return ColoredBox(
        color: const Color(0xFF05052F),
        child: child,
      );
    }

    double elapsedTimeInSeconds() =>
        (DateTime.now().millisecondsSinceEpoch - startTime.value) / 1000;
    final shader = useFuture(
      FragmentProgram.fromAsset(
        'shaders/introduction.glsl',
      ),
    );
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat();
    useAnimation(animationController);
    useEffect(
      () {
        startTime.value = DateTime.now().millisecondsSinceEpoch;
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
            painter: _ShaderPainter(data, elapsedTimeInSeconds()),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: child,
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
