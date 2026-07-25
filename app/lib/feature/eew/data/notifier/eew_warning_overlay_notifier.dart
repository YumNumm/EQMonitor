import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_effective_display_provider.dart';
import 'package:eqmonitor/feature/eew/data/service/eew_warning_overlay_scheduler.dart';
import 'package:eqmonitor/feature/eew/data/service/eew_warning_overlay_vibration_service.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_notifier.g.dart';

const eewWarningOverlayFullscreenDuration = Duration(seconds: 10);

@riverpod
class EewWarningOverlayNotifier extends _$EewWarningOverlayNotifier {
  EewWarningOverlayScheduledTask? _scheduledTask;
  EewWarningOverlayScheduledTask? _initializationTask;
  late EewWarningOverlayScheduler _scheduler;
  late EewWarningOverlayVibrationService _vibrationService;
  var _transitionEpoch = 0;
  var _vibrationEpoch = 0;
  var _alertActive = false;

  @override
  EewWarningOverlayState build() {
    _scheduler = ref.read(eewWarningOverlaySchedulerProvider);
    _vibrationService = ref.read(eewWarningOverlayVibrationServiceProvider);
    ref
      ..listen(eewWarningOverlayEffectiveDisplayProvider, (
        previous,
        next,
      ) async {
        await handleDisplayChange(next);
      })
      ..listen(appLifecycleProvider, (previous, next) async {
        await handleLifecycleChange(next);
      })
      ..onDispose(() async {
        _transitionEpoch += 1;
        _initializationTask?.cancel();
        cancelScheduledTask();
        await cancelVibration();
      });
    final initialDisplay = ref.read(eewWarningOverlayEffectiveDisplayProvider);
    if (initialDisplay != null &&
        ref.read(appLifecycleProvider) == AppLifecycleState.resumed) {
      _initializationTask = _scheduler.schedule(
        delay: Duration.zero,
        callback: () async {
          _initializationTask = null;
          if (_transitionEpoch == 0) {
            await handleDisplayChange(initialDisplay);
          }
        },
      );
    }
    return const EewWarningOverlayState();
  }

  Future<void> handleDisplayChange(EewWarningOverlayDisplayModel? model) async {
    final transition = ++_transitionEpoch;
    if (model == null) {
      await hide();
      return;
    }
    if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
      await retainWhileBackgrounded(model: model);
      return;
    }
    if (model.source == EewWarningOverlaySource.simulation) {
      await handleSimulation(model: model, transition: transition);
      return;
    }
    await handleReal(model: model, transition: transition);
  }

  Future<void> handleLifecycleChange(AppLifecycleState lifecycle) async {
    _transitionEpoch += 1;
    if (lifecycle != AppLifecycleState.resumed) {
      await minimizeForBackground();
      return;
    }
    await handleDisplayChange(
      ref.read(eewWarningOverlayEffectiveDisplayProvider),
    );
  }

  Future<void> handleReal({
    required EewWarningOverlayDisplayModel model,
    required int transition,
  }) async {
    final eventIds = model.eventIds.toSet();
    final activeIds = eventIds.difference(state.dismissedEventIds);
    if (activeIds.isEmpty) {
      await hide();
      return;
    }
    final newIds = eventIds.difference(state.seenEventIds);
    if (newIds.isNotEmpty) {
      final next = state.copyWith(
        displayModel: model,
        seenEventIds: {...state.seenEventIds, ...eventIds},
        simulationSessionActive: false,
      );
      await beginFullscreen(next: next, transition: transition);
      return;
    }
    state = state.copyWith(
      mode: state.mode == EewWarningOverlayMode.hidden
          ? EewWarningOverlayMode.minimized
          : state.mode,
      displayModel: model,
      simulationSessionActive: false,
    );
  }

  Future<void> handleSimulation({
    required EewWarningOverlayDisplayModel model,
    required int transition,
  }) async {
    if (state.simulationSessionActive) {
      state = state.copyWith(displayModel: model);
      return;
    }
    final next = state.copyWith(
      displayModel: model,
      simulationSessionActive: true,
    );
    await beginFullscreen(next: next, transition: transition);
  }

  Future<void> retainWhileBackgrounded({
    required EewWarningOverlayDisplayModel model,
  }) async {
    state = state.copyWith(
      mode: state.mode == EewWarningOverlayMode.fullscreen
          ? EewWarningOverlayMode.minimized
          : state.mode,
      displayModel: model,
      simulationSessionActive:
          model.source == EewWarningOverlaySource.simulation
          ? state.simulationSessionActive
          : false,
    );
    await cancelVibration();
  }

  Future<void> minimizeForBackground() async {
    cancelScheduledTask();
    state = state.copyWith(
      mode: state.mode == EewWarningOverlayMode.fullscreen
          ? EewWarningOverlayMode.minimized
          : state.mode,
    );
    await cancelVibration();
  }

  Future<void> beginFullscreen({
    required EewWarningOverlayState next,
    required int transition,
  }) async {
    cancelScheduledTask();
    final cancellation = cancelVibration();
    state = next.copyWith(mode: EewWarningOverlayMode.fullscreen);
    _scheduledTask = _scheduler.schedule(
      delay: eewWarningOverlayFullscreenDuration,
      callback: minimize,
    );
    _alertActive = true;
    final vibration = ++_vibrationEpoch;
    await cancellation;
    if (transition != _transitionEpoch || !ref.mounted) {
      return;
    }
    await _vibrationService.start();
    if (vibration != _vibrationEpoch || !ref.mounted) {
      await _vibrationService.cancel();
    }
  }

  Future<void> minimize() async {
    _transitionEpoch += 1;
    cancelScheduledTask();
    if (state.displayModel != null) {
      state = state.copyWith(mode: EewWarningOverlayMode.minimized);
    }
    await cancelVibration();
  }

  void expand() {
    _transitionEpoch += 1;
    cancelScheduledTask();
    if (state.mode == EewWarningOverlayMode.minimized &&
        state.displayModel != null) {
      state = state.copyWith(mode: EewWarningOverlayMode.fullscreen);
    }
  }

  Future<void> close() async {
    _transitionEpoch += 1;
    final model = state.displayModel;
    if (model?.source == EewWarningOverlaySource.simulation) {
      ref.read(eewWarningOverlaySimulationProvider.notifier).stop();
    }
    final dismissed = model?.source == EewWarningOverlaySource.real
        ? {...state.dismissedEventIds, ...?model?.eventIds}
        : state.dismissedEventIds;
    await hide(dismissedEventIds: dismissed);
  }

  Future<void> hide({Set<String>? dismissedEventIds}) async {
    cancelScheduledTask();
    state = state.copyWith(
      mode: EewWarningOverlayMode.hidden,
      displayModel: null,
      dismissedEventIds: dismissedEventIds ?? state.dismissedEventIds,
      simulationSessionActive: false,
    );
    await cancelVibration();
  }

  void cancelScheduledTask() {
    _scheduledTask?.cancel();
    _scheduledTask = null;
  }

  Future<void> cancelVibration() async {
    _vibrationEpoch += 1;
    if (!_alertActive) {
      return;
    }
    _alertActive = false;
    await _vibrationService.cancel();
  }
}

final eewWarningOverlayNotifierProvider = eewWarningOverlayProvider;
