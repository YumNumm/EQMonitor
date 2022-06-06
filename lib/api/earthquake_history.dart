import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:eqmonitor/model/eq_history_content.model.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logger/logger.dart';

class EarthQuakeHistoryApi {
  final Dio dio = Dio()
    ..options.baseUrl = baseUrl
    ..interceptors.add(LogInterceptor())
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
        // Ignore bad certificate
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    );

  final _logger = Logger();

  Future<List<EQHistoryContent>?> fetch(int count) async {
    final res = await dio.get<List<dynamic>>(
      '/eqhistory/$count.json',
    );
    if (res.statusCode == 200) {
      _logger.i(res.data!.length);
    } else {
      throw HttpExceptionWithStatus(
        res.statusCode ?? 500,
        res.statusMessage ?? res.realUri.path,
      );
    }
    return null;
  }

  Future<int?> fetchCount() async {
    final res = await dio.get<String>(
      '/eqhistory/total.txt',
    );
    return int.tryParse(res.data.toString());
  }
}
