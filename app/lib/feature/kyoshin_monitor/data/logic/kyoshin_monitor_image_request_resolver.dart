import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_image_request.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_image_request_resolver.g.dart';

@riverpod
KyoshinMonitorImageRequestResolver kyoshinMonitorImageRequestResolver(
  Ref ref,
) => const KyoshinMonitorImageRequestResolver();

class KyoshinMonitorImageRequestResolver {
  const new();

  KyoshinMonitorImageRequest resolve(KyoshinMonitorSettingsModel settings) =>
      KyoshinMonitorImageRequest(
        layer: settings.realtimeDataType.isLpgm
            ? RealtimeLayer.surface
            : settings.realtimeLayer,
        source: settings.realtimeDataType.isLpgm
            ? KyoshinMonitorSource.lmoni
            : settings.monitorSource,
        delayProfile: settings.realtimeDataType.isLpgm
            ? KyoshinMonitorDelayProfile.lpgm
            : KyoshinMonitorDelayProfile.kmoni,
        canSelectRealtimeLayer:
            settings.useKmoni && !settings.realtimeDataType.isLpgm,
      );

  KyoshinMonitorDelayAdjustConfig delayAdjustConfig(
    KyoshinMonitorSettingsApiModel api,
  ) => KyoshinMonitorDelayAdjustConfig(
    minOffset: api.minOffset,
    maxOffset: api.maxOffset,
  );
}
