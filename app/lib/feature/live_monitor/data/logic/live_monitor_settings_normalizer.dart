import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';

class LiveMonitorSettingsNormalizer {
  const LiveMonitorSettingsNormalizer();

  LiveMonitorSettings normalize(LiveMonitorSettings settings) {
    final earthquakeDisplaySeconds =
        settings.earthquakeDisplaySeconds >= 3 &&
            settings.earthquakeDisplaySeconds <= 300
        ? settings.earthquakeDisplaySeconds
        : const LiveMonitorSettings().earthquakeDisplaySeconds;
    return settings.copyWith(
      earthquakeDisplaySeconds: earthquakeDisplaySeconds,
      portraitRealtimeRatio: settings.portraitRealtimeRatio.clamp(0.2, 0.8),
      landscapeRealtimeRatio: settings.landscapeRealtimeRatio.clamp(0.2, 0.8),
    );
  }
}
