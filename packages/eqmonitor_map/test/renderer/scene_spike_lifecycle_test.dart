import 'package:eqmonitor_map/src/renderer/scene_spike_lifecycle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const reducer = SceneSpikeLifecycleReducer();

  test('initial state denies work while detached', () {
    final state = SceneSpikeLifecycleState.initial();

    expect(state.phase, SceneSpikeLifecyclePhase.detached);
    expect(state.appResourceGeneration, 0);
    expect(state.mayTick, isFalse);
    expect(state.mayUpload, isFalse);
    expect(state.requiresResourceRebuild, isFalse);
  });

  test('background stops ticking and uploads until foreground rebuild', () {
    final attached = reducer.reduce(
      state: SceneSpikeLifecycleState.initial(),
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    final background = reducer.reduce(
      state: attached,
      event: const SceneSpikeLifecycleEvent.backgrounded(),
    );
    expect(background.mayTick, isFalse);
    expect(background.mayUpload, isFalse);

    final resumed = reducer.reduce(
      state: background,
      event: const SceneSpikeLifecycleEvent.foregrounded(),
    );
    expect(resumed.requiresResourceRebuild, isTrue);
    expect(
      resumed.appResourceGeneration,
      attached.appResourceGeneration + 1,
    );
  });

  test('disposed is terminal', () {
    final disposed = reducer.reduce(
      state: SceneSpikeLifecycleState.initial(),
      event: const SceneSpikeLifecycleEvent.disposed(),
    );
    expect(
      () => reducer.reduce(
        state: disposed,
        event: const SceneSpikeLifecycleEvent.attached(),
      ),
      throwsStateError,
    );
  });

  test('deduplicates real mobile background lifecycle sequences', () {
    var state = reducer.reduce(
      state: SceneSpikeLifecycleState.initial(),
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    for (var index = 0; index < 3; index++) {
      state = reducer.reduce(
        state: state,
        event: const SceneSpikeLifecycleEvent.backgrounded(),
      );
    }
    expect(state.phase, SceneSpikeLifecyclePhase.background);
    expect(state.appResourceGeneration, 0);
  });

  test('implements every state-changing transition table edge', () {
    final detached = SceneSpikeLifecycleState.initial();
    final active = reducer.reduce(
      state: detached,
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    final background = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.backgrounded(),
    );
    final rebuilding = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );

    final transitions = [
      (
        name: 'detached + attached',
        state: detached,
        event: const SceneSpikeLifecycleEvent.attached(),
        phase: SceneSpikeLifecyclePhase.active,
        generation: 0,
        mayTick: true,
        mayUpload: true,
        requiresRebuild: false,
      ),
      (
        name: 'active + backgrounded',
        state: active,
        event: const SceneSpikeLifecycleEvent.backgrounded(),
        phase: SceneSpikeLifecyclePhase.background,
        generation: 0,
        mayTick: false,
        mayUpload: false,
        requiresRebuild: false,
      ),
      (
        name: 'background + foregrounded',
        state: background,
        event: const SceneSpikeLifecycleEvent.foregrounded(),
        phase: SceneSpikeLifecyclePhase.rebuilding,
        generation: 1,
        mayTick: false,
        mayUpload: false,
        requiresRebuild: true,
      ),
      (
        name: 'active + surfaceRecreated',
        state: active,
        event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
        phase: SceneSpikeLifecyclePhase.rebuilding,
        generation: 1,
        mayTick: false,
        mayUpload: false,
        requiresRebuild: true,
      ),
      (
        name: 'rebuilding + rebuildCompleted',
        state: rebuilding,
        event: const SceneSpikeLifecycleEvent.rebuildCompleted(),
        phase: SceneSpikeLifecyclePhase.active,
        generation: 1,
        mayTick: true,
        mayUpload: true,
        requiresRebuild: false,
      ),
      for (final state in [active, background, rebuilding])
        (
          name: '${state.phase.name} + detached',
          state: state,
          event: const SceneSpikeLifecycleEvent.detached(),
          phase: SceneSpikeLifecyclePhase.detached,
          generation: state.appResourceGeneration,
          mayTick: false,
          mayUpload: false,
          requiresRebuild: false,
        ),
      for (final state in [detached, active, background, rebuilding])
        (
          name: '${state.phase.name} + disposed',
          state: state,
          event: const SceneSpikeLifecycleEvent.disposed(),
          phase: SceneSpikeLifecyclePhase.disposed,
          generation: state.appResourceGeneration,
          mayTick: false,
          mayUpload: false,
          requiresRebuild: false,
        ),
    ];

    for (final transition in transitions) {
      final result = reducer.reduce(
        state: transition.state,
        event: transition.event,
      );

      expect(result.phase, transition.phase, reason: transition.name);
      expect(
        result.appResourceGeneration,
        transition.generation,
        reason: transition.name,
      );
      expect(result.mayTick, transition.mayTick, reason: transition.name);
      expect(result.mayUpload, transition.mayUpload, reason: transition.name);
      expect(
        result.requiresResourceRebuild,
        transition.requiresRebuild,
        reason: transition.name,
      );
    }
  });

  test('returns the same state for every idempotent transition edge', () {
    final active = reducer.reduce(
      state: SceneSpikeLifecycleState.initial(),
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    final background = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.backgrounded(),
    );
    final rebuilding = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );
    final disposed = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.disposed(),
    );
    final transitions = [
      (
        name: 'background + backgrounded',
        state: background,
        event: const SceneSpikeLifecycleEvent.backgrounded(),
      ),
      (
        name: 'active + foregrounded',
        state: active,
        event: const SceneSpikeLifecycleEvent.foregrounded(),
      ),
      (
        name: 'rebuilding + foregrounded',
        state: rebuilding,
        event: const SceneSpikeLifecycleEvent.foregrounded(),
      ),
      (
        name: 'disposed + disposed',
        state: disposed,
        event: const SceneSpikeLifecycleEvent.disposed(),
      ),
    ];

    for (final transition in transitions) {
      expect(
        reducer.reduce(state: transition.state, event: transition.event),
        same(transition.state),
        reason: transition.name,
      );
    }
  });

  test('rejects every transition missing from the transition table', () {
    final detached = SceneSpikeLifecycleState.initial();
    final active = reducer.reduce(
      state: detached,
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    final background = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.backgrounded(),
    );
    final rebuilding = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );
    final disposed = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.disposed(),
    );
    final transitions = [
      for (final event in const [
        SceneSpikeLifecycleEvent.backgrounded(),
        SceneSpikeLifecycleEvent.foregrounded(),
        SceneSpikeLifecycleEvent.surfaceRecreated(),
        SceneSpikeLifecycleEvent.rebuildCompleted(),
        SceneSpikeLifecycleEvent.detached(),
      ])
        (state: detached, event: event),
      for (final event in const [
        SceneSpikeLifecycleEvent.attached(),
        SceneSpikeLifecycleEvent.rebuildCompleted(),
      ])
        (state: active, event: event),
      for (final event in const [
        SceneSpikeLifecycleEvent.attached(),
        SceneSpikeLifecycleEvent.surfaceRecreated(),
        SceneSpikeLifecycleEvent.rebuildCompleted(),
      ])
        (state: background, event: event),
      for (final event in const [
        SceneSpikeLifecycleEvent.attached(),
        SceneSpikeLifecycleEvent.backgrounded(),
        SceneSpikeLifecycleEvent.surfaceRecreated(),
      ])
        (state: rebuilding, event: event),
      for (final event in const [
        SceneSpikeLifecycleEvent.attached(),
        SceneSpikeLifecycleEvent.backgrounded(),
        SceneSpikeLifecycleEvent.foregrounded(),
        SceneSpikeLifecycleEvent.surfaceRecreated(),
        SceneSpikeLifecycleEvent.rebuildCompleted(),
        SceneSpikeLifecycleEvent.detached(),
      ])
        (state: disposed, event: event),
    ];

    expect(transitions, hasLength(19));
    for (final transition in transitions) {
      expect(
        () => reducer.reduce(
          state: transition.state,
          event: transition.event,
        ),
        throwsStateError,
      );
    }
  });

  test('increments only the app-owned resource generation', () {
    final active = reducer.reduce(
      state: SceneSpikeLifecycleState.initial(),
      event: const SceneSpikeLifecycleEvent.attached(),
    );
    final rebuildingAfterSurface = reducer.reduce(
      state: active,
      event: const SceneSpikeLifecycleEvent.surfaceRecreated(),
    );
    final rebuilt = reducer.reduce(
      state: rebuildingAfterSurface,
      event: const SceneSpikeLifecycleEvent.rebuildCompleted(),
    );
    final background = reducer.reduce(
      state: rebuilt,
      event: const SceneSpikeLifecycleEvent.backgrounded(),
    );
    final rebuildingAfterForeground = reducer.reduce(
      state: background,
      event: const SceneSpikeLifecycleEvent.foregrounded(),
    );

    expect(rebuildingAfterSurface.appResourceGeneration, 1);
    expect(rebuildingAfterForeground.appResourceGeneration, 2);
  });

  test('rejects invalid state instead of silently normalizing it', () {
    final invalidStates = [
      const SceneSpikeLifecycleState.internal(
        phase: .detached,
        appResourceGeneration: -1,
        mayTick: false,
        mayUpload: false,
        requiresResourceRebuild: false,
      ),
      const SceneSpikeLifecycleState.internal(
        phase: .active,
        appResourceGeneration: 0,
        mayTick: false,
        mayUpload: true,
        requiresResourceRebuild: false,
      ),
    ];

    for (final state in invalidStates) {
      expect(
        () => reducer.reduce(
          state: state,
          event: const SceneSpikeLifecycleEvent.disposed(),
        ),
        throwsStateError,
      );
    }
  });
}
