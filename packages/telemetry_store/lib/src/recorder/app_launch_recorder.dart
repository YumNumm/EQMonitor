import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemetry_store/src/models/telemetry_event.dart';
import 'package:telemetry_store/src/recorder/telemetry_recorder.dart';

/// SharedPreferences key for the last app launch telemetry send timestamp.
const _kLastSentKey = 'app_launch_last_sent_ms';

/// Minimum interval between app launch telemetry records (30 seconds).
const _kDebounceMs = 30000;

/// Records [TelemetryEvent.appLaunch] events with a 30-second debounce.
///
/// Prevents duplicate records when the app is backgrounded and resumed
/// within the debounce window. Returns `true` when the event was recorded,
/// `false` when debounced.
class AppLaunchRecorder {
  AppLaunchRecorder(this._recorder, this._prefs);

  final TelemetryRecorder _recorder;
  final SharedPreferences _prefs;

  /// Records an app launch event if at least [_kDebounceMs] milliseconds
  /// have passed since the last recorded event.
  ///
  /// Returns `true` when the event was recorded, `false` when debounced.
  Future<bool> record({
    required String launchType,
    required String appVersion,
    required int buildNumber,
    required String platform,
    required String osVersion,
    required String deviceModel,
    required String locale,
    required bool isPhysicalDevice,
    required int physicalRamMb,
    required int cpuCores,
    required String manufacturer,
    int? androidSdkInt,
    String? securityPatch,
    bool? isLowRamDevice,
    String? installerStore,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final lastSentMs = _prefs.getInt(_kLastSentKey);

    if (lastSentMs != null && now - lastSentMs < _kDebounceMs) {
      return false;
    }

    final event = TelemetryEvent.appLaunch(
      launchType: launchType,
      appVersion: appVersion,
      buildNumber: buildNumber,
      platform: platform,
      osVersion: osVersion,
      deviceModel: deviceModel,
      locale: locale,
      isPhysicalDevice: isPhysicalDevice,
      physicalRamMb: physicalRamMb,
      cpuCores: cpuCores,
      manufacturer: manufacturer,
      androidSdkInt: androidSdkInt,
      securityPatch: securityPatch,
      isLowRamDevice: isLowRamDevice,
      installerStore: installerStore,
    );

    await _recorder.record(event);
    await _prefs.setInt(_kLastSentKey, now);

    return true;
  }
}
