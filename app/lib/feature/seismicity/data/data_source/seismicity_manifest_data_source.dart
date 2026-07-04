import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_manifest.dart';

/// `GET /v2/seismicity/manifest` を取得する薄いdata_source。
///
/// backend の openapi.json 反映後に `eqmonitor_api` パッケージへ移行する想定の
/// 暫定実装(素のDioで直接叩く)。
class SeismicityManifestDataSource {
  const SeismicityManifestDataSource(this._dio);

  final Dio _dio;

  Future<SeismicityManifest> fetchManifest() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v2/seismicity/manifest',
    );
    final data = response.data;
    if (data == null) {
      throw StateError('Empty /v2/seismicity/manifest response');
    }
    return SeismicityManifest.fromJson(data);
  }
}
