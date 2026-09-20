import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_map_camera_action.g.dart';

@riverpod
EqmonitorMapCameraAction eqmonitorMapCameraAction(Ref ref) =>
    const EqmonitorMapCameraAction();

sealed class const EqmonitorMapCameraActionResult();

final class const EqmonitorMapCameraActionSucceeded({
  required final MapCameraCommandSucceeded command,
}) extends EqmonitorMapCameraActionResult;

final class const EqmonitorMapCameraActionNotReady()
    extends EqmonitorMapCameraActionResult;

final class const EqmonitorMapCameraActionHypocenterUnavailable()
    extends EqmonitorMapCameraActionResult;

final class const EqmonitorMapCameraActionInvalidHypocenter()
    extends EqmonitorMapCameraActionResult;

final class const EqmonitorMapCameraActionCommandFailed({
  required final MapCameraCommandFailure failure,
}) extends EqmonitorMapCameraActionResult;

String eqmonitorMapCameraActionMessage(EqmonitorMapCameraActionResult result) =>
    switch (result) {
      EqmonitorMapCameraActionSucceeded() => '震源へ移動しました',
      EqmonitorMapCameraActionNotReady() => '地図の準備が完了していません',
      EqmonitorMapCameraActionHypocenterUnavailable() => '震源座標がありません',
      EqmonitorMapCameraActionInvalidHypocenter() => '震源座標が不正です',
      EqmonitorMapCameraActionCommandFailed(:final failure) =>
        switch (failure) {
          MapCameraCommandInvalidInput() => 'Camera入力が不正です',
          MapCameraCommandNotAttached() => 'Camera controllerが未接続です',
          MapCameraCommandNotReady() => 'Camera描画の準備が完了していません',
          MapCameraCommandRenderFailed() => 'Camera描画に失敗しました',
          MapCameraCommandDisposed() => 'Camera controllerは破棄済みです',
          MapCameraCommandSuperseded() => 'Camera commandが更新されました',
        },
    };

final class const EqmonitorMapCameraAction() {
  Future<EqmonitorMapCameraActionResult> moveToHypocenter({
    required MapViewCameraController controller,
    required double? longitude,
    required double? latitude,
  }) async {
    final camera = controller.committedCamera;
    if (camera == null) {
      return const EqmonitorMapCameraActionNotReady();
    }
    if (longitude == null || latitude == null) {
      return const EqmonitorMapCameraActionHypocenterUnavailable();
    }
    if (!longitude.isFinite ||
        !latitude.isFinite ||
        longitude < -180 ||
        longitude > 180 ||
        latitude < -90 ||
        latitude > 90) {
      return const EqmonitorMapCameraActionInvalidHypocenter();
    }
    final result = await controller.moveTo(
      camera: camera.copyWith(
        centerLongitude: longitude,
        centerLatitude: latitude,
      ),
    );
    return switch (result) {
      MapCameraCommandSucceeded() => EqmonitorMapCameraActionSucceeded(
        command: result,
      ),
      MapCameraCommandFailure() => EqmonitorMapCameraActionCommandFailed(
        failure: result,
      ),
    };
  }
}
