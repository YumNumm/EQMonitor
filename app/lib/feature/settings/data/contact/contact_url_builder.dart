import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';

class ContactUrlBuilder {
  const ContactUrlBuilder();

  Uri buildForIos({
    required String deviceId,
    required String appVersion,
    required String buildNumber,
    required IosDeviceInfo deviceInfo,
  }) {
    return build(
      deviceId: deviceId,
      appVersion: appVersion,
      buildNumber: buildNumber,
      os: 'iOS ${deviceInfo.systemVersion}',
      deviceInfo: {
        'platform': 'ios',
        ...deviceInfo.data,
      },
    );
  }

  Uri buildForAndroid({
    required String deviceId,
    required String appVersion,
    required String buildNumber,
    required AndroidDeviceInfo deviceInfo,
  }) {
    return build(
      deviceId: deviceId,
      appVersion: appVersion,
      buildNumber: buildNumber,
      os: 'Android ${deviceInfo.version.release}',
      deviceInfo: {
        'platform': 'android',
        ...deviceInfo.data,
      },
    );
  }

  Uri build({
    required String deviceId,
    required String appVersion,
    required String buildNumber,
    required String os,
    required Map<String, Object?> deviceInfo,
  }) {
    final parameters = {
      'deviceId': deviceId,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'os': os,
      'deviceInfo': jsonEncode(deviceInfo),
    };
    final query = parameters.entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key)}='
              '${Uri.encodeComponent(entry.value)}',
        )
        .join('&');
    return Uri.parse('https://eqmonitor.app/contact?$query');
  }
}
