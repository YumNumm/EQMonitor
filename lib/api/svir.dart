import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:eqmonitor/schema/svir/svirResponse.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logger/logger.dart';

class SvirApi {
  final Dio dio = Dio()
    ..options.baseUrl = 'https://svir.jp'
    ..interceptors.add(LogInterceptor())
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
        // Ignore bad certificate
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    );

  // final _logger = Logger();

  Future<SvirResponse> getData() async {
    final res = await dio.get<List<int>>(
      '/eew/data.json',
      options: Options(responseType: ResponseType.bytes),
    );
    if (res.statusCode != 200) {
      throw HttpExceptionWithStatus(
        res.statusCode ?? 500,
        res.statusMessage ?? res.realUri.path,
      );
    }
    final j = json.decode(utf8.decode(res.data ?? [])) as Map<String, dynamic>;
    return SvirResponse.fromJson(j);
  }
}
