import 'package:eqmonitor/feature/eew/data/logic/eew_warning_overlay_render_policy.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const policy = EewWarningOverlayRenderPolicy();

  test('前面表示中はfullscreen overlayを描画する', () {
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
      ),
      isTrue,
    );
  });

  test('前面表示中は最小化されたoverlayも描画する', () {
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.minimized,
        hasDisplayModel: true,
      ),
      isTrue,
    );
  });

  test('fullscreen EEWの戻る操作を処理する', () {
    expect(
      policy.shouldInterceptBack(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
      ),
      isTrue,
    );
  });

  test('既存のlifecycleと表示modelの描画条件を保つ', () {
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.paused,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
      ),
      isFalse,
    );
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.hidden,
        hasDisplayModel: true,
      ),
      isFalse,
    );
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.minimized,
        hasDisplayModel: false,
      ),
      isFalse,
    );
  });
}
