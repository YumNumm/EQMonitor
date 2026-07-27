import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_instance_owner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('remount後に遅延した旧onMapCreatedを無視してcurrentだけを受理する', () {
    final owner = LiveMonitorMapInstanceOwner<Object>();
    final oldIdentity = owner.switchInstance();
    final currentIdentity = owner.switchInstance();
    final oldController = Object();
    final currentController = Object();

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
    final owner = LiveMonitorMapInstanceOwner<Object>();
    final oldIdentity = owner.switchInstance();
    final oldController = Object();
    owner.acceptController(identity: oldIdentity, controller: oldController);
    final oldCamera = owner.beginCameraOperation(
      identity: oldIdentity,
      controller: oldController,
    );

    final currentIdentity = owner.switchInstance();

    expect(owner.currentController, isNull);
    expect(oldCamera, isNotNull);
    expect(owner.acceptCameraCompletion(oldCamera!), isFalse);
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
    final owner = LiveMonitorMapInstanceOwner<Object>();
    final identity = owner.switchInstance();
    final controller = Object();
    owner.acceptController(identity: identity, controller: controller);
    final staleCamera = owner.beginCameraOperation(
      identity: identity,
      controller: controller,
    );
    final currentCamera = owner.beginCameraOperation(
      identity: identity,
      controller: controller,
    );

    expect(staleCamera, isNotNull);
    expect(currentCamera, isNotNull);
    expect(owner.acceptCameraCompletion(staleCamera!), isFalse);
    expect(owner.acceptCameraCompletion(currentCamera!), isTrue);
  });
}
