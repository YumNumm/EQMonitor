import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void consume<T>(T value) {}

void main() {
  test('core frame revision public inventory', () {
    for (final action in nodeInventory()) {
      expect(action, returnsNormally);
    }
    for (final action in frameInventory()) {
      expect(action, returnsNormally);
    }
    for (final action in revisionInventory()) {
      expect(action, returnsNormally);
    }
    for (final action in revisionStoreInventory()) {
      expect(action, returnsNormally);
    }
  });

  test('render public inventory', () {
    for (final action in renderGeometryInventory()) {
      expect(action, returnsNormally);
    }
    for (final action in renderPacketInventory()) {
      expect(action, returnsNormally);
    }
    for (final action in renderBatchInventory()) {
      expect(action, returnsNormally);
    }
  });

  test('performance public inventory', () {
    for (final action in performanceSampleInventory()) {
      expect(action, returnsNormally);
    }
  });
}

List<void Function()> performanceSampleInventory() {
  final schema = createMapPerformanceSchemaVersion(value: 1);
  final domain = createMapClockDomainId(value: 'performance');
  final sample = MapPerformanceSample.duration(
    schemaVersion: schema,
    clockDomain: domain,
    kind: MapPerformanceMetricKind.frameReconciliation,
    monotonicAt: const Duration(seconds: 1),
    value: const Duration(microseconds: 1),
  );
  final event = createMapPerformanceEvent(frameSequence: 1, sample: sample);
  return [
    () => consume(createMapPerformanceSchemaVersion(value: 1)),
    () => consume(MapPerformanceMetricUnit.values),
    () => consume(MapPerformanceMetricKind.values),
    () => consume(
      mapPerformanceMetricUnitOf(MapPerformanceMetricKind.cacheHit),
    ),
    () => consume(
      MapPerformanceSample.duration(
        schemaVersion: schema,
        clockDomain: domain,
        kind: MapPerformanceMetricKind.frameReconciliation,
        monotonicAt: Duration.zero,
        value: Duration.zero,
      ),
    ),
    () => consume(
      MapPerformanceSample.count(
        schemaVersion: schema,
        clockDomain: domain,
        kind: MapPerformanceMetricKind.cacheHit,
        monotonicAt: Duration.zero,
        value: 0,
      ),
    ),
    () => consume(
      MapPerformanceSample.bytes(
        schemaVersion: schema,
        clockDomain: domain,
        kind: MapPerformanceMetricKind.requestBytes,
        monotonicAt: Duration.zero,
        value: 0,
      ),
    ),
    () => consume(createMapPerformanceEvent(frameSequence: 1, sample: sample)),
    () => consume(event.schemaVersion),
    () => consume(event.clockDomain),
    () => consume(
      mapFrameTimingSamples(
        timing: FrameTiming(
          vsyncStart: 0,
          buildStart: 1,
          buildFinish: 2,
          rasterStart: 2,
          rasterFinish: 3,
          rasterFinishWallTime: 3,
        ),
        schemaVersion: schema,
        clockDomain: domain,
        monotonicAt: Duration.zero,
        frameBudget: createMapFrameBudget(
          duration: const Duration(microseconds: 3),
        ),
      ),
    ),
  ];
}

List<void Function()> renderBatchInventory() {
  final policy = createMapRenderPhasePolicy(
    version: 1,
    orderedPhases: [
      createMapRenderPhaseId(value: 'base'),
      MapRenderPhaseId.labelForeground,
    ],
  );
  final packet = _publicRenderPacket();
  final batch = createMapRenderBatch(
    version: 1,
    policy: policy,
    packets: [packet],
  );
  final submission = _publicRenderSubmission(batch);
  final MapRenderBatchAdapter adapter = _PublicRenderBatchAdapter();
  return [
    () => consume<MapRenderBatchCompatibility>(batch.compatibility),
    () => consume(mapRenderBatchCompatibilityOf(packet: packet)),
    () => consume<MapRenderBatch>(batch),
    () => consume(
      createMapRenderBatch(version: 1, policy: policy, packets: [packet]),
    ),
    () => consume(batch.instanceTransforms),
    () => consume(
      buildCanonicalRenderBatches(
        version: 1,
        policy: policy,
        packets: [packet],
      ),
    ),
    () => consume(_publicRenderSubmission(batch)),
    () => consume<MapRenderSubmission>(submission),
    () => adapter.submit(submission: submission),
    () => validateMapRenderSubmission(submission: submission),
  ];
}

