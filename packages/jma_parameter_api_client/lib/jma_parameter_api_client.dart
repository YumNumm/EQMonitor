// ignore_for_file: unused_element

import 'package:dio/dio.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';
import 'package:jma_parameter_types/tsunami_param.pb.dart';
import 'package:retrofit/retrofit.dart';

export 'package:jma_parameter_types/earthquake_param.pb.dart';
export 'package:jma_parameter_types/tsunami_param.pb.dart';

part 'jma_parameter_api_client.g.dart';

class JmaParameterApiClient {
  JmaParameterApiClient({required Dio client})
      : _client = _JmaParameterApiClient(client);

  final _JmaParameterApiClient _client;

  Future<
      ({
        EarthquakeParameter parameter,
        String? etag,
      })> getEarthquakeParameter() async {
    final res = await _client.getEarthquakeParameter();
    return (
      parameter: EarthquakeParameter.fromBuffer(res.data),
      etag: res.response.headers.value('etag'),
    );
  }

  Future<String?> getEarthquakeParameterHead() async {
    final response = await _client.getEarthquakeParameterHead();
    return response.response.headers.value('etag');
  }

  Future<
      ({
        TsunamiParameter parameter,
        String? etag,
      })> getTsunamiParameter() async {
    final response = await _client.getTsunamiParameter();
    return (
      parameter: TsunamiParameter.fromBuffer(response.data),
      etag: response.response.headers.value('etag'),
    );
  }

  Future<String?> getTsunamiParameterHeadEtag() async {
    final response = await _client.getTsunamiParameterHead();
    return response.response.headers.value('etag');
  }
}

@RestApi()
abstract class _JmaParameterApiClient {
  factory _JmaParameterApiClient(Dio dio, {String baseUrl}) =
      __JmaParameterApiClient;

  @GET('/parameter/earthquake')
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> getEarthquakeParameter();

  @HEAD('/parameter/earthquake')
  Future<HttpResponse<void>> getEarthquakeParameterHead();

  @GET('/parameter/tsunami')
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> getTsunamiParameter();

  @HEAD('/parameter/tsunami')
  Future<HttpResponse<void>> getTsunamiParameterHead();
}
