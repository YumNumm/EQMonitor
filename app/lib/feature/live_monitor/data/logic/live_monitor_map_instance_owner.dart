final class LiveMonitorMapInstanceIdentity {
  const new _(this.generation);

  final int generation;
}

final class LiveMonitorMapCameraOperation<T> {
  const new _({
    required this.identity,
    required this.controller,
    required this.generation,
  });

  final LiveMonitorMapInstanceIdentity identity;
  final T controller;
  final int generation;
}

class LiveMonitorMapInstanceOwner<T> {
  LiveMonitorMapInstanceIdentity? _currentIdentity;
  T? _currentController;
  var _instanceGeneration = 0;
  var _cameraGeneration = 0;

  T? get currentController => _currentController;

  LiveMonitorMapInstanceIdentity switchInstance() {
    _currentController = null;
    _cameraGeneration += 1;
    final identity = LiveMonitorMapInstanceIdentity._(++_instanceGeneration);
    _currentIdentity = identity;
    return identity;
  }

  void invalidate() {
    _currentIdentity = null;
    _currentController = null;
    _instanceGeneration += 1;
    _cameraGeneration += 1;
  }

  bool isCurrentIdentity(LiveMonitorMapInstanceIdentity identity) =>
      identical(identity, _currentIdentity);

  bool acceptController({
    required LiveMonitorMapInstanceIdentity identity,
    required T controller,
  }) {
    if (!isCurrentIdentity(identity)) {
      return false;
    }
    if (!identical(controller, _currentController)) {
      _cameraGeneration += 1;
    }
    _currentController = controller;
    return true;
  }

  LiveMonitorMapCameraOperation<T>? beginCameraOperation({
    required LiveMonitorMapInstanceIdentity identity,
    required T controller,
  }) {
    if (!isCurrentIdentity(identity) ||
        !identical(controller, _currentController)) {
      return null;
    }
    return LiveMonitorMapCameraOperation._(
      identity: identity,
      controller: controller,
      generation: ++_cameraGeneration,
    );
  }

  bool acceptCameraCompletion(LiveMonitorMapCameraOperation<T> operation) =>
      isCurrentIdentity(operation.identity) &&
      identical(operation.controller, _currentController) &&
      operation.generation == _cameraGeneration;
}
