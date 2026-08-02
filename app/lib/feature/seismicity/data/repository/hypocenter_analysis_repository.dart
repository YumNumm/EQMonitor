import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_model_converter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

abstract interface class HypocenterArchiveEventRepository {
  Future<Result<List<SeismicityEvent>, HypocenterApiException>> fetchArchive({
    required HypocenterArchive archive,
    required SeismicityBounds bounds,
  });
}

class HypocenterAnalysisRepository implements HypocenterArchiveEventRepository {
  const HypocenterAnalysisRepository({required api.HypocentersApiClient client})
    : _client = client;

  final api.HypocentersApiClient _client;

  @override
  Future<Result<List<SeismicityEvent>, HypocenterApiException>> fetchArchive({
    required HypocenterArchive archive,
    required SeismicityBounds bounds,
  }) async {
    final events = <SeismicityEvent>[];
    String? cursor;
    try {
      do {
        final response = await _client.getV2Hypocenters(
          originTimeGte: archive.periodFrom.toUtc(),
          originTimeLte: archive.periodTo.toUtc(),
          limit: 1000,
          area: const HypocenterBoundsPolygon().encode(bounds: bounds),
          cursor: cursor,
          expectedRevision: archive.queryRevision,
        );
        if (response.data.meta.datasetRevision != archive.queryRevision) {
          return const Failure(
            HypocenterApiException(
              message: '震源データが更新されました。再度選択してください',
              statusCode: 409,
            ),
          );
        }
        events.addAll(response.data.data.items.map((item) => item.toModel()));
        cursor = response.data.data.nextToken;
      } while (cursor != null);
      return Success(events);
    } on DioException catch (error, stackTrace) {
      return Failure(
        HypocenterApiException(
          message: error.response?.statusCode == 409
              ? '震源データが更新されました。再度選択してください'
              : '震源分析データを取得できませんでした',
          statusCode: error.response?.statusCode,
        ),
        stackTrace,
      );
    }
  }
}

class HypocenterBoundsPolygon {
  const HypocenterBoundsPolygon();

  String encode({required SeismicityBounds bounds}) => [
    '${bounds.minLongitude},${bounds.minLatitude}',
    '${bounds.maxLongitude},${bounds.minLatitude}',
    '${bounds.maxLongitude},${bounds.maxLatitude}',
    '${bounds.minLongitude},${bounds.maxLatitude}',
  ].join(';');
}
