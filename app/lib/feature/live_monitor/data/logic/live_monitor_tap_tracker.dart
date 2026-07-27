import 'package:flutter/widgets.dart';

class LiveMonitorTapTracker {
  LiveMonitorTapTracker({required this.touchSlop});

  final double touchSlop;

  int? _activePointer;
  Offset? _startPosition;
  bool _cancelled = false;

  void pointerDown({required int pointer, required Offset position}) {
    if (_activePointer != null) {
      _cancelled = true;
      return;
    }
    _activePointer = pointer;
    _startPosition = position;
    _cancelled = false;
  }

  void pointerMove({required int pointer, required Offset position}) {
    if (pointer != _activePointer) {
      return;
    }
    final startPosition = _startPosition;
    if (startPosition != null &&
        (position - startPosition).distance > touchSlop) {
      _cancelled = true;
    }
  }

  bool pointerUp({required int pointer, required Offset position}) {
    if (pointer != _activePointer) {
      return false;
    }
    pointerMove(pointer: pointer, position: position);
    final isTap = !_cancelled;
    _activePointer = null;
    _startPosition = null;
    _cancelled = false;
    return isTap;
  }

  void pointerCancel({required int pointer}) {
    if (_activePointer == null) {
      return;
    }
    _cancelled = true;
    if (pointer == _activePointer) {
      _activePointer = null;
      _startPosition = null;
    }
  }
}
