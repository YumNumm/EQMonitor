import 'dart:async';

import 'package:flutter/services.dart';

Future<void> lightHapticFunction(FutureOr<void> Function() fn) async {
  await HapticFeedback.lightImpact();
  await fn();
}

Future<void> mediumHapticFunction(FutureOr<void> Function() fn) async {
  await HapticFeedback.mediumImpact();
  await fn();
}

Future<void> heavyHapticFunction(FutureOr<void> Function() fn) async {
  await HapticFeedback.heavyImpact();
  await fn();
}

Future<void> selectionHapticFunction(FutureOr<void> Function() fn) async {
  await HapticFeedback.selectionClick();
  await fn();
}
