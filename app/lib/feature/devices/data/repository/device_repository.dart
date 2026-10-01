import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/device_notification_webhook.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/provider/apns_environment.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceRepository> deviceRepository(Ref ref) async => DeviceRepository(
  api: await ref.watch(apiClientProvider.future),
  authRepository: await ref.watch(deviceAuthRepositoryProvider.future),
  apnsEnvironment: ref.watch(apnsEnvironmentProvider),
);

class DeviceRepository {
  new({
    required api.ApiClient api,
    required DeviceAuthRepository authRepository,
    required api.ApnsEnvironment apnsEnvironment,
  }) : _api = api,
       _authRepository = authRepository,
       _apnsEnvironment = apnsEnvironment;

  final api.ApiClient _api;
  final DeviceAuthRepository _authRepository;
  final api.ApnsEnvironment _apnsEnvironment;

  Future<Result<RegisteredDevice, Exception>> getDevice() =>
      Result.capture(() async {
        final response = await _api.device.getV2DeviceMe();
        return response.data.toRegisteredDevice;
      });

  /// このデバイスのロールを取得する。
  ///
  /// backend は `ADMIN_DEVICE_IDS` に列挙されたデバイスにのみ `ADMIN` を返す。
  /// 未知の値が来た場合は生成モデルのデコードが失敗し、Failure になる。
  /// 権限を推測して Admin 扱いにするフォールバックは意図的に入れていない。
  Future<Result<DeviceRole, Exception>> getDeviceRole() =>
      Result.capture(() async {
        final response = await _api.device.getV2DeviceMe();
        return response.data.role.toDeviceRole;
      });

  Future<Result<List<DeviceNotificationWebhook>, Exception>>
  getNotificationWebhooks() => Result.capture(() async {
    final response = await _api.device.getV2DeviceMeNotificationWebhooks();
    return response.data.map((webhook) => webhook.toModel()).toList();
  });

  Future<Result<DeviceNotificationWebhook, Exception>>
  createNotificationWebhook() => Result.capture(() async {
    final response = await _api.device.postV2DeviceMeNotificationWebhooks(
      body: const api.CreateDeviceNotificationWebhookRequest(),
    );
    return response.data.toModel();
  });

  Future<Result<RegisteredDevice, Exception>> registerDevice({
    required DevicePlatform devicePlatform,
    required DeviceLocale deviceLocale,
  }) => Result.capture(() async {
    final savedToken = await _authRepository.readToken();
    if (savedToken != null && savedToken.isNotEmpty) {
      try {
        final getResponse = await _api.device.getV2DeviceMe();
        return getResponse.data.toRegisteredDevice;
      } on DioException catch (e) {
        if (!_shouldRegisterAfterGetFailure(e)) {
          rethrow;
        }
        await _authRepository.clearToken();
      }
    }

    final registerResponse = await _api.device.postV2Device(
      body: api.DeviceRegisterBody(
        type: devicePlatform.toDeviceType,
        locale: deviceLocale.toDeviceLocale,
      ),
    );
    await _authRepository.saveToken(token: registerResponse.data.deviceToken);
    final getResponse = await _api.device.getV2DeviceMe();
    return getResponse.data.toRegisteredDevice;
  });

  Future<Result<void, Exception>> deleteDevice() => Result.capture(() async {
    await _api.device.deleteV2DeviceMe();
    await _authRepository.clearToken();
  });

  Future<Result<RegisteredDevice, Exception>> fetchOrRegister({
    required DevicePlatform devicePlatform,
    required DeviceLocale deviceLocale,
  }) async {
    final getResult = await getDevice();
    switch (getResult) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception, :final stackTrace):
        if (_shouldRegisterAfterGetFailure(exception)) {
          return registerDevice(
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
  /// 1. GET /v2/device/me — if 200 it already exists, skip registration.
  /// 2. POST /v2/device — only when step 1 returned 404.
  /// 3. POST /v2/device/me/migrate with [oldDeviceId].
  ///
  /// 409 on migrate is treated as idempotent success (already migrated).
  Future<Result<void, Exception>> migrateFromLegacy({
    required String oldDeviceId,
  }) async {
    // Step 1 — check existence
    final getResult = await getDevice();
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
      final registerResult = await registerDevice(
        devicePlatform: kIsWeb
            ? .ios
            : Platform.isIOS
            ? .ios
            : .android,
        deviceLocale: .ja,
      );
      if (registerResult is Failure<RegisteredDevice, Exception>) {
        return Failure(registerResult.exception, registerResult.stackTrace);
      }
    }

    // Step 3 — call migration endpoint to transfer Supabase settings
    return Result.capture(() async {
      try {
        final response = await _api.device.postV2DeviceMeMigrate(
          body: api.MigrateRequest(oldDeviceId: oldDeviceId),
        );
        final migrated = response.data.migrated;
        talker.info(
          '[V2Migration] migrate succeeded: '
          'earthquakeRegions=${migrated.earthquakeRegions}, '
          'eewRegions=${migrated.eewRegions}, '
          'notificationSettings=${migrated.notificationSettings}',
        );
      } on DioException catch (e) {
        // 409 = already migrated; treat as idempotent success
        if (e.response?.statusCode == 409) {
          talker.info('[V2Migration] already migrated (409); skipping');
          return;
        }
        // 404 = old device not found in Supabase; non-fatal
        if (e.response?.statusCode == 404) {
          talker.warning(
            '[V2Migration] old device not found (404); nothing migrated',
          );
          return;
        }
        rethrow;
      }
    });
  }

  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) => Result.capture(() async {
    await switch (kind) {
      .fcm => _api.device.patchV2DeviceMeFcm(
        body: api.V2DeviceMeFcmRequestBody(token: token),
      ),
      .apnsNotification => _api.device.patchV2DeviceMeApnsKind(
        kind: .notification,
        body: api.V2DeviceMeApnsKindRequestBody(
          token: token,
          environment: _apnsEnvironment,
        ),
      ),
      .apnsPushToStart => _api.device.patchV2DeviceMeApnsKind(
        kind: .liveActivityStart,
        body: api.V2DeviceMeApnsKindRequestBody(
          token: token,
          environment: _apnsEnvironment,
        ),
      ),
    };
  });

  static bool _isNotFound(Exception e) =>
      e is DioException && e.response?.statusCode == 404;

  static bool _shouldRegisterAfterGetFailure(Exception e) =>
      e is DioException && (e.response?.statusCode == 401 || _isNotFound(e));
}
