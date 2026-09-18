import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_camera_action.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

final class RecordingCameraHost implements MapViewCameraHost {
  new({this.failure});

  final MapCameraCommandFailure? failure;
  final commands = <MapCamera>[];

  @override
  Future<MapCameraCommandResult> applyCameraCommand({
    required int generation,
    required MapCamera camera,
    required MapCameraCommandCancellation cancellation,
  }) async {
    commands.add(camera);
    return failure ??
        MapCameraCommandSucceeded(
          generation: generation,
          committedCamera: camera,
        );
  }

  @override
  MapCameraBoundsFitResult cameraForBounds({
    required MapCameraBounds bounds,
    required EdgeInsets padding,
  }) => const MapCameraBoundsFitInvalid(
    reason: MapCameraBoundsFitInvalidReason.invalidBounds,
  );
}

void main() {
  const action = EqmonitorMapCameraAction();
  const current = MapCamera(
    centerLongitude: 137.5,
    centerLatitude: 36.5,
    zoom: 7.25,
  );

  test('committed cameraがない場合はtyped not-readyを返す', () async {
    final controller = MapViewCameraController();
    addTearDown(controller.dispose);

    final result = await action.moveToHypocenter(
      controller: controller,
      longitude: 140.1,
      latitude: 36.2,
    );

    expect(result, isA<EqmonitorMapCameraActionNotReady>());
  });

  test('震源座標の欠損はtyped unavailableでcommandを送らない', () async {
    final controller = MapViewCameraController();
    final host = RecordingCameraHost();
    addTearDown(controller.dispose);
    controller.attach(host: host, initialCamera: current);
    controller.commitCameraFromHost(host: host, camera: current);

    final result = await action.moveToHypocenter(
      controller: controller,
      longitude: null,
      latitude: 36.2,
    );

    expect(result, isA<EqmonitorMapCameraActionHypocenterUnavailable>());
    expect(host.commands, isEmpty);
  });

  test('非finiteまたは範囲外の震源はtyped invalidでcommandを送らない', () async {
    for (final coordinate in const [
      (longitude: double.nan, latitude: 36.2),
      (longitude: 140.1, latitude: double.infinity),
      (longitude: 180.1, latitude: 36.2),
      (longitude: 140.1, latitude: -90.1),
    ]) {
      final controller = MapViewCameraController();
      final host = RecordingCameraHost();
      controller.attach(host: host, initialCamera: current);
      controller.commitCameraFromHost(host: host, camera: current);

      final result = await action.moveToHypocenter(
        controller: controller,
        longitude: coordinate.longitude,
        latitude: coordinate.latitude,
      );

      expect(result, isA<EqmonitorMapCameraActionInvalidHypocenter>());
      expect(host.commands, isEmpty);
      controller.dispose();
    }
  });

  test('centerだけを置換しzoomを維持してexactly one commandを送る', () async {
    final controller = MapViewCameraController();
    final host = RecordingCameraHost();
    addTearDown(controller.dispose);
    controller.attach(host: host, initialCamera: current);
    controller.commitCameraFromHost(host: host, camera: current);

    final result = await action.moveToHypocenter(
      controller: controller,
      longitude: 140.1,
      latitude: 36.2,
    );

    expect(result, isA<EqmonitorMapCameraActionSucceeded>());
    expect(host.commands, const [
      MapCamera(centerLongitude: 140.1, centerLatitude: 36.2, zoom: 7.25),
    ]);
  });

  test('controller failureをtyped resultで返し再試行しない', () async {
    const failure = MapCameraCommandRenderFailed(
      reason: MapCameraCommandRenderFailureReason.sceneSubmissionRejected,
    );
    final controller = MapViewCameraController();
    final host = RecordingCameraHost(failure: failure);
    addTearDown(controller.dispose);
    controller.attach(host: host, initialCamera: current);
    controller.commitCameraFromHost(host: host, camera: current);

    final result = await action.moveToHypocenter(
      controller: controller,
      longitude: 140.1,
      latitude: 36.2,
    );

    expect(
      result,
      isA<EqmonitorMapCameraActionCommandFailed>().having(
        (value) => value.failure,
        'failure',
        same(failure),
      ),
    );
    expect(host.commands, hasLength(1));
  });

  test('Action resultをraw detailなしの短い分類messageへ変換する', () {
    final cases = <(EqmonitorMapCameraActionResult, String)>[
      (
        const EqmonitorMapCameraActionNotReady(),
        '地図の準備が完了していません',
      ),
      (
        const EqmonitorMapCameraActionHypocenterUnavailable(),
        '震源座標がありません',
      ),
      (
        const EqmonitorMapCameraActionInvalidHypocenter(),
        '震源座標が不正です',
      ),
      (
        const EqmonitorMapCameraActionCommandFailed(
          failure: MapCameraCommandRenderFailed(
            reason: MapCameraCommandRenderFailureReason.sceneSubmissionRejected,
          ),
        ),
        'Camera描画に失敗しました',
      ),
    ];

    for (final entry in cases) {
      expect(eqmonitorMapCameraActionMessage(entry.$1), entry.$2);
    }
  });
}
