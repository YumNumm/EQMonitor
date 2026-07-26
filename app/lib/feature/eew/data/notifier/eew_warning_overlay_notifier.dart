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
  var _displayEpoch = 0;
  var _alertGeneration = 0;
  var _vibrationActive = false;
  Future<void> _vibrationQueue = Future.value();

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
        _displayEpoch += 1;
        _initializationTask?.cancel();
        cancelScheduledTask();
        await stopVibration();
      });
    final initialDisplay = ref.read(eewWarningOverlayEffectiveDisplayProvider);
    if (initialDisplay != null &&
        ref.read(appLifecycleProvider) == AppLifecycleState.resumed) {
      _initializationTask = _scheduler.schedule(
        delay: Duration.zero,
        callback: () async {
          _initializationTask = null;
          if (_displayEpoch == 0) {
            await handleDisplayChange(initialDisplay);
          }
        },
      );
    }
    return const EewWarningOverlayState();
  }

  Future<void> handleDisplayChange(EewWarningOverlayDisplayModel? model) async {
    _displayEpoch += 1;
    if (model == null) {
      await hide();
      return;
    }
    if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
      await retainWhileBackgrounded(model: model);
      return;
    }
    if (model.source == EewWarningOverlaySource.simulation) {
      await handleSimulation(model: model);
      return;
    }
    await handleReal(model: model);
  }

  Future<void> handleLifecycleChange(AppLifecycleState lifecycle) async {
    _displayEpoch += 1;
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
  }) async {
    final previousSource = state.displayModel?.source;
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
      await beginFullscreen(next: next);
      return;
    }
    if (previousSource == EewWarningOverlaySource.simulation) {
      cancelScheduledTask();
      state = state.copyWith(
        mode: EewWarningOverlayMode.minimized,
        displayModel: model,
        simulationSessionActive: false,
      );
      await stopVibration();
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
  }) async {
    if (state.simulationSessionActive) {
      state = state.copyWith(displayModel: model);
      return;
    }
    final next = state.copyWith(
      displayModel: model,
      simulationSessionActive: true,
    );
    await beginFullscreen(next: next);
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
    await stopVibration();
  }

  Future<void> minimizeForBackground() async {
    cancelScheduledTask();
    state = state.copyWith(
      mode: state.mode == EewWarningOverlayMode.fullscreen
          ? EewWarningOverlayMode.minimized
          : state.mode,
    );
    await stopVibration();
  }

  Future<void> beginFullscreen({required EewWarningOverlayState next}) async {
    cancelScheduledTask();
    state = next.copyWith(mode: EewWarningOverlayMode.fullscreen);
    _scheduledTask = _scheduler.schedule(
      delay: eewWarningOverlayFullscreenDuration,
      callback: minimize,
    );
    final generation = ++_alertGeneration;
    await startVibration(generation: generation);
  }

  Future<void> minimize() async {
    _displayEpoch += 1;
    cancelScheduledTask();
    if (state.displayModel != null) {
      state = state.copyWith(mode: EewWarningOverlayMode.minimized);
    }
    await stopVibration();
  }

  void expand() {
    _displayEpoch += 1;
    cancelScheduledTask();
    if (state.mode == EewWarningOverlayMode.minimized &&
        state.displayModel != null) {
      state = state.copyWith(mode: EewWarningOverlayMode.fullscreen);
    }
  }

  Future<void> close() async {
    _displayEpoch += 1;
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
    await stopVibration();
  }

  void cancelScheduledTask() {
    _scheduledTask?.cancel();
    _scheduledTask = null;
  }

  Future<void> startVibration({required int generation}) {
    final operation = _vibrationQueue.then((_) async {
      if (_vibrationActive) {
        _vibrationActive = false;
        await _vibrationService.cancel();
      }
      if (generation != _alertGeneration || !ref.mounted) {
        return;
      }
      final started = await _vibrationService.start();
      if (generation == _alertGeneration && ref.mounted) {
        _vibrationActive = started;
        return;
      }
      if (started) {
        await _vibrationService.cancel();
      }
      _vibrationActive = false;
    });
    _vibrationQueue = operation;
    return operation;
  }

  Future<void> stopVibration() {
    _alertGeneration += 1;
    final operation = _vibrationQueue.then((_) async {
      if (!_vibrationActive) {
        return;
      }
      _vibrationActive = false;
      await _vibrationService.cancel();
    });
    _vibrationQueue = operation;
    return operation;
  }
}

final eewWarningOverlayNotifierProvider = eewWarningOverlayProvider;
