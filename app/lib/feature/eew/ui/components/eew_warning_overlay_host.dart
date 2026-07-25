import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_notifier.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_banner.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewWarningOverlayHost extends ConsumerWidget {
  const EewWarningOverlayHost({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifecycle = ref.watch(appLifecycleProvider);
    final state = ref.watch(eewWarningOverlayNotifierProvider);
    final displayModel = state.displayModel;

    if (lifecycle != AppLifecycleState.resumed ||
        state.mode == EewWarningOverlayMode.hidden ||
        displayModel == null) {
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

    return PopScope<Object?>(
      canPop: state.mode != EewWarningOverlayMode.fullscreen,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop && state.mode == EewWarningOverlayMode.fullscreen) {
          await notifier.minimize();
        }
      },
      child: Stack(fit: StackFit.expand, children: [child, overlay]),
    );
  }
}
