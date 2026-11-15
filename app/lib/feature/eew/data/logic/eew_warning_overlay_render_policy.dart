import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_render_policy.g.dart';

@Riverpod(keepAlive: true)
EewWarningOverlayRenderPolicy eewWarningOverlayRenderPolicy(Ref ref) =>
    const EewWarningOverlayRenderPolicy();

class const EewWarningOverlayRenderPolicy() {
  bool shouldRender({
    required AppLifecycleState lifecycle,
    required EewWarningOverlayMode mode,
    required bool hasDisplayModel,
  }) {
    return lifecycle == AppLifecycleState.resumed &&
        mode != EewWarningOverlayMode.hidden &&
        hasDisplayModel;
  }

  bool shouldInterceptBack({
    required AppLifecycleState lifecycle,
    required EewWarningOverlayMode mode,
    required bool hasDisplayModel,
  }) {
    return mode == EewWarningOverlayMode.fullscreen &&
        shouldRender(
          lifecycle: lifecycle,
          mode: mode,
          hasDisplayModel: hasDisplayModel,
        );
  }
}
