import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('push-to-start observer は再開時と停止時に Task を cancel する', () {
    final sourceFile = File(
      '../packages/live_activity_util/ios/live_activity_util/Sources/'
      'live_activity_util/EQMLiveActivityUtil.swift',
    );
    expect(sourceFile.existsSync(), isTrue);

    final source = sourceFile.readAsStringSync();
    expect(
      source,
      contains(
        'private var pushToStartTokenObservationTask: Task<Void, Never>?',
      ),
    );
    expect(
      RegExp(
        r'public func observePushToStartTokenUpdates\([\s\S]*?'
        r'stopObservingPushToStartTokenUpdates\(\)[\s\S]*?'
        r'pushToStartTokenObservationTask\s*=\s*Task\s*\{',
      ).hasMatch(source),
      isTrue,
    );
    expect(
      RegExp(
        r'for await tokenData[\s\S]*?'
        r'guard !Task\.isCancelled else \{[\s\S]*?'
        r'onUpdate\(token as NSString\)',
      ).hasMatch(source),
      isTrue,
    );
    expect(
      RegExp(
        r'public func stopObservingPushToStartTokenUpdates\(\)\s*\{'
        r'[\s\S]*?pushToStartTokenObservationTask\?\.cancel\(\)'
        r'[\s\S]*?pushToStartTokenObservationTask\s*=\s*nil'
        r'[\s\S]*?\}',
      ).hasMatch(source),
      isTrue,
    );
  });

  test('生成bindingはpush-to-start observerのstop APIを公開する', () {
    final bindingFile = File(
      '../packages/live_activity_util/lib/src/live_activity_util.dart',
    );
    expect(bindingFile.existsSync(), isTrue);

    expect(
      bindingFile.readAsStringSync(),
      contains('void stopObservingPushToStartTokenUpdates()'),
    );
  });

  test('push-to-start providerはdispose時にobserverを止めてからcontrollerを閉じる', () {
    final providerFile = File(
      'lib/feature/devices/data/provider/notification_token_stream.dart',
    );
    expect(providerFile.existsSync(), isTrue);

    expect(
      RegExp(
        r'ref\.onDispose\(\(\) \{[\s\S]*?'
        r'stopObservingPushToStartTokenUpdates\(\);[\s\S]*?'
        r'controller\.close\(\)\.ignore\(\);[\s\S]*?\}\);',
      ).hasMatch(providerFile.readAsStringSync()),
      isTrue,
    );
  });
}
