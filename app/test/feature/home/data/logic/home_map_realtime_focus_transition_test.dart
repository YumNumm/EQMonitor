import 'package:eqmonitor/feature/home/data/logic/home_map_realtime_focus_transition.dart';
import 'package:test/test.dart';

void main() {
  const transition = HomeMapRealtimeFocusTransition();

  test('ユーザー解除後は同じEEWの更新でフォーカスを再開しない', () {
    final initial = transition.sync(
      previous: HomeMapRealtimeFocusSession.initial,
      eewEventIds: const {'event-a'},
      shakeEventIds: const {},
    );
    final dismissed = transition.dismiss(previous: initial.session);

    final updated = transition.sync(
      previous: dismissed,
      eewEventIds: const {'event-a'},
      shakeEventIds: const {},
    );

    expect(updated.shouldFocus, isFalse);
    expect(updated.session.isFocused, isFalse);
  });

  test('ユーザー解除後でも新しいEEWが追加されたらフォーカスを再開する', () {
    final dismissed = transition.dismiss(
      previous: const HomeMapRealtimeFocusSession(
        eewEventIds: {'event-a'},
        shakeEventIds: {},
        isFocused: true,
      ),
    );

    final updated = transition.sync(
      previous: dismissed,
      eewEventIds: const {'event-a', 'event-b'},
      shakeEventIds: const {},
    );

    expect(updated.shouldFocus, isTrue);
    expect(updated.session.isFocused, isTrue);
  });

  test('ホーム操作は生存中のEEWへフォーカスを再開する', () {
    final dismissed = transition.dismiss(
      previous: const HomeMapRealtimeFocusSession(
        eewEventIds: {'event-a'},
        shakeEventIds: {},
        isFocused: true,
      ),
    );

    final refocused = transition.refocus(previous: dismissed);

    expect(refocused.shouldFocus, isTrue);
    expect(refocused.session.isFocused, isTrue);
  });
}
