import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_model_converter.dart';
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
      return Success(data.toShakeDetectionSnapshot());
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
