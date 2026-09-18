import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/device_notification_webhook.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Webhookを空のJSON bodyで発行して一覧へ変換する', () async {
    final adapter = _WebhookAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(
      api: api.ApiClient(dio),
      authRepository: _FakeDeviceAuthRepository(),
      apnsEnvironment: api.ApnsEnvironment.development,
    );

    final created = await repository.createNotificationWebhook();
    final listed = await repository.getNotificationWebhooks();

    expect(adapter.requests.first.data, <String, Object?>{});
    expect(created, isA<Success<DeviceNotificationWebhook, Exception>>());
    expect(
      (listed as Success<List<DeviceNotificationWebhook>, Exception>)
          .value
          .single
          .id,
      'webhook-id',
    );
  });
}

final class _WebhookAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final webhook = {
      'id': 'webhook-id',
      'createdAt': '2026-08-26T00:00:00.000Z',
      'expiresAt': null,
      'approved': false,
      'webhookUrl': null,
    };
    return ResponseBody.fromString(
      jsonEncode(options.method == 'GET' ? [webhook] : webhook),
      options.method == 'GET' ? 200 : 201,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final class _FakeDeviceAuthRepository extends Fake
    implements DeviceAuthRepository;
