import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_spike_lifecycle.freezed.dart';

enum SceneSpikeLifecyclePhase {
  detached,
  active,
  background,
  rebuilding,
  disposed,
}

@Freezed(copyWith: false, fromJson: false, toJson: false)
sealed class SceneSpikeLifecycleState with _$SceneSpikeLifecycleState {
  const factory internal({
    required SceneSpikeLifecyclePhase phase,
    required int appResourceGeneration,
    required bool mayTick,
    required bool mayUpload,
    required bool requiresResourceRebuild,
  }) = _SceneSpikeLifecycleState;

  factory initial() =>
      const SceneSpikeLifecycleState.internal(
        phase: .detached,
        appResourceGeneration: 0,
        mayTick: false,
        mayUpload: false,
        requiresResourceRebuild: false,
      );
}

@Freezed(copyWith: false, fromJson: false, toJson: false)
sealed class SceneSpikeLifecycleEvent with _$SceneSpikeLifecycleEvent {
  const factory attached() = _Attached;
  const factory backgrounded() = _Backgrounded;
  const factory foregrounded() = _Foregrounded;
  const factory surfaceRecreated() = _SurfaceRecreated;
  const factory rebuildCompleted() = _RebuildCompleted;
  const factory detached() = _Detached;
  const factory disposed() = _Disposed;
}

class SceneSpikeLifecycleReducer {
  const new();

  SceneSpikeLifecycleState reduce({
    required SceneSpikeLifecycleState state,
    required SceneSpikeLifecycleEvent event,
  }) {
    final hasValidPermissions = switch (state.phase) {
      .detached || .background => !state.mayTick && !state.mayUpload,
      .disposed =>
        !state.mayTick && !state.mayUpload && !state.requiresResourceRebuild,
      .active =>
        state.mayTick && state.mayUpload && !state.requiresResourceRebuild,
      .rebuilding =>
        !state.mayTick && !state.mayUpload && state.requiresResourceRebuild,
    };
    final hasValidResourceGeneration =
        !state.requiresResourceRebuild || state.appResourceGeneration > 0;
    if (state.appResourceGeneration < 0 ||
        !hasValidPermissions ||
        !hasValidResourceGeneration) {
      throw StateError('Invalid scene spike lifecycle state: $state.');
    }

    return switch ((state.phase, event)) {
      (.detached, _Attached()) => SceneSpikeLifecycleState.internal(
        phase: state.requiresResourceRebuild ? .rebuilding : .active,
        appResourceGeneration: state.appResourceGeneration,
        mayTick: !state.requiresResourceRebuild,
        mayUpload: !state.requiresResourceRebuild,
        requiresResourceRebuild: state.requiresResourceRebuild,
      ),
      (.active, _Backgrounded()) => SceneSpikeLifecycleState.internal(
        phase: .background,
        appResourceGeneration: state.appResourceGeneration,
        mayTick: false,
        mayUpload: false,
        requiresResourceRebuild: false,
      ),
      (.rebuilding, _Backgrounded()) => SceneSpikeLifecycleState.internal(
        phase: .background,
        appResourceGeneration: state.appResourceGeneration,
        mayTick: false,
        mayUpload: false,
        requiresResourceRebuild: true,
      ),
      (.background, _Foregrounded()) => SceneSpikeLifecycleState.internal(
        phase: .rebuilding,
        appResourceGeneration: state.requiresResourceRebuild
            ? state.appResourceGeneration
            : state.appResourceGeneration + 1,
        mayTick: false,
        mayUpload: false,
        requiresResourceRebuild: true,
      ),
      (.active, _SurfaceRecreated()) => SceneSpikeLifecycleState.internal(
        phase: .rebuilding,
        appResourceGeneration: state.appResourceGeneration + 1,
        mayTick: false,
        mayUpload: false,
        requiresResourceRebuild: true,
      ),
      (.rebuilding, _RebuildCompleted()) => SceneSpikeLifecycleState.internal(
        phase: .active,
        appResourceGeneration: state.appResourceGeneration,
        mayTick: true,
        mayUpload: true,
        requiresResourceRebuild: false,
      ),
      (
        .active || .background || .rebuilding,
        _Detached(),
      ) =>
        SceneSpikeLifecycleState.internal(
          phase: .detached,
          appResourceGeneration: state.appResourceGeneration,
          mayTick: false,
          mayUpload: false,
          requiresResourceRebuild: state.requiresResourceRebuild,
        ),
      (
        .detached || .active || .background || .rebuilding,
        _Disposed(),
      ) =>
        SceneSpikeLifecycleState.internal(
          phase: .disposed,
          appResourceGeneration: state.appResourceGeneration,
          mayTick: false,
          mayUpload: false,
          requiresResourceRebuild: false,
        ),
      (.background, _Backgrounded()) ||
      (.active || .rebuilding, _Foregrounded()) ||
      (.disposed, _Disposed()) => state,
      (.disposed, _) => throw StateError('Disposed lifecycle is terminal.'),
      _ => throw StateError(
        'Unsupported scene spike lifecycle transition: '
        '${state.phase.name} + $event.',
      ),
    };
  }
}
