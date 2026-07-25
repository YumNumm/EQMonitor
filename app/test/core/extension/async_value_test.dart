// ignore_for_file: implementation_imports, invalid_use_of_internal_member

import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/internals.dart' show DataKind;

void main() {
  group('AsyncValueX.valueOrPrevious', () {
    test('再検証 loading 中は保持済みの値を返す', () {
      final value = const AsyncLoading<String>().copyWithPrevious(
        const AsyncData('stale', kind: DataKind.cache),
      );

      expect(value.valueOrPrevious, 'stale');
    });

    test('保持済みの値がない loading 中は null を返す', () {
      const value = AsyncLoading<String>();

      expect(value.valueOrPrevious, isNull);
    });

    test('再検証失敗 error 中は保持済みの値を返す', () {
      final value = AsyncError<String>(
        Exception('offline'),
        StackTrace.empty,
      ).copyWithPrevious(const AsyncData('stale'));

      expect(value.valueOrPrevious, 'stale');
    });
  });
}
