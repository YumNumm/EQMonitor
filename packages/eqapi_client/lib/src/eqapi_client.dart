import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/app_information.dart';
import 'package:eqapi_types/model/information_v3.dart';
import 'package:retrofit/retrofit.dart';

part 'eqapi_client.g.dart';

class EqApi {
  EqApi({
    required this.dio,
  });

  final Dio dio;

  V3 get v3 => V3(dio);
  PrivateV3 get privateV3 => throw UnimplementedError(
        "privateV3 feature is not implemented on public EqApi package",
      );
}

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
    @Query("after") int after = 0,
    @Query("limit") int limit = 10,
  });

  @GET('/v3/app_information')
  Future<AppInformation> getAppInformation();
}

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
