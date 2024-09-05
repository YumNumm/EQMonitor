import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'objects.g.dart';

@RestApi()
abstract class Objects {
  factory Objects(Dio dio, {String baseUrl}) = _Objects;

  @GET('/earthquake-early/{id}.json')
  Future<HttpResponse<EarthquakeEarlyEvent>> getEarthquakeEarlyEvent({
    @Path('id') required String id,
  });
}
