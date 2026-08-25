import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_map_gpu_probe_action.g.dart';

@riverpod
EqmonitorMapGpuProbeAction eqmonitorMapGpuProbeAction(Ref ref) =>
    const EqmonitorMapGpuProbeAction();

sealed class EqmonitorMapGpuProbeInvalidationResult {
  const new();
}

final class EqmonitorMapGpuProbeInvalidationSucceeded
    extends EqmonitorMapGpuProbeInvalidationResult {
  const new();
}

final class EqmonitorMapGpuProbeInvalidationNotReady
    extends EqmonitorMapGpuProbeInvalidationResult {
  const new();
}

final class EqmonitorMapGpuProbeAction {
  const new();

  MapGpuProbeConfiguration withAtlasFixture({
    required MapGpuProbeConfiguration currentConfiguration,
    required MapSpriteAtlasProbeFixture atlasFixture,
  }) => MapGpuProbeConfiguration(
    faultPoint: currentConfiguration.faultPoint,
    atlasFixture: atlasFixture,
  );

  MapGpuProbeConfiguration withFaultPoint({
    required MapGpuProbeConfiguration currentConfiguration,
    required MapGpuFaultPoint? faultPoint,
  }) => MapGpuProbeConfiguration(
    faultPoint: faultPoint,
    atlasFixture: currentConfiguration.atlasFixture,
  );

  EqmonitorMapGpuProbeInvalidationResult invalidateRendererContextGeneration({
    required MapGpuProbeController controller,
  }) => switch (controller.invalidateRendererContextGeneration()) {
    true => const EqmonitorMapGpuProbeInvalidationSucceeded(),
    false => const EqmonitorMapGpuProbeInvalidationNotReady(),
  };
}
