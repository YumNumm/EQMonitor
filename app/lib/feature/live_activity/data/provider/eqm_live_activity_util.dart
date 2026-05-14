import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:live_activity_util/live_activity_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqm_live_activity_util.g.dart';

@Riverpod(keepAlive: true)
EQMLiveActivityUtil eqmLiveActivityUtil(Ref ref) {
  if (kIsWeb || !(Platform.isIOS || Platform.isMacOS)) {
    throw UnsupportedError(
      'EQMLiveActivityUtil is only supported on iOS and macOS',
    );
  }
  return EQMLiveActivityUtil.alloc();
}
