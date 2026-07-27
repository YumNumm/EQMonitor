import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_duration_validator.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_tap_tracker.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_coordinator.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/ui/action/live_monitor_exit_action.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_automatic_view.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_connection_banner.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_control_panel.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_split_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorPage extends HookConsumerWidget {
  const LiveMonitorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(liveMonitorSettingsProvider).value;
    final panelOpen = ref.watch(liveMonitorControlPanelProvider);
    final allowExit = useState(false);
    final confirmingExit = useRef(false);
    final durationDraft = useRef<String?>(null);
    final lastSavedDuration = useRef<int?>(null);
    final durationSaveInFlight = useRef<Future<bool>?>(null);
    final tapTracker = useMemoized(
      () => LiveMonitorTapTracker(touchSlop: kTouchSlop),
    );
    if (settings != null &&
        durationDraft.value == null &&
        durationSaveInFlight.value == null) {
      lastSavedDuration.value = settings.earthquakeDisplaySeconds;
    }

    final Future<void> Function(String?) saveDuration = (raw) async {
      if (raw == null) {
        return;
      }
      final seconds = validateLiveMonitorDuration(raw).seconds;
      if (seconds == null) {
        return;
      }
      final precedingSave = durationSaveInFlight.value;
      if (precedingSave != null) {
        await precedingSave;
      }
      if (seconds == lastSavedDuration.value) {
        if (durationDraft.value == raw) {
          durationDraft.value = null;
        }
        return;
      }
      final saveOperation = () async {
        try {
          await LiveMonitorSettingsNotifier.saveMutation.run(ref, (tsx) async {
            await tsx
                .get(liveMonitorSettingsProvider.notifier)
                .updateSettings(
                  transform: (current) =>
                      current.copyWith(earthquakeDisplaySeconds: seconds),
                );
          });
          lastSavedDuration.value = seconds;
          if (durationDraft.value == raw) {
            durationDraft.value = null;
          }
          return true;
        } on Exception catch (error, stackTrace) {
          talker.error(
            '[LiveMonitor] failed to save duration',
            error,
            stackTrace,
          );
          return false;
        }
      }();
      durationSaveInFlight.value = saveOperation;
      try {
        await saveOperation;
      } finally {
        if (identical(durationSaveInFlight.value, saveOperation)) {
          durationSaveInFlight.value = null;
        }
      }
    };

    ref.listen(liveMonitorControlPanelProvider, (previous, next) async {
      if (previous != next) {
        tapTracker.cancelAll();
      }
      if (previous == true && !next) {
        await saveDuration(durationDraft.value);
      }
    });

    final Future<void> Function() requestExit = () async {
      if (confirmingExit.value) {
        return;
      }
      confirmingExit.value = true;
      try {
        await saveDuration(durationDraft.value);
        await ref
            .read(liveMonitorExitActionProvider)
            .confirm(
              ref: ref,
              context: context,
              onConfirmed: () {
                allowExit.value = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    context.pop();
                  }
                });
              },
            );
      } finally {
        confirmingExit.value = false;
      }
    };

    final body = switch (settings) {
      null => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 12),
            Text('LiveMonitor モードを準備しています'),
          ],
        ),
      ),
      LiveMonitorSettings(:final displayMode) => switch (displayMode) {
        LiveMonitorDisplayMode.automatic => const LiveMonitorAutomaticView(),
        LiveMonitorDisplayMode.split => const LiveMonitorSplitView(),
      },
    };
    if (settings != null) {
      ref.watch(liveMonitorCoordinatorProvider);
    }

    return PopScope(
      canPop: allowExit.value,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          await requestExit();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              if (settings == null || panelOpen) {
                tapTracker.cancelAll();
                return;
              }
              tapTracker.pointerDown(
                pointer: event.pointer,
                position: event.position,
              );
            },
            onPointerMove: (event) {
              tapTracker.pointerMove(
                pointer: event.pointer,
                position: event.position,
              );
            },
            onPointerUp: (event) {
              final isTap = tapTracker.pointerUp(
                pointer: event.pointer,
                position: event.position,
              );
              if (isTap && settings != null && !panelOpen) {
                ref.read(liveMonitorControlPanelProvider.notifier).open();
              }
            },
            onPointerCancel: (event) {
              tapTracker.pointerCancel(pointer: event.pointer);
            },
            child: Stack(
              children: [
                Positioned.fill(child: body),
                const Positioned.fill(child: LiveMonitorConnectionBanner()),
                if (settings != null && panelOpen) ...[
                  const Positioned.fill(
                    child: ModalBarrier(dismissible: false),
                  ),
                  Positioned.fill(
                    child: DisplayFeatureSubScreen(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: LiveMonitorControlPanel(
                          settings: settings,
                          onDurationChanged: (raw) {
                            durationDraft.value = raw;
                          },
                          onDurationCommit: saveDuration,
                          onExit: requestExit,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
