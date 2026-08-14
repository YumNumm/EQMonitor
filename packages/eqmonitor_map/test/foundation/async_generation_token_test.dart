import 'package:eqmonitor_map/src/foundation/async_generation_token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncGenerationOwner', () {
    test('concurrent tokens in one incarnation all stay current', () {
      final owner = AsyncGenerationOwner();
      final first = owner.begin();
      final second = owner.begin();

      expect(first.isCurrent, isTrue);
      expect(
        second.isCurrent,
        isTrue,
        reason: 'begin must not retire earlier in-flight work',
      );
    });

    test('cancel retires every token issued in the same incarnation', () {
      final owner = AsyncGenerationOwner();
      final first = owner.begin();
      final second = owner.begin();
      owner.cancel();

      expect(first.isCurrent, isFalse);
      expect(second.isCurrent, isFalse);
    });

    test('cancel invalidates the outstanding token without throwing', () {
      final owner = AsyncGenerationOwner();
      final token = owner.begin();

      expect(owner.cancel, returnsNormally);
      expect(token.isCurrent, isFalse);

      final next = owner.begin();
      expect(next.isCurrent, isTrue);
    });

    test('dispose invalidates every token and blocks further begin', () {
      final owner = AsyncGenerationOwner();
      final token = owner.begin();

      owner.dispose();
      expect(token.isCurrent, isFalse);
      expect(owner.begin, throwsStateError);
    });

    test('token issued by another owner is never current', () {
      final owner = AsyncGenerationOwner();
      final other = AsyncGenerationOwner();
      final foreign = other.begin();

      expect(owner.isCurrent(foreign), isFalse);
    });
  });
}