MapRenderSubmission _publicRenderSubmission(MapRenderBatch batch) =>
    createMapRenderSubmission(
      frame: captureMapFrameSnapshot(
        clock: SystemMapClock.start(
          domain: createMapClockDomainId(value: 'render'),
        ),
        frameNumber: 1,
        camera: const MapCamera(
          centerLongitude: 0,
          centerLatitude: 0,
          zoom: 0,
        ),
        viewport: MapViewport(
          logicalSize: const Size(1, 1),
          devicePixelRatio: 1,
        ),
        revisions: const [],
        lifecycle: MapAppLifecycle.active,
        contextGeneration: 0,
      ),
      batches: [batch],
    );

final class _PublicRenderBatchAdapter implements MapRenderBatchAdapter {
  @override
  void submit({required MapRenderSubmission submission}) {}
}

List<void Function()> renderPacketInventory() {
  final packet = _publicRenderPacket();
  final parameters = createMapMaterialParameterBlock(
    version: 1,
    bytes: Uint8List(0),
  );
  return [
    () => consume(createMapRenderPipelineKey(version: 1, key: 'point')),
    () => consume(
      createMapMaterialParameterBlock(version: 1, bytes: Uint8List(0)),
    ),
    () => consume(haveEqualMapMaterialParameterContent(parameters, parameters)),
    () => consume(
      createMapRenderBatchKey(
        version: 1,
        nodeKey: createMapNodeKey(value: 'map'),
        scopeKey: 'base',
        materialKey: 'point',
        phasePolicyVersion: 1,
        phase: 0,
      ),
    ),
    () => consume(
      createMapRenderPacket(
        contractVersion: packet.contractVersion,
        sortKey: packet.sortKey,
        batchKey: packet.batchKey,
        pipeline: packet.pipeline,
        mesh: packet.mesh,
        modelTransform: packet.modelTransform,
        materialParameters: packet.materialParameters,
      ),
    ),
  ];
}

MapRenderPacket _publicRenderPacket() => createMapRenderPacket(
  contractVersion: 1,
  sortKey: MapRenderSortKey(
    phasePolicyVersion: 1,
    phase: 0,
    declarationOrderWithinPhase: 0,
    sourceOrder: 0,
    overscaledTileOrder: 0,
    featureOrder: 0,
  ),
  batchKey: createMapRenderBatchKey(
    version: 1,
    nodeKey: createMapNodeKey(value: 'map'),
    scopeKey: 'base',
    materialKey: 'point',
    phasePolicyVersion: 1,
    phase: 0,
  ),
  pipeline: createMapRenderPipelineKey(version: 1, key: 'point'),
  mesh: _publicRenderMesh(),
  modelTransform: Float64List(16),
  materialParameters: createMapMaterialParameterBlock(
    version: 1,
    bytes: Uint8List(0),
  ),
);

MapPackedMesh _publicRenderMesh() => createMapPackedMesh(
  payloadVersion: 1,
  layout: createMapPackedMeshLayout(
    version: 1,
    topology: MapPrimitiveTopology.points,
    byteOrder: MapPackedByteOrder.little,
    vertexStride: 4,
    attributes: [
      MapVertexAttributeLayout(
        semantic: MapVertexAttributeSemantic.featureIdUint32,
        format: MapVertexAttributeFormat.uint32,
        offset: 0,
      ),
    ],
    indexFormat: null,
  ),
  vertexBytes: Uint8List(4),
  vertexCount: 1,
  indexBytes: null,
  indexCount: null,
);

List<void Function()> renderGeometryInventory() {
  final base = createMapRenderPhaseId(value: 'base');
  final policy = createMapRenderPhasePolicy(
    version: 1,
    orderedPhases: [base, MapRenderPhaseId.labelForeground],
  );
  final first = MapRenderSortKey(
    phasePolicyVersion: 1,
    phase: 0,
    declarationOrderWithinPhase: 0,
    sourceOrder: 0,
    overscaledTileOrder: 0,
    featureOrder: 0,
  );
  final second = MapRenderSortKey(
    phasePolicyVersion: 1,
    phase: 0,
    declarationOrderWithinPhase: 0,
    sourceOrder: 0,
    overscaledTileOrder: 0,
    featureOrder: 1,
  );
  final attribute = MapVertexAttributeLayout(
    semantic: MapVertexAttributeSemantic.featureIdUint32,
    format: MapVertexAttributeFormat.uint32,
    offset: 0,
  );
  final layout = createMapPackedMeshLayout(
    version: 1,
    topology: MapPrimitiveTopology.points,
    byteOrder: MapPackedByteOrder.little,
    vertexStride: 4,
    attributes: [attribute],
    indexFormat: null,
  );
  return [
    () => consume(createMapRenderPhaseId(value: 'base')),
    () => consume(MapRenderPhaseId.labelForeground),
    () => consume(
      createMapRenderPhasePolicy(
        version: 1,
        orderedPhases: [base, MapRenderPhaseId.labelForeground],
      ),
    ),
    () => consume(policy.rankOf(base)),
    () => consume<MapRenderSortKey>(first),
    () => consume(compareMapRenderSortKeys(first, second)),
    () => consume(reverseMapRenderSortKeysForHitTest(first, second)),
    () => consume(MapVertexAttributeSemantic.values),
    () => consume(MapVertexAttributeFormat.values),
    () => consume(MapVertexAttributeFormat.uint32.byteLength),
    () => consume(MapVertexAttributeFormat.uint32.scalarAlignment),
    () => consume(attribute),
    () => consume(MapPrimitiveTopology.values),
    () => consume(MapPackedByteOrder.values),
    () => consume(MapIndexFormat.values),
    () => consume(
      createMapPackedMeshLayout(
        version: 1,
        topology: MapPrimitiveTopology.points,
        byteOrder: MapPackedByteOrder.little,
        vertexStride: 4,
        attributes: [attribute],
        indexFormat: null,
      ),
    ),
    () => consume(haveCompatibleMapPackedMeshLayouts(layout, layout)),
    () => consume(
      createMapPackedMesh(
        payloadVersion: 1,
        layout: layout,
        vertexBytes: Uint8List(4),
        vertexCount: 1,
        indexBytes: null,
        indexCount: null,
      ),
    ),
  ];
}

