import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_transition.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_state.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_map_focus.g.dart';

@Riverpod(keepAlive: true)
class EewMapFocus extends _$EewMapFocus {
  @override
  EewMapFocusState build() => const EewMapFocusState();

  EewMapFocusDecision sync() {
    final decision = ref.read(eewMapFocusTransitionProvider).evaluate(
      previous: state,
      aliveEews: ref.read(eewAliveTelegramProvider) ?? const [],
      allShakes: ref.read(shakeDetectionProvider),
    );
    state = decision.state;
    return decision;
  }

  void clearFocus() {
    state = ref.read(eewMapFocusTransitionProvider).clearFocus(previous: state);
  }

  EewMapFocusDecision refocus() {
    final decision = ref.read(eewMapFocusTransitionProvider).refocus(
      previous: state,
      aliveEews: ref.read(eewAliveTelegramProvider) ?? const [],
      allShakes: ref.read(shakeDetectionProvider),
    );
    state = decision.state;
    return decision;
  }
}
