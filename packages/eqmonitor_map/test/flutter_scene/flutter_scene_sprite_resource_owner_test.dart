import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_sprite_resource_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/overlay/map_point_sprite_feature.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final clock = SystemMapClock.start(
    domain: createMapClockDomainId(value: 'sprite-resource-owner-test'),
  );
  final sizePolicy = createMapZoomLinearRange(
    startZoom: 3,
    startValue: 0.5,
    endZoom: 20,
    endValue: 1.5,
  );
  final secondSizePolicy = createMapZoomLinearRange(
    startZoom: 4,
    startValue: 0.75,
    endZoom: 18,
    endValue: 1.25,
  );
  final opacityPolicy = createMapZoomStep(
    thresholdZoom: 5,
    belowValue: 0,
    atOrAboveValue: 1,
  );

  MapFrameSnapshot frame({
    required int number,
    int contextGeneration = 0,
    double longitude = 139.7,
  }) => captureMapFrameSnapshot(
    clock: clock,
    frameNumber: number,
    camera: MapCamera(
      centerLongitude: longitude,
      centerLatitude: 35.7,
      zoom: 6,
    ),
    viewport: MapViewport(
      logicalSize: const Size(400, 800),
      devicePixelRatio: 3,
    ),
    revisions: const [],
    lifecycle: MapAppLifecycle.active,
    contextGeneration: contextGeneration,
  );

  MapSpriteAtlas atlas(String identity) => createMapSpriteAtlas(
    identity: createMapSourceIdentity(value: identity),
    width: 4,
    height: 4,
    rgbaBytes: Uint8List(64),
    regions: const [
      MapSpriteRegion(
        id: 'normal',
        normalizedUv: Rect.fromLTRB(0.125, 0.125, 0.375, 0.375),
        logicalSize: Size(24, 32),
      ),
    ],
    limits: const MapSpriteAtlasLimits(
      maxWidth: 4,
      maxHeight: 4,
      maxPixelBytes: 64,
      maxRegions: 1,
    ),
  );

  MapOverlayVersionStamp stamp(int generation) => createMapOverlayVersionStamp(
    sourceIdentity: createMapSourceIdentity(value: 'event'),
    sourceIncarnation: createMapSourceIncarnation(value: 'incarnation'),
    dataSequence: generation,
    dataDigest: 'data-$generation',
    renderGeneration: generation,
    renderDigest: 'render-$generation',
  );

  List<MapPointSpriteInstanceBatch> batches({
    required MapFrameSnapshot frame,
    required MapSpriteAtlas atlas,
    required int generation,
    int priority = 0,
    bool twoPolicies = false,
    List<MapPointSpriteInstanceBatch> previous = const [],
  }) => buildMapPointSpriteBatches(
    frame: frame,
    versionStamp: stamp(generation),
    atlas: atlas,
    features: [
      createMapPointSpriteFeature(
        id: 'a',
        longitude: 139.7,
        latitude: 35.7,
        spriteRegionId: 'normal',
        sizeScale: sizePolicy,
        opacity: opacityPolicy,
        priority: priority,
      ),
      if (twoPolicies)
        createMapPointSpriteFeature(
          id: 'b',
          longitude: 140,
          latitude: 36,
          spriteRegionId: 'normal',
          sizeScale: secondSizePolicy,
          opacity: opacityPolicy,
          priority: 1,
        ),
    ],
    maxPolicyBatches: twoPolicies ? 2 : 1,
    previous: previous,
  );

  test('reuses texture topology and camera-only instance resources', () {
    final backend = _FakeSpriteBackend();
    final completions = <Completer<void>>[];
    final owner = _owner(
      backend: backend,
      maxFramesInFlight: 2,
      maxActiveAtlases: 1,
      maxTopologyVariants: 1,
      maxPolicyBatches: 2,
      completions: completions,
    );
    final spriteAtlas = atlas('sha256:atlas-a');
    final firstFrame = frame(number: 0);
    final firstBatches = batches(
      frame: firstFrame,
      atlas: spriteAtlas,
      generation: 1,
    );
    owner.prepareFrame(frame: firstFrame, batches: firstBatches).commit();
    final secondFrame = frame(number: 1, longitude: 140);
    final cameraOnly = batches(
      frame: secondFrame,
      atlas: spriteAtlas,
      generation: 1,
      previous: firstBatches,
    );
    owner.prepareFrame(frame: secondFrame, batches: cameraOnly).commit();

    expect(backend.textureUploads, 1);
    expect(backend.topologyPrepares, 1);
    expect(backend.topologyAbiVersions, [mapSpriteInstanceAbiVersion]);
    expect(backend.instancePrepares, 1);
    expect(owner.snapshot.texture.active, 1);
    expect(owner.snapshot.texture.pendingRetire, 1);
    expect(owner.snapshot.node.active, 1);
    expect(owner.snapshot.node.pendingRetire, 1);

    completions.single.complete();
    return pumpEventQueue().then((_) {
      expect(backend.textureRetires, 0);
      expect(backend.topologyRetires, 0);
      expect(backend.instanceRetires, 0);
      expect(owner.snapshot.texture.pendingRetire, 0);
    });
  });

  test(
    'different batch uploads only instance and shared atlas survives',
    () async {
      final backend = _FakeSpriteBackend();
      final completions = <Completer<void>>[];
      final owner = _owner(
        backend: backend,
        maxFramesInFlight: 2,
        maxActiveAtlases: 1,
        maxTopologyVariants: 1,
        maxPolicyBatches: 2,
        completions: completions,
      );
      final spriteAtlas = atlas('sha256:atlas-a');
      final firstFrame = frame(number: 0);
      final first = batches(
        frame: firstFrame,
        atlas: spriteAtlas,
        generation: 1,
        twoPolicies: true,
      );
      owner.prepareFrame(frame: firstFrame, batches: first).commit();
      final secondFrame = frame(number: 1);
      final second = batches(
        frame: secondFrame,
        atlas: spriteAtlas,
        generation: 2,
        priority: 3,
      );
      owner.prepareFrame(frame: secondFrame, batches: second).commit();

      expect(backend.textureUploads, 1);
      expect(backend.topologyPrepares, 1);
      expect(backend.instancePrepares, 3);
      expect(owner.snapshot.node.active, 1);
      expect(owner.snapshot.node.pendingRetire, 2);

      completions.single.complete();
      await pumpEventQueue();
      expect(backend.textureRetires, 0);
      expect(backend.topologyRetires, 0);
      expect(backend.instanceRetires, 2);
      expect(owner.snapshot.instance.active, 1);
    },
  );

  test('preflight upload and prepare failures rollback before commit', () {
    for (final failure in _FakeFailurePoint.values) {
      final backend = _FakeSpriteBackend(failurePoint: failure);
      final owner = _owner(
        backend: backend,
        maxFramesInFlight: 1,
        maxActiveAtlases: 1,
        maxTopologyVariants: 1,
        maxPolicyBatches: 1,
        completions: [],
      );
      final candidateFrame = frame(number: 0);
      final candidateBatches = batches(
        frame: candidateFrame,
        atlas: atlas('sha256:$failure'),
        generation: 1,
      );

      expect(
        () => owner.prepareFrame(
          frame: candidateFrame,
          batches: candidateBatches,
        ),
        throwsA(
          isA<FlutterSceneSpriteResourceFailure>().having(
            (failure) => failure.reason,
            'reason',
            switch (failure) {
              _FakeFailurePoint.shaderInterface =>
                FlutterSceneSpriteResourceFailureReason.shaderInterface,
              _FakeFailurePoint.atlasUpload =>
                FlutterSceneSpriteResourceFailureReason.atlasUpload,
              _FakeFailurePoint.topology =>
                FlutterSceneSpriteResourceFailureReason.topologyPrepare,
              _FakeFailurePoint.instance =>
                FlutterSceneSpriteResourceFailureReason.instancePrepare,
            },
          ),
        ),
      );
      expect(owner.snapshot.node.live, 0);
      expect(owner.snapshot.texture.live, 0);
      expect(owner.snapshot.topology.live, 0);
      expect(owner.snapshot.instance.live, 0);
      expect(backend.liveResources, 0);
    }
  });

  test('explicit rollback retires candidate resources exactly once', () {
    final backend = _FakeSpriteBackend();
    final owner = _owner(
      backend: backend,
      maxFramesInFlight: 1,
      maxActiveAtlases: 1,
      maxTopologyVariants: 1,
      maxPolicyBatches: 1,
      completions: [],
    );
    final candidateFrame = frame(number: 0);
    final prepared = owner.prepareFrame(
      frame: candidateFrame,
      batches: batches(
        frame: candidateFrame,
        atlas: atlas('sha256:rollback'),
        generation: 1,
      ),
    );

    prepared.rollback();
    prepared.rollback();
    expect(backend.textureRetires, 1);
    expect(backend.topologyRetires, 1);
    expect(backend.instanceRetires, 1);
    expect(backend.liveResources, 0);
  });

  test('one retirement failure does not block remaining exact releases', () {
    final backend = _FakeSpriteBackend(failFirstInstanceRetire: true);
    final owner = _owner(
      backend: backend,
      maxFramesInFlight: 1,
      maxActiveAtlases: 1,
      maxTopologyVariants: 1,
      maxPolicyBatches: 2,
      completions: [],
    );
    final candidateFrame = frame(number: 0);
    final prepared = owner.prepareFrame(
      frame: candidateFrame,
      batches: batches(
        frame: candidateFrame,
        atlas: atlas('sha256:retire-failure'),
        generation: 1,
        twoPolicies: true,
      ),
    );

    prepared.rollback();
    prepared.rollback();

    expect(backend.instanceRetires, 2);
    expect(backend.topologyRetires, 1);
    expect(backend.textureRetires, 1);
    if (mapGpuProbeCompileTimeEnabled) {
      expect(owner.snapshot.instance.retires, 2);
      expect(owner.snapshot.topology.retires, 1);
      expect(owner.snapshot.texture.retires, 1);
    }
  });

  test('F plus 2 worst case rejects before exceeding resource bounds', () {
    final backend = _FakeSpriteBackend();
    final completions = <Completer<void>>[];
    final owner = _owner(
      backend: backend,
      maxFramesInFlight: 2,
      maxActiveAtlases: 1,
      maxTopologyVariants: 1,
      maxPolicyBatches: 1,
      completions: completions,
    );
    for (var number = 0; number < 3; number++) {
      final currentFrame = frame(
        number: number,
        contextGeneration: number,
      );
      owner
          .prepareFrame(
            frame: currentFrame,
            batches: batches(
              frame: currentFrame,
              atlas: atlas('sha256:atlas-$number'),
              generation: number + 1,
            ),
          )
          .commit();
      expect(owner.snapshot.texture.live, lessThanOrEqualTo(3));
      expect(owner.snapshot.topology.live, lessThanOrEqualTo(3));
      expect(owner.snapshot.instance.live, lessThanOrEqualTo(3));
      expect(owner.snapshot.node.pendingRetire, lessThanOrEqualTo(2));
    }
    final overflowFrame = frame(number: 3, contextGeneration: 3);

    expect(
      () => owner.prepareFrame(
        frame: overflowFrame,
        batches: batches(
          frame: overflowFrame,
          atlas: atlas('sha256:atlas-3'),
          generation: 4,
        ),
      ),
      throwsA(
        isA<FlutterSceneSpriteResourceFailure>().having(
          (failure) => failure.reason,
          'reason',
          FlutterSceneSpriteResourceFailureReason.livePinLimitExceeded,
        ),
      ),
    );
    expect(backend.textureUploads, 3);
    expect(owner.snapshot.texture.live, 3);
  });

  test('retire all waits for fence and is idempotent after errors', () async {
    final backend = _FakeSpriteBackend();
    final completion = Completer<void>();
    final owner = FlutterSceneSpriteResourceOwner(
      limits: const MapSpriteRendererLimits(
        maxActiveAtlases: 1,
        maxTopologyVariants: 1,
        maxPolicyBatches: 1,
      ),
      maxFramesInFlight: 1,
      backend: backend,
      waitForGpuCompletion: () => completion.future,
    );
    final currentFrame = frame(number: 0);
    owner
        .prepareFrame(
          frame: currentFrame,
          batches: batches(
            frame: currentFrame,
            atlas: atlas('sha256:dispose'),
            generation: 1,
          ),
        )
        .commit();

    owner.retireAll();
    owner.retireAll();
    expect(backend.liveResources, 3);
    completion.completeError(StateError('context lost'));
    await pumpEventQueue();
    expect(backend.textureRetires, 1);
    expect(backend.topologyRetires, 1);
    expect(backend.instanceRetires, 1);
    expect(owner.snapshot.node.live, 0);
  });

  test('nullable probe and callback allocate no debug runtime path', () {
    final backend = _FakeSpriteBackend();
    final owner = _owner(
      backend: backend,
      maxFramesInFlight: 1,
      maxActiveAtlases: 1,
      maxTopologyVariants: 1,
      maxPolicyBatches: 1,
      completions: [],
    );

    expect(owner.probeRuntime, isNull);
    expect(owner.hasCounterCallback, isFalse);
  });

  test('compile-time disabled owner bypasses probe and counter hot paths', () {
    if (mapGpuProbeCompileTimeEnabled) {
      return;
    }
    final snapshots = <MapGpuResourceCounterSnapshot>[];
    final backend = _FakeSpriteBackend();
    final owner = FlutterSceneSpriteResourceOwner(
      limits: const MapSpriteRendererLimits(
        maxActiveAtlases: 1,
        maxTopologyVariants: 1,
        maxPolicyBatches: 1,
      ),
      maxFramesInFlight: 1,
      backend: backend,
      waitForGpuCompletion: Future<void>.value,
      probeRuntime: MapGpuProbeRuntime(
        configuration: const MapGpuProbeConfiguration(
          faultPoint: MapGpuFaultPoint.shaderInterface,
          atlasFixture: MapSpriteAtlasProbeFixture.production,
        ),
      ),
      onCounterSnapshot: snapshots.add,
    );
    final candidateFrame = frame(number: 0);

    final prepared = owner.prepareFrame(
      frame: candidateFrame,
      batches: batches(
        frame: candidateFrame,
        atlas: atlas('sha256:production-no-probe'),
        generation: 1,
      ),
    );
    prepared.commit();

    expect(snapshots, isEmpty);
    expect(owner.snapshot.texture.uploads, 0);
    expect(owner.snapshot.node.active, 1);
  });

  test(
    'counter callback reports candidate commit and fence retirement states',
    () async {
      if (!mapGpuProbeCompileTimeEnabled) {
        return;
      }
      final snapshots = <MapGpuResourceCounterSnapshot>[];
      final backend = _FakeSpriteBackend();
      final owner = FlutterSceneSpriteResourceOwner(
        limits: const MapSpriteRendererLimits(
          maxActiveAtlases: 1,
          maxTopologyVariants: 1,
          maxPolicyBatches: 1,
        ),
        maxFramesInFlight: 1,
        backend: backend,
        waitForGpuCompletion: Future<void>.value,
        onCounterSnapshot: snapshots.add,
      );
      final candidateFrame = frame(number: 0);
      final prepared = owner.prepareFrame(
        frame: candidateFrame,
        batches: batches(
          frame: candidateFrame,
          atlas: atlas('sha256:counters'),
          generation: 1,
        ),
      );
      prepared.commit();
      owner.retireAll();
      await pumpEventQueue();

      expect(snapshots.first.node.candidate, 1);
      expect(snapshots[1].node.active, 1);
      expect(snapshots[2].node.pendingRetire, 1);
      expect(snapshots.last.node.live, 0);
      expect(snapshots.last.node.retires, 1);
    },
  );

  test('atlas fixture uploads only texture and preserves GPU geometry', () {
    if (!mapGpuProbeCompileTimeEnabled) {
      return;
    }
    final backend = _FakeSpriteBackend();
    final owner = _owner(
      backend: backend,
      maxFramesInFlight: 2,
      maxActiveAtlases: 1,
      maxTopologyVariants: 1,
      maxPolicyBatches: 1,
      completions: [],
    );
    final productionAtlas = atlas('sha256:production');
    final firstFrame = frame(number: 0);
    final firstBatches = batches(
      frame: firstFrame,
      atlas: productionAtlas,
      generation: 1,
    );
    owner.prepareFrame(frame: firstFrame, batches: firstBatches).commit();
    final probeAtlas = replaceMapSpriteAtlasTexture(
      atlas: productionAtlas,
      identity: createMapSourceIdentity(value: 'sha256:probe'),
      rgbaBytes: Uint8List.fromList(List.filled(64, 255)),
    );
    final secondFrame = frame(number: 1);
    final secondBatches = batches(
      frame: secondFrame,
      atlas: probeAtlas,
      generation: 1,
      previous: firstBatches,
    );

    owner.prepareFrame(frame: secondFrame, batches: secondBatches).commit();

    expect(backend.textureUploads, 2);
    expect(backend.topologyPrepares, 1);
    expect(backend.instancePrepares, 1);
    expect(owner.snapshot.texture.uploads, 2);
    expect(owner.snapshot.topology.uploads, 1);
    expect(owner.snapshot.instance.uploads, 1);
  });

  test('caller limits and frames in flight must be positive', () {
    for (final limits in [
      const MapSpriteRendererLimits(
        maxActiveAtlases: 0,
        maxTopologyVariants: 1,
        maxPolicyBatches: 1,
      ),
      const MapSpriteRendererLimits(
        maxActiveAtlases: 1,
        maxTopologyVariants: 0,
        maxPolicyBatches: 1,
      ),
      const MapSpriteRendererLimits(
        maxActiveAtlases: 1,
        maxTopologyVariants: 1,
        maxPolicyBatches: 0,
      ),
    ]) {
      expect(
        () => FlutterSceneSpriteResourceOwner(
          limits: limits,
          maxFramesInFlight: 1,
          backend: _FakeSpriteBackend(),
          waitForGpuCompletion: Future<void>.value,
        ),
        throwsA(
          isA<FlutterSceneSpriteResourceFailure>().having(
            (failure) => failure.reason,
            'reason',
            FlutterSceneSpriteResourceFailureReason.invalidLimits,
          ),
        ),
      );
    }
    expect(
      () => FlutterSceneSpriteResourceOwner(
        limits: const MapSpriteRendererLimits(
          maxActiveAtlases: 1,
          maxTopologyVariants: 1,
          maxPolicyBatches: 1,
        ),
        maxFramesInFlight: 0,
        backend: _FakeSpriteBackend(),
        waitForGpuCompletion: Future<void>.value,
      ),
      throwsA(
        isA<FlutterSceneSpriteResourceFailure>().having(
          (failure) => failure.reason,
          'reason',
          FlutterSceneSpriteResourceFailureReason.invalidLimits,
        ),
      ),
    );
  });
}

