import 'dart:async';

import 'package:core/core.dart' as core;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  core.initializeTimeZones();
  await testMain();
}
