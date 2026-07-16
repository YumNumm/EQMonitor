import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

/// Source-contract test for [EQMLiveActivityUtil.swift].
///
/// Task 6 removes the per-activity Live Activity update token observation
/// path (EEW / shake-detection `activityUpdates` + `pushTokenUpdates`)
/// while preserving push-to-start token handling. This test reads the
/// Swift source directly (no FFI bindings involved) so it works on any
/// platform, including Linux CI, without requiring an iOS build.
void main() {
  test('EQMLiveActivityUtil.swift preserves push-to-start token handling '
      'and no longer contains the per-activity update token observers', () {
    final source = File(
      path.join(
        Directory.current.path,
        '..',
        'packages',
        'live_activity_util',
        'ios',
        'live_activity_util',
        'Sources',
        'live_activity_util',
        'EQMLiveActivityUtil.swift',
      ),
    ).readAsStringSync();

    // Preserved: push-to-start token handling.
    expect(source, contains('pushToStartTokenUpdates'));

    // Removed: per-activity update token observation.
    expect(source, isNot(contains('activityUpdates')));
    expect(source, isNot(contains('pushTokenUpdates')));
    expect(source, isNot(contains('observeEewActivityPushTokenUpdates')));
    expect(
      source,
      isNot(contains('observeShakeDetectionActivityPushTokenUpdates')),
    );
  });
}
