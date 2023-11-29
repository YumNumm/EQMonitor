import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/information_v3.dart';
import 'package:retrofit/retrofit.dart';

part 'eqapi_client.g.dart';

class EqApi {
  EqApi({
    required this.dio,
    required this.baseUrl,
  });

  final Dio dio;
  final String baseUrl;

  V3 get v3 => V3(dio, baseUrl: baseUrl);
  PrivateV3 get privateV3 => throw UnimplementedError(
        "privateV3 feature is not implemented on public EqApi package",
      );
}

@RestApi()
abstract class V3 {
  factory V3(Dio dio, {String baseUrl}) = _V3;

  @GET('/v3/telegram')
  Future<TelegramHistoryV3> getTelegramHistoryV3({
    @Query('includeEew') bool includeEew = false,
    @Query('limit') int limit = 100,
    @Query('offset') int offset = 0,
  });

  @GET('/v3/information')
  Future<InformationV3Result> getInformationV3({
    @Query("after") int after = 0,
    @Query("limit") int limit = 10,
  });
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
