import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:eqmonitor/model/eq_history_content.model.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class EarthQuakeHistoryApi {
  Dio dio = Dio()
    ..options.baseUrl = baseUrl
    ..interceptors.add(LogInterceptor())
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
        // Ignore bad certificate
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    )
    ..interceptors.add(
      PrettyDioLogger(),
    );

  Future<List<EQHistoryContent>?> fetch(int count) async {
    final res = await dio.get<List<dynamic>>(
      '/eqhistory/$count.json',
    );
    if (res.statusCode == 200) {
      final datas = res.data!;
      return datas
          .map<EQHistoryContent>(
            (e) => EQHistoryContent.fromJson(jsonDecode(e)),
          )
          .toList();
    }
      throw HttpExceptionWithStatus(
        res.statusCode ?? 500,
        res.statusMessage ?? res.realUri.path,
      );
  }

  Future<int?> fetchCount() async {
    final res = await dio.get<int>(
      '/eqhistory/total.txt',
    );
    return res.data;
  }
}
