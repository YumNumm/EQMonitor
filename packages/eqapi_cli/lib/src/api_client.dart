import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqapi_client/eqapi_client.dart';

class ApiClient {
  static Dio? _dio;
  static EqApi? _api;

  static String get _baseUrl {
    final url = Platform.environment['EQAPI_BASE_URL'];
    if (url == null || url.isEmpty) {
      throw StateError('環境変数 EQAPI_BASE_URL が設定されていません');
    }
    return url;
  }

  static Dio get dio {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    return _dio!;
  }

  static EqApi get api {
    _api ??= EqApi(dio: dio);
    return _api!;
  }

  static void dispose() {
    _dio?.close();
    _dio = null;
    _api = null;
  }
}
