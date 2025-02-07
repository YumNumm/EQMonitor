import 'dart:async';

import 'package:flutter/services.dart';

Future<void> lightHapticFunction(FutureOr<void> Function() fn) async {
  unawaited(HapticFeedback.lightImpact());
  await fn();
}

Future<void> mediumHapticFunction(FutureOr<void> Function() fn) async {
  unawaited(HapticFeedback.mediumImpact());
  await fn();
}

Future<void> heavyHapticFunction(FutureOr<void> Function() fn) async {
  unawaited(HapticFeedback.heavyImpact());
  await fn();
}

Future<void> selectionHapticFunction(FutureOr<void> Function() fn) async {
  unawaited(HapticFeedback.selectionClick());
  await fn();
}
