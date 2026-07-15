import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('upsertPushToken maps APNs kinds to one request each', () async {
    final adapter = _ApnsKindAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(
      api: api.ApiClient(dio),
      authRepository: _FakeDeviceAuthRepository(),
      apnsEnvironment: api.ApnsEnvironment.development,
      isApplePlatform: true,
    );

    await repository.upsertPushToken(
      kind: .apnsNotification,
      token: 'apns-token',
    );
    await repository.upsertPushToken(
      kind: .apnsPushToStart,
      token: 'push-to-start-token',
    );

    expect(adapter.requests.map((request) => request.path), [
      '/v2/device/me/apns/NOTIFICATION',
      '/v2/device/me/apns/LIVE_ACTIVITY_START',
    ]);
    final payloads = adapter.requests.map(
      (request) => jsonDecode(jsonEncode(request.data)),
    );

    expect(payloads, [
      {'token': 'apns-token', 'environment': 'development'},
      {'token': 'push-to-start-token', 'environment': 'development'},
    ]);
  });

  test('direct APNs upsert is not silently skipped by platform flag', () async {
    final adapter = _ApnsKindAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(
      api: api.ApiClient(dio),
      authRepository: _FakeDeviceAuthRepository(),
      apnsEnvironment: api.ApnsEnvironment.development,
      isApplePlatform: false,
    );

    await repository.upsertPushToken(
      kind: .apnsNotification,
      token: 'apns-token',
    );

    expect(adapter.requests.map((request) => request.path), [
      '/v2/device/me/apns/NOTIFICATION',
    ]);
  });

  test('syncPushTokens delegates present tokens in order', () async {
    final repository = _DelegatingDeviceRepository(isApplePlatform: true);

    final result = await repository.syncPushTokens(
      deviceId: 'unused',
      token: const NotificationToken(
        fcmToken: 'fcm-token',
        apnsToken: 'apns-token',
        apnsPushToStartToken: 'push-to-start-token',
      ),
    );

    expect(result, isA<Success<void, Exception>>());
    expect(repository.calls, [
      (kind: PushTokenKind.fcm, token: 'fcm-token'),
      (kind: PushTokenKind.apnsNotification, token: 'apns-token'),
      (kind: PushTokenKind.apnsPushToStart, token: 'push-to-start-token'),
    ]);
  });

  test('syncPushTokens stops after delegated failure', () async {
    final repository = _DelegatingDeviceRepository(
      isApplePlatform: true,
      failingKind: .apnsNotification,
    );

    final result = await repository.syncPushTokens(
      deviceId: 'unused',
      token: const NotificationToken(
        fcmToken: 'fcm-token',
        apnsToken: 'apns-token',
        apnsPushToStartToken: 'push-to-start-token',
      ),
    );

    expect(result, isA<Failure<void, Exception>>());
    expect(repository.calls, [
      (kind: PushTokenKind.fcm, token: 'fcm-token'),
      (kind: PushTokenKind.apnsNotification, token: 'apns-token'),
    ]);
  });
}

final class _ApnsKindAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}

final class _FakeDeviceAuthRepository extends Fake
    implements DeviceAuthRepository {}

final class _DelegatingDeviceRepository extends DeviceRepository {
  _DelegatingDeviceRepository({required bool isApplePlatform, this.failingKind})
    : super(
        api: api.ApiClient(Dio()),
        authRepository: _FakeDeviceAuthRepository(),
        apnsEnvironment: api.ApnsEnvironment.development,
        isApplePlatform: isApplePlatform,
      );

  final PushTokenKind? failingKind;
  final calls = <({PushTokenKind kind, String token})>[];

  @override
  Future<Result<void, Exception>> upsertPushToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    calls.add((kind: kind, token: token));
    if (kind == failingKind) {
      return Failure(Exception('upsert failed'));
    }
    return const Success(null);
  }
}
