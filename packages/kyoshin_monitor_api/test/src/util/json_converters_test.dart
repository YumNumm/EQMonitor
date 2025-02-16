import 'package:kyoshin_monitor_api/src/util/json_converters.dart';
import 'package:test/test.dart';

void main() {
  group('dateTimeFromString', () {
    test('正常な日時文字列からDateTimeに変換できる', () {
      final result = dateTimeOrNullFromString(
        '2024-03-20T12:34:56Z',
      );
      expect(result, isA<DateTime>());
      expect(result?.year, 2024);
      expect(result?.month, 3);
      expect(result?.day, 20);
      expect(result?.hour, 12);
      expect(result?.minute, 34);
      expect(result?.second, 56);
    });

    test('nullの場合はnullを返す', () {
      expect(dateTimeOrNullFromString(null), isNull);
    });

    test('不正な日時文字列の場合はnullを返す', () {
      expect(dateTimeOrNullFromString('invalid'), isNull);
    });
  });

  group('doubleOrNullFromString', () {
    test('数値文字列からdoubleに変換できる', () {
      expect(doubleOrNullFromString('123.45'), 123.45);
    });

    test('整数文字列からdoubleに変換できる', () {
      expect(doubleOrNullFromString('123'), 123.0);
    });

    test('nullの場合はnullを返す', () {
      expect(doubleOrNullFromString(null), isNull);
    });

    test('不正な数値文字列の場合はnullを返す', () {
      expect(doubleOrNullFromString('invalid'), isNull);
    });
  });

  group('intFromString', () {
    test('整数文字列からintに変換できる', () {
      expect(intFromString('123'), 123);
    });

    test('nullの場合はnullを返す', () {
      expect(intFromString(null), isNull);
    });

    test('不正な整数文字列の場合はnullを返す', () {
      expect(intFromString('invalid'), isNull);
    });

    test('小数文字列の場合はnullを返す', () {
      expect(intFromString('123.45'), isNull);
    });
  });

  group('boolFromDynamic', () {
    test('bool値をそのまま返す', () {
      expect(boolFromDynamic(true), isTrue);
      expect(boolFromDynamic(false), isFalse);
    });

    test('文字列からboolに変換できる', () {
      expect(boolFromDynamic('true'), isTrue);
      expect(boolFromDynamic('TRUE'), isTrue);
      expect(boolFromDynamic('1'), isTrue);
      expect(boolFromDynamic('false'), isFalse);
      expect(boolFromDynamic('FALSE'), isFalse);
      expect(boolFromDynamic('0'), isFalse);
    });

    test('数値からboolに変換できる', () {
      expect(boolFromDynamic(1), isTrue);
      expect(boolFromDynamic(0), isFalse);
    });

    test('nullの場合はnullを返す', () {
      expect(boolFromDynamic(null), isNull);
    });

    test('不正な値の場合はnullを返す', () {
      expect(boolFromDynamic('invalid'), isFalse);
    });
  });

  group('depthFromString', () {
    test('深さ文字列からintに変換できる', () {
      expect(depthFromString('10km'), 10);
    });

    test('kmがない場合も変換できる', () {
      expect(depthFromString('10'), 10);
    });

    test('nullの場合はnullを返す', () {
      expect(depthFromString(null), isNull);
    });

    test('不正な深さ文字列の場合はnullを返す', () {
      expect(depthFromString('invalid'), isNull);
    });
  });

  group('originTimeFromString', () {
    test('yyyyMMddHHmmss形式の文字列からDateTimeに変換できる', () {
      final result = originTimeFromString('20240320123456');
      expect(result, isA<DateTime>());
      expect(result?.year, 2024);
      expect(result?.month, 3);
      expect(result?.day, 20);
      expect(result?.hour, 12);
      expect(result?.minute, 34);
      expect(result?.second, 56);
    });

    test('nullの場合はnullを返す', () {
      expect(originTimeFromString(null), isNull);
    });

    test('不正な文字列の場合はnullを返す', () {
      expect(originTimeFromString('invalid'), isNull);
      expect(originTimeFromString('2024'), isNull);
      expect(originTimeFromString('202403201234'), isNull);
    });
  });
}
