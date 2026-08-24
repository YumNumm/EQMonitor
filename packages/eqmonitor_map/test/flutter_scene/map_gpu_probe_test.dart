import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('configured fault fires exactly once at its typed point', () {
    final runtime = MapGpuProbeRuntime(
      configuration: const MapGpuProbeConfiguration(
        faultPoint: MapGpuFaultPoint.atlasUpload,
        atlasFixture: MapSpriteAtlasProbeFixture.alphaHalf,
      ),
    );

    expect(
      () => runtime.throwIfRequested(MapGpuFaultPoint.shaderInterface),
      returnsNormally,
    );
    expect(
      () => runtime.throwIfRequested(MapGpuFaultPoint.atlasUpload),
      throwsA(
        isA<MapGpuProbeFault>().having(
          (fault) => fault.point,
          'point',
          MapGpuFaultPoint.atlasUpload,
        ),
      ),
    );
    expect(
      () => runtime.throwIfRequested(MapGpuFaultPoint.atlasUpload),
      returnsNormally,
    );
    expect(runtime.atlasFixture, MapSpriteAtlasProbeFixture.alphaHalf);
  });

  test('controller invalidates only its currently attached renderer host', () {
    final controller = MapGpuProbeController();
    final first = _FakeProbeHost();
    final second = _FakeProbeHost();

    expect(controller.invalidateRendererContextGeneration(), isFalse);
    expect(controller.attach(host: first), isTrue);
    expect(controller.attach(host: second), isFalse);
    expect(controller.invalidateRendererContextGeneration(), isTrue);
    expect(first.invalidations, 1);
    expect(second.invalidations, 0);

    controller.detach(host: second);
    expect(controller.invalidateRendererContextGeneration(), isTrue);
    controller.detach(host: first);
    expect(controller.invalidateRendererContextGeneration(), isFalse);
  });

  test('resource snapshots expose immutable per-kind lifecycle counters', () {
    const snapshot = MapGpuResourceCounterSnapshot(
      texture: MapGpuResourceKindCounter(
        active: 1,
        candidate: 1,
        pendingRetire: 2,
        uploads: 3,
        retires: 4,
      ),
      topology: MapGpuResourceKindCounter.zero,
      instance: MapGpuResourceKindCounter.zero,
      node: MapGpuResourceKindCounter.zero,
      rendererContextGeneration: 7,
    );

    expect(snapshot.texture.live, 4);
    expect(snapshot.rendererContextGeneration, 7);
  });
}

final class _FakeProbeHost implements MapGpuProbeHost {
  _FakeProbeHost() : invalidations = 0;

  int invalidations;

  @override
  void invalidateRendererContextGeneration() {
    invalidations++;
  }
}
