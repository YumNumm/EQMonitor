import 'package:flutter/widgets.dart';

/// ヒンジと最小表示幅から決まる、履歴ペインの配置。
class HistoryPaneLayout {
  const new({required this.available, this.list, this.detail});

  factory calculate({
    required Size size,
    required Iterable<Rect> avoidBounds,
    required Offset? globalOrigin,
  }) {
    final viewport = Offset.zero & size;
    var available = viewport;
    Rect? listBounds;
    Rect? detailBounds;
    if (globalOrigin != null) {
      for (final screenBounds in avoidBounds) {
        final bounds = screenBounds.shift(-globalOrigin);
        // 幅0の折り目も境界として扱うため、overlaps は使わない。
        final vertical =
            bounds.top <= 0 &&
            bounds.bottom >= size.height &&
            bounds.left > 0 &&
            bounds.right < size.width;
        final horizontal =
            bounds.left <= 0 &&
            bounds.right >= size.width &&
            bounds.top > 0 &&
            bounds.bottom < size.height;
        if (!vertical && !horizontal) continue;
        final first = vertical
            ? Rect.fromLTRB(0, 0, bounds.left, size.height)
            : Rect.fromLTRB(0, 0, size.width, bounds.top);
        final second = vertical
            ? Rect.fromLTRB(bounds.right, 0, size.width, size.height)
            : Rect.fromLTRB(0, bounds.bottom, size.width, size.height);
        final fits = vertical
            ? first.width >= 320 && second.width >= 360
            : size.width >= 600 && first.height >= 280 && second.height >= 360;
        if (fits) {
          listBounds = first;
          detailBounds = second;
        } else {
          available = first.width * first.height >= second.width * second.height
              ? first
              : second;
        }
        break;
      }
    }
    if (listBounds == null && available.width >= 840) {
      final width = (available.width * 0.3).clamp(320.0, 440.0);
      listBounds = Rect.fromLTWH(
        available.left,
        available.top,
        width,
        available.height,
      );
      detailBounds = Rect.fromLTRB(
        listBounds.right + 1,
        available.top,
        available.right,
        available.bottom,
      );
    }
    return HistoryPaneLayout(
      available: available,
      list: listBounds,
      detail: detailBounds,
    );
  }

  final Rect available;
  final Rect? list;
  final Rect? detail;
}
