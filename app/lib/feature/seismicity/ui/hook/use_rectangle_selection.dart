import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// ドラッグ中の矩形選択状態を保持するフック。
///
/// 画面座標(Offset)のみを扱う。地理座標への変換は呼び出し側
/// ([SeismicitySelectionOverlay])が [MapController.toLngLat] を用いて行う。
class RectangleSelectionState {
  const RectangleSelectionState({
    required this.dragStart,
    required this.dragCurrent,
    required this.startDrag,
    required this.updateDrag,
    required this.endDrag,
  });

  final Offset? dragStart;
  final Offset? dragCurrent;
  final void Function(Offset) startDrag;
  final void Function(Offset) updateDrag;

  /// ドラッグ終了時に確定した矩形(画面座標)を返し、内部状態をリセットする。
  /// ドラッグが開始されていなければ null を返す。
  final Rect? Function() endDrag;

  /// これ未満のドラッグ距離(論理ピクセル)は誤タップ等による退化した矩形と
  /// みなし、選択を確定しない([endDrag] が null を返す)。
  static const minimumDragExtent = 4.0;
}

RectangleSelectionState useRectangleSelection() {
  final dragStart = useState<Offset?>(null);
  final dragCurrent = useState<Offset?>(null);

  return RectangleSelectionState(
    dragStart: dragStart.value,
    dragCurrent: dragCurrent.value,
    startDrag: (offset) {
      dragStart.value = offset;
      dragCurrent.value = offset;
    },
    updateDrag: (offset) => dragCurrent.value = offset,
    endDrag: () {
      final start = dragStart.value;
      final current = dragCurrent.value;
      dragStart.value = null;
      dragCurrent.value = null;
      if (start == null || current == null) {
        return null;
      }
      final rect = Rect.fromPoints(start, current);
      if (rect.width.abs() < RectangleSelectionState.minimumDragExtent ||
          rect.height.abs() < RectangleSelectionState.minimumDragExtent) {
        return null;
      }
      return rect;
    },
  );
}
