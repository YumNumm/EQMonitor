import 'dart:io';

import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pushTokenPlatformCapabilitiesProvider =
    Provider<PushTokenPlatformCapabilities>((ref) {
      if (kIsWeb) {
        return const PushTokenPlatformCapabilities();
      }
      if (Platform.isAndroid) {
        return PushTokenPlatformCapabilities.forPlatform(platform: .android);
      }
      if (!Platform.isIOS) {
        return const PushTokenPlatformCapabilities();
      }

      final systemVersion = ref.watch(iosDeviceInfoProvider).systemVersion;
      final iosMajorVersion = int.tryParse(systemVersion.split('.').first);
      return PushTokenPlatformCapabilities.forPlatform(
        platform: .ios,
        iosMajorVersion: iosMajorVersion,
      );
    });
