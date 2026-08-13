import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_host.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LiveMonitor active中だけoverlay描画を抑止する', () {
    expect(
      shouldRenderEewWarningOverlay(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
        liveMonitorActive: true,
      ),
      isFalse,
    );
    expect(
      shouldRenderEewWarningOverlay(
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
      shouldRenderEewWarningOverlay(
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
      shouldInterceptEewWarningOverlayBack(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
        liveMonitorActive: true,
      ),
      isFalse,
    );
    expect(
      shouldInterceptEewWarningOverlayBack(
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
      shouldRenderEewWarningOverlay(
        lifecycle: AppLifecycleState.paused,
        mode: EewWarningOverlayMode.fullscreen,
        hasDisplayModel: true,
        liveMonitorActive: false,
      ),
      isFalse,
    );
    expect(
      shouldRenderEewWarningOverlay(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.hidden,
        hasDisplayModel: true,
        liveMonitorActive: false,
      ),
      isFalse,
    );
    expect(
      shouldRenderEewWarningOverlay(
        lifecycle: AppLifecycleState.resumed,
        mode: EewWarningOverlayMode.minimized,
        hasDisplayModel: false,
        liveMonitorActive: false,
      ),
      isFalse,
    );
  });
}
