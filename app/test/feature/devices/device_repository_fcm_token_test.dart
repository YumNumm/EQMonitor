import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('upsertPushToken sends one FCM request with the token', () async {
    final adapter = _FcmTokenAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(
      api: api.ApiClient(dio),
      authRepository: _FakeDeviceAuthRepository(),
      apnsEnvironment: api.ApnsEnvironment.development,
    );

    await repository.upsertPushToken(kind: .fcm, token: 'fcm-token');

    expect(adapter.requests.map((request) => request.path), [
      '/v2/device/me/fcm',
    ]);
    expect(adapter.requests.map((request) => request.data), [
      {'token': 'fcm-token'},
    ]);
  });

  test('upsertPushToken captures adapter failures', () async {
    final adapter = _FcmTokenAdapter(statusCode: 500);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(
      api: api.ApiClient(dio),
      authRepository: _FakeDeviceAuthRepository(),
      apnsEnvironment: api.ApnsEnvironment.development,
    );

    final result = await repository.upsertPushToken(
      kind: .fcm,
      token: 'fcm-token',
    );

    expect(result, isA<Failure<void, Exception>>());
  });
}

final class _FcmTokenAdapter implements HttpClientAdapter {
  new({this.statusCode = 204});

  final int statusCode;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString('', statusCode);
  }

  @override
  void close({bool force = false}) {}
}

final class _FakeDeviceAuthRepository extends Fake
    implements DeviceAuthRepository;
