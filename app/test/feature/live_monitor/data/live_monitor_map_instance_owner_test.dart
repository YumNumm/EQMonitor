import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_instance_owner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('remount後に遅延した旧onMapCreatedを無視してcurrentだけを受理する', () {
    final owner = LiveMonitorMapInstanceOwner<_MapController>();
    final oldIdentity = owner.switchInstance();
    final currentIdentity = owner.switchInstance();
    final oldController = _MapController();
    final currentController = _MapController();

    expect(
      owner.acceptController(identity: oldIdentity, controller: oldController),
      isFalse,
    );
    expect(owner.currentController, isNull);

    expect(
      owner.acceptController(
        identity: currentIdentity,
        controller: currentController,
      ),
      isTrue,
    );
    expect(owner.currentController, same(currentController));
  });

  test('instance切替は旧controllerと進行中camera generationを無効化する', () {
    final owner = LiveMonitorMapInstanceOwner<_MapController>();
    final oldIdentity = owner.switchInstance();
    final oldController = _MapController();
    owner.acceptController(identity: oldIdentity, controller: oldController);
    final oldCamera = owner.beginCameraOperation(
      identity: oldIdentity,
      controller: oldController,
    );
    if (oldCamera == null) {
      throw StateError('current controllerのcamera operationが作成されませんでした');
    }

    final currentIdentity = owner.switchInstance();

    expect(owner.currentController, isNull);
    expect(owner.acceptCameraCompletion(oldCamera), isFalse);
    expect(
      owner.beginCameraOperation(
        identity: oldIdentity,
        controller: oldController,
      ),
      isNull,
    );
    expect(owner.isCurrentIdentity(currentIdentity), isTrue);
  });

  test('current identityのcontrollerと最新cameraだけを受理する', () {
    final owner = LiveMonitorMapInstanceOwner<_MapController>();
    final identity = owner.switchInstance();
    final controller = _MapController();
    owner.acceptController(identity: identity, controller: controller);
    final staleCamera = owner.beginCameraOperation(
      identity: identity,
      controller: controller,
    );
    final currentCamera = owner.beginCameraOperation(
      identity: identity,
      controller: controller,
    );
    if (staleCamera == null || currentCamera == null) {
      throw StateError('current controllerのcamera operationが作成されませんでした');
    }

    expect(owner.acceptCameraCompletion(staleCamera), isFalse);
    expect(owner.acceptCameraCompletion(currentCamera), isTrue);
  });
}

final class _MapController {}
