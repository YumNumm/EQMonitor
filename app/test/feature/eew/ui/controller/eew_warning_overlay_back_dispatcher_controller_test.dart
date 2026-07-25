import 'package:eqmonitor/feature/eew/ui/controller/eew_warning_overlay_back_dispatcher_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fullscreen back is handled after minimizing the overlay', () async {
    final parent = _FakeBackButtonDispatcher();
    var delegatedCalls = 0;
    parent.addCallback(() async {
      delegatedCalls += 1;
      return false;
    });
    var minimizeCalls = 0;
    final controller = EewWarningOverlayBackDispatcherController(
      parent: parent,
      onFullscreenBack: () async {
        minimizeCalls += 1;
      },
    )..update(shouldIntercept: true);
    addTearDown(controller.dispose);

    controller.attach();

    expect(await parent.invokeCallback(Future.value(false)), isTrue);
    expect(minimizeCalls, 1);
    expect(delegatedCalls, 0);
  });

  test('non-fullscreen back delegates to the router dispatcher', () async {
    final parent = _FakeBackButtonDispatcher();
    var delegatedCalls = 0;
    parent.addCallback(() async {
      delegatedCalls += 1;
      return false;
    });
    var minimizeCalls = 0;
    final controller = EewWarningOverlayBackDispatcherController(
      parent: parent,
      onFullscreenBack: () async {
        minimizeCalls += 1;
      },
    )..attach();
    addTearDown(controller.dispose);

    controller
      ..update(shouldIntercept: true)
      ..update(shouldIntercept: false);

    expect(await parent.invokeCallback(Future.value(false)), isFalse);
    expect(minimizeCalls, 0);
    expect(delegatedCalls, 1);
  });

  test('dispose releases the old router when dispatcher changes', () async {
    final oldParent = _FakeBackButtonDispatcher();
    var oldDelegatedCalls = 0;
    oldParent.addCallback(() async {
      oldDelegatedCalls += 1;
      return false;
    });
    var minimizeCalls = 0;
    final oldController =
        EewWarningOverlayBackDispatcherController(
            parent: oldParent,
            onFullscreenBack: () async {
              minimizeCalls += 1;
            },
          )
          ..attach()
          ..update(shouldIntercept: true);

    oldController.dispose();

    final newParent = _FakeBackButtonDispatcher()
      ..addCallback(() async => false);
    final newController =
        EewWarningOverlayBackDispatcherController(
            parent: newParent,
            onFullscreenBack: () async {
              minimizeCalls += 1;
            },
          )
          ..attach()
          ..update(shouldIntercept: true);
    addTearDown(newController.dispose);

    expect(await oldParent.invokeCallback(Future.value(false)), isFalse);
    expect(oldDelegatedCalls, 1);
    expect(await newParent.invokeCallback(Future.value(false)), isTrue);
    expect(minimizeCalls, 1);
  });
}

class _FakeBackButtonDispatcher extends BackButtonDispatcher {}
