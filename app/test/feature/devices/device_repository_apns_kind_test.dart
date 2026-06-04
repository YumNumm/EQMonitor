import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/model/apns_token_kind.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APNs token kind json values are used in generated API paths', () async {
    final adapter = _ApnsKindAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final client = api.ApiClient(dio);

    await client.device.patchV2DeviceMeApnsKind(
      kind: ApnsTokenKind.notification.json,
      body: const api.V2DeviceMeApnsKindRequestBody(token: 'apns-token'),
    );
    await client.device.patchV2DeviceMeApnsKind(
      kind: ApnsTokenKind.liveActivityStart.json,
      body: const api.V2DeviceMeApnsKindRequestBody(
        token: 'push-to-start-token',
      ),
    );

    expect(adapter.requests.map((request) => request.path), [
      '/v2/device/me/apns/notification',
      '/v2/device/me/apns/liveActivityStart',
    ]);
    expect(adapter.requests.map((request) => request.data), [
      {'token': 'apns-token'},
      {'token': 'push-to-start-token'},
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
