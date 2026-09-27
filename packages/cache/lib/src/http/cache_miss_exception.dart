import 'package:dio/dio.dart';

class const CacheMissException() implements Exception {
  @override
  String toString() => 'CacheMissException: No cached response found';
}

bool isCacheMiss(Object error) =>
    error is CacheMissException ||
    (error is DioException && error.error is CacheMissException);
