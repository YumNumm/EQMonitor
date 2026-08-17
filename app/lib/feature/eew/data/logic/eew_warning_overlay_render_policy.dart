import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eewWarningOverlayRenderPolicyProvider =
    Provider<EewWarningOverlayRenderPolicy>(
      (_) => const EewWarningOverlayRenderPolicy(),
    );

class EewWarningOverlayRenderPolicy {
  const EewWarningOverlayRenderPolicy();

  bool shouldRender({
    required AppLifecycleState lifecycle,
    required EewWarningOverlayMode mode,
    required bool hasDisplayModel,
    required bool liveMonitorActive,
  }) {
    return lifecycle == AppLifecycleState.resumed &&
        mode != EewWarningOverlayMode.hidden &&
        hasDisplayModel &&
        !liveMonitorActive;
  }

  bool shouldInterceptBack({
    required AppLifecycleState lifecycle,
    required EewWarningOverlayMode mode,
    required bool hasDisplayModel,
    required bool liveMonitorActive,
  }) {
    return mode == EewWarningOverlayMode.fullscreen &&
        shouldRender(
          lifecycle: lifecycle,
          mode: mode,
          hasDisplayModel: hasDisplayModel,
          liveMonitorActive: liveMonitorActive,
        );
  }
}
