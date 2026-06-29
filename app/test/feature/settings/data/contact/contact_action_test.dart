import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_action.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  test(
    'contactUrlProvider builds iOS contact URL from app providers',
    () async {
      final container = ProviderContainer(
        overrides: [
          contactTargetPlatformProvider.overrideWithValue(TargetPlatform.iOS),
          deviceIdProvider.overrideWith((ref) async => 'device-uuid'),
          packageInfoProvider.overrideWithValue(
            PackageInfo(
              appName: 'EQMonitor',
              packageName: 'net.yumnumm.eqmonitor',
              version: '1.2.3',
              buildNumber: '456',
            ),
          ),
          iosDeviceInfoProvider.overrideWithValue(
            IosDeviceInfo.fromMap({
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
            }),
          ),
        ],
      );
      addTearDown(container.dispose);

      final url = await container.read(contactUrlProvider.future);
      final deviceInfo = jsonDecode(url.queryParameters['deviceInfo']!);

      expect(url.toString(), startsWith('https://eqmonitor.app/contact?'));
      expect(url.queryParameters['deviceId'], 'device-uuid');
      expect(url.queryParameters['appVersion'], '1.2.3');
      expect(url.queryParameters['buildNumber'], '456');
      expect(url.queryParameters['os'], 'iOS 18.0');
      expect(deviceInfo, containsPair('platform', 'ios'));
    },
  );
}
