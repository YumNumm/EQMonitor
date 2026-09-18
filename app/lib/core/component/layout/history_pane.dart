import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

/// 各ペインに独立したスクロールと、その領域の MediaQuery を与える。
class HistoryPane extends HookWidget {
  const new({
    required this.bounds,
    required this.viewport,
    required this.child,
    super.key,
  });

  final Rect bounds;
  final Size viewport;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final media = MediaQuery.of(context);
    final padding = EdgeInsets.fromLTRB(
      (media.padding.left - bounds.left).clamp(0.0, bounds.width),
      (media.padding.top - bounds.top).clamp(0.0, bounds.height),
      (media.padding.right - (viewport.width - bounds.right)).clamp(
        0.0,
        bounds.width,
      ),
      (media.padding.bottom - (viewport.height - bounds.bottom)).clamp(
        0.0,
        bounds.height,
      ),
    );
    return MediaQuery(
      data: media.copyWith(
        size: bounds.size,
        padding: padding,
        viewPadding: padding,
        // 外側の Scaffold でキーボード分の領域を差し引いている。
        viewInsets: EdgeInsets.zero,
        displayFeatures: const [],
      ),
      child: PrimaryScrollController(
        controller: controller,
        child: Material(child: child),
      ),
    );
  }
}
