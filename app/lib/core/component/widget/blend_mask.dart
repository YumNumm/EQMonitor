import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// https://stackoverflow.com/a/77039320
class BlendMask extends SingleChildRenderObjectWidget {
  const BlendMask({
    required this.blendMode,
    this.opacity = 1.0,
    super.key,
    super.child,
  });
  final BlendMode blendMode;
  final double opacity;

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

class RenderBlendMask extends RenderProxyBox {
  RenderBlendMask(this.blendMode, this.opacity);
  BlendMode blendMode;
  double opacity;

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
