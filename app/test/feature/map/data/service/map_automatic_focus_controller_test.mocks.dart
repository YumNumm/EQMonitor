// TEMPORARY verification stand-in; restored from backup after the test run.
import 'dart:async';

import 'package:maplibre/maplibre.dart';
import 'package:mockito/mockito.dart';

class MockMapController extends Mock implements MapController {
  @override
  Future<CameraAnimationResult> animateCamera(
    CameraUpdate? update, {
    CameraAnimation? animation = const CameraAnimation.ease(),
  }) =>
      (super.noSuchMethod(
            Invocation.method(#animateCamera, [update], {#animation: animation}),
            returnValue: Future<CameraAnimationResult>.value(
              CameraAnimationResult.completed,
            ),
            returnValueForMissingStub: Future<CameraAnimationResult>.value(
              CameraAnimationResult.completed,
            ),
          )
          as Future<CameraAnimationResult>);
}
