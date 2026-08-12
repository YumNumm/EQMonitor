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
  });
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
  final MapElement element = factory.create(node: node);
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
    () => element.mount(),
    () => element.update(node: node),
    () => element.unmount(),
    () => consume(factory.create(node: node)),
    () => consume(reconciler.elements),
    () => reconciler.reconcile(nodes: [node], factory: factory),
    () => reconciler.unmountAll(),
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
