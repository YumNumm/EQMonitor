import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/ui/hook/use_rectangle_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';

/// 地図上に重ねる矩形選択オーバーレイ。
///
/// [enabled] が true の間だけジェスチャーを消費し、ドラッグ確定時に
/// 画面座標を [MapController.toLngLat] で地理座標へ変換して
/// [onSelectionEnd] を呼ぶ。[enabled] が false の場合は
/// [IgnorePointer] で下のマップ操作(パン/ズーム)を妨げない。
class SeismicitySelectionOverlay extends HookWidget {
  const SeismicitySelectionOverlay({
    required this.enabled,
    required this.onSelectionEnd,
    super.key,
  });

  final bool enabled;
  final void Function(SeismicityBounds bounds) onSelectionEnd;

  @override
  Widget build(BuildContext context) {
    final selection = useRectangleSelection();

    return IgnorePointer(
      ignoring: !enabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) =>
            selection.startDrag(details.localPosition),
        onPanUpdate: (details) =>
            selection.updateDrag(details.localPosition),
        onPanEnd: (_) => _handleDragEnd(context, selection),
        child: CustomPaint(
          painter: _SelectionPainter(
            start: selection.dragStart,
            current: selection.dragCurrent,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  void _handleDragEnd(
    BuildContext context,
    RectangleSelectionState selection,
  ) {
    // 退化した(ほぼ動いていない)矩形は useRectangleSelection.endDrag が
    // null を返すため、ここでは選択なしとして扱う。
    final rect = selection.endDrag();
    if (rect == null) {
      return;
    }
    final controller = MapController.maybeOf(context);
    if (controller == null) {
      return;
    }
    final topLeft = controller.toLngLat(rect.topLeft);
    final bottomRight = controller.toLngLat(rect.bottomRight);
    onSelectionEnd(
      SeismicityBounds(
        minLatitude: [
          topLeft.lat,
          bottomRight.lat,
        ].reduce((a, b) => a < b ? a : b),
        maxLatitude: [
          topLeft.lat,
          bottomRight.lat,
        ].reduce((a, b) => a > b ? a : b),
        minLongitude: [
          topLeft.lon,
          bottomRight.lon,
        ].reduce((a, b) => a < b ? a : b),
        maxLongitude: [
          topLeft.lon,
          bottomRight.lon,
        ].reduce((a, b) => a > b ? a : b),
      ),
    );
  }
}

class _SelectionPainter extends CustomPainter {
  const _SelectionPainter({required this.start, required this.current});

  final Offset? start;
  final Offset? current;

  @override
  void paint(Canvas canvas, Size size) {
    final start = this.start;
    final current = this.current;
    if (start == null || current == null) {
      return;
    }
    final rect = Rect.fromPoints(start, current);
    canvas.drawRect(
      rect,
      Paint()
        ..color = const Color(0x332196F3)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRect(
      rect,
      Paint()
        ..color = const Color(0xFF2196F3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(_SelectionPainter oldDelegate) =>
      oldDelegate.start != start || oldDelegate.current != current;
}
