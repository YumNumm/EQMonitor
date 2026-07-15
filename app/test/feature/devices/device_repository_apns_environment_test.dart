import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/provider/apns_environment.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('apnsEnvironmentProvider follows production iOS entitlements', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      container.read(apnsEnvironmentProvider),
      api.ApnsEnvironment.production,
    );
  });

  test('upsertPushToken sends APNs environment', () async {
    final adapter = _ApnsEnvironmentAdapter();
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

    final payloads = adapter.requests.map(
      (request) => jsonDecode(jsonEncode(request.data)),
    );

    expect(payloads, [
      {'token': 'apns-token', 'environment': 'development'},
      {'token': 'push-to-start-token', 'environment': 'development'},
    ]);
  });
}

final class _ApnsEnvironmentAdapter implements HttpClientAdapter {
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
