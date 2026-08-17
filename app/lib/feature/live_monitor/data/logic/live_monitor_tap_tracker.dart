import 'dart:async';

import 'package:flutter/widgets.dart';

class LiveMonitorTapTracker {
  new({required this.touchSlop});

  final double touchSlop;

  final Set<int> _activePointers = {};
  int? _tapCandidatePointer;
  Offset? _startPosition;
  bool _cancelled = false;
  Timer? _pendingSingleTap;

  void pointerDown({required int pointer, required Offset position}) {
    final cancelsPendingSingleTap = _pendingSingleTap?.isActive ?? false;
    _pendingSingleTap?.cancel();
    _pendingSingleTap = null;
    if (_activePointers.isNotEmpty) {
      _cancelled = true;
    } else {
      _tapCandidatePointer = pointer;
      _startPosition = position;
      _cancelled = cancelsPendingSingleTap;
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

  void scheduleSingleTap({
    required bool isTap,
    required Duration delay,
    required VoidCallback onTap,
  }) {
    if (!isTap) {
      return;
    }
    _pendingSingleTap?.cancel();
    _pendingSingleTap = Timer(delay, () {
      _pendingSingleTap = null;
      onTap();
    });
  }

  void cancelAll() {
    _pendingSingleTap?.cancel();
    _pendingSingleTap = null;
    _activePointers.clear();
    _tapCandidatePointer = null;
    _startPosition = null;
    _cancelled = false;
  }
}
