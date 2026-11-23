import 'dart:async';

import 'package:flutter/services.dart';

/// ハプティックフィードバックを伴って [fn] を実行するためのユーティリティ。
class const HapticUtil._() {
  static Future<void> light(FutureOr<void> Function() fn) async {
    final feedback = HapticFeedback.lightImpact();
    await fn();
    await feedback;
  }

  static Future<void> medium(FutureOr<void> Function() fn) async {
    final feedback = HapticFeedback.mediumImpact();
    await fn();
    await feedback;
  }

  static Future<void> heavy(FutureOr<void> Function() fn) async {
    final feedback = HapticFeedback.heavyImpact();
    await fn();
    await feedback;
  }

  static Future<void> selection(FutureOr<void> Function() fn) async {
    final feedback = HapticFeedback.selectionClick();
    await fn();
    await feedback;
  }
}
