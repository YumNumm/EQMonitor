import 'dart:async';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const initialCamera = MapCamera(
    centerLongitude: 137.5,
    centerLatitude: 36.5,
    zoom: 4,
  );

  test('command before attach returns typed not-attached failure', () async {
    final controller = MapViewCameraController();
    addTearDown(controller.dispose);

    expect(
      await controller.moveTo(camera: initialCamera),
      isA<MapCameraCommandNotAttached>(),
    );
  });

  test('single attach succeeds and double attach is rejected', () {
    final controller = MapViewCameraController();
    final host = FakeMapViewCameraHost();
    addTearDown(controller.dispose);

    final first = controller.attach(host: host, initialCamera: initialCamera);
    final second = controller.attach(host: host, initialCamera: initialCamera);

    expect(first, isA<MapViewCameraAttached>());
    expect((first as MapViewCameraAttached).initialCamera, initialCamera);
    expect(second, isA<MapViewCameraAlreadyAttached>());
  });

  test('detach and reattach restore the last committed camera', () {
    final controller = MapViewCameraController();
    final firstHost = FakeMapViewCameraHost();
    final secondHost = FakeMapViewCameraHost();
    addTearDown(controller.dispose);
    controller.attach(host: firstHost, initialCamera: initialCamera);
    const committed = MapCamera(
      centerLongitude: 140,
      centerLatitude: 38,
      zoom: 7,
    );
    controller.commitCameraFromHost(host: firstHost, camera: committed);

    controller.detach(host: firstHost);
    final reattached = controller.attach(
      host: secondHost,
      initialCamera: const MapCamera(
        centerLongitude: 10,
        centerLatitude: 20,
        zoom: 2,
      ),
    );

    expect((reattached as MapViewCameraAttached).initialCamera, committed);
    expect(controller.committedCamera, committed);
  });

  test('committed getter and listenable publish host commits', () {
    final controller = MapViewCameraController();
    final host = FakeMapViewCameraHost();
    addTearDown(controller.dispose);
    controller.attach(host: host, initialCamera: initialCamera);
    final notifications = <MapCamera?>[];
    controller.committedCameraListenable.addListener(
      () => notifications.add(controller.committedCameraListenable.value),
    );

    controller.commitCameraFromHost(host: host, camera: initialCamera);

    expect(controller.committedCamera, initialCamera);
    expect(notifications, [initialCamera]);
  });

  test(
    'a newer command immediately supersedes an uncommitted command',
    () async {
      final controller = MapViewCameraController();
      final host = FakeMapViewCameraHost();
      addTearDown(controller.dispose);
      controller.attach(host: host, initialCamera: initialCamera);
      const firstTarget = MapCamera(
        centerLongitude: 135,
        centerLatitude: 35,
        zoom: 5,
      );
      const secondTarget = MapCamera(
        centerLongitude: 141,
        centerLatitude: 43,
        zoom: 6,
      );

      final first = controller.moveTo(camera: firstTarget);
      final second = controller.moveTo(camera: secondTarget);

      expect(await first, isA<MapCameraCommandSuperseded>());
      host.completeSuccess(commandIndex: 1);
      final secondResult = await second;
      expect(secondResult, isA<MapCameraCommandSucceeded>());
      expect(controller.committedCamera, secondTarget);
      host.completeSuccess(commandIndex: 0);
      await pumpEventQueue();
      expect(controller.committedCamera, secondTarget);
    },
  );

  test('detach during host await prevents every host side effect', () async {
    final controller = MapViewCameraController();
    final host = _AwaitingSideEffectMapViewCameraHost();
    addTearDown(controller.dispose);
    controller.attach(host: host, initialCamera: initialCamera);

    final pending = controller.moveTo(camera: initialCamera);
    controller.detach(host: host);

    expect(await pending, isA<MapCameraCommandNotAttached>());
    await pumpEventQueue();
    expect(host.commands.single._cameraMutationCount, 0);
    expect(host.commands.single._refreshCount, 0);
    expect(host.commands.single._decodeOrSubmitCount, 0);
  });

  test('dispose during host await prevents every host side effect', () async {
    final controller = MapViewCameraController();
    final host = _AwaitingSideEffectMapViewCameraHost();
    controller.attach(host: host, initialCamera: initialCamera);

    final pending = controller.moveTo(camera: initialCamera);
    controller.dispose();

    expect(await pending, isA<MapCameraCommandDisposed>());
    await pumpEventQueue();
    expect(host.commands.single._cameraMutationCount, 0);
    expect(host.commands.single._refreshCount, 0);
    expect(host.commands.single._decodeOrSubmitCount, 0);
  });

  test(
    'supersede during host await prevents stale host side effects',
    () async {
      final controller = MapViewCameraController();
      final host = _AwaitingSideEffectMapViewCameraHost();
      addTearDown(controller.dispose);
      controller.attach(host: host, initialCamera: initialCamera);

      final first = controller.moveTo(camera: initialCamera);
      final second = controller.moveTo(camera: initialCamera.copyWith(zoom: 8));

      expect(await first, isA<MapCameraCommandSuperseded>());
      expect(await second, isA<MapCameraCommandSucceeded>());
      expect(host.commands.first._cameraMutationCount, 0);
      expect(host.commands.first._refreshCount, 0);
      expect(host.commands.first._decodeOrSubmitCount, 0);
      expect(host.commands.last._cameraMutationCount, 1);
      expect(host.commands.last._refreshCount, 1);
      expect(host.commands.last._decodeOrSubmitCount, 1);
    },
  );

  test(
    'move and fitBounds use host mutation and return committed camera',
    () async {
      final controller = MapViewCameraController();
      final host = FakeMapViewCameraHost();
      addTearDown(controller.dispose);
      controller.attach(host: host, initialCamera: initialCamera);

      final resultFuture = controller.fitBounds(
        bounds: const MapCameraBounds(
          west: 130,
          south: 30,
          east: 145,
          north: 46,
        ),
        padding: const EdgeInsets.all(40),
      );
      host.completeSuccess(commandIndex: 0);
      final result = await resultFuture;

      expect(result, isA<MapCameraCommandSucceeded>());
      expect(host.commands, hasLength(1));
      expect(
        (result as MapCameraCommandSucceeded).committedCamera,
        host.commands.single.camera,
      );
    },
  );

  test('invalid camera and fit input return typed invalid failure', () async {
    final controller = MapViewCameraController();
    final host = FakeMapViewCameraHost();
    addTearDown(controller.dispose);
    controller.attach(host: host, initialCamera: initialCamera);

    expect(
      await controller.moveTo(
        camera: const MapCamera(
          centerLongitude: double.nan,
          centerLatitude: 35,
          zoom: 4,
        ),
      ),
      isA<MapCameraCommandInvalidInput>(),
    );
    expect(
      await controller.fitBounds(
        bounds: const MapCameraBounds(
          west: 130,
          south: 30,
          east: 145,
          north: 46,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 400),
      ),
      isA<MapCameraCommandInvalidInput>(),
    );
  });

  test('gesture and command publish the same host clamp result', () async {
    final controller = MapViewCameraController();
    final host = FakeMapViewCameraHost(minZoom: 2, maxZoom: 8);
    addTearDown(controller.dispose);
    controller.attach(host: host, initialCamera: initialCamera);
    const outsideLimits = MapCamera(
      centerLongitude: 140,
      centerLatitude: 36,
      zoom: 20,
    );
    final gestureCamera = host.clamp(outsideLimits);
    controller.commitCameraFromHost(host: host, camera: gestureCamera);

    final command = controller.moveTo(camera: outsideLimits);
    host.completeSuccess(commandIndex: 0);

    expect(
      (await command as MapCameraCommandSucceeded).committedCamera,
      gestureCamera,
    );
  });

  test('source-switch reattach preserves committed camera', () {
    final controller = MapViewCameraController();
    final oldSourceHost = FakeMapViewCameraHost();
    final newSourceHost = FakeMapViewCameraHost();
    addTearDown(controller.dispose);
    controller.attach(host: oldSourceHost, initialCamera: initialCamera);
    controller.commitCameraFromHost(
      host: oldSourceHost,
      camera: initialCamera.copyWith(zoom: 9),
    );

    controller.detach(host: oldSourceHost);
    final result = controller.attach(
      host: newSourceHost,
      initialCamera: initialCamera.copyWith(zoom: 2),
    );

    expect(
      (result as MapViewCameraAttached).initialCamera.zoom,
      9,
    );
  });

  test(
    'detach cancels pending command and dispose rejects later use',
    () async {
      final controller = MapViewCameraController();
      final host = FakeMapViewCameraHost();
      controller.attach(host: host, initialCamera: initialCamera);
      final pending = controller.moveTo(camera: initialCamera);

      controller.detach(host: host);
      expect(await pending, isA<MapCameraCommandNotAttached>());
      controller.dispose();
      expect(
        controller.attach(host: host, initialCamera: initialCamera),
        isA<MapViewCameraAttachmentDisposed>(),
      );
      expect(
        await controller.moveTo(camera: initialCamera),
        isA<MapCameraCommandDisposed>(),
      );
    },
  );
}

