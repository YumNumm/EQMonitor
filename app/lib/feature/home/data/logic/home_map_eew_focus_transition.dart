import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_map_eew_focus_transition.g.dart';

final class const HomeMapEewFocusSession({
  required final Set<String> eventIds,
  required final bool isFocused,
}) {
  static const initial = HomeMapEewFocusSession(
    eventIds: <String>{},
    isFocused: false,
  );
}

final class const HomeMapEewFocusDecision({
  required final HomeMapEewFocusSession session,
  required final bool shouldFocus,
});

class const HomeMapEewFocusTransition() {
  HomeMapEewFocusDecision sync({
    required HomeMapEewFocusSession previous,
    required Set<String> eventIds,
  }) {
    final currentEventIds = Set<String>.unmodifiable(eventIds);
    final hasNewEvent = currentEventIds.any(
      (eventId) => !previous.eventIds.contains(eventId),
    );
    final isFocused =
        currentEventIds.isNotEmpty && (previous.isFocused || hasNewEvent);
    return HomeMapEewFocusDecision(
      session: HomeMapEewFocusSession(
        eventIds: currentEventIds,
        isFocused: isFocused,
      ),
      shouldFocus: isFocused,
    );
  }

  HomeMapEewFocusSession dismiss({
    required HomeMapEewFocusSession previous,
  }) => HomeMapEewFocusSession(
    eventIds: previous.eventIds,
    isFocused: false,
  );

  HomeMapEewFocusDecision refocus({
    required HomeMapEewFocusSession previous,
  }) {
    final isFocused = previous.eventIds.isNotEmpty;
    return HomeMapEewFocusDecision(
      session: HomeMapEewFocusSession(
        eventIds: previous.eventIds,
        isFocused: isFocused,
      ),
      shouldFocus: isFocused,
    );
  }
}

@riverpod
HomeMapEewFocusTransition homeMapEewFocusTransition(Ref ref) =>
    const HomeMapEewFocusTransition();
