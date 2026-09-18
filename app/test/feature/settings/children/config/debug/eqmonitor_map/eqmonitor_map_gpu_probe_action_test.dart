import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_action.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

final class RecordingMapGpuProbeHost implements MapGpuProbeHost {
  var invalidationCount = 0;

  @override
  void invalidateRendererContextGeneration() {
    invalidationCount += 1;
  }
}

void main() {
  const action = EqmonitorMapGpuProbeAction();

  test('atlas fixtureだけを置換して現在のfaultを維持する', () {
    const current = MapGpuProbeConfiguration(
      faultPoint: .shaderInterface,
      atlasFixture: .production,
    );

    final next = action.withAtlasFixture(
      currentConfiguration: current,
      atlasFixture: .edgeBleed,
    );

    expect(next.atlasFixture, MapSpriteAtlasProbeFixture.edgeBleed);
    expect(next.faultPoint, MapGpuFaultPoint.shaderInterface);
  });

  test('faultだけを置換して現在のatlas fixtureを維持する', () {
    const current = MapGpuProbeConfiguration(
      faultPoint: .frameSubmit,
      atlasFixture: .alphaHalf,
    );

    final next = action.withFaultPoint(
      currentConfiguration: current,
      faultPoint: null,
    );

    expect(next.atlasFixture, MapSpriteAtlasProbeFixture.alphaHalf);
    expect(next.faultPoint, isNull);
  });

  test('controller未接続時はtyped not-readyを返す', () {
    final controller = MapGpuProbeController();

    final result = action.invalidateRendererContextGeneration(
      controller: controller,
    );

    expect(result, isA<EqmonitorMapGpuProbeInvalidationNotReady>());
  });

  test('接続済みcontrollerのgenerationを1回無効化してtyped successを返す', () {
    final controller = MapGpuProbeController();
    final host = RecordingMapGpuProbeHost();
    controller.attach(host: host);

    final result = action.invalidateRendererContextGeneration(
      controller: controller,
    );

    expect(result, isA<EqmonitorMapGpuProbeInvalidationSucceeded>());
    expect(host.invalidationCount, 1);
  });
}
