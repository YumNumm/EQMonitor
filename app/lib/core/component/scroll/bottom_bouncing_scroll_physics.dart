import 'package:flutter/widgets.dart';

/// 上端は Clamp、下端は Bounce する [ScrollPhysics]。
///
/// Android / iOS 共通で同じ挙動にする。
class BottomBouncingScrollPhysics extends BouncingScrollPhysics {
  const BottomBouncingScrollPhysics({
    super.parent,
    super.decelerationRate,
  });

  @override
  BottomBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BottomBouncingScrollPhysics(
      parent: buildParent(ancestor),
      decelerationRate: decelerationRate,
    );
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Underscroll (top)
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    // Hit top edge
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    // Bottom: allow overscroll for bouncing
    return 0;
  }
}
