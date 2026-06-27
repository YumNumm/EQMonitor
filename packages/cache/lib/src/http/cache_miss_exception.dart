import 'package:dio/dio.dart';

class CacheMissException implements Exception {
  const CacheMissException();

  @override
  String toString() => 'CacheMissException: No cached response found';
}

bool isCacheMiss(Object error) =>
    error is CacheMissException ||
    (error is DioException && error.error is CacheMissException);
