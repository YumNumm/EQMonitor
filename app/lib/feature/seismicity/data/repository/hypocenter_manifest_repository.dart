import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_manifest.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_model_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

class HypocenterManifestRepository {
  const new({required api.HypocentersApiClient client})
    : _client = client;

  final api.HypocentersApiClient _client;

  Future<Result<HypocenterManifest, HypocenterApiException>> fetch() async {
    try {
      final response = await _client.getV2HypocentersManifest();
      return Success(response.data.toModel());
    } on DioException catch (error, stackTrace) {
      return Failure(
        HypocenterApiException(
          message: '震源アーカイブ一覧を取得できませんでした',
          statusCode: error.response?.statusCode,
        ),
        stackTrace,
      );
    }
  }
}
