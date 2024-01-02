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

  Future<EarthquakeParameter> getEarthquakeParameter() async {
    final buffer = await _client.getEarthquakeParameter();
    return EarthquakeParameter.fromBuffer(buffer);
  }

  Future<String> getEarthquakeParameterHead() async {
    final response = await _client.getEarthquakeParameterHead();
    return response.response.headers.value('etag')!;
  }

  Future<TsunamiParameter> getTsunamiParameter() async {
    final buffer = await _client.getTsunamiParameter();
    return TsunamiParameter.fromBuffer(buffer);
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

  @GET('parameter/earthquake')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getEarthquakeParameter();

  @HEAD('parameter/earthquake')
  Future<HttpResponse<void>> getEarthquakeParameterHead();

  @GET('parameter/tsunami')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getTsunamiParameter();

  @HEAD('parameter/tsunami')
  Future<HttpResponse<void>> getTsunamiParameterHead();
}
