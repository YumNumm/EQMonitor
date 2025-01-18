import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:kyoshin_monitor_api/src/model/web_api/eew.dart';
import 'package:retrofit/retrofit.dart';

part 'kyoshin_monitor_web_api_client.g.dart';

/// 強震モニタのウェブAPI用クライアント
@RestApi(baseUrl: 'http://www.kmoni.bosai.go.jp')
abstract class KyoshinMonitorWebApiClient {
  factory KyoshinMonitorWebApiClient(Dio dio, {String? baseUrl}) =
      _KyoshinMonitorWebApiClient;

  /// ベース画像
  ///
  /// [theme] 白(w), グレー(b)
  @GET('/data/map_img/CommonImg/base_map_{theme}.gif')
  Future<Uint8List> getBaseMapImageData({
    @Path('theme') required String theme,
  });


  /// スケール
  ///
  /// [type] データ種別
  /// [layer] 地上(s), 地下(b)
  /// [theme] 白(w), グレー(b)
  @GET('/data/map_img/ScaleImg/nied_{type}_{layer}_{theme}_scale.gif')
  Future<Uint8List> getScaleImageData({
    @Path('type') required String type,
    @Path('layer') required String layer,
    @Path('theme') required String theme,
  });

  /// JsonEew
  ///
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET('/webservice/hypo/eew/{dateTime}.json')
  Future<Eew> getJsonEew({
    @Path('dateTime') required String dateTime,
  });

  /// PsWaveImg
  ///
  /// [date] 日付(yyyyMMdd)
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET('/data/map_img/PSWaveImg/eew/{date}/{dateTime}.gif')
  Future<Uint8List> getPsWaveImageData({
    @Path('date') required String date,
    @Path('dateTime') required String dateTime,
  });

  /// RealtimeImg
  ///
  /// [type] データ種別
  /// [layer] 地上(s), 地下(b)
  /// [date] 日付(yyyyMMdd)
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET(
    '/data/map_img/RealtimeImg/{type}_{layer}/{date}/{dateTime}.{type}_{layer}.gif',
  )
  Future<Uint8List> getRealtimeImageData({
    @Path('type') required String type,
    @Path('layer') required String layer,
    @Path('date') required String date,
    @Path('dateTime') required String dateTime,
  });

  /// 予想震度のベースURL
  ///
  /// [date] 日付(yyyyMMdd)
  /// [dateTime] 日付(yyyyMMddHHmmss)
  @GET('/data/map_img/EstShindoImg/eew/{date}/{dateTime}.eew.gif')
  Future<Uint8List> getEstShindoImageData({
    @Path('date') required String date,
    @Path('dateTime') required String dateTime,
  });
}
