import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/home_map_label_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/shake_detection_layer.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorRealtimeLayers extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewAliveTelegramProvider) ?? const [];
    final shakes = ref.watch(shakeDetectionVisibleProvider);
    final fillMode = ref.watch(
      homeConfigurationProvider.select(
        (configuration) =>
            configuration.value?.eew.fillMode ?? HomeEewFillMode.intensity,
      ),
    );
    final regions = eews
        .map((eew) => eew.forecastIntensity?.regions)
        .nonNulls
        .flattened
        .toList();

    final fillLayer = switch (fillMode) {
      HomeEewFillMode.intensity => EewEstimatedIntensityLayer(
        eewRegions: regions,
      ),
      HomeEewFillMode.warning => EewWarningRegionsLayer(eews: eews),
      HomeEewFillMode.none => const SizedBox.shrink(),
    };

    return Stack(
      children: [
        fillLayer,
        const KyoshinMonitorObservationLayer(),
        EewPsWaveLayer(eews: eews),
        ShakeDetectionLayer(events: shakes),
        EewHypocenterLayer(eews: eews),
        const HomeMapLabelLayer(),
      ],
    );
  }
}
