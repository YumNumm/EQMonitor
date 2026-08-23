import 'dart:async';

import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_camera_bounds.dart';
import 'package:eqmonitor_map/src/geo/map_camera_bounds_fitter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

sealed class MapCameraCommandResult {
  const MapCameraCommandResult();
}

final class MapCameraCommandSucceeded extends MapCameraCommandResult {
  const MapCameraCommandSucceeded({
    required this.generation,
    required this.committedCamera,
  });

  final int generation;
  final MapCamera committedCamera;
}

sealed class MapCameraCommandFailure extends MapCameraCommandResult {
  const MapCameraCommandFailure();
}

final class MapCameraCommandInvalidInput extends MapCameraCommandFailure {
  const MapCameraCommandInvalidInput({this.boundsReason});

  final MapCameraBoundsFitInvalidReason? boundsReason;
}

final class MapCameraCommandNotAttached extends MapCameraCommandFailure {
  const MapCameraCommandNotAttached();
}

final class MapCameraCommandNotReady extends MapCameraCommandFailure {
  const MapCameraCommandNotReady();
}

final class MapCameraCommandDisposed extends MapCameraCommandFailure {
  const MapCameraCommandDisposed();
}

final class MapCameraCommandSuperseded extends MapCameraCommandFailure {
  const MapCameraCommandSuperseded({
    required this.generation,
    required this.supersededByGeneration,
  });

  final int generation;
  final int supersededByGeneration;
}

sealed class MapViewCameraAttachmentResult {
  const MapViewCameraAttachmentResult();
}

final class MapViewCameraAttached extends MapViewCameraAttachmentResult {
  const MapViewCameraAttached({required this.initialCamera});

  final MapCamera initialCamera;
}

final class MapViewCameraAlreadyAttached extends MapViewCameraAttachmentResult {
  const MapViewCameraAlreadyAttached();
}

final class MapViewCameraAttachmentDisposed
    extends MapViewCameraAttachmentResult {
  const MapViewCameraAttachmentDisposed();
}

/// Internal bridge implemented by the base-map widget.
///
/// It stays typed and public because the controller and widget are separate
/// Dart libraries. App callers own the controller but do not implement hosts.
abstract interface class MapViewCameraHost {
  MapCameraBoundsFitResult cameraForBounds({
    required MapCameraBounds bounds,
    required EdgeInsets padding,
  });

  Future<MapCameraCommandResult> applyCameraCommand({
    required int generation,
    required MapCamera camera,
  });
}

/// Caller-owned camera command surface for the base-map widget.
final class MapViewCameraController {
  MapViewCameraController();

  final _committedCameraNotifier = ValueNotifier<MapCamera?>(null);
  final _commandOwner = _MapCameraCommandOwner();
  MapViewCameraHost? _host;
  MapCamera? _committedCamera;
  var _isDisposed = false;

  MapCamera? get committedCamera => _committedCamera;

  ValueListenable<MapCamera?> get committedCameraListenable =>
      _committedCameraNotifier;

  MapViewCameraAttachmentResult attach({
    required MapViewCameraHost host,
    required MapCamera initialCamera,
  }) {
    if (_isDisposed) {
      return const MapViewCameraAttachmentDisposed();
    }
    if (_host != null) {
      return const MapViewCameraAlreadyAttached();
    }
    _host = host;
    return MapViewCameraAttached(
      initialCamera: _committedCamera ?? initialCamera,
    );
  }

  void detach({required MapViewCameraHost host}) {
    if (!identical(_host, host)) {
      return;
    }
    _host = null;
    _commandOwner.cancel(const MapCameraCommandNotAttached());
  }

  void commitCameraFromHost({
    required MapViewCameraHost host,
    required MapCamera camera,
  }) {
    if (_isDisposed || !identical(_host, host) || camera == _committedCamera) {
      return;
    }
    _committedCamera = camera;
    _committedCameraNotifier.value = camera;
  }

  Future<MapCameraCommandResult> moveTo({required MapCamera camera}) async {
    if (_isDisposed) {
      return const MapCameraCommandDisposed();
    }
    final host = _host;
    if (host == null) {
      return const MapCameraCommandNotAttached();
    }
    if (!camera.centerLongitude.isFinite ||
        !camera.centerLatitude.isFinite ||
        !camera.zoom.isFinite) {
      return const MapCameraCommandInvalidInput();
    }
    final result = await _commandOwner.execute(host: host, camera: camera);
    if (result case MapCameraCommandSucceeded(:final committedCamera)) {
      commitCameraFromHost(host: host, camera: committedCamera);
    }
    return result;
  }

  Future<MapCameraCommandResult> fitBounds({
    required MapCameraBounds bounds,
    required EdgeInsets padding,
  }) async {
    if (_isDisposed) {
      return const MapCameraCommandDisposed();
    }
    final host = _host;
    if (host == null) {
      return const MapCameraCommandNotAttached();
    }
    final fit = host.cameraForBounds(bounds: bounds, padding: padding);
    return switch (fit) {
      MapCameraBoundsFitSucceeded(:final camera) => moveTo(camera: camera),
      MapCameraBoundsFitInvalid(:final reason) => MapCameraCommandInvalidInput(
        boundsReason: reason,
      ),
    };
  }

  void dispose() {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    _host = null;
    _commandOwner.cancel(const MapCameraCommandDisposed());
    _committedCameraNotifier.dispose();
  }
}

final class _MapCameraCommandOwner {
  var _nextGeneration = 0;
  _PendingMapCameraCommand? _pending;

  Future<MapCameraCommandResult> execute({
    required MapViewCameraHost host,
    required MapCamera camera,
  }) async {
    final generation = ++_nextGeneration;
    final previous = _pending;
    previous?.cancellation.complete(
      MapCameraCommandSuperseded(
        generation: previous.generation,
        supersededByGeneration: generation,
      ),
    );
    final pending = _PendingMapCameraCommand(
      generation: generation,
      cancellation: Completer<MapCameraCommandResult>(),
    );
    _pending = pending;
    final result = await Future.any([
      host.applyCameraCommand(generation: generation, camera: camera),
      pending.cancellation.future,
    ]);
    if (identical(_pending, pending)) {
      _pending = null;
    }
    return result;
  }

  void cancel(MapCameraCommandFailure failure) {
    final pending = _pending;
    if (pending == null) {
      return;
    }
    _pending = null;
    pending.cancellation.complete(failure);
  }
}

final class _PendingMapCameraCommand {
  const _PendingMapCameraCommand({
    required this.generation,
    required this.cancellation,
  });

  final int generation;
  final Completer<MapCameraCommandResult> cancellation;
}