List<void Function()> revisionStoreInventory() {
  final source = createMapSourceInstanceId(value: 'base-map');
  final digest = createMapContentDigest(value: 'sha256:base-map');
  const MapRevisionStateOwner<int> owner = _StateOwner();
  final store = MapRevisionCommitStore<int>(owner);
  return [
    () => consume(MapRevisionCommitStore<int>(owner)),
    () => consume(store.current),
    () => consume(
      store.commitFull(
        metadata: createMapFullRevision(
          source: source,
          revision: 1,
          digest: digest,
        ),
        validateAndBuild: () => MapRevisionCandidate(state: 1, digest: digest),
      ),
    ),
    () => consume(_commitDelta(owner: owner, source: source, digest: digest)),
    () => consume(store.fullResyncRequest),
    () => consume(store.needsFullResync),
    () => consume(store.resyncAfterRevision),
  ];
}

MapRevisionApplyResult<int> _commitDelta({
  required MapRevisionStateOwner<int> owner,
  required MapSourceInstanceId source,
  required MapContentDigest digest,
}) {
  final store = MapRevisionCommitStore<int>(owner);
  store.commitFull(
    metadata: createMapFullRevision(
      source: source,
      revision: 1,
      digest: digest,
    ),
    validateAndBuild: () => MapRevisionCandidate(state: 1, digest: digest),
  );
  return store.commitDelta(
    metadata: createMapDeltaRevision(
      source: source,
      baseRevision: 1,
      targetRevision: 2,
      targetDigest: digest,
    ),
    validateAndBuild: ({required currentState}) =>
        MapRevisionCandidate(state: currentState + 1, digest: digest),
  );
}

List<void Function()> revisionInventory() {
  final source = createMapSourceInstanceId(value: 'base-map');
  final digest = createMapContentDigest(value: 'sha256:base-map');
  final committed = createMapCommittedRevision(
    source: source,
    revision: 1,
    digest: digest,
    state: 1,
  );
  final request = createMapFullResyncRequest(
    source: source,
    afterRevision: 1,
  );
  const MapRevisionStateOwner<int> owner = _StateOwner();
  return [
    () => consume(
      createMapFullRevision(source: source, revision: 1, digest: digest),
    ),
    () => consume(
      createMapDeltaRevision(
        source: source,
        baseRevision: 1,
        targetRevision: 2,
        targetDigest: digest,
      ),
    ),
    () => consume(
      createMapCommittedRevision(
        source: source,
        revision: 1,
        digest: digest,
        state: 1,
      ),
    ),
    () => consume(createMapFullResyncRequest(source: source, afterRevision: 1)),
    () => consume(MapRevisionRejectReason.values),
    () => consume(MapRevisionApplyResult<int>.committed(current: committed)),
    () => consume(
      MapRevisionApplyResult<int>.idempotentNoOp(current: committed),
    ),
    () => consume(
      MapRevisionApplyResult<int>.rejected(
        current: committed,
        reason: MapRevisionRejectReason.staleRevision,
      ),
    ),
    () => consume(
      MapRevisionApplyResult<int>.rejected(
        current: committed,
        reason: MapRevisionRejectReason.revisionGap,
        fullResyncRequest: request,
      ).requiresFullResync,
    ),
    () => consume(MapRevisionCandidate(state: 1, digest: digest)),
    () => consume(
      owner.own(candidate: MapRevisionCandidate(state: 1, digest: digest)),
    ),
  ];
}

