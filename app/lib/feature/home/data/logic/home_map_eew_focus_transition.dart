import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_map_eew_focus_transition.g.dart';

final class HomeMapEewFocusSession {
  const new({
    required this.eventIds,
    required this.isFocused,
  });

  static const initial = HomeMapEewFocusSession(
    eventIds: <String>{},
    isFocused: false,
  );

  final Set<String> eventIds;
  final bool isFocused;
}

final class HomeMapEewFocusDecision {
  const new({
    required this.session,
    required this.shouldFocus,
  });

  final HomeMapEewFocusSession session;
  final bool shouldFocus;
}

class HomeMapEewFocusTransition {
  const new();

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
