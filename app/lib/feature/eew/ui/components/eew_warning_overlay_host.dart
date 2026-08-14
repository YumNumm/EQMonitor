import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_overlay_render_policy.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_notifier.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_banner.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_fullscreen.dart';
import 'package:eqmonitor/feature/eew/ui/controller/eew_warning_overlay_back_dispatcher_controller.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewWarningOverlayHost extends HookConsumerWidget {
  const EewWarningOverlayHost({
    required this.child,
    required this.backButtonDispatcher,
    super.key,
  });

  final Widget child;
  final BackButtonDispatcher backButtonDispatcher;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifecycle = ref.watch(appLifecycleProvider);
    final state = ref.watch(eewWarningOverlayNotifierProvider);
    final liveMonitorActive = ref.watch(liveMonitorSessionProvider);
    final displayModel = state.displayModel;
    final renderPolicy = ref.watch(eewWarningOverlayRenderPolicyProvider);
    final shouldInterceptBack = renderPolicy.shouldInterceptBack(
      lifecycle: lifecycle,
      mode: state.mode,
      hasDisplayModel: displayModel != null,
      liveMonitorActive: liveMonitorActive,
    );
    final backDispatcherController = useMemoized(
      () => EewWarningOverlayBackDispatcherController(
        parent: backButtonDispatcher,
        onFullscreenBack: () async {
          await ref.read(eewWarningOverlayNotifierProvider.notifier).minimize();
        },
      ),
      [backButtonDispatcher],
    );
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        backDispatcherController.attach();
      });
      return backDispatcherController.dispose;
    }, [backDispatcherController]);
    useEffect(() {
      backDispatcherController.update(shouldIntercept: shouldInterceptBack);
      return null;
    }, [backDispatcherController, shouldInterceptBack]);

    if (!renderPolicy.shouldRender(
      lifecycle: lifecycle,
      mode: state.mode,
      hasDisplayModel: displayModel != null,
      liveMonitorActive: liveMonitorActive,
    )) {
      return child;
    }
    if (displayModel == null) {
      return child;
    }

    final notifier = ref.read(eewWarningOverlayNotifierProvider.notifier);
    final overlay = switch (state.mode) {
      EewWarningOverlayMode.fullscreen => EewWarningOverlayFullscreen(
        displayModel: displayModel,
        onMinimize: () async {
          await notifier.minimize();
        },
        onClose: () async {
          await notifier.close();
        },
      ),
      EewWarningOverlayMode.minimized => Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: double.infinity,
          child: EewWarningOverlayBanner(
            displayModel: displayModel,
            onExpand: notifier.expand,
            onClose: () async {
              await notifier.close();
            },
          ),
        ),
      ),
      EewWarningOverlayMode.hidden => const SizedBox.shrink(),
    };

    return Stack(fit: StackFit.expand, children: [child, overlay]);
  }
}
