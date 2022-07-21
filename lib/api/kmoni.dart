import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:intl/intl.dart';

import '../schema/kmoni/EEW.dart';

class KyoshinMonitorApi {
  final Dio dio = Dio()
    ..options.baseUrl = 'http://www.kmoni.bosai.go.jp'
    ..options.connectTimeout = 5000
    //..interceptors.add(LogInterceptor())
    //..httpClientAdapter = Http2Adapter(
    //  ConnectionManager(
    //    idleTimeout: 1000,
    //
    //    // Ignore bad certificate
    //   // onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
    //  ),
    //);
    ;

  // final _logger = Logger();

  /// 強震モニタ サーバ側の最新時刻を取得します
  Future<DateTime> getLatestDateTime() async {
    final res = await dio.get<List<int>>(
      '/webservice/server/pros/latest.json',
      options: Options(responseType: ResponseType.bytes),
    );
    if (res.statusCode != 200) {
      throw Exception(
        'HttpException Status: ${res.statusCode}, msg: ${res.statusMessage}',
      );
    }
    // ちゃんと取得できていることが期待されるのでJsonParse
    final df = DateFormat('yyyy/MM/dd HH:mm:ss');
    final j = jsonDecode(utf8.decode(res.data ?? []));
    final dt = df.parseStrict(j['latest_time'].toString());
    return dt;
  }

  /// 強震モニタのEEWAPIから[targetDateTime]に対応するEEWDataを取得します。
  /// Statusが200以外を返した場合に例外`HttpExceptionWithStatus`が発生します。
  Future<KyoshinEEW> getKyoshinMonitorEEW(DateTime targetDateTime) async {
    final ymdhms = DateFormat('yyyyMMddHHmmss');
    // GET http://www.kmoni.bosai.go.jp/webservice/hypo/eew/${timestamp}.json
    // {timestamp} = YYYYMMDDHHmmss
    // https://qiita.com/smmy/items/78c77e5fa24245f202af
    final res = await dio.get<List<int>>(
      'webservice/hypo/eew/${ymdhms.format(targetDateTime)}.json',
      options: Options(responseType: ResponseType.bytes),
    );
    if (res.statusCode != 200) {
      throw Exception([
        res.statusCode ?? 500,
        res.statusMessage ?? res.realUri.path,
      ]);
    }
    final j = jsonDecode(utf8.decode(res.data ?? []));
    return KyoshinEEW.fromJson(j);
  }

  /// 強震モニタのAPIを叩く
  /// [url]には`kmoni.bosai.go.jp`以降を入力
  Future<Response<List<int>>> getRawData(String url) async {
    return await dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
  }
}
