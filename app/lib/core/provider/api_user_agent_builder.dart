import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// EQMonitor API 向け User-Agent 文字列を組み立てる。
///
/// 例: `net.yumnumm.eqmonitor/3.0.0+100 (+https://github.com/YumNumm/EQMonitor) (iPhone17,1; iOS 18.0)`
class ApiUserAgentBuilder {
  const new();

  static const repositoryUrl = 'https://github.com/YumNumm/EQMonitor';

  String build({
    required PackageInfo packageInfo,
    AndroidDeviceInfo? androidDeviceInfo,
    IosDeviceInfo? iosDeviceInfo,
  }) {
    final devicePart = switch ((androidDeviceInfo, iosDeviceInfo)) {
      (final AndroidDeviceInfo android, _) =>
        '${android.model}; Android ${android.version.release}',
      (_, final IosDeviceInfo ios) =>
        '${ios.utsname.machine}; iOS ${ios.systemVersion}',
      _ => Platform.operatingSystem,
    };

    return '${packageInfo.packageName}/'
        '${packageInfo.version}+${packageInfo.buildNumber} '
        '(+$repositoryUrl) ($devicePart)';
  }
}
