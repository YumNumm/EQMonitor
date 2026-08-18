import 'package:dio/dio.dart';
import 'package:kyoshin_monitor_api/src/model/web_api/data_time.dart';
import 'package:kyoshin_monitor_api/src/model/web_api/eew.dart';
import 'package:retrofit/retrofit.dart';

part 'lpgm_kyoshin_monitor_web_api_client.g.dart';

@RestApi(baseUrl: 'https://www.lmoni.bosai.go.jp')
abstract class LpgmKyoshinMonitorWebApiClient {
  factory(Dio dio, {String baseUrl}) = _LpgmKyoshinMonitorWebApiClient;

  /// データ時間
  ///
  /// 長周期地震動モニタ自身のホストにあるサーバ時刻。
  /// `/monitor/webservice/...` には存在せず (500)、`/img_svr/` 配下にある。
  /// `/img_svr/` は lmoni ホスト上の強震モニタへのリバースプロキシで、
  /// 返る内容は強震モニタの `latest.json` と同一だが、画像と同一ホスト・
  /// 同一経路で測れるため往復時間の推定が実態に近くなる。
  ///
  /// 公式フロントエンド (`prism_longperiod.js`) もこのパスを使っている。
  @GET('/img_svr/webservice/server/pros/latest.json')
  Future<DataTime> getLatestDataTime();

  /// ベース画像
  ///
  /// [theme] 白(w), グレー(b)
  @GET('/monitor/data/data/map_img/CommonImg/base_map_{theme}.gif')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getBaseMapImageData({@Path('theme') required String theme});

  /// スケール
  ///
  /// [type] データ種別
  /// [layer] 地上(s), 地下(b)
  /// [theme] 白(w), グレー(b)
  @GET(
    '/monitor/data/data/map_img/ScaleImg2/nied_{type}_{layer}_{theme}_scale.gif',
  )
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getScaleImageData({
    @Path('type') required String type,
    @Path('layer') required String layer,
    @Path('theme') required String theme,
  });

  /// EewJson
  ///
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET('/monitor/webservice/hypo/eew/{dateTime}.json')
  Future<Eew> getJsonEew({@Path('dateTime') required String dateTime});

  /// PsWaveImg
  ///
  /// [date] 日付(yyyyMMdd)
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET('/monitor/data/data/map_img/PSWaveImg/eew/{date}/{dateTime}_eew.gif')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getPsWaveImageData({
    @Path('date') required String date,
    @Path('dateTime') required String dateTime,
  });

  /// 強震モニタ RealtimeImg
  ///
  /// [type] データ種別
  /// [layer] 地上(s), 地下(b)
  /// [date] 日付(yyyyMMdd)
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET(
    '/img_svr/data/map_img/RealTimeImg/'
    '{type}_{layer}/{date}/{dateTime}.{type}_{layer}.gif',
  )
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getKyoshinRealtimeImageData({
    @Path('type') required String type,
    @Path('layer') required String layer,
    @Path('date') required String date,
    @Path('dateTime') required String dateTime,
  });

  /// 長周期地震動モニタ RealtimeImg
  ///
  /// [type] データ種別
  /// [date] 日付(yyyyMMdd)
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET(
    '/monitor/data/data/map_img/RealTimeImg/'
    '{type}_s/{date}/{dateTime}.{type}_s.gif',
  )
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getLpgmRealtimeImageData({
    @Path('type') required String type,
    @Path('date') required String date,
    @Path('dateTime') required String dateTime,
  });
}
