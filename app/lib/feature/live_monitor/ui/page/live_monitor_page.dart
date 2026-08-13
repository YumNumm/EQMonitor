import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_duration_save_queue.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_duration_validator.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_exit_policy.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_tap_tracker.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_coordinator.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_detected_event_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/ui/action/live_monitor_exit_action.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_automatic_view.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_connection_banner.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_control_panel.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_split_view.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorPage extends HookConsumerWidget {
  const LiveMonitorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      final notifier = ref.read(liveMonitorSessionProvider.notifier);
      final lease = notifier.acquire();
      return () {
        ref.read(liveMonitorSessionProvider.notifier).release(lease: lease);
      };
    }, const []);
    final settings = ref.watch(liveMonitorSettingsProvider).value;
    final panelOpen = ref.watch(liveMonitorControlPanelProvider);
    final allowExit = useState(false);
    final confirmingExit = useRef(false);
    final durationDraft = useRef<({String raw, int revision})?>(null);
    final durationRevision = useRef(0);
    final lastSavedDuration = useRef<int?>(null);
    final durationSaveQueue = useMemoized(LiveMonitorDurationSaveQueue.new);
    final tapTracker = useMemoized(
      () => LiveMonitorTapTracker(touchSlop: kTouchSlop),
    );
    useEffect(() => tapTracker.cancelAll, [tapTracker]);
    if (settings != null &&
        durationDraft.value == null &&
        !durationSaveQueue.hasInFlight) {
      lastSavedDuration.value = settings.earthquakeDisplaySeconds;
    }

    final Future<bool> Function({required String? raw, required int? revision})
    saveDuration = ({required raw, required revision}) async {
      if (raw == null) {
        return true;
      }
      final seconds = validateLiveMonitorDuration(raw).seconds;
      if (seconds == null) {
        return false;
      }
      final didCommit = await durationSaveQueue.run(
        raw: raw,
        operation: () async {
          if (!context.mounted) {
            return false;
          }
          if (seconds == lastSavedDuration.value) {
            return true;
          }
          try {
            await LiveMonitorSettingsNotifier.saveMutation.run(ref, (
              tsx,
            ) async {
              await tsx
                  .get(liveMonitorSettingsProvider.notifier)
                  .updateSettings(
                    transform: (current) =>
                        current.copyWith(earthquakeDisplaySeconds: seconds),
                  );
            });
            if (context.mounted) {
              lastSavedDuration.value = seconds;
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
        },
      );
      if (!context.mounted) {
        return didCommit;
      }
      final currentDraft = durationDraft.value;
      if (shouldClearLiveMonitorDurationDraft(
        didCommit: didCommit,
        currentRaw: currentDraft?.raw,
        currentRevision: currentDraft?.revision,
        committedRaw: raw,
        committedRevision: revision,
      )) {
        durationDraft.value = null;
      }
      return didCommit;
    };

    ref.listen(liveMonitorControlPanelProvider, (previous, next) async {
      if (previous != next) {
        tapTracker.cancelAll();
      }
      if (previous == true && !next) {
        final closingDraft = durationDraft.value;
        final didCommit = await saveDuration(
          raw: closingDraft?.raw,
          revision: closingDraft?.revision,
        );
        if (!context.mounted) {
          return;
        }
        final currentDraft = durationDraft.value;
        if (!didCommit &&
            currentDraft?.revision == closingDraft?.revision &&
            currentDraft?.raw == closingDraft?.raw) {
          durationDraft.value = null;
        }
      }
    });
    ref.listen(liveMonitorDetectedEventProvider, (_, next) {
      if (next.value?.event is LiveMonitorEewStartedEvent) {
        tapTracker.cancelAll();
      }
    });

    final Future<void> Function(LiveMonitorExitRequestSource) requestExit =
        (source) async {
          if (confirmingExit.value) {
            return;
          }
          confirmingExit.value = true;
          try {
            final exitingDraft = durationDraft.value;
            final didCommit = await saveDuration(
              raw: exitingDraft?.raw,
              revision: exitingDraft?.revision,
            );
            if (!context.mounted) {
              return;
            }
            final currentDraft = durationDraft.value;
            final draftDecision = resolveLiveMonitorExitDraft(
              didCommit: didCommit,
              exitingRaw: exitingDraft?.raw,
              exitingRevision: exitingDraft?.revision,
              currentRaw: currentDraft?.raw,
              currentRevision: currentDraft?.revision,
            );
            if (draftDecision == LiveMonitorExitDraftDecision.cancel) {
              return;
            }
            if (!shouldContinueLiveMonitorExit(
              source: source,
              isPanelOpen: ref.read(liveMonitorControlPanelProvider),
            )) {
              return;
            }
            final exitAction = ref.read(liveMonitorExitActionProvider);
            final VoidCallback onConfirmed = () {
              durationDraft.value = null;
              allowExit.value = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.pop();
                }
              });
            };
            switch (draftDecision) {
              case LiveMonitorExitDraftDecision.continueExit:
                await exitAction.confirm(
                  ref: ref,
                  context: context,
                  dismissWhenPanelCloses: source == .panel,
                  onConfirmed: onConfirmed,
                );
                break;
              case LiveMonitorExitDraftDecision.confirmDiscard:
                await exitAction.confirmDiscardAndExit(
                  ref: ref,
                  context: context,
                  dismissWhenPanelCloses: source == .panel,
                  onConfirmed: onConfirmed,
                );
                break;
              case LiveMonitorExitDraftDecision.cancel:
                return;
            }
          } finally {
            if (context.mounted) {
              confirmingExit.value = false;
            }
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
          await requestExit(.systemBack);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
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
                  tapTracker.scheduleSingleTap(
                    isTap: isTap,
                    delay: kDoubleTapTimeout,
                    onTap: () {
                      if (context.mounted &&
                          settings != null &&
                          !ref.read(liveMonitorControlPanelProvider)) {
                        ref
                            .read(liveMonitorControlPanelProvider.notifier)
                            .open();
                      }
                    },
                  );
                },
                onPointerCancel: (event) {
                  tapTracker.pointerCancel(pointer: event.pointer);
                },
                child: body,
              ),
            ),
            const Positioned.fill(child: LiveMonitorConnectionBanner()),
            if (settings != null && panelOpen) ...[
              const Positioned.fill(child: ModalBarrier(dismissible: false)),
              Positioned.fill(
                child: DisplayFeatureSubScreen(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: LiveMonitorControlPanel(
                      settings: settings,
                      onDurationChanged: (raw) {
                        durationRevision.value++;
                        durationDraft.value = (
                          raw: raw,
                          revision: durationRevision.value,
                        );
                        return durationRevision.value;
                      },
                      onDurationCommit: saveDuration,
                      onExit: () => requestExit(.panel),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
