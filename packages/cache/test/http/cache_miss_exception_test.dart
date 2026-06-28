import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheMissException', () {
    test('toString contains class name', () {
      expect(
        const CacheMissException().toString(),
        contains('CacheMissException'),
      );
    });
  });

  group('isCacheMiss', () {
    test('returns true for CacheMissException directly', () {
      expect(isCacheMiss(const CacheMissException()), isTrue);
    });

    test('returns true for DioException wrapping CacheMissException', () {
      final error = DioException(
        requestOptions: RequestOptions(),
        error: const CacheMissException(),
      );
      expect(isCacheMiss(error), isTrue);
    });

    test('returns false for other exceptions', () {
      expect(isCacheMiss(Exception('other')), isFalse);
    });

    test('returns false for DioException with non-CacheMiss error', () {
      final error = DioException(
        requestOptions: RequestOptions(),
        error: 'network error',
      );
      expect(isCacheMiss(error), isFalse);
    });
  });
}
