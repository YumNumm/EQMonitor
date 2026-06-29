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
    return _build(
      deviceId: deviceId,
      appVersion: appVersion,
      buildNumber: buildNumber,
      os: 'iOS ${deviceInfo.systemVersion}',
      deviceInfo: {
        'platform': 'ios',
        'modelName': deviceInfo.modelName,
        'machine': deviceInfo.utsname.machine,
        'isPhysicalDevice': deviceInfo.isPhysicalDevice,
      },
    );
  }

  Uri buildForAndroid({
    required String deviceId,
    required String appVersion,
    required String buildNumber,
    required AndroidDeviceInfo deviceInfo,
  }) {
    return _build(
      deviceId: deviceId,
      appVersion: appVersion,
      buildNumber: buildNumber,
      os: 'Android ${deviceInfo.version.release}',
      deviceInfo: {
        'platform': 'android',
        'brand': deviceInfo.brand,
        'model': deviceInfo.model,
        'manufacturer': deviceInfo.manufacturer,
        'sdkInt': deviceInfo.version.sdkInt,
        'isPhysicalDevice': deviceInfo.isPhysicalDevice,
      },
    );
  }

  Uri _build({
    required String deviceId,
    required String appVersion,
    required String buildNumber,
    required String os,
    required Map<String, Object?> deviceInfo,
  }) {
    return Uri.https('eqmonitor.app', '/contact', {
      'deviceId': deviceId,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'os': os,
      'deviceInfo': jsonEncode(deviceInfo),
    });
  }
}