final class FakeMapViewCameraHost implements MapViewCameraHost {
  FakeMapViewCameraHost({this.minZoom = 0, this.maxZoom = 20});

  final double minZoom;
  final double maxZoom;
  final commands = <FakeCameraCommand>[];
  static const _fitter = MapCameraBoundsFitter();

  MapCamera clamp(MapCamera camera) => camera.copyWith(
    zoom: camera.zoom.clamp(minZoom, maxZoom),
  );

  @override
  MapCameraBoundsFitResult cameraForBounds({
    required MapCameraBounds bounds,
    required EdgeInsets padding,
  }) => _fitter.fit(
    bounds: bounds,
    viewportLogicalSize: const Size(800, 600),
    devicePixelRatio: 1,
    padding: padding,
    minZoom: minZoom,
    maxZoom: maxZoom,
  );

  @override
  Future<MapCameraCommandResult> applyCameraCommand({
    required int generation,
    required MapCamera camera,
    required MapCameraCommandCancellation cancellation,
  }) {
    final command = FakeCameraCommand(
      generation: generation,
      camera: clamp(camera),
      completer: Completer<MapCameraCommandResult>(),
    );
    commands.add(command);
    return command.completer.future;
  }

  void completeSuccess({required int commandIndex}) {
    final command = commands[commandIndex];
    command.completer.complete(
      MapCameraCommandSucceeded(
        generation: command.generation,
        committedCamera: command.camera,
      ),
    );
  }
}

