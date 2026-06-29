import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_url_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds contact URL from iOS device info with selected fields', () {
    const builder = ContactUrlBuilder();
    final ios = IosDeviceInfo.fromMap({
      'name': 'iPhone',
      'systemName': 'iOS',
      'systemVersion': '18.0',
      'model': 'iPhone',
      'modelName': 'iPhone 16 Pro',
      'localizedModel': 'iPhone',
      'identifierForVendor': 'vendor-id',
      'freeDiskSize': 1000,
      'totalDiskSize': 2000,
      'isPhysicalDevice': true,
      'physicalRamSize': 8192,
      'availableRamSize': 4096,
      'isiOSAppOnMac': false,
      'isiOSAppOnVision': false,
      'utsname': {
        'sysname': 'Darwin',
        'nodename': 'node',
        'release': 'release',
        'version': 'version',
        'machine': 'iPhone17,1',
      },
    });

    final url = builder.buildForIos(
      deviceId: 'device-uuid',
      appVersion: '1.2.3',
      buildNumber: '456',
      deviceInfo: ios,
    );
    final deviceInfo =
        jsonDecode(url.queryParameters['deviceInfo']!) as Map<String, dynamic>;

    expect(url.scheme, 'https');
    expect(url.host, 'eqmonitor.app');
    expect(url.path, '/contact');
    expect(url.queryParameters['deviceId'], 'device-uuid');
    expect(url.queryParameters['appVersion'], '1.2.3');
    expect(url.queryParameters['buildNumber'], '456');
    expect(url.queryParameters['os'], 'iOS 18.0');
    expect(deviceInfo, containsPair('platform', 'ios'));
    expect(deviceInfo, containsPair('modelName', 'iPhone 16 Pro'));
    expect(deviceInfo, containsPair('machine', 'iPhone17,1'));
    expect(deviceInfo, containsPair('isPhysicalDevice', true));
    expect(deviceInfo, hasLength(4));
  });

  test('builds contact URL from Android device info with selected fields', () {
    const builder = ContactUrlBuilder();
    final android = AndroidDeviceInfo.fromMap({
      'version': {
        'baseOS': '',
        'codename': 'REL',
        'incremental': '123',
        'previewSdkInt': 0,
        'release': '15',
        'sdkInt': 35,
        'securityPatch': '2026-01-01',
      },
      'board': 'board',
      'bootloader': 'bootloader',
      'brand': 'Google',
      'device': 'komodo',
      'display': 'display',
      'fingerprint': 'fingerprint',
      'hardware': 'hardware',
      'host': 'host',
      'id': 'id',
      'manufacturer': 'Google',
      'model': 'Pixel 9 Pro',
      'product': 'komodo',
      'name': 'Pixel',
      'supported32BitAbis': <String>[],
      'supported64BitAbis': ['arm64-v8a'],
      'supportedAbis': ['arm64-v8a'],
      'tags': 'release-keys',
      'type': 'user',
      'isPhysicalDevice': true,
      'freeDiskSize': 1000,
      'totalDiskSize': 2000,
      'systemFeatures': <String>[],
      'isLowRamDevice': false,
      'physicalRamSize': 12000,
      'availableRamSize': 6000,
    });

    final url = builder.buildForAndroid(
      deviceId: 'device-uuid',
      appVersion: '1.2.3',
      buildNumber: '456',
      deviceInfo: android,
    );
    final deviceInfo =
        jsonDecode(url.queryParameters['deviceInfo']!) as Map<String, dynamic>;

    expect(url.queryParameters['os'], 'Android 15');
    expect(deviceInfo, containsPair('platform', 'android'));
    expect(deviceInfo, containsPair('brand', 'Google'));
    expect(deviceInfo, containsPair('model', 'Pixel 9 Pro'));
    expect(deviceInfo, containsPair('manufacturer', 'Google'));
    expect(deviceInfo, containsPair('sdkInt', 35));
    expect(deviceInfo, containsPair('isPhysicalDevice', true));
    expect(deviceInfo, hasLength(6));
  });
}
