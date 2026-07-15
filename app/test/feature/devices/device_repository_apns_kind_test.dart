import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
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
