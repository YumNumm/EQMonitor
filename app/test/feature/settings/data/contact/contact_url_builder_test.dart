import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_url_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds contact URL with app and encoded iOS device metadata', () {
    const builder = ContactUrlBuilder();

    final url = builder.build(
      deviceId: 'device-uuid',
      appVersion: '1.2.3',
      buildNumber: '456',
      os: 'iOS 18.0',
      deviceInfo: const {
        'platform': 'ios',
        'model': 'iPhone 16 Pro',
        'machine': 'iPhone17,1',
        'isPhysicalDevice': true,
      },
    );

    expect(url.scheme, 'https');
    expect(url.host, 'eqmonitor.app');
    expect(url.path, '/contact');
    expect(url.queryParameters, {
      'deviceId': 'device-uuid',
      'appVersion': '1.2.3',
      'buildNumber': '456',
      'os': 'iOS 18.0',
      'deviceInfo': jsonEncode({
        'platform': 'ios',
        'model': 'iPhone 16 Pro',
        'machine': 'iPhone17,1',
        'isPhysicalDevice': true,
      }),
    });
    expect(url.toString(), contains('os=iOS%2018.0'));
    expect(url.toString(), contains('deviceInfo=%7B'));
  });

  test('builds contact URL from iOS device info', () {
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
    final deviceInfo = jsonDecode(url.queryParameters['deviceInfo']!);

    expect(url.queryParameters['os'], 'iOS 18.0');
    expect(deviceInfo, containsPair('platform', 'ios'));
    expect(deviceInfo, containsPair('modelName', 'iPhone 16 Pro'));
    expect(
      deviceInfo,
      containsPair('utsname', containsPair('machine', 'iPhone17,1')),
    );
  });

  test('builds contact URL from Android device info', () {
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
    final deviceInfo = jsonDecode(url.queryParameters['deviceInfo']!);

    expect(url.queryParameters['os'], 'Android 15');
    expect(deviceInfo, containsPair('platform', 'android'));
    expect(deviceInfo, containsPair('model', 'Pixel 9 Pro'));
    expect(deviceInfo, containsPair('version', containsPair('sdkInt', 35)));
  });
}
