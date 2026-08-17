import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_model_converter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:talker_flutter/talker_flutter.dart';

abstract interface class HypocenterArchiveEventRepository {
  Future<Result<List<SeismicityEvent>, HypocenterApiException>> fetchArchive({
    required HypocenterArchive archive,
    required SeismicityBounds bounds,
    required CancelToken cancelToken,
    required void Function({required int fetchedEvents}) onProgress,
  });
}

class HypocenterAnalysisRepository implements HypocenterArchiveEventRepository {
  const new({
    required api.HypocentersApiClient client,
    Talker? logger,
  }) : _client = client,
       _logger = logger;

  final api.HypocentersApiClient _client;
  final Talker? _logger;

  @override
  Future<Result<List<SeismicityEvent>, HypocenterApiException>> fetchArchive({
    required HypocenterArchive archive,
    required SeismicityBounds bounds,
    required CancelToken cancelToken,
    required void Function({required int fetchedEvents}) onProgress,
  }) async {
    final events = <SeismicityEvent>[];
    String? cursor;
    _logger?.debug(
      '[HypocenterAnalysis] start partition=${archive.id.partition.name} '
      'period=${archive.id.jstLabel} revision=${archive.queryRevision}',
    );
    try {
      do {
        final response = await _client.getV2Hypocenters(
          originTimeGte: archive.periodFrom.toUtc(),
          originTimeLte: archive.periodTo.toUtc(),
          limit: 1000,
          area: const HypocenterBoundsPolygon().encode(bounds: bounds),
          cursor: cursor,
          expectedRevision: archive.queryRevision,
          cancelToken: cancelToken,
        );
        if (response.data.meta.datasetRevision != archive.queryRevision) {
          return const Failure(
            HypocenterApiException(
              message: '震源データが更新されました。再度選択してください',
              statusCode: 409,
              kind: HypocenterApiErrorKind.revisionChanged,
            ),
          );
        }
        events.addAll(response.data.data.items.map((item) => item.toModel()));
        onProgress(fetchedEvents: events.length);
        cursor = response.data.data.nextToken;
      } while (cursor != null);
      return Success(events);
    } on DioException catch (error, stackTrace) {
      _logger?.warning(
        '[HypocenterAnalysis] failed period=${archive.id.jstLabel} '
        'status=${error.response?.statusCode} type=${error.type.name}',
        error,
        stackTrace,
      );
      return Failure(
        HypocenterApiException(
          message: switch ((error.type, error.response?.statusCode)) {
            (DioExceptionType.cancel, _) => '震源分析データの取得を中止しました',
            (_, 409) => '震源データが更新されました。再度選択してください',
            _ => '震源分析データを取得できませんでした',
          },
          statusCode: error.response?.statusCode,
          kind: switch ((error.type, error.response?.statusCode)) {
            (DioExceptionType.cancel, _) => HypocenterApiErrorKind.cancelled,
            (_, 409) => HypocenterApiErrorKind.revisionChanged,
            _ => HypocenterApiErrorKind.network,
          },
        ),
        stackTrace,
      );
    }
  }
}

class HypocenterBoundsPolygon {
  const new();

  String encode({required SeismicityBounds bounds}) => [
    '${bounds.minLongitude},${bounds.minLatitude}',
    '${bounds.maxLongitude},${bounds.minLatitude}',
    '${bounds.maxLongitude},${bounds.maxLatitude}',
    '${bounds.minLongitude},${bounds.maxLatitude}',
  ].join(';');
}
