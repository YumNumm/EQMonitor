import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
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
  // Hi-net のフォーム認証(`_ssl_auth` Cookie)をセッション中保持するため、
  // メモリ上の CookieJar を利用する(アプリ再起動で失効して問題ない)。
  dio.interceptors.add(CookieManager(CookieJar()));
  return dio;
}
