import 'package:dio/dio.dart';
import 'package:eqapi_client/src/v2/v2_clients.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

export 'v2/v2_clients.dart';

part 'eqapi_client.g.dart';

/// EQ APIクライアント
class EqApi {
  EqApi({required this.dio});

  final Dio dio;

  /// デバイスAPI
  DeviceApiClient get device => DeviceApiClient(dio);

  /// 地震情報API
  EarthquakeApiClient get earthquake => EarthquakeApiClient(dio);

  /// 緊急地震速報API
  EewApiClient get eew => EewApiClient(dio);

  /// 電文API
  TelegramApiClient get telegram => TelegramApiClient(dio);

  /// ユーザーAPI
  UserApiClient get user => UserApiClient(dio);

  /// WebSocket API
  WebsocketApiClient get websocket => WebsocketApiClient(dio);

  /// V3 API (互換性維持)
  V3 get v3 => V3(dio);
}

/// V3 API (互換性維持)
@RestApi()
abstract class V3 {
  factory V3(Dio dio, {String baseUrl}) = _V3;

  @GET('/v3/information')
  Future<InformationV3Result> getInformation({
    @Query('offset') int offset = 0,
    @Query('limit') int limit = 10,
  });

  @GET('/v3/app_information')
  Future<AppInformation> getAppInformation();
}
