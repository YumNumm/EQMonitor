import 'package:eqmonitor/core/util/nullable_value_requirement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('orFailBecause', () {
    test('非 null の値はそのまま返す', () {
      const int? value = 42;
      expect(value.orFailBecause('テスト'), 42);
    });

    test('null の場合は理由を含む StateError を投げる', () {
      const String? value = null;
      expect(
        () => value.orFailBecause('直前に containsKey で存在を確認済み'),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('直前に containsKey で存在を確認済み'),
          ),
        ),
      );
    });

    test('false や 0 は null ではないのでそのまま返す', () {
      const bool? falseValue = false;
      const int? zero = 0;
      expect(falseValue.orFailBecause('テスト'), isFalse);
      expect(zero.orFailBecause('テスト'), 0);
    });
  });
}
