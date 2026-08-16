import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorConnectionBanner extends ConsumerWidget {
  const LiveMonitorConnectionBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phase = ref.watch(
      eqMonitorWsStatusProvider.select((status) => status.phase),
    );
    final label = switch (phase) {
      WsPhase.connecting => 'リアルタイム情報へ接続中',
      WsPhase.connected => null,
      WsPhase.disconnected => 'リアルタイム情報へ再接続中',
    };
    if (label == null) {
      return const SizedBox.shrink();
    }

    final colorScheme = context.designSystem.colorTheme;
    return IgnorePointer(
      child: DisplayFeatureSubScreen(
        child: SafeArea(
          minimum: const EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.topCenter,
            child: Semantics(
              liveRegion: true,
              label: label,
              child: Material(
                color: colorScheme.surfaceContainerHigh,
                elevation: 2,
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(child: Text(label)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
