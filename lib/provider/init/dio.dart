import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final DioProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ),
  )..httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
      ),
    ),
);
