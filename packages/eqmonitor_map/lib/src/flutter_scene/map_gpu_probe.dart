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

final class MapGpuProbeAtlasFixtureTransition {
  const MapGpuProbeAtlasFixtureTransition._({
    required this.previous,
    required this.next,
  });

  final MapSpriteAtlasProbeFixture previous;
  final MapSpriteAtlasProbeFixture next;
}

final class MapGpuProbeConfigurationUpdate {
  const new({
    required this.faultPointChanged,
    required this.atlasTransitionToken,
  });

  final bool faultPointChanged;
  final MapGpuProbeAtlasTransitionToken? atlasTransitionToken;
}

final class _MapGpuProbeRuntimeIdentity {
  const new();
}

final class MapGpuProbeAtlasTransitionToken {
  const MapGpuProbeAtlasTransitionToken._({
    required this._owner,
    required this._previous,
    required this._next,
  });

  final _MapGpuProbeRuntimeIdentity _owner;
  final MapSpriteAtlasProbeFixture _previous;
  final MapSpriteAtlasProbeFixture _next;
}

final class MapGpuProbeFault implements Exception {
  const MapGpuProbeFault({required this.point});

  final MapGpuFaultPoint point;

  @override
  String toString() => 'MapGpuProbeFault(${point.name})';
}

/// Debug-only fault state. Production callers do not construct this object.
final class MapGpuProbeRuntime {
  factory MapGpuProbeRuntime({
    required MapGpuProbeConfiguration configuration,
  }) => MapGpuProbeRuntime._(configuration);

  MapGpuProbeRuntime._(this._configuration);

  MapGpuProbeConfiguration _configuration;
  final _identity = const _MapGpuProbeRuntimeIdentity();
  final _issuedAtlasTransitionTokens = <MapGpuProbeAtlasTransitionToken>{};
  var _didFire = false;

  MapSpriteAtlasProbeFixture get atlasFixture => _configuration.atlasFixture;

  MapGpuProbeConfigurationUpdate updateConfiguration(
    MapGpuProbeConfiguration configuration,
  ) {
    final previous = _configuration;
    final faultPointChanged = previous.faultPoint != configuration.faultPoint;
    final atlasFixtureChanged =
        previous.atlasFixture != configuration.atlasFixture;
    _configuration = configuration;
    if (faultPointChanged) {
      _didFire = false;
    }
    final token = atlasFixtureChanged && mapGpuProbeCompileTimeEnabled
        ? MapGpuProbeAtlasTransitionToken._(
            owner: _identity,
            previous: previous.atlasFixture,
            next: configuration.atlasFixture,
          )
        : null;
    if (token != null) {
      _issuedAtlasTransitionTokens.add(token);
    }
    return MapGpuProbeConfigurationUpdate(
      faultPointChanged: faultPointChanged,
      atlasTransitionToken: token,
    );
  }

  MapGpuProbeAtlasFixtureTransition? consumeAtlasTransition(
    MapGpuProbeAtlasTransitionToken token,
  ) {
    if (!mapGpuProbeCompileTimeEnabled ||
        !identical(token._owner, _identity) ||
        !_issuedAtlasTransitionTokens.remove(token)) {
      return null;
    }
    return MapGpuProbeAtlasFixtureTransition._(
      previous: token._previous,
      next: token._next,
    );
  }

  void throwIfRequested(MapGpuFaultPoint point) {
    if (_didFire || _configuration.faultPoint != point) {
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
