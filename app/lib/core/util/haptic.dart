import 'dart:async';

import 'package:flutter/services.dart';

/// ハプティックフィードバックを伴って [fn] を実行するためのユーティリティ。
class HapticUtil {
  const HapticUtil._();

  static Future<void> light(FutureOr<void> Function() fn) async {
    await HapticFeedback.lightImpact();
    await fn();
  }

  static Future<void> medium(FutureOr<void> Function() fn) async {
    await HapticFeedback.mediumImpact();
    await fn();
  }

  static Future<void> heavy(FutureOr<void> Function() fn) async {
    await HapticFeedback.heavyImpact();
    await fn();
  }

  static Future<void> selection(FutureOr<void> Function() fn) async {
    await HapticFeedback.selectionClick();
    await fn();
  }
}
