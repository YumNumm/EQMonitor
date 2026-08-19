import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/core/provider/api_user_agent_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  const builder = ApiUserAgentBuilder();
  final packageInfo = PackageInfo(
    appName: 'EQMonitor',
    packageName: 'net.yumnumm.eqmonitor',
    version: '3.0.0',
    buildNumber: '100',
  );

  test('iOS端末情報を含むUser-Agentを組み立てる', () {
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

    expect(
      builder.build(packageInfo: packageInfo, iosDeviceInfo: ios),
      'net.yumnumm.eqmonitor/3.0.0+100 '
      '(+https://github.com/YumNumm/EQMonitor) '
      '(iPhone17,1; iOS 18.0)',
    );
  });

  test('Android端末情報を含むUser-Agentを組み立てる', () {
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

    expect(
      builder.build(packageInfo: packageInfo, androidDeviceInfo: android),
      'net.yumnumm.eqmonitor/3.0.0+100 '
      '(+https://github.com/YumNumm/EQMonitor) '
      '(Pixel 9 Pro; Android 15)',
    );
  });
}
