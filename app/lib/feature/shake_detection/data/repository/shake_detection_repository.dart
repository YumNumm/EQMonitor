import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level_parser.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_repository.g.dart';

final class ShakeDetectionApiException implements Exception {
  const ShakeDetectionApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;
}

@Riverpod(keepAlive: true)
Future<ShakeDetectionRepository> shakeDetectionRepository(Ref ref) async {
  final client = await ref.watch(apiClientProvider.future);
  return ApiShakeDetectionRepository(client: client.shakeDetection);
}

abstract interface class ShakeDetectionRepository {
  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive();
}

final class ApiShakeDetectionRepository implements ShakeDetectionRepository {
  const ApiShakeDetectionRepository({
    required api.ShakeDetectionApiClient client,
  }) : _client = client;

  final api.ShakeDetectionApiClient _client;

  @override
  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive() async {
    try {
      final data = (await _client.getV2ShakeDetectionActive()).data;
      return Success(
        ShakeDetectionSnapshot(
          revision: data.revision,
          responseAt: data.responseAt,
          events: data.events
              .map(
                (event) => ShakeDetectionEvent(
                  eventId: event.eventId,
                  serialNo: event.serialNo,
                  createdAt: event.createdAt,
                  updatedAt: event.updatedAt,
                  expiresAt: event.expiresAt,
                  level: event.level
                      .toJson()
                      .toShakeDetectionLevel()
                      .toShakeDetectionLevelModel,
                  pointCount: event.pointCount,
                  minLat: event.region.bottomRight.latitude.toDouble(),
                  maxLat: event.region.topLeft.latitude.toDouble(),
                  minLng: event.region.topLeft.longitude.toDouble(),
                  maxLng: event.region.bottomRight.longitude.toDouble(),
                  changeReasons: event.changeReasons
                      .map((reason) => reason.toJson())
                      .toList(growable: false),
                  correlatedEewEventId: event.correlatedEew?.eventId,
                  mergedEvents: event.mergedEvents,
                  points: event.points,
                  correlatedEew: event.correlatedEew,
                ),
              )
              .toList(growable: false),
        ),
      );
    } on DioException catch (error) {
      return Failure(
        ShakeDetectionApiException(
          message: error.message ?? 'Shake detection API request failed',
          statusCode: error.response?.statusCode,
        ),
      );
    } on CheckedFromJsonException catch (error) {
      return Failure(
        ShakeDetectionApiException(
          message: error.message ?? 'Shake detection API response is invalid',
        ),
      );
    } on FormatException catch (error) {
      return Failure(ShakeDetectionApiException(message: error.message));
    }
  }
}
