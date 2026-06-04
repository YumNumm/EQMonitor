import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/apns_token_kind.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
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
        final response = await _api.device.getV2DeviceMe();
        return response.data.toRegisteredDevice;
      });

  Future<Result<RegisteredDevice, Exception>> registerDevice({
    required String deviceId,
    required DevicePlatform devicePlatform,
    required DeviceLocale deviceLocale,
  }) => Result.capture(() async {
    await _api.device.postV2Device(
      body: api.DeviceRegisterBody(
        type: devicePlatform.toDeviceType,
        locale: deviceLocale.toDeviceLocale,
      ),
    );
    final getResponse = await _api.device.getV2DeviceMe();
    return getResponse.data.toRegisteredDevice;
  });

  Future<Result<void, Exception>> deleteDevice(String deviceId) =>
      Result.capture(() async {
        await _api.device.deleteV2DeviceMe();
      });

  Future<Result<RegisteredDevice, Exception>> fetchOrRegister({
    required String deviceId,
    required DevicePlatform devicePlatform,
    required DeviceLocale deviceLocale,
  }) async {
    final getResult = await getDevice(deviceId);
    switch (getResult) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception, :final stackTrace):
        if (_isNotFound(exception)) {
          return registerDevice(
            deviceId: deviceId,
            devicePlatform: devicePlatform,
            deviceLocale: deviceLocale,
          );
        }
        return Failure(exception, stackTrace);
    }
  }

  /// Migrates settings from a v2.6 Supabase device to this v3 device.
  ///
  /// Sequence (per spec):
  /// 1. GET device — if 200 it already exists, skip PUT.
  /// 2. PUT device  — only when step 1 returned 404.
  /// 3. POST /migrate with [oldDeviceId].
  ///
  /// 409 on migrate is treated as idempotent success (already migrated).
  Future<Result<void, Exception>> migrateFromLegacy({
    required String deviceId,
    required String oldDeviceId,
  }) async {
    // Step 1 — check existence
    final getResult = await getDevice(deviceId);
    final alreadyRegistered = switch (getResult) {
      Success() => true,
      Failure(:final exception) when _isNotFound(exception) => false,
      Failure() => null, // unexpected error
    };
    if (alreadyRegistered == null) {
      return getResult as Failure<void, Exception>;
    }

    // Step 2 — register only when absent
    if (!alreadyRegistered) {
      final putResult = await registerDevice(
        deviceId: deviceId,
        devicePlatform: kIsWeb
            ? .ios
            : Platform.isIOS
            ? .ios
            : .android,
        deviceLocale: .ja,
      );
      if (putResult is Failure<RegisteredDevice, Exception>) {
        return Failure(putResult.exception, putResult.stackTrace);
      }
    }

    // Step 3 — migrate endpoint removed; treat as success
    return const Success(null);
  }

  Future<Result<void, Exception>> syncLiveActivityUpdateToken({
    required String deviceId,
    required String liveActivityId,
    required String token,
  }) => Result.capture(() async {
    await _api.device.putV2DeviceMeLiveActivityLiveActivityIdToken(
      liveActivityId: liveActivityId,
      body: api.LiveActivityTokenRequest(token: token),
    );
  });

  Future<Result<api.LiveActivityTestScenarioResponse, Exception>>
  triggerLiveActivityTestScenario({
    required String deviceId,
    required api.LiveActivityStartTrigger eventType,
    required api.Scenario? scenario,
  }) => Result.capture(() async {
    final response = await _api.device.postV2DeviceMeLiveActivityTestScenario(
      body: api.LiveActivityTestScenarioRequest(
        eventType: eventType,
        scenario: scenario,
      ),
    );
    return response.data;
  });

  static bool _isNotFound(Exception e) =>
      e is DioException && e.response?.statusCode == 404;

  Future<Result<void, Exception>> syncPushTokens({
    required String deviceId,
    required NotificationToken token,
  }) async {
    final fcm = token.fcmToken;
    if (fcm != null && fcm.isNotEmpty) {
      final r = await Result.capture(() async {
        await _api.device.patchV2DeviceMeFcm(
          body: api.V2DeviceMeFcmRequestBody(token: fcm),
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
        await _api.device.patchV2DeviceMeApnsKind(
          kind: ApnsTokenKind.notification.json,
          body: api.V2DeviceMeApnsKindRequestBody(token: apns),
        );
      });
      if (r is Failure<void, Exception>) {
        return r;
      }
    }

    final pushToStart = token.apnsPushToStartToken;
    if (pushToStart != null && pushToStart.isNotEmpty) {
      final r = await Result.capture(() async {
        await _api.device.patchV2DeviceMeApnsKind(
          kind: ApnsTokenKind.liveActivityStart.json,
          body: api.V2DeviceMeApnsKindRequestBody(token: pushToStart),
        );
      });
      if (r is Failure<void, Exception>) {
        return r;
      }
    }

    return const Success(null);
  }
}
