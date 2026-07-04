import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_geojson_parser.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// manifest の layer.url が指す静的GeoJSONを取得しパースするdata_source。
///
/// GeoJSON は API ホストとは別の静的配信ホストに置かれるため、
/// [Dio.get] へは絶対URLを渡す(Dioは絶対URLの場合baseUrlを無視する)。
class SeismicityGeoJsonDataSource {
  const SeismicityGeoJsonDataSource(
    this._dio, {
    this.parser = const SeismicityGeoJsonParser(),
  });

  final Dio _dio;
  final SeismicityGeoJsonParser parser;

  Future<List<SeismicityEvent>> fetchEvents(String url) async {
    final response = await _dio.get<Map<String, dynamic>>(url);
    final data = response.data;
    if (data == null) {
      throw StateError('Empty GeoJSON response from $url');
    }
    return parser.parse(data);
  }
}
