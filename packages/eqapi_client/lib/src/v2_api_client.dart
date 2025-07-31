import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'v2_api_client.g.dart';

@RestApi()
abstract class V2ApiClient {
  factory V2ApiClient(Dio dio, {String baseUrl}) = _V2ApiClient;

  @GET('/v2/tsunami')
  Future<HttpResponse<TsunamiSummaryResponse>> getTsunamiSummary();
}
