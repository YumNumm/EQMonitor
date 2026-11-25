import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_exception.dart';

final class const EarthquakeArchiveFailureMapper() {
  EarthquakeArchiveException map(DioException error) =>
      EarthquakeArchiveException(switch (error) {
        DioException(response: Response(statusCode: 401)) => .unauthorized,
        DioException(response: Response(statusCode: 403)) => .forbidden,
        DioException(response: Response(statusCode: 404)) => .notFound,
        DioException(response: Response(statusCode: 502 || 503)) =>
          .unavailable,
        DioException(
          type: .connectionError ||
              .connectionTimeout ||
              .receiveTimeout ||
              .sendTimeout,
        ) =>
          .network,
        _ => .unknown,
      });
}
