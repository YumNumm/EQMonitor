import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/app_launch_recorder_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_launch_watcher_provider.g.dart';

/// Watches the app lifecycle and records app launch telemetry events.
///
/// On cold start (`build`), records a `cold_start` event immediately.
/// When the app resumes from background, records a `resume` event
/// (subject to the 30-second debounce inside the recorder).
///
/// Register this provider in `main.dart` by calling
/// `container.read(appLaunchWatcherProvider)`.
@Riverpod(keepAlive: true)
class AppLaunchWatcher extends _$AppLaunchWatcher with WidgetsBindingObserver {
  @override
  void build() {
    final binding = WidgetsBinding.instance..addObserver(this);
    ref.onDispose(() => binding.removeObserver(this));

    // Record cold-start event asynchronously, non-blocking.
    unawaited(_recordLaunch('cold_start'));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_recordLaunch('resume'));
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> _recordLaunch(String launchType) async {
    try {
      final recorder = await ref.read(appLaunchRecorderProvider.future);
      final packageInfo = ref.read(packageInfoProvider);

      if (kIsWeb) {
        return;
      }

      if (Platform.isAndroid) {
        final android = ref.read(androidDeviceInfoProvider);
        await recorder.record(
          launchType: launchType,
          appVersion: packageInfo.version,
          buildNumber: int.tryParse(packageInfo.buildNumber) ?? 0,
          platform: 'android',
          osVersion: android.version.release,
          deviceModel: android.model,
          locale: Platform.localeName,
          isPhysicalDevice: android.isPhysicalDevice,
          physicalRamMb: android.physicalRamSize,
          cpuCores: Platform.numberOfProcessors,
          manufacturer: android.manufacturer,
          androidSdkInt: android.version.sdkInt,
          securityPatch: android.version.securityPatch,
          isLowRamDevice: android.isLowRamDevice,
          installerStore: packageInfo.installerStore,
        );
      } else if (Platform.isIOS) {
        final ios = ref.read(iosDeviceInfoProvider);
        await recorder.record(
          launchType: launchType,
          appVersion: packageInfo.version,
          buildNumber: int.tryParse(packageInfo.buildNumber) ?? 0,
          platform: 'ios',
          osVersion: ios.systemVersion,
          deviceModel: ios.utsname.machine,
          locale: Platform.localeName,
          isPhysicalDevice: ios.isPhysicalDevice,
          physicalRamMb: ios.physicalRamSize,
          cpuCores: Platform.numberOfProcessors,
          manufacturer: 'Apple',
          installerStore: packageInfo.installerStore,
        );
      }
    } on Object catch (e, st) {
      // Telemetry must never crash the app.
      debugPrint('[AppLaunchWatcher] Failed to record $launchType: $e\n$st');
    }
  }
}
