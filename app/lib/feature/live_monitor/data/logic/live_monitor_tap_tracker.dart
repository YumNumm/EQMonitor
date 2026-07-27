import 'package:flutter/widgets.dart';

class LiveMonitorTapTracker {
  LiveMonitorTapTracker({required this.touchSlop});

  final double touchSlop;

  final Set<int> _activePointers = {};
  int? _tapCandidatePointer;
  Offset? _startPosition;
  bool _cancelled = false;

  void pointerDown({required int pointer, required Offset position}) {
    if (_activePointers.isNotEmpty) {
      _cancelled = true;
    } else {
      _tapCandidatePointer = pointer;
      _startPosition = position;
      _cancelled = false;
    }
    _activePointers.add(pointer);
  }

  void pointerMove({required int pointer, required Offset position}) {
    if (pointer != _tapCandidatePointer) {
      return;
    }
    final startPosition = _startPosition;
    if (startPosition != null &&
        (position - startPosition).distance > touchSlop) {
      _cancelled = true;
    }
  }

  bool pointerUp({required int pointer, required Offset position}) {
    if (!_activePointers.contains(pointer)) {
      return false;
    }
    if (pointer == _tapCandidatePointer) {
      pointerMove(pointer: pointer, position: position);
    }
    final isTap =
        pointer == _tapCandidatePointer &&
        _activePointers.length == 1 &&
        !_cancelled;
    _activePointers.remove(pointer);
    if (pointer == _tapCandidatePointer) {
      _tapCandidatePointer = null;
      _startPosition = null;
    }
    if (_activePointers.isEmpty) {
      _cancelled = false;
    }
    return isTap;
  }

  void pointerCancel({required int pointer}) {
    if (!_activePointers.remove(pointer)) {
      return;
    }
    _cancelled = true;
    if (pointer == _tapCandidatePointer) {
      _tapCandidatePointer = null;
      _startPosition = null;
    }
    if (_activePointers.isEmpty) {
      _cancelled = false;
    }
  }

  void cancelAll() {
    _activePointers.clear();
    _tapCandidatePointer = null;
    _startPosition = null;
    _cancelled = false;
  }
}
