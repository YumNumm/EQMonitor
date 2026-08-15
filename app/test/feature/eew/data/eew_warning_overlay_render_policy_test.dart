import 'package:eqmonitor/feature/eew/data/logic/eew_warning_overlay_render_policy.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const policy = EewWarningOverlayRenderPolicy();

  test('LiveMonitor active中だけoverlay描画を抑止する', () {
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
        liveMonitorActive: true,
      ),
      isFalse,
    );
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
        liveMonitorActive: false,
      ),
      isTrue,
    );
  });

  test('LiveMonitor activeで最小化されたoverlayも描画しない', () {
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.minimized,
        hasDisplayModel: true,
        liveMonitorActive: true,
      ),
      isFalse,
    );
  });

  test('LiveMonitor active中はfullscreen EEWの戻る操作を奪わない', () {
    expect(
      policy.shouldInterceptBack(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
        liveMonitorActive: true,
      ),
      isFalse,
    );
    expect(
      policy.shouldInterceptBack(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
        liveMonitorActive: false,
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
        liveMonitorActive: false,
      ),
      isFalse,
    );
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.hidden,
        hasDisplayModel: true,
        liveMonitorActive: false,
      ),
      isFalse,
    );
    expect(
      policy.shouldRender(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.minimized,
        hasDisplayModel: false,
        liveMonitorActive: false,
      ),
      isFalse,
    );
  });
}
