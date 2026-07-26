import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_transition_policy.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_display_state.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_detected_event_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/provider/live_monitor_scheduler_provider.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_coordinator.g.dart';

@riverpod
class LiveMonitorCoordinator extends _$LiveMonitorCoordinator {
  final policy = const LiveMonitorTransitionPolicy();
  var lastSequence = 0;
  LiveMonitorDisplayMode? lastDisplayMode;
  late LiveMonitorScheduler scheduler;

  @override
  LiveMonitorDisplayState build() {
    scheduler = ref.watch(liveMonitorSchedulerProvider);
    lastDisplayMode = ref.read(liveMonitorSettingsProvider).value?.displayMode;
    ref
      ..listen(liveMonitorDetectedEventProvider, (_, next) {
        final envelope = next.value;
        if (envelope != null) {
          acceptEnvelope(envelope);
        }
      })
      ..listen(
        liveMonitorSettingsProvider.select((value) => value.value?.displayMode),
        (_, next) => acceptDisplayMode(next),
      )
      ..onDispose(scheduler.cancel);
    return const LiveMonitorDisplayState.realtime();
  }

  void acceptEnvelope(LiveMonitorEventEnvelope envelope) {
    if (envelope.sequence <= lastSequence) {
      return;
    }
    lastSequence = envelope.sequence;
    final settings = ref.read(liveMonitorSettingsProvider).value;
    final displayMode =
        settings?.displayMode ?? const LiveMonitorSettings().displayMode;
    if (displayMode == LiveMonitorDisplayMode.split) {
      acceptSplitEvent(envelope.event);
      return;
    }
    acceptAutomaticEvent(event: envelope.event, settings: settings);
  }

  void acceptSplitEvent(LiveMonitorDetectedEvent event) {
    if (event is LiveMonitorEewStartedEvent) {
      ref.read(liveMonitorControlPanelProvider.notifier).close();
    }
  }

  void acceptAutomaticEvent({
    required LiveMonitorDetectedEvent event,
    required LiveMonitorSettings? settings,
  }) {
    final displaySeconds = switch (event) {
      LiveMonitorEarthquakeUpsertEvent() =>
        settings?.earthquakeDisplaySeconds ??
            const LiveMonitorSettings().earthquakeDisplaySeconds,
      _ => const LiveMonitorSettings().earthquakeDisplaySeconds,
    };
    final decision = policy.resolve(
      current: state,
      event: event,
      now: ref.read(appClockProvider.notifier).now().toUtc(),
      displaySeconds: displaySeconds,
    );
    applyDecision(decision);
  }

  void applyDecision(LiveMonitorTransitionDecision decision) {
    state = decision.next;
    if (decision.closeControlPanel) {
      ref.read(liveMonitorControlPanelProvider.notifier).close();
    }
    final deadline = decision.deadline;
    if (deadline == null) {
      scheduler.cancel();
      return;
    }
    scheduler.schedule(
      now: ref.read(appClockProvider.notifier).now().toUtc(),
      deadline: deadline,
      onElapsed: handleDeadline,
    );
  }

  void acceptDisplayMode(LiveMonitorDisplayMode? mode) {
    if (mode == null || mode == lastDisplayMode) {
      return;
    }
    lastDisplayMode = mode;
    scheduler.cancel();
    state = const LiveMonitorDisplayState.realtime();
  }

  void handleDeadline() {
    if (!ref.mounted) {
      return;
    }
    final decision = policy.resolveDeadline(
      current: state,
      now: ref.read(appClockProvider.notifier).now().toUtc(),
    );
    applyDecision(decision);
  }
}
