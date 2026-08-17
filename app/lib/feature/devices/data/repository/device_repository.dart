import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
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

  Future<Result<RegisteredDevice, Exception>> getDevice(String deviceId) =>
      Result.capture(() async {
        final response = await _api.device.getV2DeviceMe();
        return response.data.toRegisteredDevice;
      });

  /// デバイスに紐づくユーザーのロールを取得する。
  ///
  /// `role` は OpenAPI の `DeviceMeResponse` に未定義のため、生成モデルではなく
  /// レスポンスの生 JSON から読む。backend がフィールドを追加し次第、生成モデル
  /// 経由へ置き換える(`docs/todo/300_device_role_api_field.md`)。
  ///
  /// ロールを判定できない場合(フィールド未提供・未知の値)は null を返す。
  Future<Result<DeviceRole?, Exception>> getDeviceRole() =>
      Result.capture(() async {
        final response = await _api.device.getV2DeviceMe();
        final body = response.response.data;
        if (body is! Map<String, dynamic>) {
          return null;
        }
        final role = body['role'];
        return DeviceRole.fromApiValue(role is String ? role : null);
      });

  Future<Result<RegisteredDevice, Exception>> registerDevice({
    required String deviceId,
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

  Future<Result<void, Exception>> deleteDevice(String deviceId) =>
      Result.capture(() async {
        await _api.device.deleteV2DeviceMe();
        await _authRepository.clearToken();
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
        if (_shouldRegisterAfterGetFailure(exception)) {
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
