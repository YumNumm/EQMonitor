import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/settings/features/notification/data/model/notification_token.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceRepository> deviceRepository(Ref ref) async =>
    DeviceRepository(await ref.watch(apiClientProvider.future));

class DeviceRepository {
  DeviceRepository(this._api);

  final api.ApiClient _api;

  Future<Result<RegisteredDevice, Exception>> getDevice(String deviceId) =>
      Result.capture(() async {
        final response = await _api.device.getV2DeviceDeviceId(
          deviceId: deviceId,
        );
        return response.data.toRegisteredDevice;
      });

  Future<Result<RegisteredDevice, Exception>> registerDevice(
    String deviceId,
  ) => Result.capture(() async {
    final response = await _api.device.putV2DeviceDeviceId(
      deviceId: deviceId,
    );
    return response.data.toRegisteredDevice;
  });

  Future<Result<void, Exception>> deleteDevice(String deviceId) =>
      Result.capture(() async {
        await _api.device.deleteV2DeviceDeviceId(deviceId: deviceId);
      });

  Future<Result<RegisteredDevice, Exception>> fetchOrRegister(
    String deviceId,
  ) async {
    final getResult = await getDevice(deviceId);
    switch (getResult) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception, :final stackTrace):
        if (_isNotFound(exception)) {
          return registerDevice(deviceId);
        }
        return Failure(exception, stackTrace);
    }
  }

  Future<Result<void, Exception>> syncPushTokens({
    required String deviceId,
    required NotificationToken token,
  }) async {
    final fcm = token.fcmToken;
    if (fcm != null && fcm.isNotEmpty) {
      final r = await Result.capture(() async {
        await _api.device.patchV2DeviceDeviceIdFcm(
          deviceId: deviceId,
          body: api.FcmTokenRequest(token: fcm),
        );
      });
      if (r is Failure<void, Exception>) {
        return r;
      }
    }

    if (kIsWeb || !(Platform.isIOS || Platform.isMacOS)) {
      return const Success(null);
    }

    final apns = token.apnsToken;
    if (apns != null && apns.isNotEmpty) {
      final r = await Result.capture(() async {
        await _api.device.patchV2DeviceDeviceIdApnsType(
          type: api.ApnsTokenType.notification,
          deviceId: deviceId,
          body: api.ApnsTokenRequest(
            token: apns,
            environment: kDebugMode
                ? api.ApnsEnvironment.development
                : api.ApnsEnvironment.production,
          ),
        );
      });
      if (r is Failure<void, Exception>) {
        return r;
      }
    }

    final pushToStart = token.apnsPushToStartToken;
    if (pushToStart != null && pushToStart.isNotEmpty) {
      final r = await Result.capture(() async {
        await _api.device.patchV2DeviceDeviceIdApnsType(
          type: api.ApnsTokenType.liveActivityStart,
          deviceId: deviceId,
          body: api.ApnsTokenRequest(
            token: pushToStart,
            environment: kDebugMode
                ? api.ApnsEnvironment.development
                : api.ApnsEnvironment.production,
          ),
        );
      });
      if (r is Failure<void, Exception>) {
        return r;
      }
    }

    return const Success(null);
  }
}

bool _isNotFound(Exception e) =>
    e is DioException && e.response?.statusCode == 404;