final class _StateOwner implements MapRevisionStateOwner<int> {
  const _StateOwner();

  @override
  MapRevisionCandidate<int> own({
    required MapRevisionCandidate<int> candidate,
  }) => candidate;
}

List<void Function()> frameInventory() {
  final domain = createMapClockDomainId(value: 'frame');
  final sourceIdentity = createMapMonotonicSourceIdentity();
  final wall = createMapWallInstant(value: DateTime.utc(2026, 8, 13));
  final monotonic = createMapMonotonicInstant(
    domain: domain,
    sourceIdentity: sourceIdentity,
    elapsed: Duration.zero,
  );
  final capture = createMapClockCapture(
    domain: domain,
    sourceIdentity: sourceIdentity,
    wallInstant: wall,
    monotonicInstant: monotonic,
    previousMonotonicInstant: null,
  );
  final MapClock clock = _Clock(capture);
  final source = createMapSourceInstanceId(value: 'base-map');
  final sourceStamp = createMapFrameSourceRevisionStamp(
    sourceInstanceId: source,
    revision: 1,
    contentDigest: createMapContentDigest(value: 'sha256:base-map'),
  );
  return [
    () => consume(createMapClockDomainId(value: 'clock')),
    () => consume(
      createMapClockCapture(
        domain: domain,
        sourceIdentity: sourceIdentity,
        wallInstant: wall,
        monotonicInstant: monotonic,
        previousMonotonicInstant: null,
      ),
    ),
    () => consume<MapClockCapture>(clock.capture()),
    () => consume(SystemMapClock.start(domain: domain)),
    () => consume(createMapSourceInstanceId(value: 'source')),
    () => consume(createMapContentDigest(value: 'digest')),
    () => consume(sourceStamp),
    () => consume(
      createMapFrameLayerRevisionStamp(
        sourceInstanceId: source,
        ownerKey: createMapNodeKey(value: 'layer'),
        revision: 1,
      ),
    ),
    () => consume<MapFrameRevisionStamp>(sourceStamp),
    () => consume(MapFrameRevisionScope.values),
    () => consume(canonicalizeMapFrameRevisions(revisions: [sourceStamp])),
    () => consume(MapAppLifecycle.values),
    () => consume<MapFrameSnapshot>(_snapshot(clock, sourceStamp)),
    () => consume(_snapshot(clock, sourceStamp)),
    () => consume(
      MapViewport(logicalSize: const Size(1, 1), devicePixelRatio: 1),
    ),
  ];
}

MapFrameSnapshot _snapshot(MapClock clock, MapFrameRevisionStamp revision) =>
    captureMapFrameSnapshot(
      clock: clock,
      frameNumber: 1,
      camera: const MapCamera(centerLongitude: 0, centerLatitude: 0, zoom: 0),
      viewport: MapViewport(logicalSize: const Size(1, 1), devicePixelRatio: 1),
      revisions: [revision],
      lifecycle: MapAppLifecycle.active,
      contextGeneration: 0,
    );

final class _Clock implements MapClock {
  const _Clock(this.value);

  final MapClockCapture value;

  @override
  MapClockCapture capture() => value;
}

List<void Function()> nodeInventory() {
  final key = createMapNodeKey(value: 'root');
  final type = createMapNodeTypeId(value: 'group');
  final identity = createMapNodeIdentity(key: key, type: type);
  final node = MapDeclarationNode(identity: identity, children: const []);
  final MapElementFactory factory = _ElementFactory();
  final element = factory.create(node: node);
  final reconciler = MapChildReconciler();
  return [
    () => consume(createMapNodeKey(value: 'key')),
    () => consume(createMapNodeTypeId(value: 'type')),
    () => consume(createMapNodeIdentity(key: key, type: type)),
    () => consume<MapNodeIdentity>(identity),
    () => consume(classifyMapNodeIdentity(current: identity, next: identity)),
    () => consume(MapNodeIdentityChange.values),
    () => consume<MapNode>(node),
    () => consume(MapDeclarationNode(identity: identity, children: const [])),
    () => consume(MapScene(children: [node])),
    () => consume(element.identity),
    element.mount,
    () => element.update(node: node),
    element.unmount,
    () => consume(factory.create(node: node)),
    () => consume(reconciler.elements),
    () => reconciler.reconcile(nodes: [node], factory: factory),
    reconciler.unmountAll,
  ];
}

final class _ElementFactory implements MapElementFactory {
  @override
  MapElement create({required MapNode node}) => _Element(node.identity);
}

final class _Element implements MapElement {
  const _Element(this.identity);

  @override
  final MapNodeIdentity identity;

  @override
  void mount() {}

  @override
  void unmount() {}

  @override
  void update({required MapNode node}) {}
}
