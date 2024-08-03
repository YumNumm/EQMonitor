import 'package:dio/dio.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
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
