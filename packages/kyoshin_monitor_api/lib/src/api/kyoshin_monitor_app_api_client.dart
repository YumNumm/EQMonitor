import 'package:dio/dio.dart';
import 'package:kyoshin_monitor_api/src/model/app_api/real_time_data.dart';
import 'package:kyoshin_monitor_api/src/model/app_api/site_list.dart';
import 'package:retrofit/retrofit.dart';

part 'kyoshin_monitor_app_api_client.g.dart';

/// 強震モニタのアプリAPI用クライアント
@RestApi(baseUrl: 'http://kv.kmoni.bosai.go.jp/webservice/server')
abstract class KyoshinMonitorAppApiClient {
  factory KyoshinMonitorAppApiClient(Dio dio, {String? baseUrl}) =
      _KyoshinMonitorAppApiClient;

  /// 観測点一覧を取得
  ///
  /// [baseSerialNo] 基準となるシリアル番号
  @GET('/List.php')
  Future<SiteList> getSiteList({
    @Query('serialNo') required String baseSerialNo,
  });

  /// リアルタイムデータを取得
  ///
  /// [time] 取得する時間(yyyyMMddHHmmss)
  /// [type] データ種別
  /// - jma_int: 震度
  /// - accel: 加速度
  /// [isBehore] 地下かどうか
  @GET('/monitor.php')
  Future<RealTimeData> getRealTimeData({
    /// 時刻(yyyyMMddHHmmss)
    @Query('time') required String time,

    /// データ種別
    /// - jma_int: 震度
    /// - accel: 加速度
    @Query('type') required String type,

    /// 地下かどうか
    @Query('isBehore') bool? isBehore,
  });
}
