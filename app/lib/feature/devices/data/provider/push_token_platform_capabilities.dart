import 'dart:io';

import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_platform_capabilities.g.dart';

@Riverpod(keepAlive: true)
PushTokenPlatformCapabilities pushTokenPlatformCapabilities(Ref ref) {
  if (kIsWeb) {
    return PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.unsupported,
    );
  }
  if (Platform.isAndroid) {
    return PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.android,
    );
  }
  if (Platform.isIOS) {
    // systemVersion（例: "18.1.1"）の先頭の数値部分のみをメジャーバージョン
    // として解析する。解析できない場合はnullとなり、push-to-startは無効になる。
    final systemVersion = ref.watch(iosDeviceInfoProvider).systemVersion;
    final iosMajorVersion = int.tryParse(
      RegExp(r'^\d+').firstMatch(systemVersion)?[0] ?? '',
    );
    return PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.ios,
      iosMajorVersion: iosMajorVersion,
    );
  }
  return PushTokenPlatformCapabilities.forPlatform(
    platform: PushTokenPlatform.unsupported,
  );
}
