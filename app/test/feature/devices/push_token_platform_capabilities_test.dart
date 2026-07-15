import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('iOS 17 syncs FCM and APNs without push-to-start', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.ios,
      iosMajorVersion: 17,
    );

    expect(value.supportsFcm, isTrue);
    expect(value.supportsApns, isTrue);
    expect(value.supportsPushToStart, isFalse);
  });

  test('iOS 18 enables push-to-start', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.ios,
      iosMajorVersion: 18,
    );

    expect(value.supportsPushToStart, isTrue);
  });

  test('Android only enables FCM', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.android,
    );

    expect(value.supportsFcm, isTrue);
    expect(value.supportsApns, isFalse);
    expect(value.supportsPushToStart, isFalse);
  });
}
