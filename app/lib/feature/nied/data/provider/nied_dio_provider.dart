import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nied_dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio niedDio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      responseType: ResponseType.plain,
      contentType: ContentType.html.value,
    ),
  );
  return dio;
}