final class FakeCameraCommand {
  const FakeCameraCommand({
    required this.generation,
    required this.camera,
    required this.completer,
  });

  final int generation;
  final MapCamera camera;
  final Completer<MapCameraCommandResult> completer;
}

final class _AwaitingSideEffectMapViewCameraHost implements MapViewCameraHost {
  final commands = <_AwaitingSideEffectCommand>[];
  static const _fitter = MapCameraBoundsFitter();

  @override
  MapCameraBoundsFitResult cameraForBounds({
    required MapCameraBounds bounds,
    required EdgeInsets padding,
  }) => _fitter.fit(
    bounds: bounds,
    viewportLogicalSize: const Size(800, 600),
    devicePixelRatio: 1,
    padding: padding,
    minZoom: 0,
    maxZoom: 20,
  );

  @override
  Future<MapCameraCommandResult> applyCameraCommand({
    required int generation,
    required MapCamera camera,
    required MapCameraCommandCancellation cancellation,
  }) async {
    final command = _AwaitingSideEffectCommand();
    commands.add(command);
    await Future<void>.value();
    final cancellationFailure = cancellation.failure;
    if (cancellationFailure != null) {
      return cancellationFailure;
    }
    command._cameraMutationCount++;
    command._refreshCount++;
    command._decodeOrSubmitCount++;
    return MapCameraCommandSucceeded(
      generation: generation,
      committedCamera: camera,
    );
  }
}

final class _AwaitingSideEffectCommand {
  var _cameraMutationCount = 0;
  var _refreshCount = 0;
  var _decodeOrSubmitCount = 0;
}
