import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_map_realtime_focus_transition.g.dart';

final class const HomeMapRealtimeFocusSession({
  required final Set<String> eewEventIds,
  required final Set<String> shakeEventIds,
  required final bool isFocused,
}) {
  static const initial = HomeMapRealtimeFocusSession(
    eewEventIds: <String>{},
    shakeEventIds: <String>{},
    isFocused: false,
  );

  bool get hasTargets => eewEventIds.isNotEmpty || shakeEventIds.isNotEmpty;
}

final class const HomeMapRealtimeFocusDecision({
  required final HomeMapRealtimeFocusSession session,
  required final bool shouldFocus,
});

class const HomeMapRealtimeFocusTransition() {
  HomeMapRealtimeFocusDecision sync({
    required HomeMapRealtimeFocusSession previous,
    required Set<String> eewEventIds,
    required Set<String> shakeEventIds,
  }) {
    final currentEewEventIds = Set<String>.unmodifiable(eewEventIds);
    final currentShakeEventIds = Set<String>.unmodifiable(shakeEventIds);
    // EEW 発表中は、解除したフォーカスを揺れ検知の追加では再開しない。
    final hasNewEvent = currentEewEventIds.isEmpty
        ? currentShakeEventIds.any(
            (eventId) => !previous.shakeEventIds.contains(eventId),
          )
        : currentEewEventIds.any(
            (eventId) => !previous.eewEventIds.contains(eventId),
          );
    final hasTargets =
        currentEewEventIds.isNotEmpty || currentShakeEventIds.isNotEmpty;
    final isFocused = hasTargets && (previous.isFocused || hasNewEvent);
    return HomeMapRealtimeFocusDecision(
      session: HomeMapRealtimeFocusSession(
        eewEventIds: currentEewEventIds,
        shakeEventIds: currentShakeEventIds,
        isFocused: isFocused,
      ),
      shouldFocus: isFocused,
    );
  }

  HomeMapRealtimeFocusSession dismiss({
    required HomeMapRealtimeFocusSession previous,
  }) => HomeMapRealtimeFocusSession(
    eewEventIds: previous.eewEventIds,
    shakeEventIds: previous.shakeEventIds,
    isFocused: false,
  );

  HomeMapRealtimeFocusDecision refocus({
    required HomeMapRealtimeFocusSession previous,
  }) {
    final isFocused = previous.hasTargets;
    return HomeMapRealtimeFocusDecision(
      session: HomeMapRealtimeFocusSession(
        eewEventIds: previous.eewEventIds,
        shakeEventIds: previous.shakeEventIds,
        isFocused: isFocused,
      ),
      shouldFocus: isFocused,
    );
  }
}

@riverpod
HomeMapRealtimeFocusTransition homeMapRealtimeFocusTransition(Ref ref) =>
    const HomeMapRealtimeFocusTransition();
