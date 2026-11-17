import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// https://stackoverflow.com/a/77039320
class const BlendMask({
  required final BlendMode blendMode,
  final double opacity = 1.0,
  super.key,
  super.child,
}) extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBlendMask(blendMode, opacity);
  }

  @override
  void updateRenderObject(BuildContext context, RenderBlendMask renderObject) {
    renderObject
      ..blendMode = blendMode
      ..opacity = opacity;
  }
}

class RenderBlendMask(var BlendMode blendMode, var double opacity)
    extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = blendMode
        ..color = Color.fromARGB((opacity * 255).round(), 255, 255, 255),
    );

    super.paint(context, offset);

    context.canvas.restore();
  }
}