FlutterSceneSpriteResourceOwner<_FakeTexture, _FakeTopology, _FakeInstance>
_owner({
  required _FakeSpriteBackend backend,
  required int maxFramesInFlight,
  required int maxActiveAtlases,
  required int maxTopologyVariants,
  required int maxPolicyBatches,
  required List<Completer<void>> completions,
}) => FlutterSceneSpriteResourceOwner(
  limits: MapSpriteRendererLimits(
    maxActiveAtlases: maxActiveAtlases,
    maxTopologyVariants: maxTopologyVariants,
    maxPolicyBatches: maxPolicyBatches,
  ),
  maxFramesInFlight: maxFramesInFlight,
  backend: backend,
  waitForGpuCompletion: () {
    final completion = Completer<void>();
    completions.add(completion);
    return completion.future;
  },
);

enum _FakeFailurePoint { shaderInterface, atlasUpload, topology, instance }

sealed class _FakeResource {
  _FakeResource() : retired = false;

  bool retired;
}

final class _FakeTexture extends _FakeResource {}

final class _FakeTopology extends _FakeResource {}

final class _FakeInstance extends _FakeResource {}

final class _FakeSpriteBackend
    implements
        FlutterSceneSpriteResourceBackend<
          _FakeTexture,
          _FakeTopology,
          _FakeInstance
        > {
  _FakeSpriteBackend({
    this.failurePoint,
    this.failFirstInstanceRetire = false,
  }) : textureUploads = 0,
       topologyPrepares = 0,
       instancePrepares = 0,
       textureRetires = 0,
       topologyRetires = 0,
       instanceRetires = 0;

  final _FakeFailurePoint? failurePoint;
  final bool failFirstInstanceRetire;
  final resources = <_FakeResource>[];
  int textureUploads;
  int topologyPrepares;
  final topologyAbiVersions = <int>[];
  var _didFailInstanceRetire = false;
  int instancePrepares;
  int textureRetires;
  int topologyRetires;
  int instanceRetires;

  int get liveResources =>
      resources.where((resource) => !resource.retired).length;

  @override
  void preflightShaderInterface(MapPointSpriteInstanceBatch batch) {
    if (failurePoint == _FakeFailurePoint.shaderInterface) {
      throw StateError('shader interface');
    }
  }

  @override
  _FakeTexture uploadTexture(MapSpriteAtlas atlas) {
    if (failurePoint == _FakeFailurePoint.atlasUpload) {
      throw StateError('atlas upload');
    }
    textureUploads++;
    final resource = _FakeTexture();
    resources.add(resource);
    return resource;
  }

  @override
  _FakeTopology prepareTopology({
    required int spriteAbiVersion,
    required int materialVersion,
  }) {
    if (failurePoint == _FakeFailurePoint.topology) {
      throw StateError('topology prepare');
    }
    topologyPrepares++;
    topologyAbiVersions.add(spriteAbiVersion);
    final resource = _FakeTopology();
    resources.add(resource);
    return resource;
  }

  @override
  _FakeInstance prepareInstance({
    required _FakeTopology topology,
    required MapPointSpriteInstanceBatch batch,
  }) {
    if (failurePoint == _FakeFailurePoint.instance) {
      throw StateError('instance prepare');
    }
    instancePrepares++;
    final resource = _FakeInstance();
    resources.add(resource);
    return resource;
  }

  @override
  void retireTexture(_FakeTexture texture) {
    if (!texture.retired) {
      textureRetires++;
      texture.retired = true;
    }
  }

  @override
  void retireTopology(_FakeTopology topology) {
    if (!topology.retired) {
      topologyRetires++;
      topology.retired = true;
    }
  }

  @override
  void retireInstance(_FakeInstance instance) {
    if (!instance.retired) {
      instanceRetires++;
      instance.retired = true;
      if (failFirstInstanceRetire && !_didFailInstanceRetire) {
        _didFailInstanceRetire = true;
        throw StateError('instance retire');
      }
    }
  }
}
