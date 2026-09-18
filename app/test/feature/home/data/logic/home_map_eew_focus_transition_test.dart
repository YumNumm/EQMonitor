import 'package:eqmonitor/feature/home/data/logic/home_map_eew_focus_transition.dart';
import 'package:test/test.dart';

void main() {
  const transition = HomeMapEewFocusTransition();

  test('ユーザー解除後は同じEEWの更新でフォーカスを再開しない', () {
    final initial = transition.sync(
      previous: HomeMapEewFocusSession.initial,
      eventIds: const {'event-a'},
    );
    final dismissed = transition.dismiss(previous: initial.session);

    final updated = transition.sync(
      previous: dismissed,
      eventIds: const {'event-a'},
    );

    expect(updated.shouldFocus, isFalse);
    expect(updated.session.isFocused, isFalse);
  });

  test('ユーザー解除後でも新しいEEWが追加されたらフォーカスを再開する', () {
    final dismissed = transition.dismiss(
      previous: const HomeMapEewFocusSession(
        eventIds: {'event-a'},
        isFocused: true,
      ),
    );

    final updated = transition.sync(
      previous: dismissed,
      eventIds: const {'event-a', 'event-b'},
    );

    expect(updated.shouldFocus, isTrue);
    expect(updated.session.isFocused, isTrue);
  });

  test('ホーム操作は生存中のEEWへフォーカスを再開する', () {
    final dismissed = transition.dismiss(
      previous: const HomeMapEewFocusSession(
        eventIds: {'event-a'},
        isFocused: true,
      ),
    );

    final refocused = transition.refocus(previous: dismissed);

    expect(refocused.shouldFocus, isTrue);
    expect(refocused.session.isFocused, isTrue);
  });
}
