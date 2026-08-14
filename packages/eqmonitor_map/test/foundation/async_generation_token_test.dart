import 'package:eqmonitor_map/src/foundation/async_generation_token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncGenerationOwner', () {
    test('freshly issued token is current until a newer one is issued', () {
      final owner = AsyncGenerationOwner();
      final first = owner.begin();
      expect(first.isCurrent, isTrue);

      final second = owner.begin();
      expect(second.isCurrent, isTrue);
      expect(first.isCurrent, isFalse);
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
