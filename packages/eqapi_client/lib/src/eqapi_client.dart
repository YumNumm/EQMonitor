import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:retrofit/retrofit.dart';

part 'eqapi_client.g.dart';

class EqApi {
  EqApi({
    required this.dio,
  });

  final Dio dio;

  @Deprecated('Earthquake API v3 is deprecated.')
  V3 get v3 => V3(dio);
  @Deprecated('Earthquake API v3 is deprecated.')
  PrivateV3 get privateV3 => throw UnimplementedError(
        'privateV3 feature is not implemented on public EqApi package',
      );
}

@RestApi()
abstract class V1 {
  factory V1(Dio dio, {String baseUrl}) = _V1;

  @GET('/v1/earthquake')
  Future<List<EarthquakeV1>> getEarthquake({
    /// 1~100
    @Query('limit') int limit = 100,

    /// 0~100000
    @Query('offset') int offset = 0,

    /// 0~10
    @Query('magnitudeLte') double? magnitudeLte,

    /// 0~10
    @Query('magnitudeGte') double? magnitudeGte,

    /// 0~1000
    @Query('depthLte') double? depthLte,

    /// 0~1000
    @Query('depthGte') double? depthGte,
    @Query('intensityLte') JmaIntensity? intensityLte,
    @Query('intensityGte') JmaIntensity? intensityGte,
  });
}

@Deprecated('Earthquake API v3 is deprecated.')
@RestApi()
abstract class V3 {
  factory V3(Dio dio, {String baseUrl}) = _V3;

  @GET('/v3/telegram')
  Future<TelegramHistoryV3> getTelegramHistory({
    @Query('includeEew') bool includeEew = false,
    @Query('limit') int limit = 100,
    @Query('offset') int offset = 0,
  });

  @GET('/v3/information')
  Future<InformationV3Result> getInformation({
    @Query('offset') int offset = 0,
    @Query('limit') int limit = 10,
  });

  @GET('/v3/app_information')
  Future<AppInformation> getAppInformation();
}

@Deprecated('Earthquake API v3 is deprecated.')
abstract class PrivateV3 {
  Future<void> addTelegram({
    required TelegramV3 telegram,
    required String authorization,
  });

  Future<void> addTelegrams({
    required List<TelegramV3> telegrams,
    required String authorization,
  });

  Future<int> connectionCount({
    required String authorization,
  });
}
