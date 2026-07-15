import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Swift only observes push-to-start token updates', () {
    final source = File(
      '../packages/live_activity_util/ios/live_activity_util/Sources/'
      'live_activity_util/EQMLiveActivityUtil.swift',
    ).readAsStringSync();

    expect(source, contains('pushToStartTokenUpdates'));
    expect(source, isNot(contains('activityUpdates')));
    expect(source, isNot(contains('pushTokenUpdates')));
    expect(source, isNot(contains('observeEewActivityPushTokenUpdates')));
    expect(
      source,
      isNot(contains('observeShakeDetectionActivityPushTokenUpdates')),
    );
  });
}
