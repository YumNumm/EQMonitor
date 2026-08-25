/// Build-time gate for the debug-map-only GPU lifecycle probe.
// ignore: do_not_use_environment
const mapGpuProbeCompileTimeEnabled = bool.fromEnvironment(
  'EQMONITOR_MAP_GPU_PROBE',
);

enum MapGpuFaultPoint { atlasUpload, shaderInterface, frameSubmit }

enum MapSpriteAtlasProbeFixture {
  production,
  orientation2x2,
  alphaHalf,
  edgeBleed,
}

final class MapGpuProbeConfiguration {
  const MapGpuProbeConfiguration({
    required this.faultPoint,
    required this.atlasFixture,
  });

  final MapGpuFaultPoint? faultPoint;
  final MapSpriteAtlasProbeFixture atlasFixture;
}

final class MapGpuProbeFault implements Exception {
  const MapGpuProbeFault({required this.point});

  final MapGpuFaultPoint point;

  @override
  String toString() => 'MapGpuProbeFault(${point.name})';
}

/// Debug-only fault state. Production callers do not construct this object.
final class MapGpuProbeRuntime {
  MapGpuProbeRuntime({required this.configuration});

  final MapGpuProbeConfiguration configuration;
  var _didFire = false;

  MapSpriteAtlasProbeFixture get atlasFixture => configuration.atlasFixture;

  void throwIfRequested(MapGpuFaultPoint point) {
    if (_didFire || configuration.faultPoint != point) {
      return;
    }
    _didFire = true;
    throw MapGpuProbeFault(point: point);
  }
}

final class MapGpuResourceKindCounter {
  const MapGpuResourceKindCounter({
    required this.active,
    required this.candidate,
    required this.pendingRetire,
    required this.uploads,
    required this.retires,
  });

  static const zero = MapGpuResourceKindCounter(
    active: 0,
    candidate: 0,
    pendingRetire: 0,
    uploads: 0,
    retires: 0,
  );

  final int active;
  final int candidate;
  final int pendingRetire;
  final int uploads;
  final int retires;

  int get live => active + candidate + pendingRetire;
}

final class MapGpuResourceCounterSnapshot {
  const MapGpuResourceCounterSnapshot({
    required this.texture,
    required this.topology,
    required this.instance,
    required this.node,
    required this.rendererContextGeneration,
  });

  final MapGpuResourceKindCounter texture;
  final MapGpuResourceKindCounter topology;
  final MapGpuResourceKindCounter instance;
  final MapGpuResourceKindCounter node;
  final int rendererContextGeneration;
}

typedef MapGpuResourceCounterCallback = void Function(
  MapGpuResourceCounterSnapshot snapshot,
);

/// Prevents an in-flight retirement fence from notifying a disposed widget.
final class MapGpuResourceCounterCallbackGate {
  MapGpuResourceCounterCallbackGate({required this.callback});

  final MapGpuResourceCounterCallback callback;
  var _isDisposed = false;

  void publish(MapGpuResourceCounterSnapshot snapshot) {
    if (!_isDisposed) {
      callback(snapshot);
    }
  }

  void dispose() {
    _isDisposed = true;
  }
}

abstract interface class MapGpuProbeHost {
  void invalidateRendererContextGeneration();
}

/// Caller-owned debug controller. It never recreates the native GPU context.
final class MapGpuProbeController {
  MapGpuProbeHost? _host;

  bool attach({required MapGpuProbeHost host}) {
    if (_host != null) {
      return false;
    }
    _host = host;
    return true;
  }

  void detach({required MapGpuProbeHost host}) {
    if (identical(_host, host)) {
      _host = null;
    }
  }

  bool invalidateRendererContextGeneration() {
    final host = _host;
    if (host == null) {
      return false;
    }
    host.invalidateRendererContextGeneration();
    return true;
  }
}
