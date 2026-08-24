import 'package:eqmonitor/core/provider/clock/map_clock_source_identity_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

final class _ImmediateCameraHost implements MapViewCameraHost {
  @override
  Future<MapCameraCommandResult> applyCameraCommand({
    required int generation,
    required MapCamera camera,
  }) async => MapCameraCommandSucceeded(
    generation: generation,
    committedCamera: camera,
  );

  @override
  MapCameraBoundsFitResult cameraForBounds({
    required MapCameraBounds bounds,
    required EdgeInsets padding,
  }) => const MapCameraBoundsFitInvalid(
    reason: MapCameraBoundsFitInvalidReason.invalidBounds,
  );
}

void main() {
  test('mode identityごとにclockを替えreplay tickではcamera sessionを保つ', () async {
    var now = DateTime.utc(2026, 8, 24);
    final session = EqmonitorMapDebugMapSession(now: () => now);
    addTearDown(session.dispose);
    const realtime = (
      mode: MapClockSourceMode.realtime,
      timeShiftOffset: null,
      replaySession: null,
    );
    const replay = (
      mode: MapClockSourceMode.replay,
      timeShiftOffset: null,
      replaySession: 1,
    );
    const replayTick = (
      mode: MapClockSourceMode.replay,
      timeShiftOffset: null,
      replaySession: 1,
    );
    const nextReplay = (
      mode: MapClockSourceMode.replay,
      timeShiftOffset: null,
      replaySession: 2,
    );

    final realtimeClock = session.clockFor(sourceIdentity: realtime);
    final controller = session.cameraController;
    final host = _ImmediateCameraHost();
    controller.attach(
      host: host,
      initialCamera: const MapCamera(
        centerLongitude: 137.5,
        centerLatitude: 36.5,
        zoom: 4,
      ),
    );
    const moved = MapCamera(
      centerLongitude: 140,
      centerLatitude: 36,
      zoom: 7,
    );
    await controller.moveTo(camera: moved);

    final replayClock = session.clockFor(sourceIdentity: replay);
    now = now.add(const Duration(seconds: 1));
    final tickClock = session.clockFor(sourceIdentity: replayTick);
    final nextReplayClock = session.clockFor(sourceIdentity: nextReplay);

    expect(replayClock, isNot(same(realtimeClock)));
    expect(tickClock, same(replayClock));
    expect(nextReplayClock, isNot(same(replayClock)));
    expect(session.cameraController, same(controller));
    expect(session.cameraController.committedCamera, moved);
  });
}
