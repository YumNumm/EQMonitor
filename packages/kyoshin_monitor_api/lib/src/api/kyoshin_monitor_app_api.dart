import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'kyoshin_monitor_app_api.g.dart';

@RestApi()
abstract class KyoshinMonitorAppApiApiClient {
  factory KyoshinMonitorAppApiApiClient(
    Dio dio, {
    String baseUrl,
  }) = _KyoshinMonitorAppApiApiClient;

  @GET('/path')
  Future<ResponseType> methodName();
}

@JsonEnum(valueField: 'value')
enum KyoshinMonitorAppApiUrlType {
  /// リアルタイム情報
  /// 震度・加速度など
  realtimeData('RealtimeData'),

  /// 緊急地震速報の到達予想震度
  @Deprecated('このAPIは廃止済みです')
  hypoInfoJson('HypoInfoJson'),

  /// 緊急地震速報のP, S波の到達予想円
  @Deprecated('このAPIは廃止済みです')
  psWaveJson('PSWaveJson'),

  /// 緊急地震速報の予想震度
  @Deprecated('このAPIは廃止済みです')
  estShindoJson('EstShindoJson'),
  ;

  const KyoshinMonitorAppApiUrlType(this.value);
  final String value;
}
