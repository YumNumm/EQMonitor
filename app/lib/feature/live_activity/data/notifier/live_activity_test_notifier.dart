import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_activity_test_notifier.g.dart';

class LiveActivityTestState {
  const LiveActivityTestState({
    this.eewScenario = api.Scenario.noto4reports,
    this.shakeScenario = api.Scenario.shakeGrowth,
    this.lastEewResult,
    this.lastShakeResult,
  });

  final api.Scenario eewScenario;
  final api.Scenario shakeScenario;
  final api.LiveActivityTestScenarioResponse? lastEewResult;
  final api.LiveActivityTestScenarioResponse? lastShakeResult;

  LiveActivityTestState copyWith({
    api.Scenario? eewScenario,
    api.Scenario? shakeScenario,
    api.LiveActivityTestScenarioResponse? lastEewResult,
    api.LiveActivityTestScenarioResponse? lastShakeResult,
  }) {
    return LiveActivityTestState(
      eewScenario: eewScenario ?? this.eewScenario,
      shakeScenario: shakeScenario ?? this.shakeScenario,
      lastEewResult: lastEewResult ?? this.lastEewResult,
      lastShakeResult: lastShakeResult ?? this.lastShakeResult,
    );
  }
}

@riverpod
class LiveActivityTestNotifier extends _$LiveActivityTestNotifier {
  static final runEewMutation = Mutation<api.LiveActivityTestScenarioResponse>();
  static final runShakeMutation = Mutation<api.LiveActivityTestScenarioResponse>();

  @override
  LiveActivityTestState build() => const LiveActivityTestState();

  void selectEewScenario(api.Scenario scenario) {
    state = state.copyWith(eewScenario: scenario);
  }

  void selectShakeScenario(api.Scenario scenario) {
    state = state.copyWith(shakeScenario: scenario);
  }

  Future<api.LiveActivityTestScenarioResponse> runEewScenario() async {
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(deviceRepositoryProvider.future);
    final result = await repo.triggerLiveActivityTestScenario(
      deviceId: deviceId,
      eventType: api.LiveActivityStartTrigger.eew,
      scenario: state.eewScenario,
    );
    final response = switch (result) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    state = state.copyWith(lastEewResult: response);
    return response;
  }

  Future<api.LiveActivityTestScenarioResponse> runShakeScenario() async {
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(deviceRepositoryProvider.future);
    final result = await repo.triggerLiveActivityTestScenario(
      deviceId: deviceId,
      eventType: api.LiveActivityStartTrigger.shakeDetection,
      scenario: state.shakeScenario,
    );
    final response = switch (result) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    state = state.copyWith(lastShakeResult: response);
    return response;
  }
}
